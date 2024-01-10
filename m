Return-Path: <linux-kernel+bounces-21787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CFB829446
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D2A1F21468
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F6239AFB;
	Wed, 10 Jan 2024 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="voNkWseM"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63B439877
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d604b4b30so28316185e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 23:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704871581; x=1705476381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oB8bFEksgA/hP4pzljJqPyULshxwwfCWATJRRhxV3mo=;
        b=voNkWseMlfS3qaOFbhzSA7TRnn7PZnJvcHWcLkwbPfvYLwvvdG/DZZtRAg9aLmntRS
         iqP0Le6yZqkjEZYA0d5pqPZ+29/aRw0XjFL7ag3ADH0cb2D+jCs4F/7Pymq4W/McMPSK
         0Oh7cwB0kVfpbWJC89fHxiEhVXHshQY9Oj9TbCnoinKEA8nopRmcw+jEZk7ux8XVLCnL
         AKfyvrDraXmVLDNYKqMX+pwVZdrAw2L41heaNfQUH2ZJKQTO8ceVeC334yDMVwCkc5Mf
         41VBBqAsLmKFR1bIC00RCl74r0KUoLPh3qWqv6stG3Mqt8Wn/ZKFacVZAts1hOKd5CTb
         LKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704871581; x=1705476381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oB8bFEksgA/hP4pzljJqPyULshxwwfCWATJRRhxV3mo=;
        b=Ra2dRrx4T8lBJ8bFmsHrj/ZvIQ87V8z38+hbZzxOY0teLPvAGw09V0h32OA4rIp8t9
         FXlbCBr/uHHHHDCpckoz8wD42BmHs3bXnu6Gk7SnCq3S7JCmv5LzBn6fy0pbgRO9V2IM
         JFvXMbVFSCVfODNpSQ5J+yJfNMMYBjwMDInGlIuC92GOiTgbRrhpIP3zBXRMa3+anHZo
         4z22f9S7XedD49sBMf+ypjUm2hRHbzAUfZwkoXeQJo6eGOs7DSHMF9KYS43ARWcHcmNQ
         sEsv21RixounJSAsP5xZ975P2anVDFDu0EJhm9w8HlXvlR0GneXuCTmLLUjZI4HIG8P0
         +s1A==
X-Gm-Message-State: AOJu0YwANWg6ZMnZPW8kShaSCppcnuSQrey9upTU/qbAujojBOMfqox7
	vP6aSXn6pR2AOrf1YJ9t19GztQJiP81MXA==
X-Google-Smtp-Source: AGHT+IE76Y8hprK6/FX8obW26kFU4/Ec8lUy0x0+lATk6+++AhIfumsuIrzjjbjO9pLr10ZilSlScg==
X-Received: by 2002:a05:600c:1d08:b0:40d:8ed9:ce8c with SMTP id l8-20020a05600c1d0800b0040d8ed9ce8cmr302530wms.120.1704871581188;
        Tue, 09 Jan 2024 23:26:21 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id fs23-20020a05600c3f9700b0040c11fbe581sm1129574wmb.27.2024.01.09.23.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:26:20 -0800 (PST)
Date: Wed, 10 Jan 2024 10:26:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthias Yee <mgyee9@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: fix open parentheses alignment
Message-ID: <3778e52d-9ac5-4648-85e9-539b13e19d25@moroto.mountain>
References: <20240110072304.2226-1-mgyee9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110072304.2226-1-mgyee9@gmail.com>

On Tue, Jan 09, 2024 at 11:23:05PM -0800, Matthias Yee wrote:
> Adjusted whitespace to fix checkpatch warning Alignment Should Match
> Open Parenthesis.
> 
> Signed-off-by: Matthias Yee <mgyee9@gmail.com>
> ---
> Changes in v3
> -fixed line wrapping for commit message

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


