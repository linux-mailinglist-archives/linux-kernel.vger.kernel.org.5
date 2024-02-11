Return-Path: <linux-kernel+bounces-60714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C671F8508D1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A691C216B1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882845A784;
	Sun, 11 Feb 2024 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="izEB8l+5"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B965A4C7;
	Sun, 11 Feb 2024 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707650360; cv=none; b=DamDw2HoJnRxfFouXvgLqNn5TrOR0rrms1je28zXbAT+T9YfClUYTquhG5lwJDRVM/jmMWvttOS6Jig2KR1W4nIyc+6gj7hrp1ks1fnMRa0y0A8uMapv2Z6Fz8EiXA35VS+9u2/KZ2l1hfEfg3GecxgRxyAQYbjzWFD016Io+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707650360; c=relaxed/simple;
	bh=yA/biYvRr9hf2HQDPmoGQm+4JVMxSnfysgiTJ9nNW/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klB3Cgh3oDVutwa2VtaxHfTzIXNjxyF6rQiiJMy/QstsxbT18hwcDkQnaF2txL5a9ih+lXYE19Yr1vNccrIcXz6nwuOP9IgcDldH5i44WWC3J54mhlNXQIW574oH9cQvmJyqrHVQxBJxzVwItNwsvQIU6vUtA1zKW+ZBF1b+wNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=izEB8l+5; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707650356; bh=yA/biYvRr9hf2HQDPmoGQm+4JVMxSnfysgiTJ9nNW/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=izEB8l+5fyMBafcahj7RxjD8caa3o5xLsoG7sDDf37Zu/xKZZR0jihu0LFMaOPwOa
	 cc0+40R3Sy0T93Zthk+X7jCJjKdR6opIDYLK4V8W7tNr6tgshExAAObmfhk/IimQj1
	 r1v32OhZe6ZKEii3Pjp9zlT5xQQ0zkGlhETbSxLM=
From: Luca Weiss <luca@z3ntu.xyz>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v2 1/3] dt-bindings: power: rpmpd: Add MSM8974 power domains
Date: Sun, 11 Feb 2024 12:19:14 +0100
Message-ID: <12625470.O9o76ZdvQC@z3ntu.xyz>
In-Reply-To: <Zcipcz70vEPWLAFg@gerhold.net>
References:
 <20240210-msm8974-rpmpd-v2-0-595e2ff80ea1@z3ntu.xyz>
 <20240210-msm8974-rpmpd-v2-1-595e2ff80ea1@z3ntu.xyz>
 <Zcipcz70vEPWLAFg@gerhold.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 11. Februar 2024 12:03:15 CET Stephan Gerhold wrote:
> On Sat, Feb 10, 2024 at 05:38:56PM +0100, Luca Weiss wrote:
> > Add the compatibles and indexes for the rpmpd in MSM8974, both with the
> > standard PM8841+PM8941 PMICs but also devices found with PMA8084.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > 
> >  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 2 ++
> >  include/dt-bindings/power/qcom-rpmpd.h                  | 7 +++++++
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> > b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml index
> > 2ff246cf8b81..929b7ef9c1bc 100644
> > --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> > +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> > 
> > @@ -24,6 +24,8 @@ properties:
> >            - qcom,msm8917-rpmpd
> >            - qcom,msm8939-rpmpd
> >            - qcom,msm8953-rpmpd
> > 
> > +          - qcom,msm8974-rpmpd
> > +          - qcom,msm8974pro-pma8084-rpmpd
> > 
> >            - qcom,msm8976-rpmpd
> >            - qcom,msm8994-rpmpd
> >            - qcom,msm8996-rpmpd
> 
> This is maybe more something for the DT reviewers to decide but I wonder
> if it is a bit confusing/misleading to describe one particular PMIC with
> a generic compatible, and the other with a more specific one. Perhaps it
> would be clearer to include the PMIC name in both compatibles, i.e.
> "qcom,msm8974-pm8941-rpmpd" instead of "qcom,msm8974-rpmpd".

FWIW if we'd do that it should be qcom,msm8974-pm8841-rpmpd (so pm8841 instead 
of pm8941)

But also in the same vain, it was maybe a bit of a bad decision originally to 
make the compatibles SoC-specific and not SoC+PMIC-specific - though in nearly 
all cases this combo is fixed for a given SoC?

Anyways, I'll wait for more comments about this, I'm open to changing it 
either way.

Regards
Luca

> 
> The "qcom,msm8974-rpmpd" compatible could be maybe added as fallback.
> While it wouldn't be used for matching in the (Linux) driver the DT
> binding itself *is* "compatible" between the two PMICs because they both
> have the same power domain indexes.
> 
> i.e.
> 	compatible = "qcom,msm8974-pm8941-rpmpd", "qcom,msm8974-rpmpd";
> 	compatible = "qcom,msm8974pro-pma8084-rpmpd", "qcom,msm8974-rpmpd";
> 
> Thanks,
> Stephan





