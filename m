Return-Path: <linux-kernel+bounces-104182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DCF87CA5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F0B28252E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49441175BD;
	Fri, 15 Mar 2024 09:04:39 +0000 (UTC)
Received: from sraa.de (sraa.de [85.214.240.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F11755A;
	Fri, 15 Mar 2024 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.240.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710493478; cv=none; b=OTDDdP+0HvGf3VXfz6sb/ojuj2mfSnRJjprjQwVkbgJ044kSIPRo7U/FWeGb8rsn9e/n3Wn/wquB+sarRrJGI4Dmr5wJB62GrUDz2d+M7JXAU/AQY0uI6TVyMeJRa6BidDcHsqw/eFqoCjJ8u4xEqN+vtEjG+B8YdO6tdwC+y48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710493478; c=relaxed/simple;
	bh=VvKK+nrRhfanO9cwyxylJkFvUB7PNDc1iHj40Rjr+Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9+1e//DvRK3gSSIlpJE6gIlvg7SdEA7C/JFsCA3nqHoL3busWCzVSkYFfwYZ67BPkHk5NLfL3VRHs/yDIuoYw2Jqh2MA2hDgoBuzkV05BnqARJSTk7aELmFyBbgVo0o3IEZ/EPBp6QDVi+eOLE07Yp/+FyFj41SGNuffvXNbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sraa.de; spf=pass smtp.mailfrom=sraa.de; arc=none smtp.client-ip=85.214.240.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sraa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sraa.de
Received: from c-bda170d5.017-30-6c756e3.bbcust.telenor.se ([213.112.161.189] helo=senor0lunlx0336.eu.sony.com)
	by sraa.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <basti@sraa.de>)
	id 1rl3UP-006Y55-D0; Fri, 15 Mar 2024 10:04:33 +0100
Date: Fri, 15 Mar 2024 10:04:31 +0100
From: Sebastian Raase <linux@sraa.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, marijn.suijten@somainline.org,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm630-nile: add pinctrl for
 camera key
Message-ID: <20240315100431.1e51b9a8@senor0lunlx0336.eu.sony.com>
In-Reply-To: <ae04d6e9-1eb3-4d71-b7f1-c0fb3bddcfe8@linaro.org>
References: <20240314200037.549206-1-linux@sraa.de>
	<20240314232043.1441395-1-linux@sraa.de>
	<359dafcc-4774-4ff4-8df0-03e3641082e5@linaro.org>
	<ae04d6e9-1eb3-4d71-b7f1-c0fb3bddcfe8@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: basti@sraa.de

Hi Krzysztof,

> On 15/03/2024 00:49, Konrad Dybcio wrote:
> > On 3/15/24 00:20, Sebastian Raase wrote:  
> >> Add pinctrl configuration for gpio-keys. Without this,
> >> camera button half-presses are not detected.
> >>
> >> Tested on discovery and pioneer.
> >>
> >> Fixes: e781633b6067 ("arm64: dts: qcom: Add support for Sony Xperia XA2/Plus/Ultra (Nile platform)")
> >> Signed-off-by: Sebastian Raase <linux@sraa.de>
> >> ---
> >>   arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> >> index 87d0293c728d..823c21d5ee59 100644
> >> --- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> >> @@ -90,6 +90,8 @@ cam_vana_rear_vreg: cam-vana-rear-regulator {
> >>   
> >>   	gpio-keys {
> >>   		compatible = "gpio-keys";
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&gpio_keys_default>;  
> > 
> > It's fine to keep the "non-preferred" order, I'll probably send some
> > changes to nile and fix up the style while at it in the near future.  
> 
> Sebastian,
> Although it is also preferred to implement feedback the reviewer is
> asking. I don't understand why you insisted to keep the other order.

I simply followed the existing style and did not know any better.
Since you called it a "nit", I wrongly assumed that was acceptable.

Fixed in v3.

> Best regards,
> Krzysztof

Best Regards,
Sebastian

