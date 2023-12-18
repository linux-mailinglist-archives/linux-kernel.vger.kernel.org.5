Return-Path: <linux-kernel+bounces-4286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3265817AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23A31C227AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1136671479;
	Mon, 18 Dec 2023 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="F+cwJ0nc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B81E530;
	Mon, 18 Dec 2023 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702927471; x=1703532271; i=w_armin@gmx.de;
	bh=wmxJqeTy+krnPbLSF9jAqQ4wf8RAiD4RO8JEKBF3GIA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=F+cwJ0nclNhP1dXGLWJGMX7SZYRwJ4ILp1+U22mE3XV2bRyE7Hjj7dSVoX7PWgWj
	 x7cT1VbX6WV6im5+z7U8LnRG5N/79H31/Uzeupb6FuqlaA8x6foPGDqBNoBY5psxd
	 uUQcAdohzzpCUdIZoR8KnX27UQSEfRrvY5eVMPqxCzyu7qwknFF5mhPUz1TZDRzmh
	 eOqqzsSrQbDWxD4YsmFk/piKGTmMzpWv1b9PZCXzesHZxwbEvSacPEOZcpwKLYEL0
	 fwpFBNZAGyyF4l2lof9cloU+BAlxe2aTasliZi/t3rCm9CGxLtqJevB61m9SPpgul
	 mNg8fqfPZOk9RJsb7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mqs4f-1qtT020sBl-00mrtT; Mon, 18 Dec 2023 20:24:31 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] platform/x86: wmi: Remove unused variable in address space handler
Date: Mon, 18 Dec 2023 20:24:15 +0100
Message-Id: <20231218192420.305411-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218192420.305411-1-W_Armin@gmx.de>
References: <20231218192420.305411-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S8I+rtYqkd9hB4BTIOJFPQ8zHBXiz7Eg8j3NmD2nr4WczvFFA8y
 wujiEiadOwkeRBgz2LDLGy+g4hnPNzcZ9QReoZG3ccbaMUfBxm7QEVEgDytJmlk/Spkh8Gn
 MXftEV2FYALg9ZbOVhxJYURLme7UqXSDkIzE/o6Ws7UYFG+R9+MYPB3Hbf0vY6dXinuV9Xo
 OqZdkyQfdLOpRW3KM1ZUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pBc19rg6WvE=;ut8b/Ot7UHszPHkkeXIRDxXggIQ
 xgOKvUSiWRWz7dB/dHieWVkRL3HscBJEWGWS/W9gBLrRQq1UMwD7CNktv1Gp7oUMouyVFtn4O
 YzLTYJKKKq2GymeO+L1D55tH2WHclZSxxtAnm1idcy8OpIMSVTEv7TlZMhJP7GDps019b62So
 zvpCj1Gd9CIwxA1Wu0KowI6Phv2ubocXBNMEf30zlCma8zjgPvfoBX7n3U6AfI3P9wEWB2FKu
 vnPRSw/hGcwvWoIWp4xsZO2lFkuPgPtX43eXkL3akyZ/yX8gCWwPeFuOExn+dfHcjcmYUfE9u
 sMLHsokyCkd7SWWJh4A+iNVPLIENQuU1sYm+wz4GoK0RHk2/Vp30CaiEBpqijGNmyDv1jMgHy
 tTvthmzoLJjYshGexz4kjh8o2aI6yaQEpNKmKE5bciTyj2wAUiHHyDIkNSRGRra9gGBqKjn0j
 brebqpVEZzkeNGf/1MSPPmZO7btnNTP4zQkf6icZLxWczBUxth+6XlHYhEfHvC47JNxoVm1KV
 ZFan4LzudG7kY2iG6HTISt4MYb4iMVEd3c6yCDZGF0gqaVi8+Z53wKvCH7Jxvvxf5izReOULX
 DQp7Nn65XEGmROPhHahderl4ZDSCNoMmOx2egwAotGANmNg9EqzI43br3S+DiHMMX4jikK9wU
 c9hWhEdxH/V+VLGi+vCO9PgsmK/2hCbAXWIfY6zmGo92sG/j/kzSHS8kMu7R/v/hP0gmUSaEj
 Wm+uiS9NewfbnKGZYTto2/sSRI+5sSW6822ryB0boJ/lkdlrV3eXmrxHQ/fXHLB1phP2se6SW
 z+QE21tMw29SzGqIMAL7QGi0VQ6DUqIcYuq2/pZPkGMlOg7JGcvO5re1sA9pc5EnPnV5upOSF
 kc4DLt622flfN5VHPImXdpz1THs8aNsyv4/ugCujv9xPY8n5HrpsdTSKJdhtVd7NpVZrpfWdt
 pGEYTc0DOWCJNXy3VmjWlTdQWF4=

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


