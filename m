Return-Path: <linux-kernel+bounces-7390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7E981A740
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51BBA1C237FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB0C4878B;
	Wed, 20 Dec 2023 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBGQ/oGH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30A3482F4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so13158a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703100296; x=1703705096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G3r2jEuboXnt0TyTccKW6CqAS7wWsR7OcHQYWrEfYgk=;
        b=eBGQ/oGH4ttsIRETiVhphdmP8E0ratJH9w9+T4pFAA38BitAKjJMdVBzdrtuFehhUb
         4JrejhktM2P/Yc/hzERTC9K294/yNtWzyjfTRnvXBPKVGFRDZROCN8Ph2An6r96pFDU9
         RCukNEJVbvl/teauL1wf0tATIaNPz4icAMV0LAJ20s/BBK+7eBwPTzv9kJbV+32QfvhG
         7+LNEnvFaNFXEaGq0IkJwK5INDsdmYAbfyy8FuyqktCKbs40xiMHBSS/AL8XJb5c9LqK
         yHxB7sDgSYLCpGb6U3N4JfIoUtCvzpIEWXy5SqIMj2X5dpDTKOvezonZF2UegOlUP78E
         eFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703100296; x=1703705096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3r2jEuboXnt0TyTccKW6CqAS7wWsR7OcHQYWrEfYgk=;
        b=hH0c7ZTAVP58aTgStBNpecYUulzezFpjQb/gKJPdNxGl1Qxl8MbfmC/Yp36NMjTHfu
         8knsE1RfWfSKcehknloQI0Z4BG6D/kqb1DqLSflQgzQF8dnUZ0yABBZVb4K3zk4oXoQU
         UIWaF4ekALY5FuAgd7xF1rsmOte+nI9AvOsDcITZ5CWvoRf5WL2n7/mQzGgL+F8rPw8B
         +0NK4cH19J/HrnoGvZKUyXoXQLNIG6RuQT1zYDWSGzOLDxmE5XHmx1yaCzqllQIqSWvI
         vsuSV7bppBnN7STWpxiBDmOXYac3Uk9OCJpGj6uGNt2AuBwS7af75ByFkcWOUjTC7eYH
         9iZw==
X-Gm-Message-State: AOJu0YxaAdzaxccL3KpM68JPV9sQivPMA2VCRl/L01TWvQoiYdt80x7B
	FzNobVBkOxPMEEqLtzQhkvoz0w==
X-Google-Smtp-Source: AGHT+IE10Hi1D4FeGuaDp33730ilQCSEdYF4Q1r3oFM/U/FYVIIElNunnOAF0gcrcSMw42C8IsArdQ==
X-Received: by 2002:a05:6a20:e123:b0:187:7761:6155 with SMTP id kr35-20020a056a20e12300b0018777616155mr209907pzb.55.1703100295875;
        Wed, 20 Dec 2023 11:24:55 -0800 (PST)
Received: from google.com ([2620:15c:2d3:205:a8ff:6a0c:2784:5a34])
        by smtp.gmail.com with ESMTPSA id n38-20020a056a000d6600b006d3dd365a76sm134211pfv.2.2023.12.20.11.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 11:24:55 -0800 (PST)
Date: Wed, 20 Dec 2023 11:24:49 -0800
From: Nick Desaulniers <ndesaulniers@google.com>
To: Tanzir Hasan <tanzirh@google.com>
Cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] platform/x86: hp-bioscfg: Removed needless asm-generic
Message-ID: <ZYM_gZAdEnczZiBz@google.com>
References: <20231219-hp-password-v1-1-052fe7b6b7f1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219-hp-password-v1-1-052fe7b6b7f1@google.com>

On Tue, Dec 19, 2023 at 10:10:52PM +0000, Tanzir Hasan wrote:
> asm-generic/posix-types.h is obtained through bioscfg.h so there is no
> need to include it.

I verified that by:
1. building with V=1
2. taking the compiler invocation and adding -H

. drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
.. ./include/linux/wmi.h
... ./include/linux/device.h
.... ./include/linux/dev_printk.h
..... ./include/linux/compiler.h
...... ./arch/x86/include/generated/asm/rwonce.h
....... ./include/asm-generic/rwonce.h
........ ./include/linux/kasan-checks.h
......... ./include/linux/types.h
.......... ./include/uapi/linux/types.h
........... ./arch/x86/include/generated/uapi/asm/types.h
............ ./arch/x86/include/asm/posix_types.h
............. ./arch/x86/include/uapi/asm/posix_types_64.h
.............. ./include/uapi/asm-generic/posix_types.h

> It is also an asm-generic file which should be
> avoided if possible.

Correct, though there is a linux/posix_types.h file.

biocfg.h hasn't seen any changes since introduction; perhaps some reference was
removed in follow up changes to passwdobj-attributes.c, but nothing stood out.

Regardless, this file builds just fine without either (asm/posix_types.h or
linux/posix_types.h), and asm-generic should not be used (as suggested by Al).

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> 
> Suggest-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> ---
>  drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> index 03d0188804ba..f7efe217a4bb 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> @@ -7,7 +7,6 @@
>   */
>  
>  #include "bioscfg.h"
> -#include <asm-generic/posix_types.h>
>  
>  GET_INSTANCE_ID(password);
>  /*
> 
> ---
> base-commit: 3fb7c66ac51a87984e043d9f47b7a509e3f53906
> change-id: 20231219-hp-password-19068dc438b5
> 
> Best regards,
> -- 
> Tanzir Hasan <tanzirh@google.com>
> 

