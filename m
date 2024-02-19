Return-Path: <linux-kernel+bounces-71266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4461285A2B1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8F7CB23B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EC931A82;
	Mon, 19 Feb 2024 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EmTgCLO2"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C614B2E405;
	Mon, 19 Feb 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343982; cv=none; b=hmA4X9xA/50UX0vQ0si7+IyIuCPOhRV1WD7kLSHklRxDdCkAbJ/ZW3sI8/pjnST30tQrvGVobobTHcHylnvBsuW7dcvXYO8mnjrw8FUGvrXX4ZguW97JfqpOM3GXrOaLQyMvPz9faQ4CQ3PbuAQqyZTqAYP4F4UuBewS0dKNDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343982; c=relaxed/simple;
	bh=qHfzr9Z6AbrLnleJ2vRO1YVBS5jWB6XYcpAOq7kcFsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N7nr46yG16C1YEDo5GqpdVXMYp0iG4YPiAPV219dydC6doPCtlbGuUSqCGtyED//KcXmCJaWa8ZewthdAYokoJSL8n+DIDALtXYTd04OmQexkswD6VW8wGaYRvQA1H318RKGxSAAzLY7hDiAPHcyJKuXbbYfUHZKWXQI4cqdSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EmTgCLO2; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708343971; x=1708948771; i=w_armin@gmx.de;
	bh=qHfzr9Z6AbrLnleJ2vRO1YVBS5jWB6XYcpAOq7kcFsM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=EmTgCLO2wSkDlsTcGb7KzGMNJBIjQJA7HdTi8wQZlcl2x2ZlyWZHqh2nTRE+9nHa
	 duLFAjlPMpSnAz5eT5XKuHKOKB2oyXADJ2cQxPSGvDCSkkb74fGOyE7MOVADf/Jmm
	 r3K3sb6MBkW6lfA5xlP8cTRXYHR7KbD3At/wmM9/6X3zXHFthYAcPDlBOP6xd1vKd
	 oQlCeEw+tztsFCHcFavp1AMJa4wh+SjGRNPByzdcl+5Tfblf6QmQ0neEa9h+8lVR1
	 S/JqGwY0YANiJ5b3UrrDpFHEywR3/nW5erG6dDdQfnkyi7oMkufdfuDV/JnYTn/60
	 HQFG15unTEhPPlyy1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N17UQ-1qvnXl2og6-012XiL; Mon, 19 Feb 2024 12:59:31 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] platform/x86: wmi: Update documentation regarding _WED
Date: Mon, 19 Feb 2024 12:59:18 +0100
Message-Id: <20240219115919.16526-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219115919.16526-1-W_Armin@gmx.de>
References: <20240219115919.16526-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HVa15Z2LrHiydE7egWuwmvdECI1Tv1ZQ4wpN3HEd4/nYZH066wW
 6rSrrp1W7tjcnHIFkdtKe1fK1O2U0hrxiukCjwvvFX5RsyR742wCAH81sE/atj1I+FtCWG8
 5pCq3lvrnfiGk1QzXXaPl8b0MaZqe+uhXBz4R6AugdZixXijUl1v37OCbLAfFGUnIrvvEyJ
 Ier5ZaABptv+RqAwnD0MA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hkUeSe5q1/k=;jg/Rfqe6pDRd5XWkin84hm86CfJ
 /EHlUVVNaQOTFfJTVPcgDK9MYH7yLhR5n/H3Ho6et9/euvbQNBq0op72oMmyxmcNnzyWJ9afE
 EcP8mUtazAH3WAtCT75dpP47HHHtb31VKQY/2qfeflVIYYXIZ8CiL1wp2Uxyz1E/uCIH8YqhT
 fK0L/vm2Nzxm7Qben1bwMMBeuFrMQcf09eQ1c6IwpOxY9PGjk58kd2mMGx0JZS5nYhtFnnEIX
 hfGNLAZQkc5nsI6qXKIEoyG79DmAcg0ZPsFeQw0yg1l/Og/iKcAFGRHePQjpuqZBrE+0XWIYE
 i5MueCxE5mkB6VXZG1lFxPOClRZc0dmcn0k84TQPe2NMvcdi8/72jKjjHejsVoB2RtVlqO13N
 gxF6jCpKQ07h9zsqwQtpjyR34eDE+J2dAkfiJFT/cgc9LCJbIJ5RbjpPSIn+yYgGeFy3eo2J1
 mpDdwgleJ+UMYcZ3bpiYqmmQdEANFn+SIoP8gEm+bWgBa2GAKlj13sALw2wsgiMDUpE3ajI+o
 iqw+kqxqV8P0Jm3+1NW+tzm0ru1Gmnf//Kk65z1n4pOMSOOwIYB65DGr5mDbk0KZqSq3uGx/e
 Sy7vOSJIHm1MNF+UFNsMUAnnNP1ORM4zLozedPKJ9yf9ZVnNKSQeSEvRHXvrLyzOR9BpdPtm3
 X/eGU1aXTEqZlRmzi47nEJIE1OJv7npeY3tnM2uYXl7uRExbZF0uPkqzW5bsGgm7SpHDHNPgl
 Tg5sES+L3JJo/KhfEX38MkQYxIXSNTR6weuvsLOHgst9DeP5z4RjNn/Q8DnHB9EPUxMG9OQrd
 heqt/6eMzvqpuNriGw8jgIF0RbZrGELSeG1atJspnRDac=

Update the WMI ACPI interface documentation to include the fact
that _WED should be evaluated every time an ACPI notification
is received.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/wmi/acpi-interface.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/wmi/acpi-interface.rst b/Documentation/wmi/acpi=
-interface.rst
index d31af0ed9c08..06fb7fcf4413 100644
=2D-- a/Documentation/wmi/acpi-interface.rst
+++ b/Documentation/wmi/acpi-interface.rst
@@ -93,4 +93,7 @@ _WED ACPI method
 ----------------

 Used to retrieve additional WMI event data, its single parameter is a int=
eger
-holding the notification ID of the event.
+holding the notification ID of the event. This method should be evaluated=
 every
+time an ACPI notification is received, since some ACPI implementations us=
e a
+queue to store WMI event data items. This queue will overflow after a cou=
ple
+of WMI events are received without retrieving the associated WMI event da=
ta.
=2D-
2.39.2


