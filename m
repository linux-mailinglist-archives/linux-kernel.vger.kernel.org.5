Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644F775970A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjGSNfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjGSNfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:35:02 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF9110A;
        Wed, 19 Jul 2023 06:35:00 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so6839930276.3;
        Wed, 19 Jul 2023 06:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689773699; x=1692365699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ohi9eAkzosqxAXnsMA/wz1vAHobdzzbfArTEu065q9s=;
        b=QViHAUg4gCWTApYFar1FMfjEzYljcMWrNOt3Hc0iorDQjGgF60+Oke32r57DDgyJWb
         qbUzB0JSvzPpkoMiVclgET+flhnrv1BUmWbwsOFFIED8giuG+G7wucgkt2Kkza6Gf8gp
         jh9/KFCGVxp/XPTC1AclKJ10ecAL0enfhDMjHUEQnmk28E14VVOxyZF1DyMCvPT51gRs
         3oLj9uIwetKY3jGaKGTT8UsAjcXLiQObJxWyOFt02s7GzPequmuxWQGADtgA/WhqBAA3
         x2f1tRqj/4mw3g06cu+9RrK+GiqvrIXK8vZ0RVVOGyMZyEf08ahE4wf3KJ5FOPgUkra8
         98DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689773699; x=1692365699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohi9eAkzosqxAXnsMA/wz1vAHobdzzbfArTEu065q9s=;
        b=Ssym+PMq3nskk9RoczXO49a1zMpyA94ChpelAJz2yKpbAWsfQ4bIv27EONEiN4Xi8c
         wC5+/252pncCZ6uWfEhbLKzzAgGg8OWduakMHMl5khTgX9jAokU++9EhvSVpPm6WVNff
         cK6wtOQORHaEVnXYKrc/2o2aejyfmBhHP3auPDpMmfDZe+csai/tOo4J+7kxqO/AozII
         ahnZMpMmfIpzp9PPkHYdjaaN0ZZg40qe+yZxNdo7W8di/adwLP46UxBHzgJQCuNBPOpx
         vdFtMd8iWVViCRDwlhKt3ixJLekYwSfRVRyQ973UkxcJ3L36Nw8xZUIBImI19nL/sHax
         nVhw==
X-Gm-Message-State: ABy/qLZjRCzDBHOCwn05QpkGBJtK3vXUIdNCpNAGsKWwW/KzXG6+oSCT
        5aKV+ZCs3MXftX65O+Y7MAz1/VzIa7g=
X-Google-Smtp-Source: APBJJlEvHx0thQF4EcaGMK2MMxyVejL/lKmuY5QMB6aWxtjO316JHXbBJ6F8i34QBdSe4QZkMvL0XA==
X-Received: by 2002:a25:81c6:0:b0:c42:97f9:cda6 with SMTP id n6-20020a2581c6000000b00c4297f9cda6mr2621439ybm.29.1689773699257;
        Wed, 19 Jul 2023 06:34:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p4-20020a257404000000b00ceb2ac48b9dsm703600ybc.10.2023.07.19.06.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 06:34:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1322270b-da95-7e7c-0a68-fc883ba09dc9@roeck-us.net>
Date:   Wed, 19 Jul 2023 06:34:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] hwmon: (peci/cputemp) Add Intel Sapphire Rapids
 support
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        iwona.winiarska@intel.com, jdelvare@suse.com
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20230712091241.3668454-1-Naresh.Solanki@9elements.com>
 <20230712091241.3668454-2-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230712091241.3668454-2-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/23 02:12, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add support to read DTS for reading Intel Sapphire Rapids platform.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

I don't know what the plan is to apply this and the next patch, since
(I assume) it depends on the first patch of the series. Assuming it will
be applied through the peci tree:

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
> Changes in V2:
> - Refactored from previous patchset as seperate patch based on subsystem.
> ---
>   drivers/hwmon/peci/cputemp.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
> index e5b65a382772..a812c15948d9 100644
> --- a/drivers/hwmon/peci/cputemp.c
> +++ b/drivers/hwmon/peci/cputemp.c
> @@ -363,6 +363,7 @@ static int init_core_mask(struct peci_cputemp *priv)
>   	switch (peci_dev->info.model) {
>   	case INTEL_FAM6_ICELAKE_X:
>   	case INTEL_FAM6_ICELAKE_D:
> +	case INTEL_FAM6_SAPPHIRERAPIDS_X:
>   		ret = peci_ep_pci_local_read(peci_dev, 0, reg->bus, reg->dev,
>   					     reg->func, reg->offset + 4, &data);
>   		if (ret)
> @@ -531,6 +532,13 @@ static struct resolved_cores_reg resolved_cores_reg_icx = {
>   	.offset = 0xd0,
>   };
>   
> +static struct resolved_cores_reg resolved_cores_reg_spr = {
> +	.bus = 31,
> +	.dev = 30,
> +	.func = 6,
> +	.offset = 0x80,
> +};
> +
>   static const struct cpu_info cpu_hsx = {
>   	.reg		= &resolved_cores_reg_hsx,
>   	.min_peci_revision = 0x33,
> @@ -549,6 +557,12 @@ static const struct cpu_info cpu_icx = {
>   	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
>   };
>   
> +static const struct cpu_info cpu_spr = {
> +	.reg		= &resolved_cores_reg_spr,
> +	.min_peci_revision = 0x40,
> +	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
> +};
> +
>   static const struct auxiliary_device_id peci_cputemp_ids[] = {
>   	{
>   		.name = "peci_cpu.cputemp.hsx",
> @@ -574,6 +588,10 @@ static const struct auxiliary_device_id peci_cputemp_ids[] = {
>   		.name = "peci_cpu.cputemp.icxd",
>   		.driver_data = (kernel_ulong_t)&cpu_icx,
>   	},
> +	{
> +		.name = "peci_cpu.cputemp.spr",
> +		.driver_data = (kernel_ulong_t)&cpu_spr,
> +	},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(auxiliary, peci_cputemp_ids);

