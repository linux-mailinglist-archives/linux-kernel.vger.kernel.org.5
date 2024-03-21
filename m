Return-Path: <linux-kernel+bounces-110721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293B08862E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE241F21925
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0D2136669;
	Thu, 21 Mar 2024 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="T5uniTGB"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FC4133998;
	Thu, 21 Mar 2024 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058774; cv=none; b=anffCRPGdEg61SPxTy5QzrxTg364SsMg6YNBBjLnOkhfceBq67oOQZuLyt12uCJhX5M2TBKDJdGL/ulVUXJE470HH0L/0exVuq8kerZ4TfS5YrWhWUHPCQ63zi41EhzilHW8sp7bshCvQJH8m/bJun86ojqnqi+mOXaMdwDUmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058774; c=relaxed/simple;
	bh=TIQnoZwJq4qDV5cDowLeR4WsNNtBuDa7FQIqcE3Y5wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpy65wh6h4MYyApgQeLOcQDZ8Ptz5sGUCStrxGHnSJaTdfkKuP4fOzJk4CpbvbjhxgU+taZjUMK08xpzdc8XQF0bPeXwNNvRnyL+oFeMzgMK3cFa5PEA/zbO6s/GDikucP2g5dB9WdqXJtRF8pM/E4y6NbqyxxKgv7IoeUqhGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=T5uniTGB; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 096639C5431;
	Thu, 21 Mar 2024 18:06:11 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id MV2G5OsxunWi; Thu, 21 Mar 2024 18:06:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5CB399C5485;
	Thu, 21 Mar 2024 18:06:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5CB399C5485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1711058770; bh=//jzrul5/etI5HJYv4rf3hRGSryC23BhON2Tv1y72Hc=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=T5uniTGBmvD8LX14fBd2OlCRPvba5J3pH1vN0P9VlkNjSgE40kuovUZ27K0X9vPMn
	 e1fAvNB24jTKTgskz7fQCj1PvqdO3DpfYG52PuFSMPUnux/r0JXWMg+SNXNSzdx0x5
	 ePQScX9L8vlWCgNz891db+MEXYLlxN8Qt8B5GXz0GwK3UiDuzCQ8JedKJZVaqAYfv/
	 0Cd+DtdmlG1BjeIiv9Mf6WbyDZ5eyypCB5RbENlG86Tkrclf6G9BHIShLosqrQgn8F
	 nx/osgfLH91TFIo2HJ8OGCB9nloSWtSnN2Xuhb2TpKy7dPNvJ0KmRCgUrnGqgU5WXK
	 iFAjlu1JFKPIw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Jg8QBSn7EGNf; Thu, 21 Mar 2024 18:06:10 -0400 (EDT)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 33CD79C5431;
	Thu, 21 Mar 2024 18:06:10 -0400 (EDT)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: mdf@kernel.org
Cc: avandiver@markem-imaje.com,
	bcody@markem-imaje.com,
	Charles Perry <charles.perry@savoirfairelinux.com>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 4/4] fpga: xilinx-core: add new gpio names for prog and init
Date: Thu, 21 Mar 2024 18:04:36 -0400
Message-ID: <20240321220447.3260065-5-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321220447.3260065-1-charles.perry@savoirfairelinux.com>
References: <20240321220447.3260065-1-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Old names (prog_b and init-b) are used as a fallback for hardware
compatible with the "xlnx,fpga-slave-serial" string.

Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
---
 drivers/fpga/xilinx-core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/xilinx-core.c b/drivers/fpga/xilinx-core.c
index a35c43382dd5f..39aeacf2e4f17 100644
--- a/drivers/fpga/xilinx-core.c
+++ b/drivers/fpga/xilinx-core.c
@@ -171,6 +171,20 @@ static int xilinx_core_write_complete(struct fpga_ma=
nager *mgr,
 	return -ETIMEDOUT;
 }

+static inline struct gpio_desc *
+xilinx_core_devm_gpiod_get(struct device *dev, const char *con_id,
+			   const char *legacy_con_id, enum gpiod_flags flags)
+{
+	struct gpio_desc *desc;
+
+	desc =3D devm_gpiod_get(dev, con_id, flags);
+	if (IS_ERR(desc) && PTR_ERR(desc) =3D=3D -ENOENT &&
+	    of_device_is_compatible(dev->of_node, "xlnx,fpga-slave-serial"))
+		desc =3D devm_gpiod_get(dev, legacy_con_id, flags);
+
+	return desc;
+}
+
 static const struct fpga_manager_ops xilinx_core_ops =3D {
 	.state =3D xilinx_core_state,
 	.write_init =3D xilinx_core_write_init,
@@ -186,12 +200,14 @@ int xilinx_core_probe(struct xilinx_fpga_core *core=
)
 		return -EINVAL;

 	/* PROGRAM_B is active low */
-	core->prog_b =3D devm_gpiod_get(core->dev, "prog_b", GPIOD_OUT_LOW);
+	core->prog_b =3D xilinx_core_devm_gpiod_get(core->dev, "prog", "prog_b"=
,
+						  GPIOD_OUT_LOW);
 	if (IS_ERR(core->prog_b))
 		return dev_err_probe(core->dev, PTR_ERR(core->prog_b),
 				     "Failed to get PROGRAM_B gpio\n");

-	core->init_b =3D devm_gpiod_get_optional(core->dev, "init-b", GPIOD_IN)=
;
+	core->init_b =3D xilinx_core_devm_gpiod_get(core->dev, "init", "init-b"=
,
+						  GPIOD_IN);
 	if (IS_ERR(core->init_b))
 		return dev_err_probe(core->dev, PTR_ERR(core->init_b),
 				     "Failed to get INIT_B gpio\n");
--
2.43.0

