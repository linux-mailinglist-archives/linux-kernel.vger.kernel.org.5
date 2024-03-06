Return-Path: <linux-kernel+bounces-94748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEED98744B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3F41C21698
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635151CFAF;
	Wed,  6 Mar 2024 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Joz90yLW"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8A01CA9A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769036; cv=none; b=DD2p1mnHY6FkKj3XaQ9/aORyytLx8D020oQ6sDsAlRfighrKg2UjQ+LPsBFhxsYulZMBt3JdO7Qyrc+QZFkhsx/jq+or8Ki0CFy1liVB+DqC1nLXdDYcPvwd7LNFFFX3nQFTo1/ONdL7L9V3C0NKPL9+cLF3s7Pkaq+3N4Ab/Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769036; c=relaxed/simple;
	bh=a2mPQn+ZcAe7/sdVpjQGd6lX+EChpP9E57MgYjAx9Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uq6uSPL9mE/P8aOi4t+lCjG4wgqbHEsWxdH0LdyPzbCKiQMupPBazc4HFlyyVmwYo00LISBXavIgQ+fO/u/JnH3gqdJWvyd4hC0L5r2ZFlJzEWoy9L0Rwsw8o2+dlclk0t1iDjeenlSjLzaXGQmD4Xdk7wma8fXT5CR35bbd9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Joz90yLW; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D1A182C0220;
	Thu,  7 Mar 2024 12:50:25 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709769025;
	bh=WyoWcZDwLyeyZEXFs2G2QnqK2+2LcM5zhvfqzAtSpNs=;
	h=From:To:Cc:Subject:Date:From;
	b=Joz90yLWp5uMkCO9Lc8+SnYx9+T1EOuPtCy5YimxKG8Ur4cFwGB5Z32gglTOC2Kcd
	 7JXtuKX2CJhLGl9eiiF5OODxh/q96wFLDcSu+8vcPcsUodoFz+l3VEzItLoLW40qcH
	 DOmyDAs5i04Ild55lmKHyYzv0v2OrCdIoG69ZBV1AdFeKqc5UPaOLSzP/cRWEJIEOs
	 tBtn614Ad2OHP/T2BtuBCWjtQHKid92BbToBcnSbdJ+QOZ4u8Tgu7UMMDx7901EnrB
	 VL6jlIxE1KGuuM2EHXWTMK2oWFtXzDdyFZx7aSuzPOj/0YY8mepQi8z1L45a9dTzI7
	 WKm/hJOqOv2nw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65e901410000>; Thu, 07 Mar 2024 12:50:25 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 8220413ED56;
	Thu,  7 Mar 2024 12:50:25 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 7AB97280B6D; Thu,  7 Mar 2024 12:50:25 +1300 (NZDT)
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
Subject: [PATCH v5 0/3] auxdisplay: 7-segment LED display
Date: Thu,  7 Mar 2024 12:50:18 +1300
Message-ID: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65e90141 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=vR_gaf37D5lytMZdZ5IA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

This series adds a driver for a 7-segment LED display.

I think I've addressed all of Andy's feedback in this round. I haven't
heard from the ARM maintainers on any of the previous rounds. At Andy's
request I've dropped the USB LED change as it's not related. I can
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


