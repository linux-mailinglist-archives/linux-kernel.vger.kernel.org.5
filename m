Return-Path: <linux-kernel+bounces-4319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C87F817B73
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293F01C22D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE967346C;
	Mon, 18 Dec 2023 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="iNRPOsmh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3E072047;
	Mon, 18 Dec 2023 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702929336; x=1703534136; i=w_armin@gmx.de;
	bh=wmxJqeTy+krnPbLSF9jAqQ4wf8RAiD4RO8JEKBF3GIA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=iNRPOsmh3J8BtjQRO2c252AFsWhTLmK0WDPXDHCqvt3eANCNERGs7VY9HltO/z0c
	 C6+9SEBc4inM2In8cE4sQlcZxmZNAzZZgM++8D24Jw2lY74cmGi2GGK5UPUiflW7v
	 9F7NHeY6w/T30u4QITQ8YqaNknhMyEZNxNEirVGKrxYwkLpkHhs1VMxEvO+6+M8B/
	 qHtwKXGLUFbe02CcZ5p8hhibXm4X1YGYo75pyFP8d9AUQZ3UDL6MwO3csCX7QxSLo
	 js3f4h3MwlwmChaDKMOn7T4rtSxWFwQ0zbiast5AMvw/3gyIFGlRynOpBBiJ5BHeA
	 qnIbb5ipcpKbpBregA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MqJqN-1qtz6x1sah-00nRLD; Mon, 18 Dec 2023 20:55:36 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] platform/x86: wmi: Remove unused variable in address space handler
Date: Mon, 18 Dec 2023 20:55:26 +0100
Message-Id: <20231218195531.311179-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218195531.311179-1-W_Armin@gmx.de>
References: <20231218195531.311179-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZO3U5lnlbvYxWiXNhEPqtIOjdgx1aqSDxx9NyU/Sbu5lAT8a3po
 4Mgzwtqvh7tJnxwZ50a6rt75tu3j2/FY4LxPh3Bnpp5ONpz1Fd8uWHAiCB7amYpZ8dkCsdb
 7FXGIL/303+tOJtHHCRoTCKMPGLbSNEJ0L7OdOA4IIfhi2cqzZv7QCWhSDlACPxylfqKOlU
 QNWBHmIW9ivDlBtBb1SPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3nf4PywuDDA=;4aONr/iPKEDv53uMqpDBS2wqTJ/
 XHTH5zR4SxW6YyA7AN4KY8uFFQ2k/R9RdXrmuPa0IPNBxq4ezE4yDYwA3ARXQAcnFuJUMkrlg
 PI+evrPJZXJ1EFKhw0dhAJv3JozUMpXmBTpX/6f+zNtzS7oQ3qMw8xu8m3NQO49mCATCj5419
 FwUR3evpvUODhw6w8zRo5QSQWe4EmyduVAtJQTxW3S6IEiUAjwLjo9sorHbgaygsY9ZTIFINv
 WMHihLG/frJLUPaGncnFBlkaEWW6meH4pF3NMOke1kcdH7Y1ROATnJJbDgVeOe4cDQk2AHPQN
 i/xMxkCKDDaF0pALh7oGkq4rnkoek7+2S7bvrUDRVS6kXuLgIEwGJlYPVj8fSlC36/0fw1HMV
 yc3w/ePkKULLhGiDmI8NORWf0CKqpvIf3ILH8xVqWufevkhJLViEqhkdNMLDfu4b/q07jkpyF
 ZAJSIZQ+sBPUNT3DDKrPxP3l6FPvRKfkb72Jo+jHbpRUYxTLxtooP+n5L9ze2ybaChN3UVKKl
 w6Vj22Nd0uZyRg0hLSmTxfT2khnN+aCRgjCibq5wDLf8ri7oMj+Alr27pmEe10MoiMRmMHuNB
 VScNYn+k/QwrOXnpx9pVzB7Zo6sYDXqjg4da3KRxE4YRjF7BBQdLwot2ovecsL8US49GIiWP/
 QAumlG4zLx6SbLGYD26wJXLMoHjuoaaNFfBRdUAp6xtg4sRqCwZOkDCSKMFMYu8b7dsMSVwxA
 PTklAZEYiEtgd2Qi07lEDrTVOcgz8PZ+FlwTtH2jE0r/BNV6l5BW6kboZHLkDWZtzxF1UjWY0
 K9/pTA5lMe+Xk0m6G6bKMq8jHAL4rvttEo5z6pVl9N5KRaGBAfFsPLRnD9IXXF3Z5FWKykLus
 ZTjdY6f8TURmfHHk2UKicX1c5F3WH98GC9tvUfsOtsLXGmr7EkAJ/PyGJusofYMSnnnDTgQAc
 3OmNQPS/rYC8dukiIN44wsrv+f8=

The variable "i" is always zero and only used in shift operations.
Remove it to make the code more readable.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7303702290e5..906d3a2831ae 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1144,7 +1144,7 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physica=
l_address address,
 			  u32 bits, u64 *value,
 			  void *handler_context, void *region_context)
 {
-	int result =3D 0, i =3D 0;
+	int result =3D 0;
 	u8 temp =3D 0;

 	if ((address > 0xFF) || !value)
@@ -1158,9 +1158,9 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physica=
l_address address,

 	if (function =3D=3D ACPI_READ) {
 		result =3D ec_read(address, &temp);
-		(*value) |=3D ((u64)temp) << i;
+		*value =3D temp;
 	} else {
-		temp =3D 0xff & ((*value) >> i);
+		temp =3D 0xff & *value;
 		result =3D ec_write(address, temp);
 	}

=2D-
2.39.2


