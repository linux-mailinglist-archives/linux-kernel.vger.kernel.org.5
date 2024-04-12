Return-Path: <linux-kernel+bounces-143016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8512B8A334B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2515C1F24A47
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C790149C77;
	Fri, 12 Apr 2024 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="m/5W5Ayg"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A914884C;
	Fri, 12 Apr 2024 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938176; cv=none; b=nDhjCQhYmBzTcLv8HLmzjHL2dgJaU0w1mLyT813x7df3Ms+yMuhoYaCRBlZNOGFEC+z94PJ+RhXBKBNB6SOAOrBjvxaLBFxyXIMv8z5wZeDJKULBHiMflS+tqS1mqrEqq6S4XWjzokLRwP72JM7s8g3t5LnojXIskqeo+f993bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938176; c=relaxed/simple;
	bh=key2rY0okj8iTY/sKjeNG8DebhT6mn/FJZAaKfGK91E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BEXLpjz7PsJbpirgwIDmvnutxNTrRNyRPxySzKnQAr2AZlBV6aex0uthEpctalgV+KnKcP3vy8tcn1RTGUzw9xfpTy0Wb2BwFbNlVvJSpVcW46wyzLfiubF881fytnS4VykgouUZawpC0NIPMl7PzQzS3W1j3PzNMURUY+DTURg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=m/5W5Ayg; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712938143; x=1713542943; i=w_armin@gmx.de;
	bh=GfYGlzTabZ/Md6Ur06TpQylZldL1dEkuYiWABfiFon0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=m/5W5Ayg/cLKO6mqu+hsj+RN9pqKhFwmqKRKSFCwCY0gV+qinWNOKYvpFF/lRTeR
	 OQYLA0rpOYfYN6WvX8BajQ0+WNaDRexCLtOuK0M43KtsO6Hu6n7r+h2DfqnOiAoc3
	 xVD6trFryUR9HyRjvEAghFYRcEo81mVmlGM945nUPH6jnaxVEUSwn80u6+MuwcGVe
	 2y01YTIVE/Jz+sA68Q7TYbYUqcommHH56V0RTNv7lLhifG+z/jcxiB8yGjcEmIvBl
	 B1mHlQUXTUxrM+cEgXFegxmUidPjmxRxIbgAQIk3aeassvfaXN9O8b4QKtuuCFCvK
	 wdTTTKliQTVcI76Nag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MHXFr-1rzSKU0AOv-00Db32; Fri, 12 Apr 2024 18:09:03 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: mlj@danelec.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com,
	linux-acpi@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 1/2] hwmon: (core) Add support for power fault attribute
Date: Fri, 12 Apr 2024 18:08:56 +0200
Message-Id: <20240412160857.79858-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FxN8oOpXNdjbD6CD5rAKuRlwWxOj0azlCpDAY3MnyB/WSTkNHyl
 HE/auXD4vpPP6BXM+nU9pvumVwDf4Su+KryhDAmxqJDu8yiDN65uHKbPYAw97u/FiWmko1q
 Hho5TLZCzT0BwtE7qJV4xiv3mJ/a8nOewjXizuGz1IP0TwXpaVSPDkpdyoI8WjdMpxv/mUW
 QAgUgReNCQyayF+gFWCyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:14VeDLJl1bg=;KEqr7ll/Hc3qkWPfpw6n4LsbJL1
 c8x8CgG9ChVqgozx19NjB6vtmvVcPnWUZuIkUpXd2IoU1eZxfT8st/8o4e7LzBmt2gxfCuoZJ
 dVWm+IxbFQr74U/KExjrG3HYcg1DmvcwKFzBg5KfT9Ng4slLYwOXl+DLprnJ/4sRxjKsLgEFj
 ca90DiwEra/KsOtbhhXRxB2GaAE3PU6pfdu7jjtWey7U/YQULXX7X4oSK2nS7prKEaVZDtYMZ
 EmG477JPhy1mZRtXIiqebhQCEXag6gBngjcjzJetSi/R2HbbHMA7ZgKyzLppjU8JsHdyn5hUK
 1J5O6tE8njQN3dbBb4I4lrqy+SfDiUXyqENKxPARclE1bAq+Mtxy27ItVMUxGlFBsod4EMXoj
 GRMBeLmJi4GRPiYl39q4C1mcK4RQ0QhJiXNR0kLbbBN0n+tAD83sn5RRtkLmNWG+//eGEAFpq
 PQIZMrfgM2afNEdermyHaO4Yywd1PEja+zdzVMi9VtJ0b7IECl3M3nBgW+Z30AgsGhqPyXz8f
 om6O35uDstQ9wsH5lXRSO6Z5NoKCqVbhBlWa3Mu7YdaVOxKzGw9qy+Zuj6l4sBLNYVndcURaW
 0XG1mKeU5NG3rJPHlfgfbWh23k0lFJIZoTHzhZQ7vnkCUDEeZx79ND6loApE1IkwDJ/eJu8hJ
 NId6Dv2NIk55CmVKgEynArgI0MuuMkzArq4PdrmN6NXGI339DSedyIgGf6+HDob2OCR2o2KGM
 png1ApJBjheu5hAxEnGoqcuOgCf3oxZ5rMBguz8z2/hqGT8V4aqkrWLk9URKLV2dif/6krtQx
 lvV4hWowzBevjjmigXh0FKNSsMK53JPj75lmKMi+8/iuc=

