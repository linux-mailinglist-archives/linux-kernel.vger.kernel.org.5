Return-Path: <linux-kernel+bounces-98337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2465C877892
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB501C20FAD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDBC3A8CD;
	Sun, 10 Mar 2024 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="t3ThsTCf"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874C13A8C6
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710105195; cv=none; b=ZAartqeF6O8JHPRaGcNX5ZVCjdKY4LIyWlrfziT1lKDXhwMwTStfeYItOassjLA3KkHtIGjzHpKtxd44FEs+qBrWgMXkGZ8K0ArH2xpmTfI8e1YZBExE2LK9mRPeF04IJ+kxLqKeLr+kNXqWzKDZo6DK9rM4/rhMPwyxTMz+vME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710105195; c=relaxed/simple;
	bh=OrO2CmXDoSlkDVm2bn7JhxqtpszIGjb5tgVu6JmpVxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXKdy/04stVpGpmnyx5yj5QjWOnWFDxwh7WcoaZs5LaJPhc6ocM75oU3eTpnOgfKYtsCfLc74zUkNX8WtnAj0QwbQOprNyfEDWCtjCwDO0j5+dJuJ7sE9QmE5zuCyPAtxRwldwRN3jgAfyAm8/UeSKY4OQnXgKYHQN6at917O9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=t3ThsTCf; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3D9662C06BA;
	Mon, 11 Mar 2024 10:13:10 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1710105190;
	bh=OrO2CmXDoSlkDVm2bn7JhxqtpszIGjb5tgVu6JmpVxE=;
	h=From:To:Cc:Subject:Date:From;
	b=t3ThsTCfjPyLjkN1XM+GpJLU9FcIGgjFIBpLhq0pe6dtBEfCZQZa1zC3OwqVFLDsn
	 YwCnI8QyMF7cmvnlp3tqgNDsT1eGTso4WWodcocmnjSZ+om0fIoz4tFi/OzmP+QTJ2
	 Nnvw6cPxO6fbSnwCzdCWK2VBTHs4PPN49C41eA4MakMvVnnJLOT/WTIAhoReCD16SZ
	 gK75eQneGAZNdkxMhJCdg51ah89zu5FqLq7dliNSS4y0+sW3zTQWUBxcYdlWlM+yD8
	 4FKBu9ogFc4Pz+swwlwOKqgqS96fCOh7c1IGTlmqtUF/3v+VY0HIAtj2+VPccEaJC9
	 7Lz4D8siuO3Zg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65ee22660000>; Mon, 11 Mar 2024 10:13:10 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 099B413ED56;
	Mon, 11 Mar 2024 10:13:10 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 0506A28057C; Mon, 11 Mar 2024 10:13:10 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andy@kernel.org,
	geert@linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] auxdisplay: seg-led-gpio: Import linedisp namespace
Date: Mon, 11 Mar 2024 10:13:04 +1300
Message-ID: <20240310211304.1190913-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65ee2266 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=X1mCtxt7WXDfd5xlTicA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The seg-led-gpio driver uses symbols from the linedisp namespace. Ensure
these are imported.

Fixes: 899383f9ecf5 ("auxdisplay: Add 7-segment LED display driver")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/auxdisplay/seg-led-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/auxdisplay/seg-led-gpio.c b/drivers/auxdisplay/seg-l=
ed-gpio.c
index 5dc2a006cac5..35a8dbb1e9d2 100644
--- a/drivers/auxdisplay/seg-led-gpio.c
+++ b/drivers/auxdisplay/seg-led-gpio.c
@@ -110,3 +110,4 @@ module_platform_driver(seg_led_driver);
 MODULE_AUTHOR("Chris Packham <chris.packham@alliedtelesis.co.nz>");
 MODULE_DESCRIPTION("7 segment LED driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(LINEDISP);
--=20
2.43.2


