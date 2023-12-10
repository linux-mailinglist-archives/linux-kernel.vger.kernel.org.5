Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF0680BCBD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjLJThK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjLJThF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:37:05 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B63FED
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:37:11 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfb30ce241so32769765ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1702237031; x=1702841831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYqVx7BSwmx7CJkNw+pgf/xGVsuqtWLaE6AqjTQ5f8w=;
        b=PcL40m1KisYzJwqTGdemsgsYMxeZFS2bRlYRtNJ5N/m+ZmHlsM7nTQeOjA6tQfziEX
         BZWCNTtwcexg0vyuH2Sc48H/FSuP7F9dMmajqAhp/U/McyWlTKI7NMetmqRqKTwwT4CT
         bm4QWosddoJhx3hWb0TKfVer3TMQ5EKBj6LRHXJyG2fiWCXu4In56G+RzLZfoX2mawh7
         b1QUaXa+zDaFQF53SwW0dZknmQUgpTo4IhG9VheAKiSCJtcwgM/G8hs7Z4EwgO1IEXlQ
         qJbNMXhH95gcI8IxChjCf+spqnehVcNX5St5YKEcs+qB84KCkjnmJKDcCCqxaRbtCFCw
         zEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702237031; x=1702841831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYqVx7BSwmx7CJkNw+pgf/xGVsuqtWLaE6AqjTQ5f8w=;
        b=aBmy582hGOTEZKo03fgnZSi9k1yuWCQHJHwftSkC/QNonamu9Kphl1ys+1a5Qfertf
         2prrSi8DpRWxLiKIMwX2E6nqlQekO75f7bZmsXKqRz/10zGtBKywhW0U6zzMHQkAWq0Y
         q4CkCgzcyNmL7Te9gaOqwpemMN0lyY0ALrJERYU1AfpCxemRwRavetbkEXoeK8n9Jgpm
         JhoDeSZh0nQIZ+1eCEoPGgfeqfwLaGmym/QZ6xK7gha+1+UqFrJ8xjTPjBIEsBWRsUWe
         vyCR9axD3kXl1Vx/sgKuu49HFsYwrjmqwn3O9X4VwScGrS/lvMFe/G9ssD+8HF3WOwvu
         hjtg==
X-Gm-Message-State: AOJu0YyF8DiO9rCWyB+T39QrK7+6NiELfYbhYxJnS6Fgw9e7iqysBBl4
        eA6jp0Oxgn5DxZEMc+BSPnmndDyFwdQnGLsIrIfZeQ==
X-Google-Smtp-Source: AGHT+IEK160QHkpu3VcpJ0992SmIcp30ONtRFtn2YZ1IcChm75uhrH4ZjJwTYohbxjX6EWW9gvvyjQ==
X-Received: by 2002:a17:902:7ed0:b0:1d0:83af:fa0d with SMTP id p16-20020a1709027ed000b001d083affa0dmr2576323plb.112.1702237031155;
        Sun, 10 Dec 2023 11:37:11 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001b9e9edbf43sm5117419plk.171.2023.12.10.11.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 11:37:10 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 2/4] Staging: rtl8192e: Remove variable bLastSeg
Date:   Sun, 10 Dec 2023 11:37:03 -0800
Message-Id: <20231210193705.2131807-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231210193705.2131807-1-tdavies@darkphysics.net>
References: <20231210193705.2131807-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable bLastSeg as it is defined but never used.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index c0a24826cd3b..fb399acb7157 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -103,7 +103,6 @@ struct cb_desc {
 	/* Tx Desc Related flags (8-9) */
 	u8 bLastIniPkt:1;
 	u8 bCmdOrInit:1;
-	u8 bLastSeg:1;
 	u8 bEncrypt:1;
 	u8 tx_dis_rate_fallback:1;
 	u8 tx_use_drv_assinged_rate:1;
-- 
2.39.2

