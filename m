Return-Path: <linux-kernel+bounces-103686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D349B87C2FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737D81F2356B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5744874E29;
	Thu, 14 Mar 2024 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="rHy0czus"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5D1A38D0;
	Thu, 14 Mar 2024 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441960; cv=none; b=OvkZ/T86uM/u0WIOe09mB6fVuYzk2IOQmsw+2mjZWZuiQYrLxefx/oZ/IXkd1ULmSQOIwWZ/bB5oxGPdLy8qE5hJuJzrKOWLG5liDicb2E7XyoDu2msaAN6UJ43sP/mNkJkgNKPLQCXOG2swKCv8p3TipIz7DI2WfUn1VjLE2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441960; c=relaxed/simple;
	bh=Yt/Ht2srOy/MWCeGWifQCTS+hIHpil3Qr+8V2f3E2F4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gKilfIDWLxDlPDOUQLnrEVFYwGUioaSwTzfnvlwhvvNlO9FWcwZRjkn7QAVpk46p2movZZ74lYkLMdviqm4bAR9Zb/tVuhHym3Kn8fn0Ih7s1V8sqIgYPq3CF/Cct7z7af1MxJTBHuZhkDWPkFIhTGa3Bh71nwTC+N3Fai+Mge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=rHy0czus; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710441944; x=1711046744; i=w_armin@gmx.de;
	bh=/mn6muzWIRKWcjsSnajnl4H8oquLpAAam6hy8/xPwIQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=rHy0czusPTznn1fpc3Y8eDzLXfwUvohmWNqKR7VakmygTrjrIvLdQgscmsTpbouB
	 7eGTBBny+eF0lb2NmjrM81MI4B1V+VAMQnKig4UODlTnofid0Wn+h8pl7v55EVyu+
	 HM2RCpIjyXPWgASzvIUMNx4UsKgmLaaI+5cSHk4E0F9a74B10fhpmcsYryNfW+6e/
	 M2+DEz7OxNT3SBPNw2SM5ocYv3kWtxHiP5eDMRCxN9Ol9wRj68uajiVACVMzS2AL/
	 j1DnEA/KPUL+g91dnDZ1javkRGy7qJ06fDNu0gyKiml/tOGJdHv2v33XjTeewk7rG
	 peXfegeiqW5OBCM7hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MGhyS-1rX8yQ0JOM-00DoVs; Thu, 14 Mar 2024 19:45:44 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	mario.limonciello@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] platform/x86: wmi: Support reading/writing 16 bit EC values
Date: Thu, 14 Mar 2024 19:45:37 +0100
Message-Id: <20240314184538.2933-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/cqH+NjydsRZcAVaI7S67/vzGgGpC5ogQtVinAFyhRN575Hz5aH
 JMetDs+5HM0fcKKi0hHLiAvrwxDRiVYZLkYucxrwmLijq7a6DXOcxjuo6K5YlbDT1wVNFCo
 7a5aexbIEKtucHVIn/A8meyuKw3dio5bZDvJMixIjaChquzt5Tn+gcSgNoGhI+YMo8VhCSY
 WCzlphX8ZUGjhiZjEAuXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FabCNjlmGVU=;O794OGRdPae3dIb4R1gaWQv8KA9
 K8mT4uQ3b5lB08wTSukck2bRDH5MMDcSlkRUiOz1CLci1V9cixwE1CB6aM/rhdGlvc8IiOjwh
 1LXM6N4DMeVbL3nsDRo+EoM66MswaECp8q6SMUmiZPhvBd3uWMtyF0VZwMxSC/kCwrFF2gPpz
 XKmrIV4p0jL0cCkhFhzOILbSAzJzeNpcTzpKvq2hScckdVmENGe76CLaZzJvg5wA2rxH28JJY
 Co93bkDu45B8ugjVgfkF2PMXdnYTDO56EXmZjp8qY3LAriXJSPLvc31sf3VxhbJIj7qtIOHqP
 cGodsui0KXrp9U/0h6hZP/jMnYeTnBQFUUIVx0uwLTynwPMscyDX/4A7EZx1huYlHgmEg38UI
 277nnnfBkpJmh+RYj0yqakvfKMQ35kiM53Qwvn/bCu1F/vDi553yR7DcLMH3vO+vcK2gtnJx0
 TGI55mlV1Uf42np2fdhDLAxDFryyG0nCCGhXrohwdpx9T5pGmKn0yS/DLjkIc6dEjaci5fkyv
 1l7Eq6u03+H9zaXfaYPBGA68A+ip7lmT3r7POfdOG/ZZC86rt3LmLgWmkow5GB4AVLbOOR1AT
 iKnYRggAaU1cIiSdxyQgjKZ4J9lzrAihm9+6vjYnSi1Q3LDKFZQtMKt/VjTaZ2L92ZcVP6t6s
 kwfsfU4rK7+Qj1Ke51vMbapEVd84JxPqbuS4xzAJ438kHWlxSN1ATPFb/9xhWwkl8xyVPJcz3
 PpgS+4e3NGkZM306xo3sqFknpo5yhreyOyX2QWSUHAUCb224lZaQGDYBAHc4KbWiC0sY/DmUF
 VD0W3IjMx4gyRZpcYGOtH5gabCHnuMmh01cOXk3dKfRsQ=

