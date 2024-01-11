Return-Path: <linux-kernel+bounces-23834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFAA82B27F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AAA81C225CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792EF4F883;
	Thu, 11 Jan 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="F2JtKCd2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JyUaLbvL"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26944F5EB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 2B8683200ADA;
	Thu, 11 Jan 2024 11:10:19 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Jan 2024 11:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1704989418; x=1705075818; bh=9R
	zTEvhCKL7Awc276Zv+gQzOpQmx3QFfr62ZtDcmxl0=; b=F2JtKCd2ne/gs9Cdl5
	Xf5PybmLlsvLZ2MrcGh/bWpxnjf+zp2lW8AwJsORGFkOTM5w3Dmzg7IfDVNMJdyB
	nFZua0JNEDRHR/a5jdapaBeZtTEOVYECnA+CKCqetyGU2qQFXm0l3CQe5oU2skjm
	G/FgoWhV+7Uq8ER0AAhPF1+XHTEfcKVDwobMjc/MNcMmKghpagxIO/SogK/+KL0v
	q5Nf13Tai6dZF4y7qJ3Lj9KKYnqfE5gxXPGlz4O3IIlDJK5/m0XVcOwW6lo+Dd73
	VvEoL7ULh13o6aXWFTAsNBIkRWvqLLDN6h1UN3LFnj20Eq/y4SGHYpiKv7EJsryY
	EbEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1704989418; x=1705075818; bh=9RzTEvhCKL7Aw
	c276Zv+gQzOpQmx3QFfr62ZtDcmxl0=; b=JyUaLbvLrAjM/4vuCLILKt5YcZ5fq
	4mGkNFOzd5wwpxRhbp/APfrn938Q0EZM7pUfN2iXL2OcXIPhffN/VwbNeur+HS6O
	ejpU3CUBiaAFmdB+FFbUfUAupUi2ouIAnw7sXbegataypOMrNOVTV1jISJFpYOBk
	H/yWVuJ/KFSmidefjNlWsXsVXf8AY1lcT+WtVyxSPlhu+Qw46LYu36G+MEu7y+sq
	5KRtT5YBy518GHBdfCMtJpNaCt1Rjz0pLPV09tztgvHJoW/Bfr1aQFZWgMZTETX8
	amPQmkCBcBX8SEzOwH9bim03+eg4Ci3gNJVOCKNqrS+Q7Z3wTK3cjyiow==
X-ME-Sender: <xms:6hKgZV7pDxt4jGyIYcSR_9bczrdnUHI8r02soLYCfPeGcQ9LuFrKCg>
    <xme:6hKgZS7tDsATHrcJp4FTxmmI3H-Uw8bzaTpTKa6FlOrnTroyRzkBM0usq7ds12aPu
    jt5iKopkMIzI7Df2zk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefgffevuddtledthfduiedtvddvtdelfeekhfeggfevveelgfeitdeileeffefg
    ieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:6hKgZceoOrEMZd48J4wpycMMr8r6MWi8-SQp_y5sPm5qxsgJBS_qEQ>
    <xmx:6hKgZeIS9JfUxMH78OkSr6nhls3PknNijAH2vqNLvelmzkyJZ-neHw>
    <xmx:6hKgZZLafpwUnFBE2n84jJkptSJuLQRd7XnSOb_ZbJopyqLIvJMMUw>
    <xmx:6hKgZXjYMWKiXxh9czlzIOIXAN108KG9HFbpw-GiXZqWLH8dWNS_Qg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 04C6DB6008D; Thu, 11 Jan 2024 11:10:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1c120ba6-3c94-4d94-8497-afb6c5063d3c@app.fastmail.com>
Date: Thu, 11 Jan 2024 17:09:20 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL 0/4] ARM: SoC updates for 6.8
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

There are 1095 non-merge commits from 204 developers this time,
but only 68 branches I merged from platform maintainers.
The most active developers are:

     98 Krzysztof Kozlowski
     65 Dmitry Baryshkov
     46 Fabio Estevam
     43 Konrad Dybcio
     33 Neil Armstrong
     31 Uwe Kleine-K=C3=B6nig
     31 Johan Hovold
     30 Luca Weiss
     28 AngeloGioacchino Del Regno
     20 Andrew Davis
     19 Moudy Ho
     17 Peter Griffin
     17 Herve Codina
     17 Alexander Stein
     14 Geert Uytterhoeven
     14 Alex Bee
     13 Stephan Gerhold
     12 Michal Simek
     11 Rob Herring
     11 Jaewon Kim

As the dirstat shows, the changes are once more dominated by
Qualcomm DT updates, which also matches the number of machines
they support and that are newly added:

   0.4% Documentation/devicetree/bindings/arm/mediatek/
   0.5% Documentation/devicetree/bindings/arm/
   0.6% Documentation/devicetree/bindings/clock/
   0.3% Documentation/devicetree/bindings/display/mediatek/
   0.5% Documentation/devicetree/bindings/interconnect/
   0.7% Documentation/devicetree/bindings/media/
   0.4% Documentation/devicetree/bindings/sound/
   0.7% Documentation/devicetree/bindings/
   0.4% arch/arm/boot/dts/marvell/
   0.4% arch/arm/boot/dts/nxp/imx/
   3.8% arch/arm/boot/dts/qcom/
   0.4% arch/arm/boot/dts/renesas/
   1.5% arch/arm/boot/dts/rockchip/
   1.0% arch/arm/boot/dts/st/
   1.0% arch/arm/boot/dts/ti/omap/
   0.5% arch/arm/boot/dts/
   1.2% arch/arm/
   0.3% arch/arm64/boot/dts/allwinner/
   0.6% arch/arm64/boot/dts/amlogic/
   2.7% arch/arm64/boot/dts/exynos/google/
   2.7% arch/arm64/boot/dts/exynos/
   5.9% arch/arm64/boot/dts/freescale/
   0.7% arch/arm64/boot/dts/marvell/
   4.3% arch/arm64/boot/dts/mediatek/
  30.4% arch/arm64/boot/dts/qcom/
   0.7% arch/arm64/boot/dts/renesas/
   6.8% arch/arm64/boot/dts/rockchip/
   0.4% arch/arm64/boot/dts/sprd/
   4.5% arch/arm64/boot/dts/ti/
   0.5% arch/arm64/boot/dts/
   0.4% arch/riscv/boot/dts/sophgo/
   0.4% arch/riscv/boot/dts/
   6.7% drivers/clk/samsung/
   0.3% drivers/firmware/arm_scmi/
   0.9% drivers/firmware/microchip/
   0.7% drivers/mailbox/
   0.9% drivers/soc/apple/
   0.9% drivers/soc/fsl/qe/
   0.3% drivers/soc/hisilicon/
   3.7% drivers/soc/mediatek/
   0.7% drivers/soc/qcom/
   0.8% drivers/tee/optee/
   1.3% drivers/
   3.1% include/dt-bindings/clock/
   0.7% include/dt-bindings/interconnect/
   0.3% include/dt-bindings/reset/
   0.4% include/
 1024 files changed, 60736 insertions(+), 7782 deletions(-)

Six new arm64 SoCs are added: Samsung ExynosAutov920,
Google gs101 (Tensor G1), MediaTek MT8188, Qualcomm
SM8650 (Snapdragon 8 Gen 3), Qualcomm X1E80100 (Snapdragon
X Elite) and Unisoc UMS9620 (Tanggula 7 series). More details
are in the soc-dt-6.8 tag description.

The DT branch has two merge conflicts against earlier
bugfixes. If you want to validate your conflict
resolution against what I have, please see=20

https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git test-merge

    Arnd

