Return-Path: <linux-kernel+bounces-51764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E843E848F0C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783171F22249
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3112822612;
	Sun,  4 Feb 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="h11aAxJR"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503D225DC
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062188; cv=none; b=EOjwFN1NOy/Ps3Okh3QmZ/oI3Y0JiR1FCAzQY6Mb04/CK/NE7ncW0RTvRhWxwLemQkEQDpA7038S2/SiqA+LaYgwKkcheVBIKaAM6QWCML71btwhDTC3Y31faDzXtR4QWabolk27lbafu3ipwGuhmUShth0+U43r4EPwgm5/8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062188; c=relaxed/simple;
	bh=7FYnnNqTc0H5T6M7a9N0Nki5bcUxmzHuVUFte9heJ/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tPP4lcs3p9Bd+NMagdNV5IFF+oJQqpuxNrNzHgbZ/fFTgtRbx56n8AjVmpFxCxDXXy4nlTPvDoX4ZAp/IVwAdi/A4tf5pgfIE4J4yAVLeKoMLPHjXoDwMXRq1FZuY/6Nddbqbwy7AaHoaHRIgaBO90UR0l5A41wTSYzwtXeETr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=h11aAxJR reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso3268232a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 07:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707062185; x=1707666985;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KAFRuJjARefD8ORAWekwdxcIKqWzl1i5HJCIgFDPMM=;
        b=VN2k8UXBmK5xgYUtJkxxvkBTzo9OJ/uptae0+yOZlnLgmrTpPXzCKoih84XqIvKvfq
         dLFd6s2jMDqTxQK1kSjoNfquQt4LSRG920PS2Iu1EA/URZ6wsNBNvJ5PxpUxZO1OB4S0
         WuPMiKJ/BDEN1wbSUYeP4gMJXs6LCtz9UGj2v8GlqoQfCENqWL6mwEp9I+1XDAhyPyUP
         dDKHjhFRAdBvUmS3kt+BpbNCwLuzCwt7F6+TZvSnzfv8YW9f/1ZVz/V9CO7Z3SgaYpb1
         bdfG1VFerzrtqLrZKVGiyzHB20rUOsYwt849qpA4CAJPlzyhUy7YLqbRFZd4hJD0GGOg
         6/ZA==
X-Gm-Message-State: AOJu0YwuM/eO+3lSpCOXSAUxNcGKtQwx1NOLYHgg6+0F0dNmLYSoBcbd
	33KupJD1uP62fmMsYprs9QwTluD40E7pNCoj9gLQawiE0FwCjjDr
X-Google-Smtp-Source: AGHT+IHAbT63OH5TuHb985B1Th0KfRZAXTVOpEZ9uWRXKKd6ssXFlc3EnDihepHznE9F9inu57D9bw==
X-Received: by 2002:a05:6a00:be1:b0:6e0:3408:9ee with SMTP id x33-20020a056a000be100b006e0340809eemr1559221pfu.29.1707062185363;
        Sun, 04 Feb 2024 07:56:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXiC9H2820vLVBaDFmqFhOCZF9yjI163G+Jz5lyCy7fgz07hK1x36ejr+C8O/SETmppv3FjJTmoRFoaGgHE7K6pSRgUmlDmbXPJGsGLi0iH+0IcmJiYMtKxCgCDcTRzdFtisSavRcvG4MvWGgjGk4GhQ8SAzQc8AOI82p9wLXHAWI/ZQGwNGndQ1N3JgfoKRa3is4BrX8E9RPSnJ0iOfV/5bCe2nixKeHpI2/DFt3bJJmjm3c0=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id 34-20020a630f62000000b005d8e30897e4sm5183255pgp.69.2024.02.04.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 07:56:24 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707062183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1KAFRuJjARefD8ORAWekwdxcIKqWzl1i5HJCIgFDPMM=;
	b=h11aAxJRBAGw5IIhq9r4RhYGRThs1ok2AZ7W9XLM9NSJcSHu4zvdZz/SI2FdnXkWccn0JL
	FRLqAnKd83z/OHrZGHEwAG9rtAaZPWpN/sBsrIoSSqvxvGS5si2JYwgfIfW5W4Xs0/e2nf
	1p8pSrGEMpry9g9t1ezBeMLGD7Ud0Smv2MYIq+/mIIzE8tVKl1RO8wJlKnQVtsDQ7rzIi6
	lTV1i5vINZjfjpT4Kyvwjn9N+BdwglCS8xzaWcyvFzsxVEpAKMeElavIrz4UFL4vq7QIEf
	F11ozJb+8DjFahthbPJ/AFeEepbQZ8GYmgmr/R10tXQ8jvkdGLPQs0aTWsw0lw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 12:56:44 -0300
