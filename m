Return-Path: <linux-kernel+bounces-135818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B725E89CBC4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CCA2833F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C595126F3F;
	Mon,  8 Apr 2024 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="KWaMjJX/"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C401119A;
	Mon,  8 Apr 2024 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601370; cv=none; b=jNH3S32uEEvGd5xPiclZdJOotJcXatX/uKd1qF0EDI4uybVXVEz3PKk00CaE3kJcBG/ycAQeMRduLYUDtWTggKs339HXrA2rDtruF0XpofmVkVYQS/mgpCv/ggnijPEw0aBqVJ/RDVFVm6n0gfRHrumoMCnhLw4uLsyhomL/IMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601370; c=relaxed/simple;
	bh=PG1o3L91lYgh8vv/DGFGkaxqiPASzURvCwbdexZwJXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyJbz6HS+wvRRsMYkFPXVgNs5eEytnY0Byv4/YIEdYxHqeu2cvhZohZxqu3LbYBA18iFUp9bvvcYmN2RrYTq0BNTobEqg4TKBUCy4IHn7fpDFAsa2xfjaLiX8AqORQO44p8Klx0XfQZQabrDKohqHwGBAyd4rboQ9fCKRl7ktfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=KWaMjJX/; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712601366; bh=PG1o3L91lYgh8vv/DGFGkaxqiPASzURvCwbdexZwJXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KWaMjJX/Twh+ifm5VlUNa7OhDTmR63O5NKwhUeqQtZjpgsa6nLTLsrRYu6fRTW00k
	 p7EWYmG0idPNOAmLcUVWDoC7xVrBu6GZWbeTlEmhEiYl8Vkwq5ASEh9yf+tE+mhf/x
	 j2PrTUkC/MbaKy5GPwTo/yPtm9VHepbf+5ZClz/g=
From: Luca Weiss <luca@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 1/2] dt-bindings: pinctrl: qcom,pmic-gpio: Allow gpio-hog nodes
Date: Mon, 08 Apr 2024 20:36:04 +0200
Message-ID: <5894182.DvuYhMxLoT@g550jk>
In-Reply-To: <794f7e3c-6467-4da1-bc9f-3853459bbd78@linaro.org>
References:
 <20240408-qcom-pmic-gpio-hog-v1-0-f61fc5323110@z3ntu.xyz>
 <20240408-qcom-pmic-gpio-hog-v1-1-f61fc5323110@z3ntu.xyz>
 <794f7e3c-6467-4da1-bc9f-3853459bbd78@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Montag, 8. April 2024 19:26:49 CEST Konrad Dybcio wrote:
> 
> On 4/8/24 18:39, Luca Weiss wrote:
> > Allow specifying a GPIO hog, as already used on
> > qcom-msm8974-lge-nexus5-hammerhead.dts.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> >   .../devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml          | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> > index a786357ed1af..510a05369dbb 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> > @@ -424,6 +424,10 @@ patternProperties:
> >               $ref: "#/$defs/qcom-pmic-gpio-state"
> >           additionalProperties: false
> >   
> > +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
> 
> I see a couple bindings do this, but I'm not sure if we want two
> allow two styles for no reason.. Rob?

This regex is actually from the gpio-hog.yaml base
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/gpio/gpio-hog.yaml#L23

Why it's made this way I cannot tell you, but I didn't want to 'artifically'
restrict the pattern for qcom,pmic-gpio.

> 
> Konrad
> 





