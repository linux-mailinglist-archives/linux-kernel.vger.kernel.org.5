Return-Path: <linux-kernel+bounces-4334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660F3817BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BE11C23852
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0340073495;
	Mon, 18 Dec 2023 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mWGQtcwR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545CE73469;
	Mon, 18 Dec 2023 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702930766; x=1703535566; i=w_armin@gmx.de;
	bh=Gv/3KB2nhnzbj6OabYsWChzNP4Kil+PLOJoDKQOnE44=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=mWGQtcwRPhtW/JXklo9Vki7Pj8Ts0Sy5ielOVqHp+wTHpmQ97iWguYnpEJ1Jd3wA
	 f2znaplS9RBsOOUHf3+qS3X3PlPa6a4no9+3n8XjC46I0e3j25EL+pAoKZr+oymzx
	 vZD2+vd2MqpLknKxecemUwNRsB2RJhkgvjVLEjol+QL906DjOFgPbpXxUqXt6JKic
	 246nqNd9Y52BTkZUJcAXb+EKso4TDWJBc/ZnsfwOpJ5Hw2Qd7guPXnIj3hAD+zv18
	 QdJnn8IIyHwCE90UXdWqQDri+25LnddCazR2eynJh2XR9dp9jelaY2ZQ2uRX1pX30
	 sqqGuAi7gFMu+eOU9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MOiHl-1rfWqH0uAJ-00Q9Su; Mon, 18 Dec 2023 21:19:26 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 2/6] platform/x86: wmi: Remove ACPI handlers after WMI devices
Date: Mon, 18 Dec 2023 21:18:43 +0100
Message-Id: <20231218201844.2860-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218201844.2860-1-W_Armin@gmx.de>
References: <20231218201844.2860-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XOdpNjhflCYKJ1a+4E2Buao2nLfPzOYhyhtIE5Yvp/hvdx3f3V3
 PAz+fPMBVHAzyWVntXAdayofd/qfaQ9+aIQA/ezcPCqjFi9cxhjpu/f3b8yvDslFyEQucZe
 zrmOYm4iZ+8zKqQry9xVQF90v/CsE1rZ15FshNAsyvbiENrA09WBb6y4VghHZU1SeGn7Vta
 bLA1z3h9EyNbje1Fyjifg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Kxsn0DJ1v4g=;jhv3lb2Pj5rrq6ZAZa6pRPVGWVE
 JS1tKzoUYgMYJ6MKiv/Cd/ft0+yTXxKO+TaofGzbtPkrTniIzvSclh+bBNgPSrpnrxbz92BOS
 pFSvlikPliddvT7DNkQJzBMUYA6AE4roZL/HKz+J3B/zSZWtDiwo4QEIA50x6qbNhnIwJSbPs
 YVbpQqIOLyYu/cX+oZDV6Nwbigtme8n9t1zg6V4z/Z11OUPKbjCXWhBfuO8Ha2Sa2J86XflbE
 6C7jhOc1lK5lU2FR4U9VqHuGTJvcdnkvPY4Jc+VW00YDU9x0W/xB1ttmDVOZeCadMr9M7zaN0
 3T7cbkhjGE2ydMLNwIOYqPBHgiFi8Aev4Q044SzDJRJFCEybdT/Kc+v/j5VySIbItQ8QiFWMB
 PUqGxL4NbWTyk9qfqltyHlKvkxUnAf8CKU0t2pz4HRMdXFIUf2JhFAiov5x0eI7BjbWmFyv7/
 LGYsotAiQaKefymxuTKT7uENIez+xpiKidavHj83RwICOWbOBgjFOMlbxVaxR+f1PZjaPPs1w
 Fno1S4jrwJn30naCvtGTfL3S0SZOOx8loIXYJOmeNlFEkXhhGD01lxdYgC+MeHoLkljHTt2H3
 2goZxtcBs04rhzVskLzYNmKaiCeXx4glfuXeKNaA/LWWtiOFiaQsVKdc+FjNeL0PT20xVk4M/
 qNnKoYPOQf5h/dslojIdiYLth6TZWdh2CtRppPBmrpEoA0uR35xrxjVjJNivGCVRvl6g0jyrB
 mdD5rwuN85COPjhAJrbbbGk8EGaUM78wU+WTxWBaY/1yxG7FHKXaP397pAJKIJQ4UiiaNYKun
 ITAAtMwAZBUApFnGhB2McZ1LM1SpegYAu5VNrRhrVB6poAY1I2lJhUjKYA9xgZkze2kpQIndz
 VHcqzVpQxXYiryxXj/ywEGRETDz+WZUuR6Unv4Xud7OA88dibnD70OIAlRj6ySN1bTvkYM87Q
 2kPQGQ==

When removing the ACPI notify/address space handlers, the WMI devices
are still active and might still depend on ACPI EC access or
WMI events.
Fix this by removing the ACPI handlers after all WMI devices
associated with an ACPI device have been removed.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 906d3a2831ae..2120c13e1676 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1239,13 +1239,12 @@ static void acpi_wmi_remove(struct platform_device=
 *device)
 	struct acpi_device *acpi_device =3D ACPI_COMPANION(&device->dev);
 	struct device *wmi_bus_device =3D dev_get_drvdata(&device->dev);

-	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY,
-				   acpi_wmi_notify_handler);
-	acpi_remove_address_space_handler(acpi_device->handle,
-				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
-
 	device_for_each_child_reverse(wmi_bus_device, NULL, wmi_remove_device);
 	device_unregister(wmi_bus_device);
+
+	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY, acpi_wm=
i_notify_handler);
+	acpi_remove_address_space_handler(acpi_device->handle, ACPI_ADR_SPACE_EC=
,
+					  &acpi_wmi_ec_space_handler);
 }

 static int acpi_wmi_probe(struct platform_device *device)
=2D-
2.39.2


