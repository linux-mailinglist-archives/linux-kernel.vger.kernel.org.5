Return-Path: <linux-kernel+bounces-150407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA088A9E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98525B23DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8FE16F8E4;
	Thu, 18 Apr 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="KGZ6C84m"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3D16EBEA;
	Thu, 18 Apr 2024 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454647; cv=none; b=lO/+93vVh7P9Y2AxhpGARaM3Xqr+NYWFZUjRJIF0r7idtxXDkraNjJEXKM7KgI5d6ww4Q1sFSXb5AXx0TSWCnLgkXeB5KVmA349kUIKg17O3C62lclmiqSx5cCbp6I2fmSNZANCeLo1C9xfOkb7Esv+Lu+eS7EkiYHEusfCh2bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454647; c=relaxed/simple;
	bh=OAeYXdnsHo/DbZFmMhO4X2AF1kWlsKRdM1cAg1u4sQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpCYYJPazdhJvE6jW74MjPuh+JtdJFhjd4k8vRhkh7+ThiI+aODU/ueKoNSOiTSO8dprdZi+LMtkRU18tj+ukEot8QZrmypFS63HLRIEhNbY98G1Q9V6WZTAMjPv2Sl5a/Yzxt2mXatNboSMJ+l60yYDG6AATUtAtKytIWzVgwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=KGZ6C84m; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713454632; x=1714059432; i=parker@finest.io;
	bh=+oqF0TtEVeNFKa6CNbV30K8acenVtAv92jduxJuUnGU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KGZ6C84mpRGmyLI24Vzuao4PZSuD2zS7lvjtVc/CVt1TMjVlhTMU0B8iTwdKbLLT
	 e/67Ko+okbqsZImtBpynuk8W/n63ULHZV5vqX/kV7VIVdAdSQbBFCZ2ft++yQjgc0
	 mm2FcuvMMAAc+7DMzsyTRFUMmZ9f5nEVQZ+mDk1YpB0aBQ26R7+ev75Wft3p33Ba8
	 CUbUFd11LN8nIu6BfHQPxaH1JxAoADdzqsmHPEHZe5dNobuTVDbulqGRKjHoTjnKV
	 APPewIWjXGLrTy+60v2F5/rj23QyzFbAquNJgn1zqgL/07c67hR70v7OboumGn65H
	 UH2IYbzSNj0UjmFclQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MH1eO-1rtZnu2Xuk-004pgx; Thu, 18 Apr
 2024 17:37:12 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/4] serial: exar: add missing kernel doc function parameters
Date: Thu, 18 Apr 2024 11:36:28 -0400
Message-ID: <a79cc7d98a94b71b8d2f390b578514e84fe17c97.1713452766.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713452766.git.pnewman@connecttech.com>
References: <cover.1713452766.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Peb4tWBB6FbIjS85voxb3JKatrdxNOnXiihCl6U2UyHeSbVugu8
 gdH2glLJYS+dh5R3Sg/qu8lQkGm4Y6/ipwp9KOflfFIk6szoGss7v8IXhJtT61+IV5OGF2B
 aIXafB28nqUxsznV27dKZEjk8V/XDx+t0+3H8JGhs+Fy0efiOOFTsOClqVBoK8gLpxxoGlx
 wOxEDGh498tsbrraNBFlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q3pLf8qgAM4=;HwJgLiZqFwukb4dnVRLXoTN2R87
 KLA0VPF7PN6g66gPeo45GCnj8XR29+ZsHskfogOpQ2kNDBPnNf+vTMDXRe+hkP4R6J26YiZx+
 13XyWr1px4fTnxiIUowKxs6r7RanfAE8PGB4uX21XJOOlqIhsu22ki69jBZbCuEc4KR+v65cw
 0t2aDCizA7xpkL8CFOxp7koaMZoYuSTCigVHt/cUGL06qnsTg5S1WGl2Ie60s9W8BXERz775j
 aKyIC7rNgnTmpTcs/QLKFP03tOXnaAwH4E68f8Yb53WLP7XoxEsZJthydYGSzAHt7AYzsKLW2
 +4Udui4ZhfAkO0yF7lJ107o3l1ruohl4pfeFTMhZy2X2PbErk3LW9lJ+lbfGDYS/cEeZGFXse
 R1wTaDis65rzmluBRhtBq2iqAz7oINQh3oebjaI8zGhVYyjoHyIOUVLfxabBKS4+dsMnEVhP4
 4Jn/A3uWpLpAFFAh+s8+PWSh6qu/3JAcu4zIzGlClkaTwkiTuOUBVHLUTVmIz3dKPl36Y/toi
 Q82peq6wZLC2MdVk8lgyTTyme4BLgj9Gri2RiPxW42Mj7HnksLt8Jss/fvdDCeHuiMxBZZiWd
 ZZ8T2AcCiGCiFr7Xziwq9zM/tpw4KuX8JvtZ0UY2BspqgNBj+N3lnpl0e0YOVMNoVZd5p0OhN
 GorNL4kd3FbEXuxRj86ac3TvSjaxujRH1FKnYRq3vnULJcZPeNMe4Z7tAmBHYgOmn0qHTn88Z
 0P0B+hgPfOssgGLXv4xJqiLoEL1lOFzXiItWzMAZ0bhdQh+9bku9Vo=

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


