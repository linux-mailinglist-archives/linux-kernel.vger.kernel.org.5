Return-Path: <linux-kernel+bounces-98348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8A78778B5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1A01C20F68
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FB93B78D;
	Sun, 10 Mar 2024 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="gVcAZjE5"
Received: from smtp2.math.uni-bielefeld.de (smtp2.math.uni-bielefeld.de [129.70.45.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91C38394;
	Sun, 10 Mar 2024 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710108821; cv=none; b=MgPupHUmzE2jYN2h5I3+72ve1jHD+1+KPDJ4qrv4ZnKOMCk4uPbp2rI6nXZ47GGTyLztlN384iTdAK05T7BMoGG1KzLFPIYfmZZhrfoBi2mGqRPnyCrFIVxowq5UML43Y1bAZM2Alx2L93YLmWxE6TGh+HInA6VTgqNS+FdTH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710108821; c=relaxed/simple;
	bh=Xp6HN1t5P9W1dHKGWQfqKqsgWh0lrw2Qc0o8/g7BVbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrBniG+us5ppYIVCV//2Vxkw9Vw3ORI0iEFLn/dOtRgBMZEYQn69ybWziHrbfIdclKX/nk6fAhPrfZKIEp3rTU33ZT2wVxaMYWzBsL4JTng1WUp5bcQbparUrwO9VZtZ7WsabU7uUe2Bh66Zx9UybFHUkbTshpizmWi1vhG8shA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=gVcAZjE5; arc=none smtp.client-ip=129.70.45.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
Received: from localhost (dslb-094-217-220-071.094.217.pools.vodafone-ip.de [94.217.220.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp2.math.uni-bielefeld.de (Postfix) with ESMTPSA id 6C30A60063;
	Sun, 10 Mar 2024 23:07:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1710108432;
	bh=Xp6HN1t5P9W1dHKGWQfqKqsgWh0lrw2Qc0o8/g7BVbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=gVcAZjE5IlCILMtST6tKtnw3IhFgUhO1k+6TkOiE8TAnpe4qL1gBMdkO+hJHI+GMc
	 weGITu4R4JnGLa48XjtGigxd3Ua1WlPo4+CaJQDIsvjvbeFk7o69nHuSI54yK/ss9J
	 AV4SZM9ruqjYJJiiFFhgjvTpjTcMQ7aO+aA1o4lLPlctCwNJL3txJY8H/VULAiCC5H
	 6/1zSH7Q0cDXFgwfMTjkNqtwu3kcZQjZdKzbrFgXCcbVsdeEYVZT1t4cBJCelXUeEf
	 3atijaNzEE0c3YaQoHgQhic5bGGwh3tmf6kxnPiKNfqK3fA6G0lXz7TSdWHSYVtMVV
	 tjRD2i82DUhng==
From: tjakobi@math.uni-bielefeld.de
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (dell-smm) Add Dell G5 5505 to DMI table
Date: Sun, 10 Mar 2024 23:07:09 +0100
Message-ID: <20240310220710.896230-1-tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Enables reading the speed of the CPU and GPU fan on the G5.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 44aaf9b9191d..02405a1dd0a0 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1096,6 +1096,13 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G5 5590"),
 		},
 	},
+	{
+		.ident = "Dell G5 5505",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G5 5505"),
+		},
+	},
 	{
 		.ident = "Dell Inspiron",
 		.matches = {
-- 
2.43.0


