Return-Path: <linux-kernel+bounces-69108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337298584B3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655811C22025
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B55F1350DE;
	Fri, 16 Feb 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMSBG9Bk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4701350C8;
	Fri, 16 Feb 2024 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106287; cv=none; b=eymyXYp2sLjKaMQNOU5hf2GKAYn87mw+fFEFVsD4t+mcYWsGahgDbBgwmmTmBywetdtmJWLHxFKEoaPpPpcHp3DO+SzvyBPY1EBA+f7VUWyWMywvUoIwf/98hmf2ql9wy5v6oQyaat3bHpgAYD6AOKBRm95lV1ioUG1/c8/FfWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106287; c=relaxed/simple;
	bh=TzxyUhzWqR9OGR0ur5lsWOcMoqjtLpMgsu+N/yqRV/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/QZj2x3ZvsKWF2jIe5qlwhPQs9OS4yiKb5iUOzQp+GxCvNQW+QZF9sEXUNdmWHBVZpMu9CiL0nXiKKMNgJ/hjcCa3YXi54xjk8ZC8GShdvk1GwuqBHSJaa8FFUki9e6MjE70PMeA5duRbZ7+xtHWwsXFvZ7Diy31IAH+bCRA2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMSBG9Bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F1BC433C7;
	Fri, 16 Feb 2024 17:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708106286;
	bh=TzxyUhzWqR9OGR0ur5lsWOcMoqjtLpMgsu+N/yqRV/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMSBG9BkYIxFDjC5KmCPBFFdDDt88bpd723PEAupSkg0/l4CI/u1KJHRUAKZMHHVF
	 82/WHm5v6nZVd3K1e8jwXwDOTrlml7lkrzn9pTd2ldCnFa2DF6eiJuxf1h3huaMWV2
	 NiSulu/q0ZWuqy7qUpPCHt5SbrE27oyPe1e7z8t2F/s+zjnEnpAOpgzxYWG3hcAUyM
	 Woq6/rNfkcJQz3NXOVy1mghaxKes9myS5GPleFUqJjvM2rL1NP6ffJvtOyLZ4SFaLu
	 lrpcKGLF0FBZa57SjU6NnHQ7krfusuxiRQa7CJhWN6G0U07A7rtBD26/Taz6MFHzgz
	 kz4kOk6JdhLaw==
Date: Fri, 16 Feb 2024 11:58:03 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: quic_fenglinw@quicinc.com, kernel@quicinc.com, 
	Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: add #power-domain-cells for
 gcc node
Message-ID: <wged56grfp7qwvkd2gq4qbewzdevv23kz52vou2z2uh4ws7c3c@b6xigs2ca5oe>
References: <20240104-gcc-docs-update-v1-1-127e4816b798@quicinc.com>
 <CAA8EJprsGke9zZBy_x=YSxz7R1aSpx8r3ndjjXVVKhjKBxd=QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprsGke9zZBy_x=YSxz7R1aSpx8r3ndjjXVVKhjKBxd=QQ@mail.gmail.com>

On Thu, Jan 04, 2024 at 11:53:46AM +0200, Dmitry Baryshkov wrote:
> On Thu, 4 Jan 2024 at 10:06, Fenglin Wu via B4 Relay
> <devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
> >
> > From: Fenglin Wu <quic_fenglinw@quicinc.com>
> >
> > Property '#power-domain-cells' is required as per defined in qcom,gcc.yaml
> > so add it for ipq6018 gcc device node to eliminate following warning in
> > dtbs_check:
> >
> > arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: gcc@1800000:
> >         '#power-domain-cells' is a required property
> > from schema $id: http://devicetree.org/schemas/clock/qcom,gcc-ipq6018.yaml#
> 
> But ipq6018 doesn't implement GDSC support. So for the sake of fixing
> the warning you are adding a bogus property.
> 

The platform does indeed have two USB GDSCs, which you can see being
referred to in gcc_ipq6018_probe().

But while this patch removes a warning, I think the proper solution
would be to actually describe those GDSCs in the DeviceTree as well.
Unfortunately this would imply the need to actually implement them in
Linux as well.


Alternatively, there exist a reason for not actually change the state of
these GDSCs at runtime - i.e. the gcc driver is doing the right thing.
But if so, this patch would be wrong...

Regards,
Bjorn

> >
> > Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > index 39cd6b76b4c1..54914912d610 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > @@ -386,6 +386,7 @@ gcc: gcc@1800000 {
> >                         reg = <0x0 0x01800000 0x0 0x80000>;
> >                         clocks = <&xo>, <&sleep_clk>;
> >                         clock-names = "xo", "sleep_clk";
> > +                       #power-domain-cells = <1>;
> >                         #clock-cells = <1>;
> >                         #reset-cells = <1>;
> >                 };
> >
> > ---
> > base-commit: 17cb8a20bde66a520a2ca7aad1063e1ce7382240
> > change-id: 20240103-gcc-docs-update-fa604579e468
> >
> > Best regards,
> > --
> > Fenglin Wu <quic_fenglinw@quicinc.com>
> >
> >
> 
> 
> -- 
> With best wishes
> Dmitry

