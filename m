Return-Path: <linux-kernel+bounces-158095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F308B1B67
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6F21F24B40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6DD6CDC1;
	Thu, 25 Apr 2024 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="Mw9l+DQL"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58642E631;
	Thu, 25 Apr 2024 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714028632; cv=none; b=ngHLqkWujC2fBlapOu5ziShtn6yV3NRhIItdOzLyJyrOd4bEoID5AoKV3kaoXDD9myPKZFs1MEWnQ69plI04EYPOqJD7o/yuFjQB+So267h1YTL3brTpYcgmst+Db3xG8j4JpO2D0zi7tXEdhPRyHGka7opYyI8qOwTOqSGnq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714028632; c=relaxed/simple;
	bh=ophQ8lpzX8fyeF5A4dR/OensBG1FXCTGczX843SrocU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHKK/IcCncFAoSypB9T2xOBvsi8BGjtyc9ZRFE7yw17wbnOX3cmjzj0og5w5+Ab9XfDyTN+aPUBc82svsGe0vdKXmH/jyKf/zl285OX04J8FE6Kc2Gq3l78DZ73QUfG4ZJG+FS/0pmVihkcOGLe6/R3hvvpLXf0eXKqkwn4hYEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=Mw9l+DQL; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [220.162.71.180])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 307D47884E;
	Thu, 25 Apr 2024 15:03:34 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 307D47884E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1714028621;
	bh=AK6H6ldj7P6o3ylZtkoQ2LgaK1xemeiTHMq/b0TWzZ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mw9l+DQLqALMOuzPxOwtAs8Ei8HWtDRIVwlLfwiIxuAOIMulvYMGjL97sRQkUX2f7
	 P0zBR7KErF6JpaPlGxnE58dmX1t8AuaLimoTX1Z1VoDVWB/P7Wt97EGVFRhY1k4JwZ
	 ABlvaV6mfnMOtRWJBVjWdLbkXXrA/050jgmkDxOE=
Message-ID: <ae845812-681e-4033-99b1-e761d2288a08@classfun.cn>
Date: Thu, 25 Apr 2024 15:03:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] pwm: Add SI-EN SN3112 PWM support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Xilin Wu <wuxilin123@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Molly Sophia <mollysophia379@gmail.com>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-2-e0aa05c991fd@gmail.com>
 <rzxzqgx65m7yo2btzh5dzcxuqquszujdvffq2dippdak2qdx7c@g77efrhjyure>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <rzxzqgx65m7yo2btzh5dzcxuqquszujdvffq2dippdak2qdx7c@g77efrhjyure>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/4/25 14:02, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Apr 24, 2024 at 11:29:07PM +0800, Xilin Wu via B4 Relay wrote:
>> From: Junhao Xie <bigfoot@classfun.cn>
>>
>> Add a new driver for the SI-EN SN3112 12-channel 8-bit PWM LED controller.
>>
[...]
>> +MODULE_LICENSE("GPL");
> 
> Best regards
> Uwe
> 

Thank you for your reply! I will fix them and resend this commit.

This is the link of datasheet for SI-EN SN3112, but it is written in Chinese:
https://datasheetspdf.com/pdf-down/S/N/3/SN3112-12-SI-EN.pdf

