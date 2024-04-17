Return-Path: <linux-kernel+bounces-149176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7FC8A8CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D96F1F21B76
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4483F38F94;
	Wed, 17 Apr 2024 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="ATOnx/2w"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD3171A1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385521; cv=none; b=aYY+QQJ0+zACVvoVq3REMZVGCXRlsYa1Yrr8DX4G6CiiygzhtvU+MsUq/Lr9M5/SWGowGg82uehbHjTq9SG8nLpoG6tJW9vUXQSNZ+DzhNp2LfTjJO+TqksCOgi3gtVGvGRgUEq3AXXU9YjtC9GqhYAlnrPMCO6x1DaVCDLKXbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385521; c=relaxed/simple;
	bh=pWXBe/vHkE5ouscTtZT8KCIjeqHGRYUlLlnF5gAbhJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/saCKDRbaX7aIRgkBB1kyQFoEUkoQyW0oCwbGN1/uFhYp6rUAz10Cmss+ODzY3zgZAR1/30pNn9hcx02oG3b93DMqc2cUbybbdVcxVB+swQSV7KNJVjlPKjYLRlR1NpLHjMJdirc36XbYSLg9fXXFtB7yxmMJje7bzoj8t3TqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=ATOnx/2w; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Message-ID: <587b3cff-a8b6-4412-8cff-79eb48d9556b@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1713385516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6rUr9bTJkPoASfG3Y7dLkjBo8BzVRWb+gB92W3GbXg=;
	b=ATOnx/2wn9QuqErvMnHfiPTY09lnC1ZLFHM5UvwAOfSAHgvRB4d/DGSrfKkrKlEwVByGYd
	4mHoyTcGU+BLIiQQi0/kBhMHLE9Ee8J+xTIueClUcSef/cglpyAAM12PRi9IRvi+55m4fS
	Utn03zR6n6SyQzbd5MWGKSBJ1VNjX1/5h4+ASlMqsVjVr6s4cO0R4TR5iv4L2NGRLuwMEa
	STUCTv9A+iWMhJjleADcOhtjaNUC25OPTRFf8sXmKDPFMdSUJT0+UPBycAOvIuaNRWBuIT
	MM+8gSolkbMneBnSSqZwUHosgwA+TtQGu3Iq8jGttLX0O3KxRLxFPiY2IGlg/w==
Date: Wed, 17 Apr 2024 23:25:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/4] ARM: dts: qcom: msm8974: Split out common part of
 samsung-klte
To: Rong Zhang <i@rong.moe>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
References: <20240213110137.122737-1-i@rong.moe>
 <20240213110137.122737-2-i@rong.moe>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20240213110137.122737-2-i@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 13.02.2024 13:58, Rong Zhang wrote:
> Samsung Galaxy S5 has many variants. Variants that support LTE use klte*
> as their codename. Currently, the only supported one is the one without
> any suffix, namely, klte. It is known that other klte* variants have
> only minor differences compared to klte and can mostly work with the
> klte DTB.
> 
> Split the common part into a common DTSI so that it can be imported in
> the DTS of klte and other klte* variants.
> 
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>   ... qcom-msm8974pro-samsung-klte-common.dtsi} |   7 +-
>   .../dts/qcom/qcom-msm8974pro-samsung-klte.dts | 833 +-----------------
>   2 files changed, 17 insertions(+), 823 deletions(-)
>   copy arch/arm/boot/dts/qcom/{qcom-msm8974pro-samsung-klte.dts => qcom-msm8974pro-samsung-klte-common.dtsi} (98%)
>   rewrite arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts (99%)
> 

Tested on regular Samsung Galaxy S5 (qcom-msm8974pro-samsung-klte).

Tested-by: Alexey Minnekhanov <alexeymin@postmarketos.org>

-- 
Regards,
Alexey Minnekhanov
postmarketOS developer