Power sensor driver might want to signal that the power
value is not usable. Add a new power fault attribute to
report such failures.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v2:
- added patch
=2D--
 Documentation/ABI/testing/sysfs-class-hwmon | 9 +++++++++
 drivers/hwmon/hwmon.c                       | 1 +
 include/linux/hwmon.h                       | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/A=
BI/testing/sysfs-class-hwmon
index cfd0d0bab483..ed01d43d2491 100644
=2D-- a/Documentation/ABI/testing/sysfs-class-hwmon
+++ b/Documentation/ABI/testing/sysfs-class-hwmon
@@ -882,6 +882,15 @@ Description:

 		RW

+What:		/sys/class/hwmon/hwmonX/powerY_fault
+Description:
+		Reports a power sensor failure.
+
+		- 1: Failed
+		- 0: Ok
+
+		RO
+
 What:		/sys/class/hwmon/hwmonX/powerY_rated_min
 Description:
 		Minimum rated power.
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 3b259c425ab7..6150d64f5c4c 100644
=2D-- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -560,6 +560,7 @@ static const char * const hwmon_power_attr_templates[]=
 =3D {
 	[hwmon_power_crit] =3D "power%d_crit",
 	[hwmon_power_label] =3D "power%d_label",
 	[hwmon_power_alarm] =3D "power%d_alarm",
+	[hwmon_power_fault] =3D "power%d_fault",
 	[hwmon_power_cap_alarm] =3D "power%d_cap_alarm",
 	[hwmon_power_min_alarm] =3D "power%d_min_alarm",
 	[hwmon_power_max_alarm] =3D "power%d_max_alarm",
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index edf96f249eb5..00122e565dbf 100644
=2D-- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -237,6 +237,7 @@ enum hwmon_power_attributes {
 	hwmon_power_max_alarm,
 	hwmon_power_lcrit_alarm,
 	hwmon_power_crit_alarm,
+	hwmon_power_fault,
 	hwmon_power_rated_min,
 	hwmon_power_rated_max,
 };
@@ -270,6 +271,7 @@ enum hwmon_power_attributes {
 #define HWMON_P_MAX_ALARM		BIT(hwmon_power_max_alarm)
 #define HWMON_P_LCRIT_ALARM		BIT(hwmon_power_lcrit_alarm)
 #define HWMON_P_CRIT_ALARM		BIT(hwmon_power_crit_alarm)
+#define HWMON_P_FAULT			BIT(hwmon_power_fault)
 #define HWMON_P_RATED_MIN		BIT(hwmon_power_rated_min)
 #define HWMON_P_RATED_MAX		BIT(hwmon_power_rated_max)

=2D-
2.39.2


