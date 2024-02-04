Return-Path: <linux-kernel+bounces-51724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B222848E9C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFFAD1F21952
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A7224E3;
	Sun,  4 Feb 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4Ge1Czm"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6444A9465;
	Sun,  4 Feb 2024 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058047; cv=none; b=aR+NBuIcscKsqadTx8MDAGP2nn9HYAdNdhbafYmMd+hnBMrWaHa8+h4ONE60qMqZxWLcCIGzzL1eVCNAfc4Kq+xF5HOoz8SvV+Z9zt4j1ZjaBfvinWla0KlZjiByn85HpQ08RJatymQl3SzkfwwFmPBkuw6bOqLA7BJIMcHqTZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058047; c=relaxed/simple;
	bh=m3Jy76PhMLlcHJABd3sQLeIQ6gDRssB/iSvJUUFUYNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqV4/3Bw+4im3shTSu04pXTAXAPz050zi0sphsxr0ZMVJ6LZxrJmwzbWso1xC2M5/pfK/OgdRHlpPJQm2YGrgLJs4P4FJrr0a1Jpq+0ENRuBd4f2nck5nIQEFu2DRXb6r6V+ZwyuYSf3IGMfdeG96bxRMPrYmwW0wcLoyDJGxY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4Ge1Czm; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e03ab56e75so128594b3a.2;
        Sun, 04 Feb 2024 06:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707058045; x=1707662845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwReRzXXpjYUlVCgbTG0gMEwWsRKLH7sLsnRayuqFqo=;
        b=A4Ge1CzmBtoILVIWYHD7zxFQb89gqxpw9mFwUNZuIRvU4Me5sLUFJvPsMIEjEXzXuN
         icKRO+WXhxAvIbNd/LbArqw1fPw66dTZWcQ06+3vRUPC6VC9FyxdCFFkeUAhPEGqudEc
         +sy/lQF7Pz9BAcB3MDyqU1CHXWK6P+tISlOb3ri/IeMmsEhl24JTR/qdXnFRnmBOqzn0
         23gkh88eh5g0N1vJDohZV+v5rkMpsIMAjg1nlt2yHpE3uNju1JBJlrQXTqVVwMdf2njh
         U0eKk0YjfE5RqUek+v9uw8TvCwhSwK8uuolPCkaxAc6Ftzu3OvQQoEE6/KDqoPD8mk8U
         TbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707058045; x=1707662845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwReRzXXpjYUlVCgbTG0gMEwWsRKLH7sLsnRayuqFqo=;
        b=od2SO1MPBMaJO3NWTnGgQtPAmlZTfMeCOcfHHxQXeGnR10l62434bWAd/v/U+os08X
         OM5fWevXGTJL3sRXboq3MrTEweGIKlbGqdCCI1Er94jTymA0bMr0Q3I13nJmcTR1rYDo
         /gk02r7SDJ+GXvM2qundZSlGa6HTZXycfFKATFFyOAfSCHxoLwR8934QYT7HlZFSqLyp
         g4zZmYvcuy2w8VdcLRoMDmXp84zYLFaYm4qPZQ5SSj5Xha9itrE9LROPYYw3vP/IyHTa
         LGlg89GDbmA2SQfwsgmfobKP5lbQryv3Q3FYMTgDR5KREKbwE2dkMU0+V/xyMVsLgxP0
         YK7A==
X-Gm-Message-State: AOJu0YxcmhnNHDM8YgPKAUs39x4oYgH2+qtdNIuDyrYmPHDeTiBMgXls
	H/oEqE9BA5Y6BSk3128I5yzjaXw33jX2k8LoBXDwyAR0PnV371A/DMgQVOg6
