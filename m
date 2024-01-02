Return-Path: <linux-kernel+bounces-14453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A209A821D3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1BF1F22B41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5F011727;
	Tue,  2 Jan 2024 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8+dPWga"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398011194
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d604b4b30so25932785e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704204207; x=1704809007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gm2hXx5OxeyOxmYs9z0AMxVtmT7lZ2HwF2TM+0OQnV4=;
        b=a8+dPWgaS8E2aYSjnjszJP6kgg/svLsybi6525IA6/ajonHIMZz/HAxVFZggxVQohp
         5E3ii+yEz9hShO376e0FcDBWdOqKeHN5dtqHGkOSucNCFWw8WrKFyI+mPddGjNvxxKgp
         A+rtuHQJcjFkwZLJ/+NXy73GI0JulSb5J3sDOinm/3kUMaXF6AwqpbvzCMX4Mw1Qfgg2
         n0YqUa4xsaSMNe0j1sV4ScEJ57MLDuXqy940my5NiP8/yjThflFIt+uElg8FrOdDXwpx
         kBRqCjsjXr6+qQAFSHog1b4aofKscq5ozh+5Ogx8DqW5URtXNI4EDAIl33RkdhxS2Xfu
         ZvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204207; x=1704809007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm2hXx5OxeyOxmYs9z0AMxVtmT7lZ2HwF2TM+0OQnV4=;
        b=Dibkzb0b+Zfh6+1B93M9Y6JIiNtm844nviYacH2LBhRFXqXPK4EUCXCo1INJhMT0Ej
         fzDVtVZwIttbQC5hsT0yrL3214vv+fjweuNBu8ICvhmZpeEN36cSXMgYrlUo8uM9KSuf
         fiSbPEYufsEzhjCv/ifx0Axz/cVzL4hJMtBK2H5QA0PhAQc3C0i0Y8IjPjwPwtOPomMc
         w5M3jqDvI1MBz23kTKQgZ+D8oaHQKv/1M13XjehW1OzSOohzro+k2on+fJKVtJ/0M3+k
         SttloN0bBV/CK42Yje7ciaOGhMLOgHPSg4lRjJffWNr5nsix4boOLt+ceVza4lvueE9y
         JBKA==
X-Gm-Message-State: AOJu0YwARbyWW5t+ZdjoaGj/EeDuZ1GI32kX2Te6dU/t7XsjUCJEJ8OJ
	O2A5vldnzwbL0+EQVFRcV7o3pBkqBu0sVw==
X-Google-Smtp-Source: AGHT+IG+uVM0QKMD5sZLNHS1LUvENcwUlvFjpNhHg7TNOtGjSQFVBrHtal+ZV4SNZgV25Gs3/ZVTkQ==
X-Received: by 2002:a05:600c:5195:b0:40d:88b8:1bd1 with SMTP id fa21-20020a05600c519500b0040d88b81bd1mr1277633wmb.185.1704204207378;
        Tue, 02 Jan 2024 06:03:27 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id iv13-20020a05600c548d00b0040d30af488asm49616502wmb.40.2024.01.02.06.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:03:27 -0800 (PST)
Date: Tue, 2 Jan 2024 16:17:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "<Tree Davies" <tdavies@darkphysics.net>
Cc: Nathan DSilva <expitau@gmail.com>, gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com, kamrankhadijadj@gmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Add blank line after declarations
Message-ID: <9802302b-5aba-4675-bfaa-eadd3e168d1e@suswa.mountain>
References: <20231215032852.501316-1-expitau@gmail.com>
 <ZXvevJ2vEEQ92rau@oatmeal.darkphysics>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXvevJ2vEEQ92rau@oatmeal.darkphysics>

On Thu, Dec 14, 2023 at 09:06:04PM -0800, <Tree Davies wrote:
> 3. For this driver, it is best to send your patches to Greg, Philipp Hortmann,
> and Dan Carpenter (error27@gmail.com) looks at them sometimes too. And like you
> did, cc the mailing lists.

You don't need to CC me.  I'm on the list.  Just use get_maintainer.pl.

Otherwise your advise was correct.

regards,
dan carpenter