The ACPI EC address space handler currently only supports
reading/writing 8 bit values. Some firmware implementations however
want to access for example 16 bit values, which is perfectly legal
according to the ACPI spec.

Add support for reading/writing such values.

Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Chnages since v4:
- spelling fix
- fix checkpatch warning

Changes since v3:
- change type of variable i to size_t

Changes since v2:
- fix address overflow check

Changes since v1:
- use BITS_PER_BYTE
- validate that number of bytes to read/write does not overflow the
  address
=2D--
 drivers/platform/x86/wmi.c | 54 +++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 1920e115da89..9602658711cf 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1153,6 +1153,34 @@ static int parse_wdg(struct device *wmi_bus_dev, st=
ruct platform_device *pdev)
 	return 0;
 }

+static int ec_read_multiple(u8 address, u8 *buffer, size_t bytes)
+{
+	size_t i;
+	int ret;
+
+	for (i =3D 0; i < bytes; i++) {
+		ret =3D ec_read(address + i, &buffer[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ec_write_multiple(u8 address, u8 *buffer, size_t bytes)
+{
+	size_t i;
+	int ret;
+
+	for (i =3D 0; i < bytes; i++) {
+		ret =3D ec_write(address + i, buffer[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 /*
  * WMI can have EmbeddedControl access regions. In which case, we just wa=
nt to
  * hand these off to the EC driver.
@@ -1162,27 +1190,27 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physi=
cal_address address,
 			  u32 bits, u64 *value,
 			  void *handler_context, void *region_context)
 {
-	int result =3D 0;
-	u8 temp =3D 0;
+	int bytes =3D bits / BITS_PER_BYTE;
+	int ret;

-	if ((address > 0xFF) || !value)
+	if (!value)
+		return AE_NULL_ENTRY;
+
+	if (!bytes || bytes > sizeof(*value))
 		return AE_BAD_PARAMETER;

-	if (function !=3D ACPI_READ && function !=3D ACPI_WRITE)
+	if (address > U8_MAX || address + bytes - 1 > U8_MAX)
 		return AE_BAD_PARAMETER;

-	if (bits !=3D 8)
+	if (function !=3D ACPI_READ && function !=3D ACPI_WRITE)
 		return AE_BAD_PARAMETER;

-	if (function =3D=3D ACPI_READ) {
-		result =3D ec_read(address, &temp);
-		*value =3D temp;
-	} else {
-		temp =3D 0xff & *value;
-		result =3D ec_write(address, temp);
-	}
+	if (function =3D=3D ACPI_READ)
+		ret =3D ec_read_multiple(address, (u8 *)value, bytes);
+	else
+		ret =3D ec_write_multiple(address, (u8 *)value, bytes);

-	switch (result) {
+	switch (ret) {
 	case -EINVAL:
 		return AE_BAD_PARAMETER;
 	case -ENODEV:
=2D-
2.39.2


