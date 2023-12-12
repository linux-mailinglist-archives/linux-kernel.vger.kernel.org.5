Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D30D80FA54
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377762AbjLLWQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjLLWQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:16:55 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA723BD;
        Tue, 12 Dec 2023 14:17:01 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3333074512bso3898435f8f.1;
        Tue, 12 Dec 2023 14:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702419420; x=1703024220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZ89YvrOqku4UfXm1LiD3M7ba2ZGC3MrhjCGhcqvrpM=;
        b=PMo1bj+EzKDopEu7dedF3dK2z5Q+EZmfciPbRhOkg/3cOD7LRvuLiBBsIakJLDebvC
         Vq8hCeeyh3SyLsZSZmrgPI8nanXLvyD8VRmBFBn8X+z107pE2kOxaWgMdsumP4yDiok9
         XjyKUUrgddbB1Pixfd3BB7D0BMoQSF6yNNzMTzl+JeTET9ZjiSKXOosz8BZ6RW6LgOGA
         YovI9967CUsYfQOuK6zlFwrX3UQRgdteMG7YWMgrcvdWyZFZI5sKQb8bGho1ZVShmDwg
         dvkeQPR0vMf76ErYOjYYQB1+W4Uc1DNp+B2pkVvocH3sPxrXoY0mbNdhRcw293AQDDHA
         yjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419420; x=1703024220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZ89YvrOqku4UfXm1LiD3M7ba2ZGC3MrhjCGhcqvrpM=;
        b=hqVuiGLJcRFJpt15iThBq2zLyXPXCi5QYuKCFZo4xER0Z+CZRBwmyAMDIrmMk1oUNV
         G+72XgAQJb9wqyjD/kh49Ig+aa/M2ppe4iA/jyuQu7dh+WVNHo2Fe8RyjDQfnSoCWt+V
         kaQEkj6rCX2oWhdZs5VWHUSai+fbU+4TUEeTnDDQvsvUUhVaazAC0n/eyAk8l+DMsFZh
         6bJjRm3RkuaWa/3wNRAF5gDy0Pmy2wMtX5W/Uk7qwTcPNywQRnL2CikJdTDOQctc/OV0
         h/ED9/C8iP7nIODDqP7zrtYXHB+OFF4u86iBJKiVIfKsWLKxPyhjdvgmVz6iEfcD48WJ
         MY+A==
X-Gm-Message-State: AOJu0Ywr08JGXVf0EqXbqsKwvC+jFauEaSDPJLe6V+BvlVULvkhEzh87
        OYk3uprAjNjdBNibN7lSZz8s7EIZkkA=
X-Google-Smtp-Source: AGHT+IFeWW81nf2WWg8qv9w9rgm6Uvxq2pHl5HscOB/An/EEw3ukFuK0YWWXXYQ795X3sy+lnOpN1Q==
X-Received: by 2002:a05:600c:3acd:b0:40c:451b:45e0 with SMTP id d13-20020a05600c3acd00b0040c451b45e0mr2270512wms.120.1702419419910;
        Tue, 12 Dec 2023 14:16:59 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m11-20020a056000008b00b0033332524235sm11669113wrx.82.2023.12.12.14.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:16:59 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tools/thermal: tmon: add support for cold and critical cold trip point
Date:   Tue, 12 Dec 2023 23:13:01 +0100
Message-Id: <20231212221301.12581-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212221301.12581-1-ansuelsmth@gmail.com>
References: <20231212221301.12581-1-ansuelsmth@gmail.com>
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

Add support for cold and critical cold trip point.

Add new char to represent these new values.
Saddly trip point name initial char can't be used as it does conflicts
with the Critical trip name conflicts with them, still a more or less
symbolic char is used to represent these new trip points.

Use:
- N as Negative for Cold trip point
- Z as Zero for Critical Cold trip point

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 tools/thermal/tmon/tmon.h | 2 ++
 tools/thermal/tmon/tui.c  | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/tmon.h b/tools/thermal/tmon/tmon.h
index 44d16d778f04..26d1c829af7d 100644
--- a/tools/thermal/tmon/tmon.h
+++ b/tools/thermal/tmon/tmon.h
@@ -58,6 +58,8 @@ struct cdev_info {
 enum trip_type {
 	THERMAL_TRIP_CRITICAL,
 	THERMAL_TRIP_HOT,
+	THERMAL_TRIP_COLD,
+	THERMAL_TRIP_CRITICAL_COLD,
 	THERMAL_TRIP_PASSIVE,
 	THERMAL_TRIP_ACTIVE,
 	NR_THERMAL_TRIP_TYPE,
diff --git a/tools/thermal/tmon/tui.c b/tools/thermal/tmon/tui.c
index 031b258667d8..6b58ffa4df6c 100644
--- a/tools/thermal/tmon/tui.c
+++ b/tools/thermal/tmon/tui.c
@@ -307,7 +307,7 @@ void show_dialogue(void)
 	wattroff(w, A_BOLD);
 	/* print legend at the bottom line */
 	mvwprintw(w, rows - 2, 1,
-		"Legend: A=Active, P=Passive, C=Critical");
+		"Legend: A=Active, P=Passive, C=Critical, N=Cold, Z=Critical Cold");
 
 	wrefresh(dialogue_window);
 }
@@ -535,6 +535,8 @@ static char trip_type_to_char(int type)
 	switch (type) {
 	case THERMAL_TRIP_CRITICAL: return 'C';
 	case THERMAL_TRIP_HOT: return 'H';
+	case THERMAL_TRIP_COLD: return 'N';
+	case THERMAL_TRIP_CRITICAL_COLD: return 'Z';
 	case THERMAL_TRIP_PASSIVE: return 'P';
 	case THERMAL_TRIP_ACTIVE: return 'A';
 	default:
-- 
2.40.1

