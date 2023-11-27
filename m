Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA787FACC4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjK0Vrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0Vrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:47:51 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC08C95;
        Mon, 27 Nov 2023 13:47:57 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-280cd4e6f47so821981a91.1;
        Mon, 27 Nov 2023 13:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701121677; x=1701726477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yENf5zK8npnEq3zXzznQUfMJ+TQe/R8aXuxIDKQvB2c=;
        b=kRLBlIWkEO2IAGP4e+aeXkezW9FH4YZLLimCqu/bS0U/nm91PZcvLgJLOhFgZPk0nL
         Nx4DVMTtaaxDsiiWqjl27eV9j+aCL/4wzOfqh6Vb1iaw0bDuUAwZsYNXNMru0Emh+Od/
         YL5pQF3OFSofIfCuA2PHCcvUlI01SkX1t0N59bkMY2SAfnAvQ+u/4XKyEKRgxFoQQJPo
         bHWevMnoPGED7Mi/rjt75dnI6Z/3CYTr/eeM872Rx9SOZ9zQ/OUp1r4vz4PspN7sjm5x
         ibRr4SMdzpie9hOw0ERl8O/74l2y2azz2V/ll8IGkB0R1L41301U2F8Zrm56ITU8hVwI
         7dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701121677; x=1701726477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yENf5zK8npnEq3zXzznQUfMJ+TQe/R8aXuxIDKQvB2c=;
        b=iY8ZJLZhqkRC+a9xV95OHMF5c/m2tWyax9A23ygTCEqtYSzcEDL2I+Xv+c4clxfzr7
         KUgOEqMxm2rJ0647qlxd7bnqINgUO8C3yBjk/mbr4iYfyKLbDWYz/6u5vjTw0DstyMEq
         wE41UNGo7MkfBV+CkEl6uiHlaeeqaE7Kiibow3CF/vWAyQioKlBxGkV0PMNlfBADRUL9
         vCrxyH2gBID42+/2o9B9/ShGXJtyRC8kueriBccKRfpGQwgHO64FNzPWDiACGjUBe8Cg
         2KPtk1xKsbkW6Jd3+oJKudgFWykataAOGk6OTuw3vyeceZEfP10RnVCXKqRCESW2XTBF
         W/CA==
X-Gm-Message-State: AOJu0YyFobCCET7CWEPfkgWfxyMD0ShBaOGMlAPy+uHA23JGv/JEEbhi
        MdT7w2FOYN6YOfMr2UOMgK4=
X-Google-Smtp-Source: AGHT+IEOSnhIcLBo96G7tVBzj7G7TEY3gt/PrGp7hjwInGYPB+a6key28Rd+N+mtFsDYB9Dn3jgLWg==
X-Received: by 2002:a17:90b:2388:b0:285:e55:68b8 with SMTP id mr8-20020a17090b238800b002850e5568b8mr13652253pjb.1.1701121677347;
        Mon, 27 Nov 2023 13:47:57 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001cf6d5a034dsm8700276pld.209.2023.11.27.13.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 13:47:56 -0800 (PST)
Message-ID: <916abed0-23f7-482c-b7a1-c2a081ac2122@gmail.com>
Date:   Tue, 28 Nov 2023 03:17:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver : edac : Fix warning using plain integer as
 NULL
Content-Language: en-US
To:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, qiuxu.zhuo@intel.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231127202906.GIZWT8EgKxGzLQTRtw@fat_crate.local>
 <20231127214156.432669-1-singhabhinav9051571833@gmail.com>
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231127214156.432669-1-singhabhinav9051571833@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 03:11, Abhinav Singh wrote:
> Sparse static analysis tools generate a warning with this message
> "Using plain integer as NULL pointer". In this case this warning is
> being shown because we are trying to initialize  pointer to NULL using
> integer value 0.
> 
> The reason for this change is that use of numeric 0 for a null pointer is
> unacceptable. See this link for the long description why:
> Link: https://www.spinics.net/lists/linux-sparse/msg10066.html
> 
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
> v1 -> v2: 1. Fixed the comment section descrbing the current code.
> 	  2. Added a reason for why this change is required.
> 
>   drivers/edac/i7core_edac.c | 4 ++--
>   drivers/edac/sb_edac.c     | 6 +++---
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
> index 08bf20c60111..4c76d0f180ec 100644
> --- a/drivers/edac/i7core_edac.c
> +++ b/drivers/edac/i7core_edac.c
> @@ -376,7 +376,7 @@ static const struct pci_id_table pci_dev_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_nehalem),
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_lynnfield),
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_westmere),
> -	{NULL,}			/* 0 terminated list. */
> +	{NULL,}			/* NULL terminated list. */
>   };
>   
>   /*
> @@ -385,7 +385,7 @@ static const struct pci_id_table pci_dev_table[] = {
>   static const struct pci_device_id i7core_pci_tbl[] = {
>   	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_X58_HUB_MGMT)},
>   	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LYNNFIELD_QPI_LINK0)},
> -	{0,}			/* 0 terminated list. */
> +	{0,}			/* NULL terminated list. */
>   };
>   
>   /****************************************************************************
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
> index a3f50a66de33..5d9a2963dc54 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -439,7 +439,7 @@ static const struct pci_id_descr pci_dev_descr_sbridge[] = {
>   
>   static const struct pci_id_table pci_dev_descr_sbridge_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_sbridge, ARRAY_SIZE(pci_dev_descr_sbridge), 1, SANDY_BRIDGE),
> -	{NULL,}			/* 0 terminated list. */
> +	{NULL,}			/* NULL terminated list. */
>   };
>   
>   /* This changes depending if 1HA or 2HA:
> @@ -576,7 +576,7 @@ static const struct pci_id_descr pci_dev_descr_haswell[] = {
>   
>   static const struct pci_id_table pci_dev_descr_haswell_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_haswell, 13, 2, HASWELL),
> -	{NULL,}			/* 0 terminated list. */
> +	{NULL,}			/* NULL terminated list. */
>   };
>   
>   /* Knight's Landing Support */
> @@ -686,7 +686,7 @@ static const struct pci_id_descr pci_dev_descr_broadwell[] = {
>   
>   static const struct pci_id_table pci_dev_descr_broadwell_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_broadwell, 10, 2, BROADWELL),
> -	{NULL,}			/* 0 terminated list. */
> +	{NULL,}			/* NULL terminated list. */
>   };
>   
>   
Thank You, for explaining me what needs to be done. Yeah without a 
proper reason a change is never really clear which can be confusing to 
anyone looking. I will make sure I add a reason in every patch from now on.

Thank You,
Abhinav Singh
