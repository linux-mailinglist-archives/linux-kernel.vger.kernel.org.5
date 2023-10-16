Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3497CB288
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjJPS3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjJPS3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:29:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE50A2;
        Mon, 16 Oct 2023 11:29:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-692c02adeefso3422177b3a.3;
        Mon, 16 Oct 2023 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697480984; x=1698085784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JjHsQBZguJmg5VUaxhHmSJkmwaoPV8XzNp+2kxO9i1A=;
        b=R3zQ4EEALMi2YI9lVaHgi+z5C9WN4E49/wXKi+EwHnUFCMc8GGOHFqTWl51J7IiORX
         7dhj/P0RFUgJ755/YaNvt46lqVOi0sdGoehuIfSftFdtF7GjJtiWB091xUWvNBQ6kaSN
         skEkyzrsmJUTG0Apf+IsCfhjVBN3+ptec8Zmwgj+wghc+myvbQxjDjxs733Evo1BEk2o
         5naDr9CyeWRHm8ggvCBrdJbjRhgwxKl/Lq4+gngTCw463iD5CPf67xd2DTW2v1SFV/Lk
         L8UE/9o1Xx2RtpyHpZNICAg6G67pUb60aQg1URgDxt8VXJR3AyhJy/hPahOXB/h/6czC
         C5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480984; x=1698085784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjHsQBZguJmg5VUaxhHmSJkmwaoPV8XzNp+2kxO9i1A=;
        b=mgKQkRJffEuyeqDiLTN0Vk1zxipH8yyefyC6zDLklJ+0+Ntb3aHKGj2GG0Nx6Y7WyZ
         0k2sU7nrlz+vShc3etSNYq/afdIrMRpBJF+/lyvWQEyY/pblYsOTF/YDipt6w1it1K7P
         XvwJlTkk1J4Td7kEBIKVZBTy+zEtCoZTeQVwoVnmEe2Qn+3jDR7akj8PMLesfEsoEOdQ
         O+xwjI3Dotr4nkvBIajAvohAKcz3aND/f4CY0xRfUgYKcP5HaUwnD/lHI25dsWiOzPly
         9uAp4Pp7Mb9ZF4KH73b3wO4IfQsOJ0fClufe66lgbF7m8K5j95gdbwEl2x4/cUNMlxiJ
         Lvwg==
X-Gm-Message-State: AOJu0YzhsqJhxELdqFdffBQvB08LXhpZafaXTYLLa4F/2ISKDoaJKHP6
        4NueLrzei9y5YDp7Omfd84c=
X-Google-Smtp-Source: AGHT+IFZEg5xAk1ZmYp3GRROoasA68Dv9NYl8hDbMXgzL2h184umSXsYNgNS+151sy+zwC6/69sJkg==
X-Received: by 2002:a05:6a20:d41d:b0:15a:836:7239 with SMTP id il29-20020a056a20d41d00b0015a08367239mr28055416pzb.11.1697480983734;
        Mon, 16 Oct 2023 11:29:43 -0700 (PDT)
Received: from policorp.cardumecowork.local ([177.91.232.53])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b001acae9734c0sm8712826plk.266.2023.10.16.11.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:29:43 -0700 (PDT)
From:   Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To:     jlee@suse.com
Cc:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, edson.drosdeck@gmail.com
Subject: [PATCH] platform/x86: acer-wmi: Remove void function return
Date:   Mon, 16 Oct 2023 15:29:10 -0300
Message-Id: <20231016182910.3344-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to Linux kernel coding style.

Reported by checkpatch:

WARNING: void function return statements are not generally useful

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 drivers/platform/x86/acer-wmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 377a0becd1a1..0e472aa9bf41 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1922,7 +1922,6 @@ static void acer_rfkill_exit(void)
 		rfkill_unregister(threeg_rfkill);
 		rfkill_destroy(threeg_rfkill);
 	}
-	return;
 }
 
 static void acer_wmi_notify(u32 value, void *context)
@@ -2517,7 +2516,6 @@ static void __exit acer_wmi_exit(void)
 	platform_driver_unregister(&acer_platform_driver);
 
 	pr_info("Acer Laptop WMI Extras unloaded\n");
-	return;
 }
 
 module_init(acer_wmi_init);
-- 
2.39.2

