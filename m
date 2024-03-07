Return-Path: <linux-kernel+bounces-96133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF431875783
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7821F22D7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D882E138482;
	Thu,  7 Mar 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="0Yxn+aHB"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F613790D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841062; cv=none; b=BDF9jJTUUR6w7R2urOiTd4G+l6AvV2gKfXmTDpEvQ4DNotuJABB6ekmls7t3Puc2f0lcnQslwd4lELL7HEfq2qf/FdowiON9QAq2Xt7cFB1034Vi5xUoDirJXTSMcKT49CyHD8X3oezAwmaboy+Kl90xeP+s4KTWhurDH9LGjtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841062; c=relaxed/simple;
	bh=cQnFoidiV8SbY3NpmvYiYVvmuFmU0SCpFFwSZGGyC14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vk79hpT8Ocf8gmp5x3NDy6OgWJ341V3CeeebvfR88aShYqad2+aLpJltnObb9TYqhmbVBcQIDBNbItYtV6bLwsjJ8lMcfIddXPoonx/9JocSMs4TypHNeGbXr7wA2KacHffvHLpv2kZpCXAx9rqUwkK5Ntu39O6qaPDGdh8g7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=0Yxn+aHB; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2648A2C0230;
	Fri,  8 Mar 2024 08:50:56 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709841056;
	bh=/CsoqBaF4QQmh/yhUXEg5ykrKNTZyl8O9XO+0F9DFoY=;
	h=From:To:Cc:Subject:Date:From;
	b=0Yxn+aHBLhLVI4vQsytuVBOhyY7scTIrYQ6EqWoMMNi3GilElsy7wiB6CdixmjwBk
	 celZTr7+VcTAyWTkWEzUR/8yX+u+M9h270eU6dkMf/d2oNjT05MgiJilyMyevnQtkE
	 qowDnuaYO4B0ko4XZSUbJtDVcnoNDZOvhmXp1fBD/lszQo0CRgnCugUmg+Rk3V1ur4
	 9Sf2YN6Ibrgmgim1n1YPqwqFJcf53rpbJb40sF1L+q6IAReMRNRhaiRIetLFnbu2bR
	 Az3tZBWiO9/Kuk0rcsO73BmBlZxygN2HFWDv1BbcZKZTZpCtPHJGj6PQNViwPgzy36
	 jgTyiMMlg6vAQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65ea1a9f0001>; Fri, 08 Mar 2024 08:50:55 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id BEC2A13ED8D;
	Fri,  8 Mar 2024 08:50:55 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id B69382808A5; Fri,  8 Mar 2024 08:50:55 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andy@kernel.org,
	geert@linux-m68k.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	lee@kernel.org
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v6 0/3] auxdisplay: 7-segment LED display
Date: Fri,  8 Mar 2024 08:50:50 +1300
Message-ID: <20240307195053.1320538-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65ea1a9f a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=B6tuhtDmE4Oz97erSUUA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

This series adds a driver for a 7-segment LED display.

I think I've addressed all of Andy's feedback in this round. I haven't
heard from the ARM maintainers on any of the previous rounds. I can
submit the dts change separately if required, I've mostly been including
it so there is an in-tree user of the driver I'm adding.

Chris Packham (3):
  auxdisplay: Add 7-segment LED display driver
  dt-bindings: auxdisplay: Add bindings for generic 7-segment LED
  ARM: dts: marvell: Add 7-segment LED display on x530

 .../bindings/auxdisplay/gpio-7-segment.yaml   |  55 +++++++++
 .../boot/dts/marvell/armada-385-atl-x530.dts  |  13 +-
 drivers/auxdisplay/Kconfig                    |  11 ++
 drivers/auxdisplay/Makefile                   |   1 +
 drivers/auxdisplay/seg-led-gpio.c             | 112 ++++++++++++++++++
 5 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/gpio-7-s=
egment.yaml
 create mode 100644 drivers/auxdisplay/seg-led-gpio.c

--=20
2.43.2


