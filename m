Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F337626F0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjGYWi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjGYWhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:37:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B1D5259;
        Tue, 25 Jul 2023 15:30:17 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso3575436b3a.3;
        Tue, 25 Jul 2023 15:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690324137; x=1690928937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zVQovqgIjSqRTIt+DkdpoM6DyIIcDIA/J+K4Pjg9mHw=;
        b=lOnSIyATWC3N5DkAU9sAKOAtb+XfM4LyUKyCprRmujjHG9wmXSqx0A7k329g88GMsg
         Jc/J8rDihf4haYHl1xe0QL4CdM7QgdCEsoi0JUHRBxgxDOb770zjsy8/4IElDpaIwlZF
         EebVeQdm0/+tVBn6i6cMm6HuORR277kflpTz1eFuz2gvP+ioEj4CGrGd8W6Pl2mFFsyx
         2u5/a6hZx2GZ2fSzzX0GgtyP8ui2VXZAcIw+qWyV6t6Lzk8BRR8FsEdxlSAB6HmB2i1F
         yoRKtQ1mkumK6rvmaP+TbP9wT6rjJjNakr8pbmtYlRkxrMyucjbdOesVKl3yel8mM/sI
         h5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690324137; x=1690928937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVQovqgIjSqRTIt+DkdpoM6DyIIcDIA/J+K4Pjg9mHw=;
        b=DkmM6CHXTYhYmxs581i/e+Fhu8goCMj6Pgl99tQV9+B4Ke5T87vIea1Wv/KrFZwjTt
         ZwXzoz4v2huV58rclzFrO2xamzyCCJKjW1tLStk+w8/SMPql1VBYra/dsL9Zc+bEurAJ
         YHm/R4Nwsc5KnmN9Zi2+F5niPWLx9HuC6B3RLsUnAuwLhHDFX+xNU7YGFBsDPHjAsJAY
         i4p0RLssy5w3SDMey1sDRtIIPQ0VXAIxufu+l73IErDOdwoEe3yLcVEBenB9ua02x81B
         DveClue5M9UEmkoWWbLBGJZ+vcn4UkBrVV+UR7v+vsNfAYvUGJ4CjqzQKqtUllNjUpON
         LPdQ==
X-Gm-Message-State: ABy/qLYWdr/Y5yjZa54NDdWiMIrwk8PLpkXq1RaGKJl9Fg75ridFtLKH
        axMfJ9m+c35yyY3oRAvYdk3v07CjZJsBlQ==
X-Google-Smtp-Source: APBJJlH7PxV/ysCWK+hECO2DUlRQqagQe6lTLATCOxltuIerbOy5nVg0V8BsKj7ig3kT9/zvdLTuTQ==
X-Received: by 2002:a05:6870:4411:b0:1b3:9e41:de07 with SMTP id u17-20020a056870441100b001b39e41de07mr518746oah.36.1690323663698;
        Tue, 25 Jul 2023 15:21:03 -0700 (PDT)
Received: from localhost.localdomain ([97.115.139.81])
        by smtp.gmail.com with ESMTPSA id zh27-20020a0568716b9b00b001b02fa3097dsm5851622oab.42.2023.07.25.15.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:21:03 -0700 (PDT)
From:   Aaron Armstrong Skomra <skomra@gmail.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin.tissoires@redhat.com, jikos@kernel.org
Cc:     pinglinux@gmail.com, skomra@gmail.com, Joshua@Joshua-Dickens.com,
        jason.gerecke@wacom.com,
        Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Subject: [PATCH Wacom EKR Battery Fixes 2/3] HID: wacom: remove unnecessary 'connected' variable from EKR
Date:   Tue, 25 Jul 2023 15:20:57 -0700
Message-Id: <20230725222057.123863-1-skomra@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Armstrong Skomra <aaron.skomra@wacom.com>

The 'connected' variable was poorly named, and this has led to some
confusion. We can get the same information by checking if a serial number
exists in the specified EKR slot.

Signed-off-by: Aaron Skomra <skomra@gmail.com>
Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 2 +-
 drivers/hid/wacom_wac.c | 2 --
 drivers/hid/wacom_wac.h | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index eb833455abd5..16862f97c46c 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2684,7 +2684,7 @@ static void wacom_remote_work(struct work_struct *work)
 
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
 		serial = data.remote[i].serial;
-		if (data.remote[i].connected) {
+		if (serial) {
 
 			if (kt - remote->remotes[i].active_time > WACOM_REMOTE_BATTERY_TIMEOUT
 			    && remote->remotes[i].active_time != 0)
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 6c056f8844e7..c922c1c4c78f 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1209,10 +1209,8 @@ static void wacom_remote_status_irq(struct wacom_wac *wacom_wac, size_t len)
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
 		int j = i * 6;
 		int serial = (data[j+6] << 16) + (data[j+5] << 8) + data[j+4];
-		bool connected = data[j+2];
 
 		remote_data.remote[i].serial = serial;
-		remote_data.remote[i].connected = connected;
 	}
 
 	spin_lock_irqsave(&remote->remote_lock, flags);
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 2e7cc5e7a0cb..a10b19669947 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -331,7 +331,6 @@ struct hid_data {
 struct wacom_remote_data {
 	struct {
 		u32 serial;
-		bool connected;
 	} remote[WACOM_MAX_REMOTES];
 };
 
-- 
2.34.1

