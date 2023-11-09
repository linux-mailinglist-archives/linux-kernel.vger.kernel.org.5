Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655867E71C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345082AbjKISzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345074AbjKISzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:55:09 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBDB3C12
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:55:07 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc28719cb0so2562695ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 10:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699556107; x=1700160907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRi+qAy0bRoafy49vwIjB8vcVV09afunArSCgU/jH/8=;
        b=LA+sVoGnwa9W3vsSL4f+Kwf+yFOv9WG90xZDpAOD1jJquoMgHTTTpbzDBgJGP3BEMg
         oEybdvKTzQHeRTcrfwRvZcwnZjLkEJ53xfoAohGtC9wauweiEwVJAHTnQ8V75F9K4ngS
         dUbOOrET5eeOFhBlulk+bJRPAzsoICFASsfJ1PW3jltcD0d1hN8AXm7rvfLiRH97i+rf
         LQtHAZ2PA+WGISy8Xw4VWhC4BsRViw2ymqf9aljYI0/qriyJhwJksSQrNTvbnnHnhkZE
         H2904BWtrWdfos0ap1JpKjKU8v6nPxXqp6KtjxdUiY3QvOU63cFyfnSTjDxn4EF8ZT1n
         rdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699556107; x=1700160907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRi+qAy0bRoafy49vwIjB8vcVV09afunArSCgU/jH/8=;
        b=IQbIidPhytEE91oExz4/rBWTkXzKbDOzkWinqiVoD7XMNrG3n2MPk12CDpAXoKAiqk
         NBi83jn8Y3MqaOl2Uhxi7niZCRTJ8spsuRzZhNV+f4X3NkGiFH+RBYNXml4AHU9KxrDp
         Jnq55n1bqNJbqACeR1rJgnAeLERZaNh98YwkMfgpPeSQvoNLn4GsQjn80UdQt9Er09qq
         xSc8nBCjkK5IybNXPbxI4Nheh26WCIkExVPvdKNODJMZX7oQNGCiNpG/33jvORp4/8DI
         GnZRKNSfV0VZRh4vft4kd18R/eHcblbE7xH9lXLDaOnYYtBEEx0DAupQ5iIkrz0T4R1y
         cvPQ==
X-Gm-Message-State: AOJu0YzdfcVhSxS1FJFx6G992yp+qi+zfcYeHLR/1qKMJHquHI1yHNLc
        8JdxMB4WOp39K45cayEy1W0=
X-Google-Smtp-Source: AGHT+IEjlXJkC2bw7tWXPOMaDfWHKiPmPN5r1CPOZIEmM6XpA/df2WMR8wr6JLELmvE8T9Bj+So2cQ==
X-Received: by 2002:a17:902:c943:b0:1c7:5581:f9c with SMTP id i3-20020a170902c94300b001c755810f9cmr6369730pla.0.1699556106845;
        Thu, 09 Nov 2023 10:55:06 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902d71300b001c61921d4d2sm3821837ply.302.2023.11.09.10.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:55:06 -0800 (PST)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     bleung@chromium.org, tzungbi@kernel.org
Cc:     groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 4/7] platform/chrome: Fix typo 'lantency' in comment
Date:   Fri, 10 Nov 2023 02:54:36 +0800
Message-Id: <20231109185439.1535962-5-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231109185439.1535962-1-visitorckw@gmail.com>
References: <20231109185439.1535962-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'lantency' with 'latency' in the comment.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 85764e62cbe4..92faf701b8f0 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -176,7 +176,7 @@ static s64 cros_ec_sensor_ring_median(s64 *array, size_t length)
  * While a and b are recorded at accurate times (due to the EC real time
  * nature); c is pretty untrustworthy, even though it's recorded the
  * first thing in ec_irq_handler(). There is a very good change we'll get
- * added lantency due to:
+ * added latency due to:
  *   other irqs
  *   ddrfreq
  *   cpuidle
-- 
2.25.1

