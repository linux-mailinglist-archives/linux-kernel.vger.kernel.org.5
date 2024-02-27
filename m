Return-Path: <linux-kernel+bounces-82771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF21868973
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0591C21841
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34FE54BED;
	Tue, 27 Feb 2024 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGV5cRn6"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D6F54BCF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017164; cv=none; b=F/zqTvh3gQHCoSzkY7D9UP4R+2x801BEeflFSUR4gXi9En9npLD7LN5zI9xvP6J2/I7NGPeDbXjJl2f6PTjuX3Qgfu5IRfByC8oN4Qx7GfZEHPrAvZsfSuKKM3F4aWDryFnvEpcOGvEVOB3yKXwYLQ3Thbqf/t94POzp5UEZzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017164; c=relaxed/simple;
	bh=vc4XeNHKboLhVCJFQrUuVUM2zKD2sNEwLsiP/Wd1Df4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mo5+8avjMBZmjQJQg4GhHaT2Ma/VrfJdJjvIvOrEAwmK6O+SgZwqQ5bntBzefZXD5/zZYPN6tufj8I5pTyCEA2QCoS74CzApaNiJZ5J4AqWdcFH4JbiCxHUHRVa4RGxw79CG6Au+d3/gSVPLDNVZPxPHd1wRcNteZVeB7BOEVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGV5cRn6; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d28464c554so30787331fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709017160; x=1709621960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CnSkxBusm54u4LGQ9Qtvtg38+ac26g3umiSCmvFbMfs=;
        b=GGV5cRn6Qw5+ESBQpPN3jq7LrH0B1ebl6JMe8Ah2Zo/h3itxLIBemVUfPA/Vc7vB3D
         rLMOHQEqDemMtlf3z+0i2SYcMC9wScc6kHklsw3laeeuiN7mS4noIJQV/sjtKPBYZScf
         KdMHUR9NTgUT9s1ElEKBFc6/R8J0lhCRT/wwq6xXh93brFKKZfliSHHUhpPQHUeZ2X4+
         qQVybl+2TuoaM/U+Tu7ifdlRIKrbW3vWFtL448jVPn/Jtwt6xKlOLpYzynFenYjOUNQp
         +2na+iU/Nmcv9O6ydbjwyHTUWFXI1IA7cWJ0RzX2iuKD0SEjpL7FD2WeOWqwpJPMmuAv
         iPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709017160; x=1709621960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnSkxBusm54u4LGQ9Qtvtg38+ac26g3umiSCmvFbMfs=;
        b=BXiEiwjQmXVzLq/gt1Ake8CB/m6ymG1oplJM1imNoyGIOXmiHRewGEK794ATtEFHZj
         tMyO2Q+1KCmg4qgXMG5jjKJBRzdh19X/EPDJnEz0fMokkiUxuO49aB4DBo7dLvRRrEWQ
         MG6FuNQDxOsw8qM5uS49PiqymWs1RYpPCD3RCPQcy/bNrTlq8WOGIH0yWAIGB9fyzjQU
         UvTwbI7+IYWkSUV+4lPHVcCPhyTPaCj72Biai08+iC9i1fZoHZtLEs2k2K9CBoCyzZbV
         VkEppiGCwLdr49GzORzZ1kscnsyXGbVGMfBSJnEe5zFaiJXazzjCCo6kQOg4skLPbuIT
         CB8A==
X-Forwarded-Encrypted: i=1; AJvYcCVTHPN/GP3k1z/Ew/v0emXjDshWg13b3NCMreriIAwzvOlTJpvDF+9GHlNuzbRZKatI1giFsKdq5ZFFbj6QCSVVwCJks7rM+x9qDj9A
X-Gm-Message-State: AOJu0YzYQw+leRNFAOoF/jU2NVYRd6sUM0TbucdrpTGkUYwxd8Zmm+hU
	MH2Y0OjMEB7BUJ3eMQJByy96ZjJZWwuNMOgXxTO7sTfhs19CNKVB
X-Google-Smtp-Source: AGHT+IG+SkBw04nHiBsMtpnkGl6++qqPTT4h9JorJC4LwWOfmwgybJ+J915v/fkCT2B0EUPD219CuA==
X-Received: by 2002:a2e:9793:0:b0:2d2:25bf:d80a with SMTP id y19-20020a2e9793000000b002d225bfd80amr5321410lji.5.1709017160426;
        Mon, 26 Feb 2024 22:59:20 -0800 (PST)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id h1-20020a2ea481000000b002d292191b10sm294670lji.36.2024.02.26.22.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 22:59:20 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 27 Feb 2024 07:59:18 +0100
To: Martin Kaiser <martin@kaiser.cx>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] lib/test_vmalloc.c: drop empty exit function
Message-ID: <Zd2IRlYaBLDOVboY@pc636>
References: <20240226191159.39509-1-martin@kaiser.cx>
 <20240226191159.39509-3-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226191159.39509-3-martin@kaiser.cx>

On Mon, Feb 26, 2024 at 08:11:58PM +0100, Martin Kaiser wrote:
> The module is never loaded successfully. Therefore, it'll never be
> unloaded and we can remove the exit function.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  lib/test_vmalloc.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> index 191b6bd5dff9..d0c0cbe1913d 100644
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -600,12 +600,7 @@ static int vmalloc_test_init(void)
>  	return -EAGAIN; /* Fail will directly unload the module */
>  }
>  
> -static void vmalloc_test_exit(void)
> -{
> -}
> -
>  module_init(vmalloc_test_init)
> -module_exit(vmalloc_test_exit)
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Uladzislau Rezki");
> -- 
> 2.39.2
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

