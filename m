Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1E17F8E12
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjKYThn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjKYThl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:37:41 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916DC129;
        Sat, 25 Nov 2023 11:37:47 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so520467a12.0;
        Sat, 25 Nov 2023 11:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700941066; x=1701545866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDIBxA9kD5zfBqSmoblE0Q36en0y2Rsc1kRyQf2RpvI=;
        b=WlXf1p1jlk3AMMhP2i9eFj7NsDJBibJt6WmdME16HTYcuM0NroEVBPoqQlqyxKEF/1
         p3LFb3/5pQaejmLc90eNvFN49iD2KnO2ep4je11g/Bc3PQHR63Onr1CBjaS4lAl6ws/Z
         JXhc5xrVSnbVOaXPee5Fq//1TanZST6UbS1HkLXbW/+N5YF3Pqj7S+q3ZQUW3hcuJczP
         MjeSxzridUlB2clrWojSgrGK+2qct5gjYmRrQJFvm+dsZsvvqJT12BRsAmxAOGqbDyIU
         EICYy4RWxMfIru5r5nVaxedUZTUybX78OePh9Yv++uWTsCYGOfF3HbL7vGLjDqA+ANwf
         LSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700941066; x=1701545866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDIBxA9kD5zfBqSmoblE0Q36en0y2Rsc1kRyQf2RpvI=;
        b=NaHJKarIqhuNvI2KB61nP56r5elBgSa0WVCOz5j3h+xtZrqi7loTrF48apSGxvMrTA
         23xCKBZ8/klitmJrFCUMPbUgrVfPs4Q3vXjSBvpUNhWk14BTNykPwXaBydk14hSYVO9a
         1a7OkPdmTs+p3GEqmjQrmPIUQMIErpRREPzXG85Bpim0PhFW11kEQhARDH1tFhfv2kWG
         Necd6XoHyoALhWF83YjMHz8SH1nmWfzDwvdSToV5+xyIgMzNHcCnexVEOLNLfA0CbSB3
         eKMgf+Qnf5y0eSKWQw4wsXZ7of7dCAUvXklg9eiHapLTN/ZBPP5D2KKgmWXcFP9RNlQ2
         5e7Q==
X-Gm-Message-State: AOJu0YwLyvahz6DHCiygH+TwCZyeaHR/FNNpFdWzPUzeus6ZP3/HTdFy
        HdgsNqvuFKvGQuKEkzGOC8c=
X-Google-Smtp-Source: AGHT+IENJDWPrj2AQtMqCZGty34ui9ZnqiqL7t6IzyBzgSeVGbG1NqW6Cf2dyMipIYQ2x4bWMQ504g==
X-Received: by 2002:a05:6a00:1514:b0:6cb:d24b:894c with SMTP id q20-20020a056a00151400b006cbd24b894cmr8555929pfu.2.1700941066463;
        Sat, 25 Nov 2023 11:37:46 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id x23-20020aa793b7000000b006cb638ba1aasm4610588pff.49.2023.11.25.11.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 11:37:46 -0800 (PST)
Message-ID: <af53864a-39df-4530-bf3f-5277be8f0d4d@gmail.com>
Date:   Sun, 26 Nov 2023 01:07:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver : edac : Fix warning using plain integer as NULL
Content-Language: en-US
To:     tony.luck@intel.com, qiuxu.zhuo@intel.com, bp@alien8.de,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231109212157.1454726-1-singhabhinav9051571833@gmail.com>
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231109212157.1454726-1-singhabhinav9051571833@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 02:51, Abhinav Singh wrote:
> Sparse static analysis tools generate a warning with this message
> "Using plain integer as NULL pointer". In this case this warning is
> being shown because we are trying to initialize  pointer to NULL using
> integer value 0.
> 
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
>   drivers/edac/i7core_edac.c |  2 +-
>   drivers/edac/sb_edac.c     | 10 +++++-----
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
> index 23d25724bae4..08bf20c60111 100644
> --- a/drivers/edac/i7core_edac.c
> +++ b/drivers/edac/i7core_edac.c
> @@ -376,7 +376,7 @@ static const struct pci_id_table pci_dev_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_nehalem),
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_lynnfield),
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_westmere),
> -	{0,}			/* 0 terminated list. */
> +	{NULL,}			/* 0 terminated list. */
>   };
>   
>   /*
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
> index 0c779a0326b6..a3f50a66de33 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -439,7 +439,7 @@ static const struct pci_id_descr pci_dev_descr_sbridge[] = {
>   
>   static const struct pci_id_table pci_dev_descr_sbridge_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_sbridge, ARRAY_SIZE(pci_dev_descr_sbridge), 1, SANDY_BRIDGE),
> -	{0,}			/* 0 terminated list. */
> +	{NULL,}			/* 0 terminated list. */
>   };
>   
>   /* This changes depending if 1HA or 2HA:
> @@ -505,7 +505,7 @@ static const struct pci_id_descr pci_dev_descr_ibridge[] = {
>   
>   static const struct pci_id_table pci_dev_descr_ibridge_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_ibridge, 12, 2, IVY_BRIDGE),
> -	{0,}			/* 0 terminated list. */
> +	{NULL,}			/* 0 terminated list. */
>   };
>   
>   /* Haswell support */
> @@ -576,7 +576,7 @@ static const struct pci_id_descr pci_dev_descr_haswell[] = {
>   
>   static const struct pci_id_table pci_dev_descr_haswell_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_haswell, 13, 2, HASWELL),
> -	{0,}			/* 0 terminated list. */
> +	{NULL,}			/* 0 terminated list. */
>   };
>   
>   /* Knight's Landing Support */
> @@ -620,7 +620,7 @@ static const struct pci_id_descr pci_dev_descr_knl[] = {
>   
>   static const struct pci_id_table pci_dev_descr_knl_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_knl, ARRAY_SIZE(pci_dev_descr_knl), 1, KNIGHTS_LANDING),
> -	{0,}
> +	{NULL,}
>   };
>   
>   /*
> @@ -686,7 +686,7 @@ static const struct pci_id_descr pci_dev_descr_broadwell[] = {
>   
>   static const struct pci_id_table pci_dev_descr_broadwell_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_broadwell, 10, 2, BROADWELL),
> -	{0,}			/* 0 terminated list. */
> +	{NULL,}			/* 0 terminated list. */
>   };
>   
>   
Hello maintainers, any reviews or comments

Thank You,
Abhinav Singh
