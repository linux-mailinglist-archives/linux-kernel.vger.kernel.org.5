Return-Path: <linux-kernel+bounces-7812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD9981AD8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11975B229D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285068F47;
	Thu, 21 Dec 2023 03:32:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF5DAD21;
	Thu, 21 Dec 2023 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id A003F24E285;
	Thu, 21 Dec 2023 11:32:24 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 11:32:24 +0800
Received: from localhost.localdomain (113.72.145.47) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 11:32:23 +0800
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Claudiu Beznea <Claudiu.Beznea@microchip.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>
CC: Walker Chen <walker.chen@starfivetech.com>, Xingyu Wu
	<xingyu.wu@starfivetech.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>
Subject: [PATCH v1 0/2] Add Cadence I2S controller driver for the
Date: Thu, 21 Dec 2023 11:32:21 +0800
Message-ID: <20231221033223.73201-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

The Cadence I2S Controller implements a function of the multi-channel
(up to 8-channel) bus. Each stereo channel combines functions of a
transmitter and a receiver, and can switch freely between them. Each
channel has independent gating, clock and interruption control. It also
support some of these channels are used as playback and others can also
be used as record in the same time.

Four I2S controllers are used on the StarFive JH8100 SoC. Two of the I2S
controllers use two stereo channels, one of them use four channels, and
one use eight. It had tested on the fpga with WM8960.

Xingyu Wu (2):
  dt-bindings: ASoC: Add Cadence I2S controller for StarFive JH8100 SoC
  ASoC: starfive: Add drivers of Cadence Multi-Channel I2S Controller

 .../bindings/sound/cdns,jh8100-i2s.yaml       | 100 +++
 MAINTAINERS                                   |   7 +
 sound/soc/starfive/Kconfig                    |  18 +
 sound/soc/starfive/Makefile                   |   4 +
 sound/soc/starfive/cdns-jh8100-i2s-pcm.c      | 262 +++++++
 sound/soc/starfive/cdns-jh8100-i2s.c          | 727 ++++++++++++++++++
 sound/soc/starfive/cdns-jh8100-i2s.h          | 171 ++++
 7 files changed, 1289 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cdns,jh8100-i=
2s.yaml
 create mode 100644 sound/soc/starfive/cdns-jh8100-i2s-pcm.c
 create mode 100644 sound/soc/starfive/cdns-jh8100-i2s.c
 create mode 100644 sound/soc/starfive/cdns-jh8100-i2s.h

--=20
2.25.1


