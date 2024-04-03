Return-Path: <linux-kernel+bounces-129702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19434896EB0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FE21C2583E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F781465B0;
	Wed,  3 Apr 2024 12:07:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CC7143869;
	Wed,  3 Apr 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712146073; cv=none; b=tqx0ArNencF0PjN50Y2OSaYErOvPSMLIpHJAaicWy5MYsZ7sGA1xNyPys9MuXIjFFkb0ZsVW/HCSnJw/4fYHl5WUrnB7NF2gYHVsb5c1yCMeAN1pjC28iTvC9Jg3P18snEquprjNpawkz+sUrsOxlYr+tR5HThpLvjsQynqb93k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712146073; c=relaxed/simple;
	bh=Y/ag3P9VuxJJwnLSBZ99yt8RVJaw8Rj9An0Jv5ji+Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9sYxDunosEZNxlhtG0ZipYKq2/jIcRHbftm8fbhpRZyzta2DZ3/Ck56MUswUrcWC0b7PBsHjUjeM4pq0v+Ba8ZZB1lPvVrnmNfLbsjh0BDvETWkJiKjs2IxCw5FODxVN8lcvGp3c2DUkQq7G5LR5RT0C68e3XBk5nGjiNugoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC70B1007;
	Wed,  3 Apr 2024 05:08:22 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DB613F64C;
	Wed,  3 Apr 2024 05:07:49 -0700 (PDT)
Message-ID: <03834bb6-c5dc-4be6-8244-fafb4080d5ac@arm.com>
Date: Wed, 3 Apr 2024 14:07:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] OPP: OF: Export dev_opp_pm_calc_power() for usage
 from EM
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sboyd@kernel.org, nm@ti.com,
 linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
 viresh.kumar@linaro.org, krzysztof.kozlowski@linaro.org,
 alim.akhtar@samsung.com, m.szyprowski@samsung.com, mhiramat@kernel.org
References: <20240402155822.505491-1-lukasz.luba@arm.com>
 <20240402155822.505491-2-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240402155822.505491-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/04/2024 17:58, Lukasz Luba wrote:

[...]

> @@ -539,6 +541,12 @@ static inline void dev_pm_opp_of_unregister_em(struct device *dev)
>  {
>  }
>  
> +static inline int dev_pm_opp_calc_power(struct device *dev, unsigned long *uW,
> +			  unsigned long *kHz)

This looks like a weird alignment comparing to the adjacent functions.

[...]

