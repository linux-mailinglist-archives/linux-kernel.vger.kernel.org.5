Return-Path: <linux-kernel+bounces-80311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3168862D37
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4541F2175A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAAE1BDD6;
	Sun, 25 Feb 2024 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Ag6eyl5z"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A91B81F
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708896887; cv=none; b=R9zCuko6UEk5iF7ZrqnTlt1BR2x1/PT0lSPrIFMevOsFNMN2k/cwI6ze5yj5kpDMoQNRAdOJofJQxZMHgXhypUGPKV2q3aR/IM9fnMHdalfXGmykd3VPdjj1bldpuYZ/xvSDZRyBD+jkqIwFK9U9nRC/9S059ahIeLryAKDiCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708896887; c=relaxed/simple;
	bh=rBkQQG9txA6R1c7Mv2Avk/c9RrmlA7X0BzGB2IgLlPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/+fudCfe5WD6R+Gc6LVgJ2GU/JfD7c+H6qodMKbWgDNOHn09D0Oj1/2sN7+JyeeI/Q7fCNujCfrVLw8ZO+qfMkEPx+qJ1i8bCDEwpnlcyeeP44wZiaGgjSpM6dNsrWGHwr8Q5LLcvFkSnFvcX4YWjMzx7yMoAwq5csFfi5FXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Ag6eyl5z; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CC9C42C0271;
	Mon, 26 Feb 2024 10:34:35 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708896875;
	bh=dYKwYg9jFPCTvhHfnHRuamLyYbyHrNi847yiy9x7npg=;
	h=From:To:Cc:Subject:Date:From;
	b=Ag6eyl5z+oYCkDn07RZHWIrsq+RJoFXQ4DnFWtqvGivt2F6Lssg+kLb4GFQ2htr/m
	 6LIr3JJlfK4ysLIZAn5DB+QzCT0bcNxPCxMKAnjwLWN0R+DHemijzQPVoHOaku8wKD
	 za3x8FjVFuDa3q2UeOozYkJ1vgdU9xhjvJUt2QRljkslkVkN/IL+9m18VF+yEv0jWB
	 qOBuCmiwWrvFndDA0+05vpKgSavhnsSYaS7ykRRgNEn549t6TiYJdIzfg+ivo8biqN
	 I7yr9O6cK1o5aXfZZGXBhsCKXuoCJlCToU40/RgkeVaVYRWbQXrZEytkYDcg9DUDJz
	 5Eu/5yHMN20IA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65dbb26b0000>; Mon, 26 Feb 2024 10:34:35 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 9B26113EDA8;
	Mon, 26 Feb 2024 10:34:35 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 935FF280808; Mon, 26 Feb 2024 10:34:35 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: ojeda@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	andy.shevchenko@gmail.com,
	geert@linux-m68k.org,
	pavel@ucw.cz,
	lee@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-leds@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/3] auxdisplay: 7 segment LED display
Date: Mon, 26 Feb 2024 10:34:20 +1300
Message-ID: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65dbb26b a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=k7vzHIieQBIA:10 a=VwQbUJbxAAAA:8 a=BcuUNpNrl9xOKT-QDWIA:9 a=3ZKOabzyN94A:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

This series adds a driver for a 7 segment LED display.

I'd like to get some feedback on how this could be extended to support >1
character. The driver as presented is sufficient for my hardware which on=
ly has
a single character display but I can see that for this to be generically =
useful
supporting more characters would be desireable.

Earlier I posted an idea that the characters could be represended by
sub-nodes[1] but there doesn't seem to be a way of having that and keepin=
g the
convenience of using devm_gpiod_get_array() (unless I've missed something=
).

[1] - https://lore.kernel.org/lkml/2a8d19ee-b18b-4b7c-869f-7d601cea30b6@a=
lliedtelesis.co.nz/

Chris Packham (3):
  auxdisplay: Add 7 segment LED display driver
  dt-bindings: auxdisplay: Add bindings for generic 7 segment LED
  ARM: dts: marvell: Add 7 segment LED display on x530

 .../auxdisplay/generic,gpio-7seg.yaml         |  40 +++++
 .../boot/dts/marvell/armada-385-atl-x530.dts  |  13 +-
 drivers/auxdisplay/Kconfig                    |   7 +
 drivers/auxdisplay/Makefile                   |   1 +
 drivers/auxdisplay/seg-led.c                  | 152 ++++++++++++++++++
 5 files changed, 212 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/generic,=
gpio-7seg.yaml
 create mode 100644 drivers/auxdisplay/seg-led.c

--=20
2.43.2


