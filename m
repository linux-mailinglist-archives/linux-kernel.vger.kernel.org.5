Return-Path: <linux-kernel+bounces-12549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D468381F68C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75CA51F23304
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD616ABC;
	Thu, 28 Dec 2023 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QcCer+ma"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4EF63A8;
	Thu, 28 Dec 2023 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703757268; x=1704362068; i=markus.elfring@web.de;
	bh=LdODy8f52XjIOK0lSfQyj0RXaUr08zMyR40prr4dQGA=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=QcCer+malGs0R8tHkNVZJNODF7VXQCWs1FmPeLeDnHDA4R+NSAnmkg28sSKX6bjo
	 e1hL+41LTyF8dfz+5DrSM84/YOz7Ou0c/mpIKb+5zz5osQiJ5K4UmW2x50or73Kq6
	 9zZIPh+7he+jlVDTsJnLXsFPpd171CTbMXTDiN30nCHPjwsn8up1DBv/oeSYD7Zxw
	 /LOxW/pNv13hPm79dTSU2XBlyjefGToZlz8cwYUKtD990WQoLH9980X7WsSwdeGoG
	 G/mh/cp3LcV2xgECQvevNyipV4Wl4V3TLiLBbvb1G6GQgw8+brkTq3PEzCBZ617hq
	 TRs0Yiz1DS8o3F6i7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1uAl-1r7cuT2k13-0124gY; Thu, 28
 Dec 2023 10:54:28 +0100
Message-ID: <0d0c4876-37d7-4bee-912e-56324495454f@web.de>
Date: Thu, 28 Dec 2023 10:54:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] platform/x86/amd/pmf: Return a status code only as a constant
 in two functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jUyWQ8RdCi/tZgmPTVI41q7ZfAnELOCp0Gr+YCtZLiTgdfgay07
 gGXqfKbOwAOWKrG67ZvuiZlekxdBzMMLpxHD/qONJxGq5nNQqFJxdvgUxzjGgziIDoGdzvZ
 WakR3etjiquyCRo49clUjpeSUWaBv+cd0P4nFVqOqj7m1GVJDfJL7oVmFbDBOGow9k/HVQw
 x/f+h/Po33VoWewuIx5ag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TmTrwd9GXRU=;a027FqgyvmWIt3MVpkxyigPDqmP
 acsYJhm5sPpKoXVvfh7Gf+SjuizSh9inE2myh2BEj4WtO1/1VB6AL0Q6plOUyEuwqRQ7Q7nk8
 tU+k8UrcrwQcvUXD13RastM9QiqGPNnuOQtdveBb1mMKmiQdhnGKqnYLwmAYS0E+Epzv72761
 htaNIx58/hCGS6akKG35Mwiv9z6U9YSK8+WrS2vSzqAjzyCRRQH3CKJnL6f09sw9KiaM4DI5x
 5W8GRDquBMA+zimrP3cIfOh+URtHirL0L9pYTSvNCmiwqmvApngWXgWZJ564Sx/hU7QICSMUk
 7SE1PpmxfFUn7uWPfLxP/ZtlI1n4+0qEqBD6VMqOwBLVOxyd8l/vraEzoloWTm2E+17hQ7RMU
 4UWeqxMoo885EOcoO6ohdkK7BdZw3Rl/0P//aijDOO7c4jC2OZev6pNr9Pxy/Gke7BjEJEbbf
 0OHUuic3iaysSYgibyt+0ZvRmZuu7G5thk0nxqRAGnS9Iq6nF4wsA4HKgCrBXLQEDRg+DPFBL
 3F1Pr64sa+uDVDAMD2dQ5JgBOHZ1heOskBw424rdltztdCv2tD7PsVoDCdWp3GoQS+XX087W5
 xfBISGMIatrHdUdyX2vzMUliId+NRfXqcvfjlzmHAyYiPmikF+5uRZWEM1rWrMDZ0k3RN0QCo
 sHTseRwbYQz3jemr5TypWn1oDTfI8EqIwPshqR+C/a6u1Tcwdd91YcgpfrZY+WgOjo93FDgza
 jtFLeqpT53t7SomsXg+KMQsh9qynyigtgeO6FSagAgJ0Jm3zAEUib02CkzmAgFn6U+tu+Sjmn
 2hNnKiUcAo7wB8wJUlI6EvUbvgKdrbM2JXpUKy4npympipN4SRhLuT8g0jfBWgqjai/zBrIBH
 2i/+rscupe+QBnzGbJI3NlPItlwA6/0jRP3P2Awm2ihsXqAQW4vNWTcl58R6Z5q+e3RIscZT2
 cxOvMg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 28 Dec 2023 10:48:16 +0100

Return a status code without storing it in an intermediate variable.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/platform/x86/amd/pmf/acpi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/acpi.c b/drivers/platform/x86/am=
d/pmf/acpi.c
index 4ec7957eb707..ce00dd9a5391 100644
=2D-- a/drivers/platform/x86/amd/pmf/acpi.c
+++ b/drivers/platform/x86/amd/pmf/acpi.c
@@ -111,7 +111,6 @@ int apmf_os_power_slider_update(struct amd_pmf_dev *pd=
ev, u8 event)
 	struct os_power_slider args;
 	struct acpi_buffer params;
 	union acpi_object *info;
-	int err =3D 0;

 	args.size =3D sizeof(args);
 	args.slider_event =3D event;
@@ -121,10 +120,10 @@ int apmf_os_power_slider_update(struct amd_pmf_dev *=
pdev, u8 event)

 	info =3D apmf_if_call(pdev, APMF_FUNC_OS_POWER_SLIDER_UPDATE, &params);
 	if (!info)
-		err =3D -EIO;
+		return -EIO;

 	kfree(info);
-	return err;
+	return 0;
 }

 static void apmf_sbios_heartbeat_notify(struct work_struct *work)
@@ -148,7 +147,6 @@ int apmf_update_fan_idx(struct amd_pmf_dev *pdev, bool=
 manual, u32 idx)
 	union acpi_object *info;
 	struct apmf_fan_idx args;
 	struct acpi_buffer params;
-	int err =3D 0;

 	args.size =3D sizeof(args);
 	args.fan_ctl_mode =3D manual;
@@ -158,14 +156,11 @@ int apmf_update_fan_idx(struct amd_pmf_dev *pdev, bo=
ol manual, u32 idx)
 	params.pointer =3D (void *)&args;

 	info =3D apmf_if_call(pdev, APMF_FUNC_SET_FAN_IDX, &params);
-	if (!info) {
-		err =3D -EIO;
-		goto out;
-	}
+	if (!info)
+		return -EIO;

-out:
 	kfree(info);
-	return err;
+	return 0;
 }

 int apmf_get_auto_mode_def(struct amd_pmf_dev *pdev, struct apmf_auto_mod=
e *data)
=2D-
2.43.0


