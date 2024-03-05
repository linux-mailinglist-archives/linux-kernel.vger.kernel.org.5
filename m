Return-Path: <linux-kernel+bounces-92796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11490872614
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4089A1C22B5E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012C117BC2;
	Tue,  5 Mar 2024 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNqkpBd3"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF042179AE;
	Tue,  5 Mar 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661450; cv=none; b=Gi3oaXboIpbH7O260QVCHzliHXVrFPvJupmD6dgXbO/TEEt7XRcCLbKRlVFXDy80oqnpV3w8KYXVaEt9nakH7pkW8Dt/sMoPQT1m5qK69LoRPNK4rGQDe+g8DK1siW34RsKyZcJezayAQLuG8nP9PuLjllLiyOnm8kfd/n+n6Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661450; c=relaxed/simple;
	bh=bVxVS3ZGUjqlqgdrOWmfCxp+oYUjKgtDAL1tm4EWlN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/FPD4XMmzBS9FrdX23wLEIwR3q4B8d5kVauqMD/TbvKGgYju2VU3S4VA4ALHbmpROpOANSEi6dsKKJ1cw3Wih5LunOMvBLi4K17rx7AN+9gRo8GYCfiUtisdyVAMqnLCIRcin0mXmXnx6eSplOaKWy5YrS7AYOl6OOFEOvFlAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNqkpBd3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6381df003so37006b3a.0;
        Tue, 05 Mar 2024 09:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709661448; x=1710266248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJDGsyF4mopA/H2UWXnK0dSUCuet93iJDyDnyA6ycws=;
        b=iNqkpBd3zlKlGANtuR7ZI6VHVs1ovUc6EydcFuntHB+l9Nf3ULeOpTXOiQA24GleuC
         Z8NCVNRXLPMTyPqlkS9ETUyIhjaeHomWZ5rRciFhCncwTo33sX6SpTKnPpsdFQCrb4Or
         14ttGtlIYr5oYsWn1M4mgIbxUCdsW2A7QgGlxFMYcZm8OOPLq4dVBzRgwZ3GIMISNpKg
         u+EMPP4szMJ4r3G+CHCMsjzPRUGCr8RX5cjx4VXJqmIvmRVKw+aqyhgBrwvdHR5/cg1/
         RvxKOpdee0aNnput2mkiKO8QGv7U9g7Z7pL8u4cfr4BMm9LDhZRfSzb1X1/JqNFKUxOV
         sMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709661448; x=1710266248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJDGsyF4mopA/H2UWXnK0dSUCuet93iJDyDnyA6ycws=;
        b=XKCdktURvQleaLxCUp39SgSqIar4zt0eq4BrdLHqaqCqG3jsPdK+vkJq5LI7ZtL7aT
         K9pXdvTUy6TWqlxC8hoEDL1BRAUHnZ49q9K8g0BpbRHYpYfhvhRkqNk0PIZrZSG4ExVv
         Ma5/rKIbt8kUgdtsF3gVLpWHNkfRB74VaxDC7WTktdjdGsvW0dWw1RUpts6TqV/mHRAf
         Na+xeLz+mq1F2pRat8i3bEfsS6Obwj/E5bdKerkxIPcWug2QpZHMytZcko1IS8S0upty
         riypLxCyy2gRsEBTy06jslr1RoVcTQ3woG0IkW+btf1fDwCuaWLPVz2H1y8ykaGVfobZ
         W1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfej7qwWo9bxJtgIeIbyjTVSGoepMlaKYAuMEuaxbEGzpZoTjMVMA2w7prjQnCOwicIDlN0SJh0Tjf6VK7OwsYc8kse17f6PmoP2jM
X-Gm-Message-State: AOJu0YyfLAEcerz37EAiN8iGE+N2Nx58zWsC0nn/qr4DeWNU1xw+1aEl
	q6eME9+KR0xexFCAnKlBIQp6DOpSeo1cEbJe/px4CqGnpka+27gX
X-Google-Smtp-Source: AGHT+IFK9QVCvBx7zA0rQGSm0P2UsjGoafUWHPUEIsVqLUTCeSTXEUH2vnr0jJRUJaC0ItL+lAmjCg==
X-Received: by 2002:a05:6a20:651d:b0:19e:a36c:36ef with SMTP id n29-20020a056a20651d00b0019ea36c36efmr2004631pzg.48.1709661448198;
        Tue, 05 Mar 2024 09:57:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090a051000b0029932d64c2bsm10996551pjh.17.2024.03.05.09.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:57:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 Mar 2024 09:57:26 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH v1 2/3] watchdog: intel-mid_wdt: Don't use "proxy" headers
Message-ID: <72cd08af-7334-49f7-9ac3-5a9ef93ed134@roeck-us.net>
References: <20240305165306.1366823-1-andriy.shevchenko@linux.intel.com>
 <20240305165306.1366823-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305165306.1366823-3-andriy.shevchenko@linux.intel.com>

On Tue, Mar 05, 2024 at 06:52:19PM +0200, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/intel-mid_wdt.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
> index b41c45582aa4..06d5d207a065 100644
> --- a/drivers/watchdog/intel-mid_wdt.c
> +++ b/drivers/watchdog/intel-mid_wdt.c
> @@ -9,11 +9,17 @@
>   *      Contact: David Cohen <david.a.cohen@linux.intel.com>
>   */
>  
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
>  #include <linux/interrupt.h>
> +#include <linux/math.h>
>  #include <linux/module.h>
> -#include <linux/nmi.h>
> +#include <linux/panic.h>
>  #include <linux/platform_device.h>
> +#include <linux/types.h>
>  #include <linux/watchdog.h>
> +
>  #include <linux/platform_data/intel-mid_wdt.h>
>  
>  #include <asm/intel_scu_ipc.h>
> -- 
> 2.43.0.rc1.1.gbec44491f096
> 

