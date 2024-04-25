Return-Path: <linux-kernel+bounces-157892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 979768B1839
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8433B2356B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E646AC2;
	Thu, 25 Apr 2024 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="ZQHPPUN9"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5848F2582;
	Thu, 25 Apr 2024 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714006675; cv=none; b=WjtOIBsqOo+6Zh44RR5DKnJZadL/8nbE6RAlc41kEMdowdNjgY79j41RwucQtRO+eTx7zDEA5sIBjMWYVpiP9t3k6zIFkcGUbRtyC5DeiuKWo021uPel1Jqds//096Yn5yPD3Bam+prWAV3GMm3wQcyCMtYvAy3WNMlBPRjAuw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714006675; c=relaxed/simple;
	bh=jJlA4qW0WfV3qbaZvbRCTVVym3gR466ShwgEbBIkoK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YceyTm86PRTFviOTu1RFASdlbmpRGEx42wVHdp0+sfnXv5NHHGbmul99BdCBAigFrSeLcbYFT2IEeJmgxW7cqeJGsNRE0w64Hz99VdHEZR5VYSG9rOD8vhInYJAtgPndrbfUZDLdBW2xOnsQqPeMfWuTi8lFINeII4858AYQ6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=ZQHPPUN9; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [220.162.71.180])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 98B5D7870F;
	Thu, 25 Apr 2024 08:57:41 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 98B5D7870F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1714006667;
	bh=hs/RZj5lsMbnG9+JZAQhqO/qGFihPkInPVFOlxvoHxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZQHPPUN9ksQCpiKXMkNkPEBhLgiJp84hXip1H8YS4+GRIvikmPULvbqe92LpStBlk
	 LgcZepbk2WDIuzfVanjEuSsFAmRnriCydDCxazv/skIjRgp85iKYb35xkn4vyGykGD
	 lL/cMUezXevZs7YXjmQXzoJb/epMKGR79gabHK9Q=
Message-ID: <361fc6a0-f0d0-49b2-b885-3b197294ec9f@classfun.cn>
Date: Thu, 25 Apr 2024 08:57:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] pwm: Add SI-EN SN3112 PWM support
To: Konrad Dybcio <konrad.dybcio@linaro.org>, wuxilin123@gmail.com,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Molly Sophia <mollysophia379@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-2-e0aa05c991fd@gmail.com>
 <af62742c-8d6d-4fa9-b2e4-f83253e6e388@linaro.org>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <af62742c-8d6d-4fa9-b2e4-f83253e6e388@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/4/25 03:37, Konrad Dybcio wrote:
> On 4/24/24 17:29, Xilin Wu via B4 Relay wrote:
>> From: Junhao Xie <bigfoot@classfun.cn>
>>
>> Add a new driver for the SI-EN SN3112 12-channel 8-bit PWM LED controller.
>>
>> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
>> ---
>[...]
>> +    return sn3112_write_reg(priv, SN3112_REG_PWM_EN + reg,
>> +                priv->pwm_en_reg[reg]);
> 
> This looks like a weird reimplementation of regmap_update_bits
> 

We cannot use regmap_update_bits because this chip does not support read command.
It will discard all read command.

>> +}
>> +
[...]
> 
> devm_pwmchip_add?
> 
> Konrad

Thank you for your reply, I will fix them.

