Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D080766C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbjG1MJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjG1MJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:09:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF1010EC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:09:31 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe0c566788so3565845e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690546170; x=1691150970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IgYRXxxK/5wAQI8aY9jzNcf8VXgkU89vW14ATX1K3wQ=;
        b=Z8elz0L8CO6jiS0GIKrj0BJxeBSShxQk4TdI5eSj7rsYLqlbGRYniiUDZM9XG9LmTF
         /6nolx7fL38gIIjvdH5Qikze+TLZkEBs0TJesCnyKOpOVDx+vx1eVZFplSc9T9N15L4v
         qGSP9xQQhmJcOwTZvs6VM/gXkhG33T1SXmEhcjVRDa25ALuFi96KnT8/O2HN02lFf35D
         KvgeuPo1G77msVA0iJ1MXm36WDo0iKzUtuUrHAHzXDqtVEMJB+XSpUCfwPryHj/wyWml
         akRbGx2TkYeRzLV/4l9ZQwk9I5u5ZytBQ6Dmc9EcWE3NpQXn9gRMMg1ebhDQaeIk58lz
         G86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690546170; x=1691150970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgYRXxxK/5wAQI8aY9jzNcf8VXgkU89vW14ATX1K3wQ=;
        b=Wb+asBBeJ9gE/vaN3F8cfaL1ZYYoJW2m7AJX+NHyT/l5DVTqf1SnBmAPs51Jry3+gG
         IHy/CBDiGV3wJyOXEUcsm+3TVG9ODWFNiDguDfuSYROzGOQB67fjjzIeyvBmZJguFN9l
         bffcKyW7CnBdkmjUy+tcy/N5WLt/1giI6ekya64amUBdT+S72A1ZNWfaKK634+vVpPbw
         NMlAQmW6dtqBs6n6oiYzT9vx6wxGgHPFkNNl7xq2GVLJwkElZuHY+EDNckzDWGtedCkq
         hp+2B7PwaIIGNBL96OcPnze+jZwgtXKMGIK9YLmED659x6WUBnfnQfAVxwmwfE5J2ikG
         aHvA==
X-Gm-Message-State: ABy/qLaL8wt+OKuxQT88miJ2B8whM9XEtotO4KMBFKacO0RqiVJiVhMh
        C2ocvB33MnZ+wG7+y4ZRD6M=
X-Google-Smtp-Source: APBJJlHZDmLmzYtmm3fRpWLY8dRjc7TguZZPZHSFI1d1nHs3cRqMKxKTnkXIDty9Jqal6AqlqwmLww==
X-Received: by 2002:ac2:5b1d:0:b0:4fd:d1df:9bda with SMTP id v29-20020ac25b1d000000b004fdd1df9bdamr1537060lfn.42.1690546169831;
        Fri, 28 Jul 2023 05:09:29 -0700 (PDT)
Received: from ramazan-pc.synapse.com (d98-21.icpnet.pl. [77.65.98.21])
        by smtp.gmail.com with ESMTPSA id d28-20020ac2545c000000b004fb8f4df9bdsm792300lfn.226.2023.07.28.05.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 05:09:29 -0700 (PDT)
From:   Ramazan Safiullin <ram.safiullin2001@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Ramazan Safiullin <ram.safiullin2001@gmail.com>
Subject: [PATCH] MAINTAINERS: add documentation to PSI section
Date:   Fri, 28 Jul 2023 14:09:09 +0200
Message-Id: <20230728120909.234244-1-ram.safiullin2001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While creating a patch for the psi documentation I noticed that
MAINTENERS was missing an entry in psi.

Add entry for psi documentation.

Signed-off-by: Ramazan Safiullin <ram.safiullin2001@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5c16bb92fe2..2da6643b9488 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17103,6 +17103,7 @@ PRESSURE STALL INFORMATION (PSI)
 M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Suren Baghdasaryan <surenb@google.com>
 S:	Maintained
+F:	Documentation/accounting/psi.rst
 F:	include/linux/psi*
 F:	kernel/sched/psi.c
 
-- 
2.25.1