Subject: [PATCH] bus: sunxi-rsb: make sunxi_rsb_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-bus-v1-1-bda309c4b829@marliere.net>
X-B4-Tracking: v=1; b=H4sIALuzv2UC/x2MQQqAIBAAvxJ7TrDFivpKRKRutRAWihGEf8+6z
 RxmHgjkmQL0xQOeLg58uCxVWYDZZreSYJsdUKKSKJXQMUxmp9nF82NhqZMaa9saaiBXp6eF7/8
 4jCm9djMpg2EAAAA=
To: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1445; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=7FYnnNqTc0H5T6M7a9N0Nki5bcUxmzHuVUFte9heJ/g=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv7PD/cro16iyRDAtGwb6gU1EUNlRLBdjX+kR9
 cDRFXyIFViJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+zwwAKCRDJC4p8Y4ZY
 prOiEACYCcDYtS1q/kpdhK9KoGBYD1FigTQui2eoTVOCZiMr0vjDk12Y5v/J2uq0XdmPtWnYxuY
 cM4JKLK3TrSTnUPRM81KqiGHOb5LDuCGY4/JANKeXBWXs8kMr5yV+2r6aCEtUTG3n7zvkySfqaj
 7P7NBvZ7f34LDFroyLS4UX/r94N6h8pvaT433xpJ/rUHFNtoyWo2pXjP/Cbhai+qk95FR2qFPM2
 UtAkD3x24ir8F6m0Ci4NNwB2V0zxzuX8QM2Hham3eQGTWBY9tMJhDeZE7ECRutSboJoSGwEij1p
 1SbcP3v0ean1749aMXTWF+CH510T2HmVii1rnmqzos/PQOHE/PJNjN5rKY/4c2d7t8qAvbeGvRK
 18v4kfdCGSi85B51cvNtlZXnveFPMATxsH01mDnZjO7l6KpTWnmKsxYqEWMLlc8w/6pEyuYra0S
 P5oR7AOyNygJPEIWGVjs1vClmnnwox6kqW9izerDlzVpDZKrRfkntyayssimpVI6YRsbkspMC3Q
 0k7efWA8QgT8hfD6q6M3rgf+EfJbo8OhGVZTdelKFjUb8SHgBFBvPc0qldPgW/LrOLVfOEea4di
 qeUzSMj5K6cFS0pffQraoDKqJrv3Nwy9vsDf3EEzF8ynWYy4FH0/mq9bWH1GX0BjcCGp5xVtzYe
 HDxESQOWdQ14j2w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the sunxi_rsb_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/bus/sunxi-rsb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index fd3e9d82340a..1e29ba76615d 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -128,7 +128,7 @@ struct sunxi_rsb {
 };
 
 /* bus / slave device related functions */
-static struct bus_type sunxi_rsb_bus;
+static const struct bus_type sunxi_rsb_bus;
 
 static int sunxi_rsb_device_match(struct device *dev, struct device_driver *drv)
 {
@@ -177,7 +177,7 @@ static int sunxi_rsb_device_modalias(const struct device *dev, struct kobj_ueven
 	return of_device_uevent_modalias(dev, env);
 }
 
-static struct bus_type sunxi_rsb_bus = {
+static const struct bus_type sunxi_rsb_bus = {
 	.name		= RSB_CTRL_NAME,
 	.match		= sunxi_rsb_device_match,
 	.probe		= sunxi_rsb_device_probe,

---
base-commit: 38ed19495066966979ba821b9e0f549ad5ea620d
change-id: 20240204-bus_cleanup-bus-de90b25d7ce6

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


