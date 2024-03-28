Return-Path: <linux-kernel+bounces-122366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4E088F5B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACE629D6C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEFE2D05D;
	Thu, 28 Mar 2024 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2A3Tvd/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482A411723;
	Thu, 28 Mar 2024 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711595246; cv=none; b=kk9qwn8ANzGJJG6E07g/Cni8Y3mLfwEOscwaVvrWlV3/p0WX7sNljNxqTRUlaN0gy6tueqUdEcuLGtxCC8wwmvA+yo09mmOq4Rw+xV1FlqIMj1yhHng1mIsoavtyTwnUDbSSrUo3//NzzqvYANQt6rfe+5dlkp46VHHiyYfLpOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711595246; c=relaxed/simple;
	bh=WC52WXgaSNC9yCqTllGz957YlKJl0tjKPMh71bGurV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyRX0WNT1aNRoAT8qB11ldN1hiC2a3rC/O16r9Z/MX/LKDqFXQzdLIlr2UzPFvTwBHHrEUh4bthM6IniGCKiQJhrhlOWVftoW8L2b/hoFaP4uxzmVWN5mglH4RJVKzM/XPUiKl1ENdsZBswTCVgUy8W5cy5eF16Q9RuzH+mZ/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2A3Tvd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D6DC433F1;
	Thu, 28 Mar 2024 03:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711595245;
	bh=WC52WXgaSNC9yCqTllGz957YlKJl0tjKPMh71bGurV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2A3Tvd/XbyIFtp+PAipTINFrP0WBJa0Vdcj7za+pO058py6cOqOpFAUusiKB564L
	 RWx/E3EV1M+xE4t5x6Lw/X5YeMb4j6pWi1IhWko8nfVtcWbdUypZX6Ww42q0xaebfW
	 HlU5WpnyxTs4ij/0UaccrqDdvm+GBVgg0z2wPr00RSOTMxN5JQevBTEfZDDX3Nq4YQ
	 mmZAHXgMyebedAbt+YgR7h99uT6wAGhNxrb/m5VYMlhuJEMOcNQPZ3GcY5Ocb9ZCfP
	 krldZKo7VvrvAMckYvfZTB3t5dsfqtU2vMNgvl3hdpyJN67ltPk61ZIHfN74hZxv39
	 e/34FBZ9zI3jA==
Date: Wed, 27 Mar 2024 22:07:23 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: qcs6490-rb3gen2: Add DP output
Message-ID: <zsjzysb7h3wi3cfpaozl46l4jnsd7e3lxttzm5vptozjx24cqo@vqmyhl65q7ay>
References: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
 <20240326-rb3gen2-dp-connector-v2-2-a9f1bc32ecaf@quicinc.com>
 <CAA8EJpoe7A94608V1GdQ-oU9UXagHPm0mVBUe4Yxi=HF2pMd7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoe7A94608V1GdQ-oU9UXagHPm0mVBUe4Yxi=HF2pMd7w@mail.gmail.com>

On Thu, Mar 28, 2024 at 03:51:54AM +0200, Dmitry Baryshkov wrote:
> On Wed, 27 Mar 2024 at 04:04, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> >
> > The RB3Gen2 board comes with a mini DP connector, describe this, enable
> > MDSS, DP controller and the PHY that drives this.
> >
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 40 ++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > index 63ebe0774f1d..f90bf3518e98 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > @@ -39,6 +39,20 @@ chosen {
> >                 stdout-path = "serial0:115200n8";
> >         };
> >
> > +       dp-connector {
> > +               compatible = "dp-connector";
> > +               label = "DP";
> > +               type = "mini";
> > +
> > +               hpd-gpios = <&tlmm 60 GPIO_ACTIVE_HIGH>;
> 
> Is it the standard hpd gpio? If so, is there any reason for using it
> through dp-connector rather than as a native HPD signal?
> 

I added it because you asked for it. That said, I do like having it
clearly defined in the devicetree.

Regards,
Bjorn

