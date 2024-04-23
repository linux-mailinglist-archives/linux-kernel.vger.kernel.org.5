Return-Path: <linux-kernel+bounces-155954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3C68AFBA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5DF2813BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BBF143C7B;
	Tue, 23 Apr 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="IhPqFUIe"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778D413E8AC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713910620; cv=none; b=V0F7Zl0niJX9pAa5w4nldjYKdjYKXr4ALRz7I04DWhgR05GsWtI4k6vYlNQYbMEy4gQUGtiQPY6rGVeVS8nEgp8CBj4WvLv0VsezZJd8/G0ReMFkgXodZSvjN9KG72OfKzBenlro9YQhqpPcfisYTvy1VKkaxCt9YrCKfomHtcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713910620; c=relaxed/simple;
	bh=uIvRB5NhfN2RXfjYTOp2QuqGoCvYKF0OeyC5UW2/DcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KN8fo/erRWsDfsurJAhBA8uGaJ54Ey0yncQDp+6q6Tcj8tfl6vT9+28UudEu1uS4/AK05iAmVfHMQjJNyLIrlNC4texX/ds6HoFzVNx8jMlHJI5TF8pFHjOyGSXZKqALrHRiR5htLgueIppe1e0ZJQhsPB/pxZSgX0e8SKXDCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=IhPqFUIe; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1713910616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XW873UGjtp3CtjRhR1JwZmgVceGGsdglvcVq6ycij5Q=;
	b=IhPqFUIeapGEVFg1ElpFmNtVYZYG0/H9zj1K+JeyVTS3TSRyq+OP1NU5EMKxN7EDn/4RP4
	yFpTf6UomkXwnv8loPYQhYncBmCBf+9FcJtR6wu79s3WaWw0afEMPWVQ9NHys3R4eethTg
	FlrLjVMYbIuClMBFbiOqSocwbcjH3AhVFeOGz7hPjIytVZCRO6nKMRBnfZj8zgzczJFZMa
	z9c3aQxBTdu+A/sytAezbUbYIqCW8Jg/c5pVyhpn0pSFiYtilguomcdCH8vfm9/Vw2S7P8
	KW1osG7NookGntuPiOIKiI5JlZCQJsNNIyR3caMqDuU/VF9Uxul2qeqhkJrwwg==
From: John Watts <contact@jookia.org>
Date: Wed, 24 Apr 2024 08:16:43 +1000
Subject: [PATCH] Documentation: firmware-guide: ACPI: Fix namespace typo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-acpidocfix-v1-1-078658a3c456@jookia.org>
X-B4-Tracking: v=1; b=H4sIAEozKGYC/x2MQQqAIBAAvyJ7TjCRor4SHWx3q72oKEQg/j3pO
 AMzFQpn4QKrqpD5kSIxdBgHBXj7cLEW6gzWWGecddpjEop4yqvdjHgQLYYmDz1Imbv+Z9ve2gd
 AB2f1XAAAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1713910603; l=1676;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=uIvRB5NhfN2RXfjYTOp2QuqGoCvYKF0OeyC5UW2/DcE=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABASSTf5mrqWgP5uUpDqHQe9Md
 PWHPqYh94bBAxQenQGkJG3PnKqqI7u4f5v+/M8fDnqXp/XusTfmk82TXVZ0PLAgUAAOro
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT

The ACPI namespace has always started with LNXSYSTM, not LNXSYSTEM.
Fix the documentation accordingly.

Signed-off-by: John Watts <contact@jookia.org>
---
This isn't a major issue, it just is incorrect and requires people
following the documentation to look for a similar directory.
---
 Documentation/firmware-guide/acpi/namespace.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/namespace.rst b/Documentation/firmware-guide/acpi/namespace.rst
index 4ef963679a3d..5021843b526b 100644
--- a/Documentation/firmware-guide/acpi/namespace.rst
+++ b/Documentation/firmware-guide/acpi/namespace.rst
@@ -15,7 +15,7 @@ ACPI Device Tree - Representation of ACPI Namespace
 Abstract
 ========
 The Linux ACPI subsystem converts ACPI namespace objects into a Linux
-device tree under the /sys/devices/LNXSYSTEM:00 and updates it upon
+device tree under the /sys/devices/LNXSYSTM:00 and updates it upon
 receiving ACPI hotplug notification events.  For each device object
 in this hierarchy there is a corresponding symbolic link in the
 /sys/bus/acpi/devices.
@@ -326,7 +326,7 @@ example ACPI namespace illustrated in Figure 2 with the addition of
 fixed PWR_BUTTON/SLP_BUTTON devices is shown below::
 
    +--------------+---+-----------------+
-   | LNXSYSTEM:00 | \ | acpi:LNXSYSTEM: |
+   | LNXSYSTM:00  | \ | acpi:LNXSYSTM:  |
    +--------------+---+-----------------+
      |
      | +-------------+-----+----------------+

---
base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
change-id: 20240424-acpidocfix-47ccbdd90d6a

Best regards,
-- 
John Watts <contact@jookia.org>


