Return-Path: <linux-kernel+bounces-104632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEE087D146
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E661F21AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FA245C06;
	Fri, 15 Mar 2024 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ2f//sK"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3312E71;
	Fri, 15 Mar 2024 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520615; cv=none; b=tXSUqnhbgrYzWaqMFCDt+RlfP1aSu0Q61iVWQXYNtBHLRAvgABnqHz6HpYvsfg6GqJZp/SY4H8vRDdslIVD+27klLS5m433mXgazZp2TGZmndfBn9uIxmQ3AlQRyK9i5empWuY2AQ3TTtHurNzBE+WJR+gaIePR+o5Cml0OVsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520615; c=relaxed/simple;
	bh=uC5VIfkv0Jum6Z0WXV3XmwmF8GY+xRPbShmLcmkydzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffBXqaK0kmpLIf9CAUFeU9s+KmmaM1iaIrXx1lxvQMoY3hxGUihrIaVLk1B2JDWvdX1MY/MVG8XQB1gyiqxNi0sEz/J0wT/B6v10vRjjINvubNGs/e3PdvHwjUHG0zvGjUmLes86t7R7uPmhS5aBluGErpRGrmD+4YVCVvU/LVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ2f//sK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a36126ee41eso285615266b.2;
        Fri, 15 Mar 2024 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710520612; x=1711125412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WAJd17tQUXzgE53aI6B1hdEipyJmkfxL6o6rwzYoy8=;
        b=jQ2f//sKiyW1ELhBfa6alOtDJjXkJGJshSVQb/6GiC7t8tb2/+CIsJ0dHjzRHLxu5k
         A7ieShZ2jFzsOFOK79bqfra0JoGKbS4IYorOUQK50dr9KvxPcWjj+AJ4VgHpTlgWbfsE
         PQ1K+oqTZuerPnAX+ibhvAH9rVzC9hGZ16EwRU5Puy+vgM6dfhHc5D6zkOi4qY/k/Tv3
         WsWJqqTD9UJLwLYOABOkPhba0RBDmRQb9i2Ps8bNv8BklYgPcWtdB8BPU/QjzB0netQX
         2cVmRxcyqcywuGuAJ1By8rJ9EA5HnMI/KUA1NwsN3zb+9pr9jVeiT1E5ZW7XOMsYi4AX
         8+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710520612; x=1711125412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WAJd17tQUXzgE53aI6B1hdEipyJmkfxL6o6rwzYoy8=;
        b=kGPP4+SF02M4VPtgspxUMHgF0ycWLO+hd6/ZYR+ZGmN149IsHxDYutgQflCLZP1zRv
         gThoOjKDoQutO0q2isozjDGMdpStRvrA+/XNI0sxOMKcMHG1ahLcFPR1sAkGZeKXAysj
         ONd822iZ3V4ybvjBxj+cfTvjJWnvoN0UD74yBFm9GPyCSglTN0JY8u4im6H2tyiFH9gQ
         yk8l/cNsjCKvPvgoa91ZTNWISU7ohlcqqmd7A+Na3Tu1iIwqlVqZHrI8GSJPX6L74K8p
         oPbQvIkwElqIv17pnSopkBJPBvGGig1UgGpzyP3foFASIErIEQ4B5fc0Z4CBVyhfyKbc
         UTxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB5qrisQvWL/YPDOh4V3unlgeu1WfvH0IrxWvtTYhrlquQGit7IEopxljVpiJqXh1emFlD7jqacz/cPJAlZFCA1xEP8C4XGaksCEqiGiep1gZ7VVLOKXilA2MxT6gRBWM/hujjBTTVCU4GRPS3A6/vXQYaA49CmPSP4uT+gXa3
X-Gm-Message-State: AOJu0YxuERVCuUDhfK4l1xGKYeYJGVSgj4EhYW1Pgs4HjzX1jwe56Dxt
	4HSmWTg2LWD3qT2B0T66omjphHqRO4WYLD/KTBo+Ba+w1sbMyTL9
X-Google-Smtp-Source: AGHT+IGiLRMeewXTx7ynckmJWlfGqHD8aeux8y1eXng1121L4qb9aJWb8iMJ7SCHqwDWTPkdMjj+4g==
X-Received: by 2002:a17:906:ba84:b0:a46:74d2:a0c3 with SMTP id cu4-20020a170906ba8400b00a4674d2a0c3mr4515276ejd.4.1710520612100;
        Fri, 15 Mar 2024 09:36:52 -0700 (PDT)
Received: from fedora (host-95-250-206-50.retail.telecomitalia.it. [95.250.206.50])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906bc4b00b00a4671d37717sm1758044ejv.52.2024.03.15.09.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 09:36:51 -0700 (PDT)
Date: Fri, 15 Mar 2024 17:36:49 +0100
From: Francesco Valla <valla.francesco@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	fabio@redaril.me, Linux CAN <linux-can@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Documentation: networking: document CAN ISO-TP
Message-ID: <ZfR5IXA9tVHgBTva@fedora>
References: <20240313223445.87170-1-valla.francesco@gmail.com>
 <20240313223445.87170-2-valla.francesco@gmail.com>
 <ZfPUqOVpF8u5738S@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfPUqOVpF8u5738S@archie.me>

On Fri, Mar 15, 2024 at 11:55:04AM +0700, Bagas Sanjaya wrote:

<snip>
> 
> htmldocs build reports new warnings:
> 
> /home/bagas/repo/linux-kernel/Documentation/networking/isotp.rst:3: WARNING: Title overline too short.
> 
> ====================
> ISO-TP (ISO 15765-2) Transport Protocol
> ====================
> /home/bagas/repo/linux-kernel/Documentation/networking/isotp.rst:275: WARNING: Title underline too short.
> 
> Multi-frame transport support
> --------------------------
> /home/bagas/repo/linux-kernel/Documentation/networking/isotp.rst:275: WARNING: Title underline too short.
> 
> Multi-frame transport support
> --------------------------
> 
> I have applied the fixup:
> 
> ---- >8 ----
> diff --git a/Documentation/networking/isotp.rst b/Documentation/networking/isotp.rst
> index d0c49fd1f5c976..a104322ddb6c5e 100644
> --- a/Documentation/networking/isotp.rst
> +++ b/Documentation/networking/isotp.rst
> @@ -1,11 +1,11 @@
>  .. SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>  
> -====================
> +=======================================
>  ISO-TP (ISO 15765-2) Transport Protocol
> -====================
> +=======================================
>  
>  Overview
> -=========================
> +========
>  
>  ISO-TP, also known as ISO 15765-2 from the ISO standard it is defined in, is a
>  transport protocol specifically defined for diagnostic communication on CAN.
> @@ -272,7 +272,7 @@ differ less than this value will be ignored:
>      ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RX_STMIN, &stmin, sizeof(stmin));
>  
>  Multi-frame transport support
> ---------------------------
> +-----------------------------
>  
>  The ISO-TP stack contained inside the Linux kernel supports the multi-frame
>  transport mechanism defined by the standard, with the following contraints:
> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara

Thank you! Fixes (along with some rework) will be applied to the v2.

Regards,
Francesco


