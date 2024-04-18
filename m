Return-Path: <linux-kernel+bounces-150683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 325E98AA2FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5FD9B23E63
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7541802C6;
	Thu, 18 Apr 2024 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiiMh9ql"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8F17736;
	Thu, 18 Apr 2024 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469262; cv=none; b=SNdu4SZO4NnDDmhEirfE3T04qJFdKhrOlOnVrrL5Tuz9WwTHIDIXLJInRCCGYuVeH51LgF2dgtdFuZrD6raGv/X2FbTXkecZc0/IRshgk7SkjPKPNrz2NOQTf4wX9pXc1u5OjusAlZ5tz+ZNjAK2gcoU8nPcCpaPsKNJbdDdeqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469262; c=relaxed/simple;
	bh=aS23Egj41v2BDHrq+NW1x/Np7rHcaTENUK5x/g1qZeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1sSwGSU64QRP20c5/PN9Lnrf0FHaXA1cpnw8YvVMLqfgTSEj0B3bFxxS6oQL732LLkGM79B1ouXvYeiS0lasNk6HMC5s96MkujNEfhfXNZ4bo0mJfN72WZU5DXyUcmJWkgxCJzq+Xeqrtzvdj2mopSKRftGB+ylgROesBdE9dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiiMh9ql; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3455ff1339dso842072f8f.0;
        Thu, 18 Apr 2024 12:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713469259; x=1714074059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tVCQ37O1W//FfApwwrAn8TFEc25ulIjoj7L8vQOR71k=;
        b=DiiMh9qlMJQnQQIK3uHvfy9/ApgH5pJAnPKhPbWDuqUqT7RDvhWpeexiPNE+GD64Zf
         HZkhTU+CwNZnfM2Lipe8qQWglqpwOz1EO6VsJza4VVfQzXPTO9jwrAU30Gh+Gga94LBE
         I1rWS+/xkB3lz3gmoAwkAUmjJEFEfd38DpZfGm6aJpdefAJ1FhV0Goo0glUsrchor3Te
         /J4Y6sScxIlTmpTs2P65QL0SLpWaV+rQh6bqHKdx3bnHSxW1Q0G/n9r8+oF7J5fOsrcz
         m7zJdeo+3nilTRForewP6Oim/DMeFryW9TuJAz2vx+8YBKR+yZ9VImCvWawNYABVagxx
         fgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469259; x=1714074059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVCQ37O1W//FfApwwrAn8TFEc25ulIjoj7L8vQOR71k=;
        b=oJcc8p4izaZvpz1BHs5UmObn/TbqX5s8s/lcGH3W9gRLPBHLOawGW+HWhTiHnNRzUb
         5u/mOzvd+VaY4J9BMAoZI1Y5SumCAW4LPmLzOUuyNIXqpHSu8BYJWgmpkAPRIbg8/Kfd
         8zb6rfH/pcGDEGEczSLrzx7QwOxJnVT2GFQej3vqtbx3CZqwzMXWeRFNVpxtV018Lkcs
         aZCYoNe15qo44rMa3q2ZsDtXT5v9R8KKKLuDruuM8N1ha7fkg8JeOg4qCXA1JcEjzS9P
         Ld8nDEgNaOonX/DTaUxo8B9hJKH66YRoz/tph3sOy20//XXb5pTFGijkmJNL4+MHJxV/
         sbDg==
X-Forwarded-Encrypted: i=1; AJvYcCWIEWKHFqxGgRer9LilSGV1P9tHhTZqFAMyCYGsvZc6KutZ2thG+2EcnHr2lBvcqBBS1qzWlJVfImhYpjIyQ91dPALL/KgzwJ/AIs3N
X-Gm-Message-State: AOJu0Yx73813nIT1ZqafNL+bMccEi7FyRzg3IqlxhXZYm2bG3SL0A0mm
	HckofdoQ9c21EH90agkhCaZ66gT4SNJZfGL3tm/QqY2Xcud0JrsT
X-Google-Smtp-Source: AGHT+IEWWYERxq3bNUvPaNn9FKZLX7UcbAd7HglXGZn2SE8bgy21wfhO9k5MlIw4fQHf5pdR18+aEg==
X-Received: by 2002:a5d:6d85:0:b0:343:eb28:58e9 with SMTP id l5-20020a5d6d85000000b00343eb2858e9mr3409827wrs.28.1713469259219;
        Thu, 18 Apr 2024 12:40:59 -0700 (PDT)
Received: from debian.fritz.box ([2a02:810d:6d3f:e873:3f2f:a87f:452e:78c0])
        by smtp.gmail.com with ESMTPSA id jx12-20020a05600c578c00b0041674bf7d4csm7405811wmb.48.2024.04.18.12.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 12:40:58 -0700 (PDT)
From: Stefan Berzl <stefanberzl@gmail.com>
To: jikos@kernel.org,
	spbnick@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: uclogic: Remove useless loop
Date: Thu, 18 Apr 2024 21:40:51 +0200
Message-ID: <20240418194051.15852-1-stefanberzl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The while in question does nothing except provide the possibility
to have an infinite loop in case the subreport id is actually the same
as the pen id.

Signed-off-by: Stefan Berzl <stefanberzl@gmail.com>
---
 drivers/hid/hid-uclogic-core.c | 55 ++++++++++++++++------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index ad74cbc9a0aa..8219d3dc9de4 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -431,40 +431,35 @@ static int uclogic_raw_event(struct hid_device *hdev,
 	if (uclogic_exec_event_hook(params, data, size))
 		return 0;
 
-	while (true) {
-		/* Tweak pen reports, if necessary */
-		if ((report_id == params->pen.id) && (size >= 2)) {
-			subreport_list_end =
-				params->pen.subreport_list +
-				ARRAY_SIZE(params->pen.subreport_list);
-			/* Try to match a subreport */
-			for (subreport = params->pen.subreport_list;
-			     subreport < subreport_list_end; subreport++) {
-				if (subreport->value != 0 &&
-				    subreport->value == data[1]) {
-					break;
-				}
-			}
-			/* If a subreport matched */
-			if (subreport < subreport_list_end) {
-				/* Change to subreport ID, and restart */
-				report_id = data[0] = subreport->id;
-				continue;
-			} else {
-				return uclogic_raw_event_pen(drvdata, data, size);
+	/* Tweak pen reports, if necessary */
+	if ((report_id == params->pen.id) && (size >= 2)) {
+		subreport_list_end =
+			params->pen.subreport_list +
+			ARRAY_SIZE(params->pen.subreport_list);
+		/* Try to match a subreport */
+		for (subreport = params->pen.subreport_list;
+		     subreport < subreport_list_end; subreport++) {
+			if (subreport->value != 0 &&
+			    subreport->value == data[1]) {
+				break;
 			}
 		}
-
-		/* Tweak frame control reports, if necessary */
-		for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
-			if (report_id == params->frame_list[i].id) {
-				return uclogic_raw_event_frame(
-					drvdata, &params->frame_list[i],
-					data, size);
-			}
+		/* If a subreport matched */
+		if (subreport < subreport_list_end) {
+			/* Change to the (non-pen) subreport ID and continue */
+			report_id = data[0] = subreport->id;
+		} else {
+			return uclogic_raw_event_pen(drvdata, data, size);
 		}
+	}
 
-		break;
+	/* Tweak frame control reports, if necessary */
+	for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
+		if (report_id == params->frame_list[i].id) {
+			return uclogic_raw_event_frame(
+				drvdata, &params->frame_list[i],
+				data, size);
+		}
 	}
 
 	return 0;
-- 
2.43.0


