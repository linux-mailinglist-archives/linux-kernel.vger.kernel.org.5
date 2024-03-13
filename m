Return-Path: <linux-kernel+bounces-102540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF2387B398
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C718B1C22CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C11C53E3E;
	Wed, 13 Mar 2024 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="pxVlJYub"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A90C5336D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366051; cv=none; b=OVNlZAIUiSOHp6HADvzAf4clQac/0V2wqpw7e/P6bojewlIqL+u6gSyLGwKNweY/dfTDEc/Xj1pE63tW5Mz1WJbPOCDUkifRS3X0VlKIzQbVtVhicwpcnl3IWQXac8ncwAzDaXpSp1WUJRBJHjAWtwrbBjCnCwpfsYNFvCtbT/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366051; c=relaxed/simple;
	bh=mPoVTQYq7VdvrrxQ6la9CwblUF2lFdSL1QHuZq2WXy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KodjNKCN3fzWay4r29OaCr/aIJDbayQzGKu7JW+m+LnqdkxTxs6AlrHIWjxH4aseq4fEHBijRFjf3nI65YE9qKEoEnuCVsjsacsIhUhU/aggyHTFt/Z1dSKm2YnU0J2NuHtYeAQrG57MtLpbLE5Rzhr667MLmsPi7ObTOHu3Fks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=pxVlJYub; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CA5592C018E;
	Thu, 14 Mar 2024 10:40:40 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1710366040;
	bh=mV4oUURtJa5fDu6eFwW5lGCkuKZZh3l9yb4RSs8QcHQ=;
	h=From:To:Cc:Subject:Date:From;
	b=pxVlJYubjo1eWXzzeyJ8BwJYcJGiFp8JZOY6qVsg+gF+blBWcweh8BYyMwD1+MWPu
	 Eg7vmuhvRYLrkh5aM2XAIuvx91yL35m9wZIiYmTM0uqN1HNOnJjIWWAo/r5RkBxWR/
	 cY7K1x5FlVeacgNN6i5VFH0ImCP+A+CGgIQdKhmm6tLYCnTsedSShaquxE63jCqOsE
	 Xz8nqfaPSgaKTiy3JHFXlfe5MoKaG/gmi4F4gJt2tCS2CR9Rgo9oicQCH7cUgZT1yJ
	 cxKtB4vnBgD4J2/oycOTk+UItUkVyuJmId4P5CB8PGF1EkvZMbk+bSCUbeg9Q0zWE7
	 ty8e/8v6vgLJw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65f21d580000>; Thu, 14 Mar 2024 10:40:40 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 85A5D13EE36;
	Thu, 14 Mar 2024 10:40:40 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 80C5D280A37; Thu, 14 Mar 2024 10:40:40 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] ACPI: docs: enumeration: Make footnotes links
Date: Thu, 14 Mar 2024 10:40:38 +1300
Message-ID: <20240313214038.479253-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=KIH5D0Fo c=1 sm=1 tr=0 ts=65f21d58 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=dw0t6H4-AAAA:8 a=iFXl2urbudpVc5562-MA:9 a=3ZKOabzyN94A:10 a=wVJa4CU9-Z26yuRAZDil:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Update the numeric footnotes so that they are rendered as hyperlinks in
the html output.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/firmware-guide/acpi/enumeration.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Document=
ation/firmware-guide/acpi/enumeration.rst
index d79f69390991..0165b09c0957 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -595,7 +595,7 @@ bridges/switches of the board.
=20
 For example, let's assume we have a system with a PCIe serial port, an
 Exar XR17V3521, soldered on the main board. This UART chip also includes
-16 GPIOs and we want to add the property ``gpio-line-names`` [1] to thes=
e pins.
+16 GPIOs and we want to add the property ``gpio-line-names`` [1]_ to the=
se pins.
 In this case, the ``lspci`` output for this component is::
=20
 	07:00.0 Serial controller: Exar Corp. XR17V3521 Dual PCIe UART (rev 03)
@@ -637,7 +637,7 @@ of the chipset bridge (also called "root port") with =
address::
 	Bus: 0 - Device: 14 - Function: 1
=20
 To find this information, it is necessary to disassemble the BIOS ACPI t=
ables,
-in particular the DSDT (see also [2])::
+in particular the DSDT (see also [2]_)::
=20
 	mkdir ~/tables/
 	cd ~/tables/
@@ -667,7 +667,7 @@ device::
 			}
 	... other definitions follow ...
=20
-and the _ADR method [3] returns exactly the device/function couple that
+and the _ADR method [3]_ returns exactly the device/function couple that
 we are looking for. With this information and analyzing the above ``lspc=
i``
 output (both the devices list and the devices tree), we can write the fo=
llowing
 ACPI description for the Exar PCIe UART, also adding the list of its GPI=
O line
@@ -724,10 +724,10 @@ created analyzing the position of the Exar UART in =
the PCI bus topology.
 References
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-[1] Documentation/firmware-guide/acpi/gpio-properties.rst
+.. [1] Documentation/firmware-guide/acpi/gpio-properties.rst
=20
-[2] Documentation/admin-guide/acpi/initrd_table_override.rst
+.. [2] Documentation/admin-guide/acpi/initrd_table_override.rst
=20
-[3] ACPI Specifications, Version 6.3 - Paragraph 6.1.1 _ADR Address)
+.. [3] ACPI Specifications, Version 6.3 - Paragraph 6.1.1 _ADR Address)
     https://uefi.org/sites/default/files/resources/ACPI_6_3_May16.pdf,
     referenced 2020-11-18
--=20
2.43.2


