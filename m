Return-Path: <linux-kernel+bounces-39306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 795D883CE85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACADD1C21124
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D4613A277;
	Thu, 25 Jan 2024 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="nmdQJrpj"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ABD13A262;
	Thu, 25 Jan 2024 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217966; cv=none; b=soDdT7pqLRtKQZtD1Sfh5M90QoaUXna++xlhR6DaVo2g3MYt6mjvKJ+6MptAh+yJQpA+kA23USm7SaObll18GiiuMcG0yPA74pGvVn73NgJtmlEEBhYBZOmkYQBbctgDmfcOudoastu+S74ksThzaa+rKdjcL3+Nls9KRfP7r7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217966; c=relaxed/simple;
	bh=kx9FeMTO9kz6c3Lety3dxdwU6n70e2EWE5IksjXF7fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEo3+RdkSTsUuCYx16XHvQTt/ebHT698wnJKues6Rfpx6gd+4Kl1zOLrgcajsS7hm1ZDRgEmg9i3mR7syiZWOo4BWwOPHPXuDuIygjxfUhRlfic9MCqZl+MvdHq/LTVbjCddf8sV+/AQ+3Y95ThO/H1TqFkcQPJktuU5L/1Ujyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=nmdQJrpj; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1706217953; bh=kx9FeMTO9kz6c3Lety3dxdwU6n70e2EWE5IksjXF7fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nmdQJrpjwPNb9Uo1+W7e0ZLHvt8kwoGM6TTZ+z8WY9H/VB4fHN6Dx01K4HVk7C6ek
	 8Xj61dSRqMRw6ZY0cbcX9X6x0vz7BgcEoI1/6ChHvQUr2bBGfFj+hlMYJLwJPUt4Gy
	 lGLYDp6sUyciEEP2ANDqc8JUKrigpNO8bWDVFgfU=
From: Luca Weiss <luca@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: Re: [PATCH 2/3] clk: qcom: gcc-msm8953: add MDSS_BCR reset
Date: Thu, 25 Jan 2024 22:25:52 +0100
Message-ID: <2714198.mvXUDI8C0e@z3ntu.xyz>
In-Reply-To: <5192c3b1-46fd-455d-aa67-b05bf5c54e19@linaro.org>
References:
 <20240123-msm8953-mdss-reset-v1-0-bb8c6d3ce897@z3ntu.xyz>
 <20240123-msm8953-mdss-reset-v1-2-bb8c6d3ce897@z3ntu.xyz>
 <5192c3b1-46fd-455d-aa67-b05bf5c54e19@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Mittwoch, 24. J=E4nner 2024 13:10:53 CET Konrad Dybcio wrote:
> On 1/23/24 22:03, Luca Weiss wrote:
> > From: Vladimir Lypak <vladimir.lypak@gmail.com>
> >=20
> > Add an entry in the gcc driver for the MDSS_BCR reset found on MSM8953.
> >=20
> > Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > [luca: expand commit message, move entry]
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
>=20
> I found some more definitions in lk2nd
>=20
> 88:#define  GCC_CRYPTO_BCR                    (CLK_CTL_BASE + 0x16000)
> 106:#define SDCC1_BCR                          (CLK_CTL_BASE + 0x42000) /*
> block reset*/ 125:#define SDCC2_BCR                          (CLK_CTL_BASE
> + 0x43000) /* block reset */ 150:#define USB_HS_BCR                      =
 =20
> (CLK_CTL_BASE + 0x41000) 155:#define GCC_QUSB2_PHY_BCR                =20
> (CLK_CTL_BASE + 0x4103C) 168:#define USB_30_BCR                =20
> (CLK_CTL_BASE + 0x3F070)
> 189:#define USB3_PHY_BCR                (CLK_CTL_BASE + 0x3F034)
> 190:#define USB3PHY_PHY_BCR                 (CLK_CTL_BASE + 0x3F03C)
>=20
> Couldn't find this one though, did you confirm that MDSS goes off
> when you assert it?

That one's defined here:
https://gerrit-public.fairphone.software/plugins/gitiles/kernel/msm-4.9/+/r=
efs/heads/int/13/fp3/arch/arm64/boot/dts/qcom/msm8953-mdss-pll.dtsi#21

I'll add some of the others in v2.

>=20
> Konrad





