Return-Path: <linux-kernel+bounces-73376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504FD85C1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFCB1C22700
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A9976906;
	Tue, 20 Feb 2024 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="KycZigQU"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18362599;
	Tue, 20 Feb 2024 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447537; cv=none; b=sumTAPyoePLcUEx9bMhjPpKaosei+lgEwZDCsrX92GzKl4F7napb8kvyznB22KNZmbiOrOcVlC6gHILXbOpxYev5hs6nbZKzZpzjXbajnzy3Z9TQqzxR0e8qmUZKiySfr+lbAg3wosvOZ8PuC7MO8acUn4jWn2XWmPu6czsTzOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447537; c=relaxed/simple;
	bh=uPw+t+yyr5l3RfuJ+j4QxR6uN1Mq2rOau1muRGhJc4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePALlA/5j5hLEisXr7tpzli6YalwdkTRVLjsKAwM+IfsOYFyV1hLWdvX2zPU6VfPHguRH9BNkdxDo1EYlJ/WGQeKfPk5EomoQfD6dmvKXAOOLqu0AYXG+RHrMG8jVvx8Vyl0OS27TPMPECcTx0acyNu9bBf3HWHrZl0qarG+dCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=KycZigQU; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1708447534; bh=uPw+t+yyr5l3RfuJ+j4QxR6uN1Mq2rOau1muRGhJc4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KycZigQUMXyUgO/ZX1pwNs/h4N/p5iUVZ+Ez1ku4mVxBnPMAymiAu3PSAIG2LqEG6
	 7Bt+7rBQf9ShkFg6bd76BMPxt4VXeHeYe/E85r4AJG2zZcXlm9x2GA0wKoj1v6NCv6
	 QctnEHZnprqmKoaU8RxkTXVoLWvshdQWUcHd0zpA=
From: Luca Weiss <luca@z3ntu.xyz>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>, Andrew Morton <akpm@linux-foundation.org>,
 "G.Shark Jeong" <gshark.jeong@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maximilian Weigand <mweigand@mweigand.net>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8974-hammerhead: Hook up backlight
Date: Tue, 20 Feb 2024 17:45:32 +0100
Message-ID: <2444202.ElGaqSPkdT@g550jk>
In-Reply-To: <20240220141210.GG6716@aspen.lan>
References:
 <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
 <20240220-lm3630a-fixups-v1-4-9ca62f7e4a33@z3ntu.xyz>
 <20240220141210.GG6716@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 20. Februar 2024 15:12:10 CET Daniel Thompson wrote:
> On Tue, Feb 20, 2024 at 12:11:22AM +0100, Luca Weiss wrote:
> > Connect the panel with the backlight nodes so that the backlight can be
> > turned off when the display is blanked.
> >
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> 
> > ---
> >  arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
> > index 4aaae8537a3f..8eaa5b162815 100644
> > --- a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
> > +++ b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
> > @@ -182,7 +182,7 @@ &blsp2_i2c5 {
> >  	status = "okay";
> >  	clock-frequency = <355000>;
> >
> > -	led-controller@38 {
> > +	backlight: led-controller@38 {
> 
> Again... a minor nit regarding existing problems but this node doesn't
> follow the generic naming recommendations:
> https://devicetree-specification.readthedocs.io/en/stable/devicetree-basics.html#generic-names-recommendation

"led-controller" is listed on that page, or do you mean something else?

> 
> 
> Daniel.
> 





