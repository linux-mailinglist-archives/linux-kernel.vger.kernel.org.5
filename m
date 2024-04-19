Return-Path: <linux-kernel+bounces-151574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A89788AB095
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB231F244D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F5112D759;
	Fri, 19 Apr 2024 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="aNkmz85f"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019112FB12;
	Fri, 19 Apr 2024 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536260; cv=none; b=TJxIOu33kOXTFpPnAfenxMxcZTBvxm10Q+cy2AavTmYV0tLB4gWfNQPa9pnNLlRFTQzxtcBQykZTv/ooa9/QQfvZNdjanUBrVXBs9rhpQlYnmh9f6aZHhB3YRYjDRuRAQso+PbOLBUvoqQ2we+MW7FLA0Zt4sf9nipSK+cY5jlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536260; c=relaxed/simple;
	bh=OAeYXdnsHo/DbZFmMhO4X2AF1kWlsKRdM1cAg1u4sQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3f/HecG4CdqYhnkiiphQ42vXh/z4h541ssQ6M8r3mJbWohEuCqclXp8Yu91hxg9YJE4lb4OruOu6Uiv3ZZybjGyiySJYSYHmfXZ+dgN+D6AC2Z8JlAEd3vfVBPI52kFTDlSk0p3H9s5gAQzPg7pjeIGaGjU/v+fEQdfWTQo0Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=aNkmz85f; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713536244; x=1714141044; i=parker@finest.io;
	bh=+oqF0TtEVeNFKa6CNbV30K8acenVtAv92jduxJuUnGU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aNkmz85fYlBOaGAHBNxKdo6B3ne/qJKa3N8g5PFI8PVuslkcvP9B8HwsRwq1upGL
	 +isq3Q29HOtExiiC3RSZL35q97bCiG6D4l1njg4JDYkjEAj8X6IT6XaNvjSSowuor
	 vWLtKXvb9ATlqw8qRpibOKyIBcca9Uy3/umw/59J9ylcdNY0awugKjVWUeWZlQFEh
	 Bm8jXsAc+EnuAPIAeNlZgZuRN7lIo+p+LfUAGaWtZzLcntfmSnefWDfGQ0rnLPCVN
	 x4N0NEc3EYjBxExpAFze6xF6NDyFKYAf25Q6XV9zlrQDCp3OUeyWiGNrkT0ZchPrO
	 XKjAmif3oVVeXV1l5g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MBVXk-1rpXJV2uko-00AWAU; Fri, 19 Apr
 2024 16:17:23 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Parker Newman <pnewman@connecttech.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/4] serial: exar: add missing kernel doc function parameters
Date: Fri, 19 Apr 2024 10:17:01 -0400
Message-ID: <eff495e2263de22e25ff8b8d7cedf57fe0e75c65.1713533298.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713533298.git.pnewman@connecttech.com>
References: <cover.1713533298.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VUG1KUrvzth9u/JxCJmkf7s90ubBuIDoDNYWTM2YYLRx86BiZMw
 wh7jTcYzGOyVDr6C1yr4znNtQzhCoy2R6OuZxo7TA+PLrysTBK3Ni26QNCgdb9Nklquysy9
 B0mUq2PyB3s00o1abSFo+PsbTUN2uVvd4apt7p82ObFHCXckFR5UQjrdTN1pazxKnKgpYMl
 qYbVCG0W9T96Xv4/Q+paA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gNPXuRkoSpQ=;Otn35BzurIR2v3UC2DIDbYyZH1c
 l9B3euleK2Rf87vEoM74oa8GchMDF6/cbRcFTSU7qaWla4rK8f6NaMGZS7ofdO7MrCc5jCTA0
 0xfKwz8hR8m/kDAfyiC6vRUFhAiavjdpDfSsIMniWqWKiiOEhRI9+k9BjS0J/dwgPO8iLq+yC
 xlM5+rIuWd0zq+IJZXpyA45C2DWBUjGuBuuOu71MWxSEfono2oYsJS6UPcOgAexCFKuXw0+p0
 zHSiseIRpyqKw5EaPTrEyhDT0lHQYUXOR/l1bynjVJOJiE+CBagjPDdVkTa6HycNouZziuJTL
 0kFuKr/v6kJ8LKDoBoYziugROsW858LMNq91XhrloekhaA/Zr20OPR3npv6lqpK0wBvXM0FZ4
 xkPm906pAmgFtrKxZnGcUIhASXhXKxYSgw0HQzzzGcCc6am9C0q6KFbFM7kajg/NlkUNmmANm
 yMaSdyeb1yC68QoFS895qa9xKiO2GaXQ7EVVOzbHXrWb/a0vOTThgxtnFMdEJmiE15zZZy/cf
 VaPBgOgCIllepLHpkzMNcNZXuROgVkS0sTk1v79K3blkpaVvcVW9VxfDpPVoIU+kFqsXjqlYi
 g0ztW68dCSq3I5TTpcs2Z/W0FUg+Q2T8a0Tvx5/sT8wNr9Tmnz96eGeZtuwoH9/Lf4OqSiHgr
 /vgUwD9sP+R+ZHfEZngJeAup6U9UjFxuF++3u08hrFxGfIEVO2XSC4ZhJYr2AHcFc6uP6Z7+8
 QhDPwdYznya4dL/BPeluoIyIuvDe5aeNoaHLRsBVi5fO5Cm0h1Q2eE=

From: Parker Newman <pnewman@connecttech.com>

Adds missing kernel doc function parameters to 3 functions.

Reported-by: kernel test robot <lkp@intel.com>
Closes:
https://lore.kernel.org/oe-kbuild-all/202404181353.1VIC4cz9-lkp@intel.com/

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 5e42558cbb01..a180741da634 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -715,6 +715,7 @@ static int cti_read_osc_freq(struct exar8250 *priv, u8=
 eeprom_offset)
 /**
  * cti_get_port_type_xr17c15x_xr17v25x() - Get port type of xr17c15x/xr17=
v25x
  * @priv: Device's private structure
+ * @pcidev: PCI device pointer
  * @port_num: Port to get type of
  *
  * CTI xr17c15x and xr17v25x based cards port types are based on PCI IDs.
@@ -807,6 +808,7 @@ static enum cti_port_type cti_get_port_type_xr17c15x_x=
r17v25x(struct exar8250 *p
 /**
  * cti_get_port_type_fpga() - Get the port type of a CTI FPGA card
  * @priv: Device's private structure
+ * @pcidev: PCI device pointer
  * @port_num: Port to get type of
  *
  * FPGA based cards port types are based on PCI IDs.
@@ -836,6 +838,7 @@ static enum cti_port_type cti_get_port_type_fpga(struc=
t exar8250 *priv,
 /**
  * cti_get_port_type_xr17v35x() - Read port type from the EEPROM
  * @priv: Device's private structure
+ * @pcidev: PCI device pointer
  * @port_num: port offset
  *
  * CTI XR17V35X based cards have the port types stored in the EEPROM.
=2D-
2.43.2


