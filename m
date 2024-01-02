Return-Path: <linux-kernel+bounces-14454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D3D821D40
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F7E1C22244
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8992A10979;
	Tue,  2 Jan 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+tcxqoO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC71094E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d5d898162so42238185e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704204216; x=1704809016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qqTKJtifBPnETv7np6pfevn5UJOzWmcakMBHLMWLps=;
        b=o+tcxqoOYcQ5HAayJnRqSm7NxdAqP2MErgQU8epSHKYVyM/c4jcC81b3Yd176KG4DS
         9is9buQ+5aWrA1Vstbw8VmEpR+TW5x0EIzaEnOUzWKGKlHt2pDC8o31QuXCPaNCnAaYg
         fREAZEYQLWPjKfhv094977NNmDuGdHgxllDUKqBRTbO7o4wvPfrr18FmMrPjtcTWlVmP
         hqurUR1K9WRIvk7jcGSW+sezFZSzYApttQ5VbJFRxbDZMcT6LLZjNUQfigzswlbPLHjx
         my4cIf89hejeyO+DSyYRLSV5+ufEdKHqv/MzVcuzKn4V2mTPSkNlcRx4VVenc/GRQfhx
         k0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204216; x=1704809016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qqTKJtifBPnETv7np6pfevn5UJOzWmcakMBHLMWLps=;
        b=auET08G7DZz3Wrs83VDle5h3p2b4fWEw8UXeJKTQUKtnXPYzAoa0nHo361h9t9wCC9
         i+90LLEc2GhnrIpT5uNeQ7DRwupxHv5Wcyrky0Ke9HPgjyD4RvwguZZrE53IHRcuQjZ7
         g3m57/zHTQjwWYrIn4ZPFw+jp5JdX8V7IuV5KZ79KL0c9OozT+NPikeIGd4DBg3sGh5D
         j7srcJ1Jo3O52wVJat7hH1ClixQEJyo5VZBelhdtorvfNg/NNfIeSxuR3inlQCbYsffi
         lE9/SKEcjozqCpNj9tGI1euoj6jdkB69xlgD9Z1KkJB2PNZZ4Qs2Oeb7rRINwjz8hUqo
         l7aw==
X-Gm-Message-State: AOJu0YzxIsfabj4hC7VVocOxfV3+EmbCiH0lyJjwP9c6KQL1EsCtw+9r
	4XcGLFzZoCgXpWZGIQWYnY+57ibKvEWuGw==
X-Google-Smtp-Source: AGHT+IHszu5kYoPxaua17Zir72G8+47MdyzOxbuqM4YiER7bIwhhZFsyR7srK6e08ANasQ0eoLbNNw==
X-Received: by 2002:a05:600c:ca:b0:40d:376b:c640 with SMTP id u10-20020a05600c00ca00b0040d376bc640mr12050424wmm.102.1704204216035;
        Tue, 02 Jan 2024 06:03:36 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id d17-20020adffbd1000000b0033719111458sm11777561wrs.36.2024.01.02.06.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:03:35 -0800 (PST)
Date: Tue, 2 Jan 2024 16:22:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nathan DSilva <expitau@gmail.com>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	tdavies@darkphysics.net, error27@gmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: Add blank line after declarations
Message-ID: <213d872d-8ad0-49f5-b6ae-9a1c69ecc107@suswa.mountain>
References: <ZXvevJ2vEEQ92rau@oatmeal.darkphysics>
 <20231215152918.532037-1-expitau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215152918.532037-1-expitau@gmail.com>

On Fri, Dec 15, 2023 at 03:29:18PM +0000, Nathan DSilva wrote:
> Remove a warning about line breaks after declarations found by checkpatch.
> 
> Signed-off-by: Nathan DSilva <expitau@gmail.com>
> ---
> 
> Thank you very much for your response. I didn't realize you could select
> multiple --to recipients, or that you could have comments not in the changelog.
> 

This should say:

v2: Fix commit message
v3: Improve these notes about changes between versions

Otherwise it looks okay.

regards,
dan carpenter



