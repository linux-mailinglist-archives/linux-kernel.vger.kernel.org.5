Return-Path: <linux-kernel+bounces-75149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E899285E3D4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5313A1F227F7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA3382D9F;
	Wed, 21 Feb 2024 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KISnUU3j"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B30467E89
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534627; cv=none; b=uEd6zJjz1ZKZ75ddi19HV/1ma9gDnT+p8OXV//FkEnb6//olv1p9VH7+88huVG422v9MZcV0nOz7XFIFo3QC132YoXauAVOQV+g6mSoPeS3ChIIlaHgBeDEBX7Q2uwXNwyQqEYj2hP9ip0rdTJFYZSJzWXoDSNddOaQnRJKVjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534627; c=relaxed/simple;
	bh=wh1Y68Qw9TiSpJkLvYzv56JbZYASbMgr3+trld1sEeM=;
	h=Message-ID:Date:From:To:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvjzPdHMzDhepaflUWIXbzNXrxFqEZHPSW+Pb9QoerRpy6uZTIqfjk7IpXw6it3o4Li2YtFQZDx5Z9nrz5vtoGCUZykGhETMpltTuPzIa3H3X1y4wiOS3O5uOhaFZxTBeaDBEjbY9vUAZ69OaJI2J8HV2/ao7L/6+a39B05+Ung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KISnUU3j; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7875c347a03so51322385a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708534625; x=1709139425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EjEx5GdMf18n+MVcK0OG2gI0zxVtTpHLxuGAPIBqzlA=;
        b=KISnUU3j9zVeCzJwsndVI6qgrq8GLvv0EmT28YyzoguHbELlLsIeMEhhrwX+fbaVso
         gfyBJq1b2MQESwvNmLXDxp1npvCnasxlgKsZ77byZzjSizwpdkZvVwDEj+p+qjIFkf6d
         Cok5agx7/UNT3+fYoxVpzHdnrc5xceTFquUAOdunL53wwePQ6VGcav0Eojc+954hTrIW
         2pSUld51bKBY62FYbeFiOqNSf5rsOWgn5vWRmj987Bya6Yj+A6TrxJbi/nFikqPr7eCM
         c8a0H4emocmqcHrpORgdRX5TPnfCqOUOP10UOOZFAciD32EddOWeYKs7B+wuX7K9UVIX
         SaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708534625; x=1709139425;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjEx5GdMf18n+MVcK0OG2gI0zxVtTpHLxuGAPIBqzlA=;
        b=FrfpgXgjR17rPJOnymlW+joG8VufrbtIbCiUNy+nfGD5o+3TFfumfVcdqKuGSVfDDD
         wnl6+rx23TEO46GQ9VFqXIbew2bx/Ui5xJIQ0dKeuOkxV34MSdJ5BX0lwhhcxIfiDUOk
         WUPqZWZfjCwi1Bd0mTxIKyU+/r2L3K3N/HkAc6wuiANNd4FFhw+XPRCu06/+EbWdxGQ4
         UOKsvzVD4UZuA+MkorVpMyX1YS46vXRR3djVWbmO9++jqbhihY8pnAWLUQ6JibrEvlrw
         TOaPAVmgy3BFYLq6L/in1jJlPpFbgeBHnad60OsAGtRsVJEqZqwFhFkZWa/Bj6P1R6vE
         YK3w==
X-Forwarded-Encrypted: i=1; AJvYcCXTiKx94pBvZhW1EWL5WOhzhwzbU7+8xOEbk+VXhwoI8Y+4eHeAKrWW1SII31ijhYOKm8KXqwWs55abFo0/J7IsoVPBLomyseZgwtgr
X-Gm-Message-State: AOJu0YyUAzSmtrS5hq9d8881Gtka5E4kcz4uWfmXXDl8hnxUf+/QgjsS
	xWpQW/pgnfjGxM9dvgD7vHnLQJrqm93JnGdq7UfDmzChJcZK0PkI
X-Google-Smtp-Source: AGHT+IGUX8Pf3qFKmT8HFC1cYqwmlRIY6B8oBVLzt8R7MtzZiDl4O99UQOHB0WFLKn6zfQwLYQ1zWQ==
X-Received: by 2002:a05:620a:16b6:b0:787:7f9f:d5ed with SMTP id s22-20020a05620a16b600b007877f9fd5edmr4526752qkj.6.1708534624770;
        Wed, 21 Feb 2024 08:57:04 -0800 (PST)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id os38-20020a05620a812600b0078722793b6csm4477618qkn.48.2024.02.21.08.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:57:04 -0800 (PST)
Message-ID: <65d62b60.050a0220.c7b96.614e@mx.google.com>
X-Google-Original-Message-ID: <ZdYrXKF67tgRKOaF@Ansuel-XPS.>
Date: Wed, 21 Feb 2024 17:57:00 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH v2 0/2] ARM: decompressor: support AUTO_ZRELADDR and
 appended DTB
References: <20240121203009.9257-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121203009.9257-1-ansuelsmth@gmail.com>

On Sun, Jan 21, 2024 at 09:29:32PM +0100, Christian Marangi wrote:
> This series try to address a long lasting problem with legacy device
> that require an appended DTB and the use of AUTO_ZRELADDR.
> 
> With these device AUTO_ZRELADDR is not possible if for some reason at
> the start of the RAM it's needed to reserve some space. (example qcom SoC
> that allocate reserved space for SMEM)
> 
> In the current implementation with appended DTB and AUTO_ZRELADDR,
> the memory start is only derived from the PC register and it can't be
> changed by declaring additional info in the DTS.
> 
> In a normal setup, we have an intentional undocumented chosen property
> to handle this and the memory node to declare the start of the memory.
> 
> With this applied and ARM_ATAG_DTB_COMPAT_IGNORE_MEM enabled (more 
> info in the related patch) ipq806x can boot right away with AUTO_ZRELADDR
> enabled and a correct memory node defined in DTS.
> 
> It's needed to ignore MEM ATAGs as most of the time the values from the
> bootloader are hardcoded and OEM didn't care to actually provide them
> resulting in funny situation where a Netgear R7800 with 512Mb of RAM
> have Uboot passing 1.7GB of RAM with ATAGS.
> 
> While MEM ATAG may be broken, other ATAG like serial number or bootargs
> might still be useful for partition declaration (cmdlinepart) or other
> info hence DTB_COMPAT is still needed in these case and can't be
> disabled.
> 
> I'm open to any suggestion on how this can be improved and I would love
> some additional testing on other legacy platform but I assume this will
> permit many legacy device to be correctly supported without having to
> hardcode address.
> 
> Changes v2:
> - Add Review and Ack Tags
> - Use IS_ENABLED instead of global variable
> 
> Christian Marangi (2):
>   ARM: decompressor: support memory start validation for appended DTB
>   ARM: decompressor: add option to ignore MEM ATAGs
> 
>  arch/arm/Kconfig                        | 12 ++++++++++++
>  arch/arm/boot/compressed/atags_to_fdt.c |  4 ++++
>  arch/arm/boot/compressed/head.S         | 22 ++++++++++++++++++++++
>  3 files changed, 38 insertions(+)
> 
>

Any news for this?

-- 
	Ansuel

