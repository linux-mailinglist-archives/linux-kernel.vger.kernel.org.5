Return-Path: <linux-kernel+bounces-4333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD66817BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339D71F24346
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CDE7207B;
	Mon, 18 Dec 2023 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="s7l6pPKv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37304239A;
	Mon, 18 Dec 2023 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702930757; x=1703535557; i=w_armin@gmx.de;
	bh=wmxJqeTy+krnPbLSF9jAqQ4wf8RAiD4RO8JEKBF3GIA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=s7l6pPKv9BuBVYZ3gIfHq/6URUUA1BHGp5n0ihUtyvfQofdNs3v+Gaa41hO2NClR
	 WZtBlSD+ecFMyWAeF1AmWrHz2qVSQlDJK6zADyQD2WO9Vw4bKwC9BJqYccltCMmE0
	 9nxJRckWz6AbvZRF9lTenMhgHIeJGW67qcdyXCcthAGUin4+KUWUqoqVHOl0dAWaQ
	 nvpX0uClpPtE9zZXJIkTovz19edAKosRTcCL9Ux8iyPwsdodyiFlFBK7Pw0rn4MA5
	 rOs5MBhS5LdtcSPeonEXoPpqBvryrEa2n1bX12BhoiLEKW4BbBw6nnSkBZ3qhfHGB
	 3tSZQnfyb40AKuiOYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mof9P-1qvdT21hKz-00p8HD; Mon, 18 Dec 2023 21:19:17 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 1/6] platform/x86: wmi: Remove unused variable in address space handler
Date: Mon, 18 Dec 2023 21:18:41 +0100
Message-Id: <20231218201844.2860-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218201844.2860-1-W_Armin@gmx.de>
References: <20231218201844.2860-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KAjm65QT9bT5nfT6XqP92X2Nm+jWQAubsvYi5HST0dK9+svm1Ge
 QzkiHdUHU0BhHTLqTSyMtB+9XpmXMWJ5apONpxef8YKdFGrN1MrhRyrsJnK0067bp0IQrfE
 IGPIoeVFhkoXehlyTAF7/mFnQW8L8hS1+vP55wjWDvPLAndWdch5OOb5LLOVb/81XQHiB2H
 CbndZaUtpeDVI6fxMGe4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i2HjnkTolY4=;kFzDhjTZ6XZL0SJHyAXlhhP2n9+
 TiU47rXnKooelB+tJAEqvPPDwDcVm50A6GXYQWwunT2ot+JqGXz5BHCn4I/Vtuf8QjYm9g2lw
 Ax92MbJuu1bSveqjpkCBbpVFp+blFXGps97KSXc6kMGEvfRVw6GYP54SljrExiKrBaZGhI7wh
 w6FaKS7VGu1NNb2AIrFnh32DIK9AMVPWpE5r4rTZT9OVfLEejiWPnOA27WI1JUNzUbowjzSFV
 GMZ7mAQ04n21+fkS4H+VBxFjWu5nTL9qQq+wjhl9S7jZFBdVPLvYVW1pkRIVRwmqrY08RmSpE
 L+dB/eHW3P611/7fL/IC/hzzB3SDDrFd468ASoCQICzmYckgvfL8KJvxatQLP00CCZ0Ht5+Lq
 Nk3fpkIjjOZJtw2iv68Xyy98flhw+OTP+ehHTvS5hZvttI34IsEo2HvbW9+fqSdEuRmS9pqEj
 l05B8edyd9R6PUTH0xckunxdG5MnI7zlsFmYYQsg1Y3AIeBDkIgA3+wZqkpluey7X1mPvkJJe
 exanl8jirW3UzFdr354An+75CGtd2DZWMQXct2L39UDZWhcL/ovJxs6ZEWJz5EpoKIjwh7uz1
 /lQH2TCoAEdFXTZu1bXjIw56CeqIEv/XKPa5ZAGeXWaz8GRmlJxKVaB7aqlzZngaUOGsviYTT
 J9ftd2COVMvWx8zDQ4NztTqaCGoCPj3cZFjFV1sJ/yL6Gj9hq07OJOSsUhJK9EI+XIyZ4sfjX
 WI8GoIW2Aaypy5BbPbVB/Q3lGxjB+4RGZWIREJjCTbP5BZyN/692uULDsA/50t4D7a29XJEF1
 DZEEKXfbR7OLonDxH97Nmxfx34wz5j5GXSZjlyRjf5cKEp4Ciuo2tMWG71cY0lq/wRAJiBKC9
 6Eu+SKVetX1dQr0/vRjd+7S8rC5cc1YQaKs+VAwV3hGme0lNVPd3Ex9LmRJT4FZimnxeYwjTe
 /VTkzBDABKN5Jgb01ImeT740F/I=

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


