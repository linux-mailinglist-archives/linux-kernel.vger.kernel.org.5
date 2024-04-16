Return-Path: <linux-kernel+bounces-147694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061B38A77D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62871F217A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249F31E889;
	Tue, 16 Apr 2024 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChUkTmyH"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052439FCF;
	Tue, 16 Apr 2024 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713306894; cv=none; b=LpY+7YCvRsKd6Z0jLqpwFeQulsP7IhrJZ11RH0I/HN4ekiSUpYavdz0gmBOibtAa5iFIK35UWc87uO1uyYe1VrQYznip7GYc7k27+sjeu+0mSI6KrC7gCc8/YmNrIxakhsUWOPuuDadDcAA/eUf5jbsA+QnpS2sUOhsURC2Px2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713306894; c=relaxed/simple;
	bh=TIppXwoyy7JCBAG2mGLWtbBQ6zU3Bx81FBr226GDJ+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmHN7sMVkPP1hbUQTtfwNBovHBtlgm7SAB2PKwhtYzywnfK269TSKuZRWCPipw5GCJcXHfip2l0hkAt/by03Y4jNoVN3V28T3yNqIVUDUPNX7o+mC5NttNUyS1pAECa3XLg9aWDVrhrsoPZE01jjnKlZy0atc50zNcwKkY/9HZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChUkTmyH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso3733516b3a.1;
        Tue, 16 Apr 2024 15:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713306892; x=1713911692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYEBHSAYBc3ncttOdz1OGEIHHb3oWxG6brf944qm+EY=;
        b=ChUkTmyHQEOT7YuOAD6yPJOBOza0sjR79JtTCqlqeQnX6cgJNdOpKDsaAcu9JseqvK
         nnTW82Rf7+aHtWTmpK/HQWP/F9a/rfXIwX8/8QVL2gvCFCu+0NMQER/IqgsCt6G2Pyz5
         Y7NuP8CHbYssPRmQsGIlHYRZ04Io7uab3lhM+bn2niL0XGF9HqT6E98ybydxVVpqCdcZ
         MqZSLdpZqTcA3jLXNLv+ZKAG7igdqxyqYvvbSMB5ejviOB4QOCTvwp3axnh+GQFGeUC7
         2hoiSt90i48vCb/ytW8Lt5a9Wv7TO2btpZ7sHGplBjJ41f2V4WZOISAKtXQKNCvEDvET
         Pi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713306892; x=1713911692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYEBHSAYBc3ncttOdz1OGEIHHb3oWxG6brf944qm+EY=;
        b=FNp/2uKR7ZoTQCiF+ombIzjMJPjLno5RnRHmMy9NiVX/iNx31omtZ79eztPB9DDtXX
         S0ZThRpLm8u8K/EC1KoMGR1whTU5uUn8hCzpTpvWohRvUPtLNK3VNGX7FRTdqPeEsCQo
         ZsC4GLzgcvfZVte04lTWFN0eCufeQaa/7xS+OcJ8953g9Fh7fUd43C3fxcUar8ahCNFE
         mB5qEZLkSAUijNDZ1rWhbeXYitSWnfpBbqio2QOJ1H7WDO+Ichk4qU3hXtmRXLEU5nki
         x2ICBad4qU9E/ZSmzfrJmTky7+NxbR/h3nq6yJqQR7qh9TR5TQXe7uOwJUrMy2b0Mumw
         yVyg==
X-Forwarded-Encrypted: i=1; AJvYcCVcuE30lOc92FSaIYfumvL/CRqDFEY0roQ3biKjMKIj/MdQgZGh2QiC12rAoEXv3D0KciD1ukVwvBuWU3tk30em6dInoAErIb0gmA2wCVA9rKalNIqTWn4KhtDrzDVr2EH4Ci+YznxJ6UA=
X-Gm-Message-State: AOJu0Yxnt5cQXs2qqjo7fLTABlVs6ECjacPum3DFJTtc6Ir3H/6kPZtb
	AIRNEeNTfkRpjll7zSWv6+2ePI2ad2phmEb9VX28X8VxbLZUsljp
X-Google-Smtp-Source: AGHT+IFh/zIfLrwa77zo+Wv6gz7XzJ//wE0dD/DGVm2QVPsw21WOGIkW96K3P/dBgSNVdt8rRN1gYQ==
X-Received: by 2002:a05:6a21:498a:b0:1a7:56d2:66c1 with SMTP id ax10-20020a056a21498a00b001a756d266c1mr13935301pzc.29.1713306892189;
        Tue, 16 Apr 2024 15:34:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q14-20020a62ae0e000000b006ecde91bb6esm9413744pff.183.2024.04.16.15.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:34:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 16 Apr 2024 15:34:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tony Luck <tony.luck@intel.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Iwona Winiarska <iwona.winiarska@intel.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v3 50/74] x86/cpu/vfm: Update drivers/hwmon/peci/cputemp.c
Message-ID: <5869d164-25c4-42e5-bf87-c4aeeac57388@roeck-us.net>
References: <20240416211941.9369-1-tony.luck@intel.com>
 <20240416212216.9605-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416212216.9605-1-tony.luck@intel.com>

On Tue, Apr 16, 2024 at 02:22:16PM -0700, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/hwmon/peci/cputemp.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
> index a812c15948d9..28cec5c318d4 100644
> --- a/drivers/hwmon/peci/cputemp.c
> +++ b/drivers/hwmon/peci/cputemp.c
> @@ -11,6 +11,7 @@
>  #include <linux/peci-cpu.h>
>  #include <linux/units.h>
>  
> +#include <asm/cpu_device_id.h>
>  #include "common.h"
>  
>  #define CORE_NUMS_MAX		64
> @@ -361,9 +362,9 @@ static int init_core_mask(struct peci_cputemp *priv)
>  
>  	/* Get the RESOLVED_CORES register value */
>  	switch (peci_dev->info.model) {
> -	case INTEL_FAM6_ICELAKE_X:
> -	case INTEL_FAM6_ICELAKE_D:
> -	case INTEL_FAM6_SAPPHIRERAPIDS_X:
> +	case VFM_MODEL(INTEL_ICELAKE_X):
> +	case VFM_MODEL(INTEL_ICELAKE_D):
> +	case VFM_MODEL(INTEL_SAPPHIRERAPIDS_X):

$ git describe
v6.9-rc4-31-g96fca68c4fbf
$ git grep VFM_MODEL
$

So I guess this depends on some other patch ?
That might be worth mentioning, especially since

$ git describe
next-20240416
$ git grep VFM_MODEL
$

doesn't find it either.

On top of that, it looks like

#include <asm/cpu_device_id.h>

introduces a dependency on X86 which is not currently the case.
CONFIG_PECI is typically used on BMCs. Many of those do not use
Intel CPUs. It does not seem appropriate to make support for PECI
based hardware monitoring dependent on it running on an Intel CPU.

Thanks,
Guenter

