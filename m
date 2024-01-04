Return-Path: <linux-kernel+bounces-16285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB12823C41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F05EB24CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAF81EB3E;
	Thu,  4 Jan 2024 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWFwVg+s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633131EB23
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe7595c204so1456816276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 22:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704349625; x=1704954425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZKVNWMZBR2eYWT59dTj/uyfqypo9Ohb4eJLIAFi1GR8=;
        b=QWFwVg+sB5ihJPFehHpyJDiHGQj2B626tzG3TCOiyGUIuJ3AZvHnwCtIXK43cs4PL/
         RiLEvh5DR1sa6SZH4osFQ/PJda6+9GNSs/8j2SE2RY8KrIOGUshqoutmOLctsh+N8bY/
         4/NjOEGC0uJAFXG/l3Z45O8xJETHfXxcoSGTq6MSsY4XSnKt69tZf2M1xsx0rhA0kslD
         vDMZ+iNapvmWiqsbim0dYlPPp1ITzxZ7pu+5vJac69xaeuzhZPfH6M5l/fcwtKXKBR8a
         A8dAQXnNnhRzfD6dbFDVKq67FOf6bCKTHgpANj9HLPsmmw/RtNWKXOoSSvdKfYZld+lu
         IjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704349625; x=1704954425;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKVNWMZBR2eYWT59dTj/uyfqypo9Ohb4eJLIAFi1GR8=;
        b=Q9zJ4G+5Rbkd8dXfBHGPfoc3laNqfr/AXBEr69m/tO88sQvPlTEq08AVpc3MJqqsog
         wfN9zHIaGTOUxqKMzegkhfuraegPniucpZMQPNQ1HL8y0XcnAzl5rxvccUbTCVop1y+G
         UDY62gqaTer1A2DFaWKDvWJk0r4kQEyhzxUZGmxxREn5ohvl8ey16lKV9n5eoSps1Opf
         mvMro5hNDb8k8S+RF9cjN1YJvIOecxAmuIVku6s219XQyuio2eXJH5JRe3DGsaq4DcId
         jvHYamNMhsKxy2s/J7e4qr1iLao073WYtg75ib9oEXwC8ge34MR7eo8XQoSaau50yh1/
         c6ug==
X-Gm-Message-State: AOJu0YyZvnVF1AtcSbv7QdZuLmht542OMHMao7QhYElmuOuH+o8rrIcK
	sjurFz9HgHz0cWSkUqH3uoduPmjeZfTR9LOxpW9RqibshJA=
X-Google-Smtp-Source: AGHT+IEiM8eZ/BmTuqN5gV+shHxc8NSMHg5N7+oDE9GyzA6PITekyfPwSpOrPDWoSOY3bkHBaZqtVgS6CBetbrnl1oSY
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a25:6809:0:b0:dbd:c33f:4642 with
 SMTP id d9-20020a256809000000b00dbdc33f4642mr12255ybc.3.1704349625304; Wed,
 03 Jan 2024 22:27:05 -0800 (PST)
Date: Thu,  4 Jan 2024 11:56:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240104062659.1160670-1-vamshigajjela@google.com>
Subject: [PATCH] spmi: hisi-spmi-controller: Fix kernel panic on rmmod
From: Vamshi Gajjela <vamshigajjela@google.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, manugautam@google.com, 
	Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure consistency in spmi_controller pointers between
spmi_controller_remove/put and driver spmi_del_controller functions.
The former requires a pointer to struct spmi_controller, while the
latter passes a pointer of struct spmi_controller_dev, leading to a
"Null pointer exception".

'nr' member of struct spmi_controller, which serves as an identifier
for the controller/bus. This value is assigned a dynamic ID in
spmi_controller_alloc, and overriding it from the driver results in an
ida_free error "ida_free called for id=xx which is not allocated".

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
---
 drivers/spmi/hisi-spmi-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
index 9cbd473487cb..af51ffe24072 100644
--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -303,7 +303,6 @@ static int spmi_controller_probe(struct platform_device *pdev)
 
 	spin_lock_init(&spmi_controller->lock);
 
-	ctrl->nr = spmi_controller->channel;
 	ctrl->dev.parent = pdev->dev.parent;
 	ctrl->dev.of_node = of_node_get(pdev->dev.of_node);
 
@@ -326,7 +325,8 @@ static int spmi_controller_probe(struct platform_device *pdev)
 
 static void spmi_del_controller(struct platform_device *pdev)
 {
-	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
+	struct spmi_controller_dev *spmi_controller = platform_get_drvdata(pdev);
+	struct spmi_controller *ctrl = spmi_controller->controller;
 
 	spmi_controller_remove(ctrl);
 	spmi_controller_put(ctrl);
-- 
2.43.0.472.g3155946c3a-goog


