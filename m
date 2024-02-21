Return-Path: <linux-kernel+bounces-74004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D985CED5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1965283033
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D215383BF;
	Wed, 21 Feb 2024 03:39:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349DC23C9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486798; cv=none; b=k8XMp87BdIX04uUTp4CgnEuFlNJSv3vRZLl9gt+R8jAYkJyF3BPhygmqPDXgM2uEGplMzCIGDPl3Z0lQ2N4G7E4YNv50ZI2hrffOa1k/FnJvRIhlVhG08nmoWKbVOOZKqN9rAa0bQp/FfjE27XqM/JpqPxMSjYf5XvTFtj9r044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486798; c=relaxed/simple;
	bh=aRGRT/EULKL0RNug/P+QJ3+WKZdIcrq2nA16Ay6NTmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnrSyRduMBaxYRdVjdHbpGeFujFllCoEXjIF4XAyQ+K6DgBGbrhgxcO/oBX57/5nfmZPiWuarGUtJ6k7tQJYonvlFTYh3nKhR4LNC7rvDtrwIOOoApniuh0M7j/ZWfIuBPFgSRi99uz0A3U5N7cWI7ga3s+n2S5rnvekV+VVzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DB411007;
	Tue, 20 Feb 2024 19:40:26 -0800 (PST)
Received: from [10.163.46.138] (unknown [10.163.46.138])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 389DE3F766;
	Tue, 20 Feb 2024 19:39:44 -0800 (PST)
Message-ID: <3b400f7d-f76c-4e54-92d9-7ece7f712ea8@arm.com>
Date: Wed, 21 Feb 2024 09:09:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: constify the struct device_type usage
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240219-device_cleanup-coresight-v1-1-4a8a0b816183@marliere.net>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240219-device_cleanup-coresight-v1-1-4a8a0b816183@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/24 19:13, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> coresight_dev_type variable to be a constant structure as well, placing it
> into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  drivers/hwtracing/coresight/coresight-priv.h  | 2 +-
>  drivers/hwtracing/coresight/coresight-sysfs.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index eb365236f9a9..ca3362cbdb70 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -13,7 +13,7 @@
>  #include <linux/pm_runtime.h>
>  
>  extern struct mutex coresight_mutex;
> -extern struct device_type coresight_dev_type[];
> +extern const struct device_type coresight_dev_type[];
>  
>  /*
>   * Coresight management registers (0xf00-0xfcc)
> diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
> index f9444e2cb1d9..1e67cc7758d7 100644
> --- a/drivers/hwtracing/coresight/coresight-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-sysfs.c
> @@ -377,7 +377,7 @@ static struct attribute *coresight_source_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(coresight_source);
>  
> -struct device_type coresight_dev_type[] = {
> +const struct device_type coresight_dev_type[] = {
>  	[CORESIGHT_DEV_TYPE_SINK] = {
>  		.name = "sink",
>  		.groups = coresight_sink_groups,
> 
> ---
> base-commit: c099fdd218a0fedfe87e0b88d2ba0667eab3b3c8
> change-id: 20240219-device_cleanup-coresight-00ba00fd5f21
> 
> Best regards,