X-Google-Smtp-Source: AGHT+IE40eDopAIGPJ/kRruMbFaLdVCaGvjEmPV9ckRuXbME5f+ZBfsyYlr1+BfUKsXI3M4ZVEAl6A==
X-Received: by 2002:a05:6a00:4b4f:b0:6e0:3b40:e375 with SMTP id kr15-20020a056a004b4f00b006e03b40e375mr1080467pfb.31.1707058045663;
        Sun, 04 Feb 2024 06:47:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVfDIMj2jBme42JG+7xO3ZxjjZKEG9rV0+aX9UPlzwfIKkUYgqsx46kWhKRorU1ew8gCW+zfVPxPD9BR6a63fUl/U6QBwYw9e4TI/LGJYHzDHmJQRkTHOJW8dDH6j+mUQWJRxHWXOW8712RBsG7ssQY8hnaS5OSaBCfu6PSyIH/
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a7-20020a056a0011c700b006dfe402357bsm4836193pfu.120.2024.02.04.06.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:47:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 4 Feb 2024 06:47:24 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Zhang Rui <rui.zhang@intel.com>
Cc: jdelvare@suse.com, fenghua.yu@intel.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 07/11] hwmon: (coretemp) Remove redundant
 pdata->cpu_map[]
Message-ID: <d414ba25-c541-4036-b442-9e53f16ea02a@roeck-us.net>
References: <20240202092144.71180-1-rui.zhang@intel.com>
 <20240202092144.71180-8-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202092144.71180-8-rui.zhang@intel.com>

On Fri, Feb 02, 2024 at 05:21:40PM +0800, Zhang Rui wrote:
> pdata->cpu_map[] saves the mapping between cpu core id and the index in
> pdata->core_data[]. This is used to find the temp_data structure using
> cpu_core_id, by traversing the pdata->cpu_map[] array. But the same goal
> can be achieved by traversing the pdata->core_temp[] array directly.
> 
> Remove redundant pdata->cpu_map[].
> 
> No functional change.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/coretemp.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index cdd1e069d5c1..29ee8e0c0fe9 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -96,7 +96,6 @@ struct temp_data {
>  struct platform_data {
>  	struct device		*hwmon_dev;
>  	u16			pkg_id;
> -	u16			cpu_map[NUM_REAL_CORES];
>  	struct ida		ida;
>  	struct cpumask		cpumask;
>  	struct temp_data	*core_data[MAX_CORE_DATA];
> @@ -517,7 +516,6 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
>  		if (index < 0)
>  			return index;
>  
> -		pdata->cpu_map[index] = topology_core_id(cpu);
>  		index += BASE_SYSFS_ATTR_NO;
>  	}
>  
> @@ -696,7 +694,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
>  	struct platform_device *pdev = coretemp_get_pdev(cpu);
>  	struct platform_data *pd;
>  	struct temp_data *tdata;
> -	int i, indx = -1, target;
> +	int i, target;
>  
>  	/* No need to tear down any interfaces for suspend */
>  	if (cpuhp_tasks_frozen)
> @@ -707,18 +705,16 @@ static int coretemp_cpu_offline(unsigned int cpu)
>  	if (!pd->hwmon_dev)
>  		return 0;
>  
> -	for (i = 0; i < NUM_REAL_CORES; i++) {
> -		if (pd->cpu_map[i] == topology_core_id(cpu)) {
> -			indx = i + BASE_SYSFS_ATTR_NO;
> +	for (i = BASE_SYSFS_ATTR_NO; i < MAX_CORE_DATA; i++) {
> +		if (pd->core_data[i] && pd->core_data[i]->cpu_core_id == topology_core_id(cpu))
>  			break;
> -		}
>  	}
>  
>  	/* Too many cores and this core is not populated, just return */
> -	if (indx < 0)
> +	if (i == MAX_CORE_DATA)
>  		return 0;
>  
> -	tdata = pd->core_data[indx];
> +	tdata = pd->core_data[i];
>  
>  	cpumask_clear_cpu(cpu, &pd->cpumask);
>  
> @@ -729,7 +725,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
>  	 */
>  	target = cpumask_any_and(&pd->cpumask, topology_sibling_cpumask(cpu));
>  	if (target >= nr_cpu_ids) {
> -		coretemp_remove_core(pd, indx);
> +		coretemp_remove_core(pd, i);
>  	} else if (tdata && tdata->cpu == cpu) {
>  		mutex_lock(&tdata->update_lock);
>  		tdata->cpu = target;

