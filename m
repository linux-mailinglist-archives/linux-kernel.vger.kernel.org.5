Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4505F8001DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376976AbjLADGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjLADGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:06:14 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDC91715;
        Thu, 30 Nov 2023 19:06:20 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1fa21f561a1so41181fac.3;
        Thu, 30 Nov 2023 19:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701399979; x=1702004779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HlBmXw61xz34FZu2gf3f1pqRz+gjfA0iYgscjQD41D0=;
        b=eSzFICNiPiCFyIuhyNu86j0qLPu38z4YgCpZY7ZLRIfFef/IbdhKjuVl58Z3PPMkUi
         ANYh72yHVaR3RuQl5gqPNX0iiJemAHMza2c62qV+KrEIl5GRiZUGV9GsYOjcW257xjTx
         Z7Kpps5Tvvx/AqbM3OA3T/WS1OfwiYQfskuf/CrLY2u9KTF/vn2R8HpYvH53rUp4/nSV
         p2w8lA4giUJtq3+fa4Re60zpF79NSmBXELbqOGkS0yF9kOBVeHFbRsdKqnIb0AkxhmF/
         5WLN7cF8oCxBPHnEGrLmU0LX1Ffqnhg6CX+IwXHPg5rJ2b7ieA7U+dAONcQ5A/BKC8J5
         LYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701399979; x=1702004779;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlBmXw61xz34FZu2gf3f1pqRz+gjfA0iYgscjQD41D0=;
        b=D2YmBPIyjOSvDnyYjup+aZxtxyP1i0H0bZVvdAstQBy6apWT/eaThHsegOZYlrim06
         Rgu8BiVuxEOBeNWIiSCNTe6WO1oWLnPfYFGlsInU/6Havfv9bzaoCnh1sAq9XhxNKqPa
         jWhx4pHiZdLq8dxk+259WWn3Qn0vJaw+QDu5k7mFo/Wko3Tv8yxFpZjJEq9Tmu8VgN+Y
         ZlRl5b66GsIAjTD57gvL6RNhn2dvenFMMq2HhqJRMdr4FDAZHESX9CGx+MPlHcLoe+fM
         fyKyV3Roa53BpgtYqf+Pt2PqvcGJpots2jMkhmZh2iXy9Inps2VLfZgV65kEe2zC+jYM
         HgtQ==
X-Gm-Message-State: AOJu0YzXKZekC05gY99vusmIodkoUhcejXnfqaeJr7rvMX3IfltR7yzR
        iPAZcfoIb6YXgMZ4ZS3fwwg=
X-Google-Smtp-Source: AGHT+IEgnGhO56NtfC2n7g1nUI541wzAoNfYMJjns8/mutxpmQ0j+u4qNM5GGZFdKGMMVIOD52UD5g==
X-Received: by 2002:a05:6870:8921:b0:1fa:de7e:bfa2 with SMTP id i33-20020a056870892100b001fade7ebfa2mr2196755oao.51.1701399979393;
        Thu, 30 Nov 2023 19:06:19 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fu18-20020a0568705d9200b001fa8b2d3212sm596221oab.1.2023.11.30.19.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 19:06:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <91a3f785-8d69-4425-ad23-a6ac0ebddb07@roeck-us.net>
Date:   Thu, 30 Nov 2023 19:06:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hwmon: (coretemp) Fix core count limitation
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, jdelvare@suse.com
Cc:     fenghua.yu@intel.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231127131651.476795-1-rui.zhang@intel.com>
 <20231127131651.476795-4-rui.zhang@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231127131651.476795-4-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 05:16, Zhang Rui wrote:
> Currently, coretemp driver only supports 128 cores per package.
> This loses some core temperation information on systems that have more
> than 128 cores per package.
>   [   58.685033] coretemp coretemp.0: Adding Core 128 failed
>   [   58.692009] coretemp coretemp.0: Adding Core 129 failed
> 
> Fix the problem by using a per package list to maintain the per core
> temp_data instead of the fixed length pdata->core_data[] array.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>   drivers/hwmon/coretemp.c | 110 ++++++++++++++++++---------------------
>   1 file changed, 52 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index cef43fedbd58..1bb1a6e4b07b 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -39,11 +39,7 @@ static int force_tjmax;
>   module_param_named(tjmax, force_tjmax, int, 0444);
>   MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
>   
> -#define PKG_SYSFS_ATTR_NO	1	/* Sysfs attribute for package temp */
> -#define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
> -#define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
>   #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
> -#define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
>   
>   enum coretemp_attr_index {
>   	ATTR_LABEL,
> @@ -90,17 +86,17 @@ struct temp_data {
>   	struct attribute *attrs[TOTAL_ATTRS + 1];
>   	struct attribute_group attr_group;
>   	struct mutex update_lock;
> +	struct list_head node;
>   };
>   
>   /* Platform Data per Physical CPU */
>   struct platform_data {
>   	struct device		*hwmon_dev;
>   	u16			pkg_id;
> -	u16			cpu_map[NUM_REAL_CORES];
> -	struct ida		ida;
>   	struct cpumask		cpumask;
> -	struct temp_data	*core_data[MAX_CORE_DATA];
>   	struct device_attribute name_attr;
> +	struct mutex		core_data_lock;
> +	struct list_head	core_data_list;
>   };
>   
>   struct tjmax_pci {
> @@ -491,6 +487,23 @@ static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
>   	return tdata;
>   }
>   
> +static struct temp_data *get_tdata(struct platform_data *pdata, int cpu)
> +{
> +	struct temp_data *tdata;
> +
> +	mutex_lock(&pdata->core_data_lock);
> +	list_for_each_entry(tdata, &pdata->core_data_list, node) {
> +		if (cpu >= 0 && !tdata->is_pkg_data && tdata->cpu_core_id == topology_core_id(cpu))
> +			goto found;
> +		if (cpu < 0 && tdata->is_pkg_data)
> +			goto found;
> +	}

I really don't like this. With 128+ cores, it gets terribly expensive.

How about calculating the number of cores in the probe function and
allocating cpu_map[] and core_data[] instead ?

Thanks,
Guenter

