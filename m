Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E3E7C92EC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 08:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjJNGMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 02:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjJNGMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 02:12:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1D6C2;
        Fri, 13 Oct 2023 23:12:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3231df054c4so2272847f8f.0;
        Fri, 13 Oct 2023 23:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697263927; x=1697868727; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VRzvbjqCINI1PjThGRzgdXHNyyoQH94qlPK9c4W3jg=;
        b=j3H1hIW8s0mX6xMYgzqOsXGQOYG+bJxJoM2q5WCRVoknhFsUnjzMIZiM7UjVnKbU8c
         zIR9NtjP4sRyxjV2xsboGqdOifv8F/B2FFJrjMXbzEISp1jME7F1QSPvTTQFQNnuztT/
         9VDFj9jT4YqUjVu09cttoW7cVeIhkpiBrbAbyIndeenD4BtTL5zHl96nk/++YfcVtOxZ
         TW47qFcLi1Jc4IwAJQT/ieYjOfk0U9FASCfVlM/V3RrvdXu3VuVMReg4XsPSjTI5eh0C
         GL6HHIGtHm1O6aErQoQkz9yE66pK+YGAdgFVkGLOCHyV9mDYceq8Y5D0l+hUCqsBqVEo
         wUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697263927; x=1697868727;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VRzvbjqCINI1PjThGRzgdXHNyyoQH94qlPK9c4W3jg=;
        b=B8xlvMjTHEyLVaAlKih4RKliDXhXEDlJHx9elaWsYSQ9I9BkYmrj4VnMe4M7utYjQG
         /CbdRDrOuTgVJicsUdGO6IRscgHyQjhtqWCB5YkKJnTbXCH72V3zaGhHzqdvVT0DsFaN
         ahs4llaYa37ucf7Yi0dvGIHME8dsIEcJP9nN75y6uVNNIxswz4HZuzzCKSHbtdlIZO5H
         f1Y6q8X7mOV7dqbBxVjfDpXTyOPwgBm8NEGr+pkArLHZM1nBAjclPhoOqDq2ErTkF6Lv
         oIoNhoWatOwtamc7e7mD1a+AJj1XQ9bV8HcRL9WrUPnBtFCfGZdl6f4RD7K7IPRaqTXK
         +Org==
X-Gm-Message-State: AOJu0YyzhL/Wf5MqYzekYp/xgsycBjwYyTQrlmOQhq+fQ2VeZ+0XqatJ
        2E2aDoQLm+bNtJ9NgQWjAW4=
X-Google-Smtp-Source: AGHT+IEjl9+rfnX2Gg8X1OBHZpVzqr/44hZGVggeu2TnQcKCipUXTEy/23qd9OlQsph4TJXX+wsc8g==
X-Received: by 2002:a5d:63cb:0:b0:32d:a40f:d920 with SMTP id c11-20020a5d63cb000000b0032da40fd920mr901050wrw.20.1697263927045;
        Fri, 13 Oct 2023 23:12:07 -0700 (PDT)
Received: from gilbert-PC ([105.112.18.68])
        by smtp.gmail.com with ESMTPSA id k7-20020a5d66c7000000b0031fd849e797sm22116052wrw.105.2023.10.13.23.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 23:12:04 -0700 (PDT)
Date:   Sat, 14 Oct 2023 07:11:59 +0100
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     outreachy@lists.linux.dev, manishc@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, coiby.xu@gmail.com,
        gregkh@linuxfoundation.org
Cc:     netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: qlge: Add bool type to qlge_idc_wait()
Message-ID: <ZSoxLxs45bIuBrHg@gilbert-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by checkpatch:

WARNING: else is not generally useful after a break or return

The idea of the break statements in the if/else is so that the loop is
exited immediately the value of status is changed. And returned
immediately. For if/else conditionals, the block to be executed will
always be one of the two. Introduce a bool type variable 's_sig' that
evaluates to true when the value of status is changed within the if/else
block.

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/qlge/qlge.h     | 1 +
 drivers/staging/qlge/qlge_mpi.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/qlge/qlge.h b/drivers/staging/qlge/qlge.h
index d0dd659834ee..b846bca82571 100644
--- a/drivers/staging/qlge/qlge.h
+++ b/drivers/staging/qlge/qlge.h
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/rtnetlink.h>
 #include <linux/if_vlan.h>
+#include <linux/types.h>
 
 /*
  * General definitions...
diff --git a/drivers/staging/qlge/qlge_mpi.c b/drivers/staging/qlge/qlge_mpi.c
index 96a4de6d2b34..44cb879240a0 100644
--- a/drivers/staging/qlge/qlge_mpi.c
+++ b/drivers/staging/qlge/qlge_mpi.c
@@ -909,6 +909,7 @@ int qlge_mb_wol_set_magic(struct qlge_adapter *qdev, u32 enable_wol)
 static int qlge_idc_wait(struct qlge_adapter *qdev)
 {
 	int status = -ETIMEDOUT;
+	bool s_sig = false;
 	struct mbox_params *mbcp = &qdev->idc_mbc;
 	long wait_time;
 
@@ -934,14 +935,17 @@ static int qlge_idc_wait(struct qlge_adapter *qdev)
 		} else if (mbcp->mbox_out[0] == AEN_IDC_CMPLT) {
 			netif_err(qdev, drv, qdev->ndev, "IDC Success.\n");
 			status = 0;
-			break;
+			s_sig = true;
 		} else {
 			netif_err(qdev, drv, qdev->ndev,
 				  "IDC: Invalid State 0x%.04x.\n",
 				  mbcp->mbox_out[0]);
 			status = -EIO;
-			break;
+			s_sig = true;
 		}
+
+		if (s_sig)
+			break;
 	}
 
 	return status;
-- 
2.34.1

