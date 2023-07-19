Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F515759715
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjGSNgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjGSNgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:36:16 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102B8119;
        Wed, 19 Jul 2023 06:36:16 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a44cccbd96so2683595b6e.3;
        Wed, 19 Jul 2023 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689773775; x=1692365775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ2vx/tKf7zzjvUa+sqtKM/x0dVHinqfYDPi5srcm3E=;
        b=IJ0k1i3/+kogGTYB6zcbpuRB3on4TUjyXoCiQxZjJFH4AX35tptgNy1GKF6bm3DR5O
         KJ/Phjqy1fcXGbstssVplRm9Fsz7xk1pnhE7VspMc3+FiieyicaPIR3HHTKAXJv/3yTg
         wsHVifm6dIRpYeB4CtJOLtfzE3OTpagu0TBVNDdSHb8fn855cxAFEJfsU/G3i5pEyX2y
         bSq1EhpN/bqNLfzhNcJgxz8WYuDAVUvNsTclsRTfLCJ71MMaxWljMFfNQUyMkE3j6lIH
         zDXA0icFrezc2RpUF5havMSHbBLDvrKfHlNG/B0/+08ldOqRejTiwjZtZu/aW0nJxH5v
         GurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689773775; x=1692365775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJ2vx/tKf7zzjvUa+sqtKM/x0dVHinqfYDPi5srcm3E=;
        b=Fi7L3icrRuT8qLJsHoLW2xzILuSkusUhMFbDQdR4jgEwuBbk5i5Eg0wbpUtDr3Pks/
         pvbr0zpcA/0DRpwysNSZSiuFSowMfsnUvHYG4Y8t2xERFY9wLRkoTvi92F8uQzKPDyHO
         H74PlHsAkyj5IdoC8s5O1qChLuLlAb/wqyOA2O3TnwBPqCXlVumAJZ0kdKu4swo8ORX6
         D0vQmTo/hmxQbJx/o1IUP8xLqYVuRMLdZfjrujT0CklNHN6JzesnnfOkvzxOtUrst9Aa
         8IsoGqzPiYOigcLTfmBVXydslV7SYXkTkzZj1nxDQSkew5akv8b/hwuDjLsY7qu4NeQp
         fLAg==
X-Gm-Message-State: ABy/qLaVKoeMbuiARRcB+KJFkzqgAiLTKpZcwDMg78DkHvau59ZyOACq
        vC0i1I5bagOJ2stCza7kJVGZ5kNiW3Q=
X-Google-Smtp-Source: APBJJlHVGjAmOWoOgJ5U2OPYf5RbYG+LbvDjDgwqAQITZ6UbFDZuQoaqdyheA+Z369mDOodnFPomwA==
X-Received: by 2002:a05:6358:c1d:b0:133:8a9:b354 with SMTP id f29-20020a0563580c1d00b0013308a9b354mr3085486rwj.1.1689773775083;
        Wed, 19 Jul 2023 06:36:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p10-20020a056902014a00b00c602b4b7226sm843677ybh.25.2023.07.19.06.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 06:36:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cc4fa759-b7c0-61e0-d7f6-e8704aed4e6a@roeck-us.net>
Date:   Wed, 19 Jul 2023 06:36:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/3] hwmon: (peci/dimmtemp) Add Sapphire Rapids support
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        iwona.winiarska@intel.com, jdelvare@suse.com
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20230712091241.3668454-1-Naresh.Solanki@9elements.com>
 <20230712091241.3668454-3-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230712091241.3668454-3-Naresh.Solanki@9elements.com>
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
> This patch extends the functionality of the hwmon (peci/dimmtemp) to
> include support for Sapphire Rapids platform.
> 
> Sapphire Rapids can accommodate up to 8 CPUs, each with 16 DIMMs. To
> accommodate this configuration, the maximum supported DIMM count is
> increased, and the corresponding Sapphire Rapids ID and threshold code
> are added.
> 
> The patch has been tested on a 4S system with 64 DIMMs installed.
> Default thresholds are utilized for Sapphire Rapids, as accessing the
> threshold requires accessing the UBOX device on Uncore bus 0, which can
> only be achieved using MSR access. The non-PCI-compliant MMIO BARs are
> not available for this purpose.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Assuming this will be applied through the peci tree:

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in V2:
> - Update subject.
> ---
>   drivers/hwmon/peci/dimmtemp.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
> index ed968401f93c..edafbfd66fef 100644
> --- a/drivers/hwmon/peci/dimmtemp.c
> +++ b/drivers/hwmon/peci/dimmtemp.c
> @@ -30,8 +30,10 @@
>   #define DIMM_IDX_MAX_ON_ICX	2
>   #define CHAN_RANK_MAX_ON_ICXD	4
>   #define DIMM_IDX_MAX_ON_ICXD	2
> +#define CHAN_RANK_MAX_ON_SPR	128
> +#define DIMM_IDX_MAX_ON_SPR	2
>   
> -#define CHAN_RANK_MAX		CHAN_RANK_MAX_ON_HSX
> +#define CHAN_RANK_MAX		CHAN_RANK_MAX_ON_SPR
>   #define DIMM_IDX_MAX		DIMM_IDX_MAX_ON_HSX
>   #define DIMM_NUMS_MAX		(CHAN_RANK_MAX * DIMM_IDX_MAX)
>   
> @@ -530,6 +532,15 @@ read_thresholds_icx(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u
>   	return 0;
>   }
>   
> +static int
> +read_thresholds_spr(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u32 *data)
> +{
> +	/* Use defaults */
> +	*data = (95 << 16) | (90 << 8);
> +
> +	return 0;
> +}
> +
>   static const struct dimm_info dimm_hsx = {
>   	.chan_rank_max	= CHAN_RANK_MAX_ON_HSX,
>   	.dimm_idx_max	= DIMM_IDX_MAX_ON_HSX,
> @@ -572,6 +583,13 @@ static const struct dimm_info dimm_icxd = {
>   	.read_thresholds = &read_thresholds_icx,
>   };
>   
> +static const struct dimm_info dimm_spr = {
> +	.chan_rank_max	= CHAN_RANK_MAX_ON_SPR,
> +	.dimm_idx_max	= DIMM_IDX_MAX_ON_SPR,
> +	.min_peci_revision = 0x40,
> +	.read_thresholds = &read_thresholds_spr,
> +};
> +
>   static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
>   	{
>   		.name = "peci_cpu.dimmtemp.hsx",
> @@ -597,6 +615,10 @@ static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
>   		.name = "peci_cpu.dimmtemp.icxd",
>   		.driver_data = (kernel_ulong_t)&dimm_icxd,
>   	},
> +	{
> +		.name = "peci_cpu.dimmtemp.spr",
> +		.driver_data = (kernel_ulong_t)&dimm_spr,
> +	},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(auxiliary, peci_dimmtemp_ids);

