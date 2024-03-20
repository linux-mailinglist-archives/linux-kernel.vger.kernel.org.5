Return-Path: <linux-kernel+bounces-109383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5394E881864
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A52B2274E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261288593F;
	Wed, 20 Mar 2024 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="F0FP0imW"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9328592D;
	Wed, 20 Mar 2024 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965498; cv=none; b=pEC+Lyg6DZejdl9u/2QS4/WGa3ZsrkLsFhLBTr+QoRrsMCOBx/nSWoanQAwOm/75+wvMtGAq0Tk6JxA/UIzPakrtRxi0J+Y4mHEwSTrfsYwzE6rD7iP8+1oCN2adqqA0kBDFNISn/yeuLA3Cc+XLfrMJn48XA5SStcDR9gltuBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965498; c=relaxed/simple;
	bh=1QTJYF/WVBiUpPd9h01Zak4bCyOARoYPEAdW5+RbQ0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAXKY4ITsti2seT23K2l309G4u6BDrH/Z0BF6uk+qp8pSZof7gcTB0thjjy3C+VJo8kOCHpa9O9lxZI+qnzxeDV2XhBrKMaG1vPGV+I8Ed7lBy3JRh1ab2qSCO010kTxbMuVaDgPQx/KiCQmepyLwqPPjAadyFNmgVstz6AvUfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=F0FP0imW; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E5C3387F52;
	Wed, 20 Mar 2024 21:11:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710965493;
	bh=qKi5o7N4Mo7W2yDJ2JzF88gBa6ndwUAwavGM4+FFst4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F0FP0imWKQL5JoKWuRNOIPk7FUIJFO1MsE7vvD+lu/BoIVAEsqnba5tOzOZmhp+Cc
	 YQoPNNEreLSzRnbBytgkkINuPefTM6y2xSr8qXvW/izW3RQW7jEQGMZzU8znNnxMxX
	 zSfkoTR1AN2cPVgFGPBi0X/GSvayn91fP6WP2vgMbJRnMWaBp/gPQs1lXJnbp+kDSt
	 CjDYa8ybHmZMl0EqNpGis2UGZhoJQJ3C0kBz3AqD4WnqEFcE1GpNY3IoV6W3DfT2qn
	 LIVlyUWh19cXkMKrqys4ocDohGyQLVzc3Dc4s/AnmjKvcNA0w0xU9EJSXEzLb2oWib
	 gMdj2glYN/ppA==
Message-ID: <21fce6d1-fadb-4175-9539-73d4cbdad452@denx.de>
Date: Wed, 20 Mar 2024 21:03:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>,
 broonie@kernel.org, tzimmermann@suse.de, omosnace@redhat.com,
 paul@paul-moore.com, yi.zhang@huawei.com, jack@suse.cz, tytso@mit.edu
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org
References: <20240313164640.616049-1-sashal@kernel.org>
 <ZfrngHBf1hbHohFa@duo.ucw.cz>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZfrngHBf1hbHohFa@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/20/24 2:41 PM, Pavel Machek wrote:

>> Marek Vasut (1):
>>    regmap: Add bulk read/write callbacks into regmap_config
> 
> This one quite intrusive for the stable. Plus, at least "regmap: Add
> missing map->bus check" is marked as fixing this one.

If there is no very good reason to include that regmap patch in stable 
backports, I would skip it, it is a feature patch. Does any backport 
depend on it ?

