Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267147D1C65
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjJUKPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjJUKPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:15:06 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FB410C4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:15:03 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so1920405e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697883301; x=1698488101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zu42pQJStzejxYxI5j1H3uBlC7qEy33j9WdXMX2X/AQ=;
        b=PrA+QRxjNTg8DzUeCgoSa7YK1t3wRY3A54tEd/UlegMXr9pAyvZ2/TMac6SJVGDecn
         Qmn9OjBEUSE7bDF9DsFFXfjXmIdc+KRhV+gSxH46ImPyObL02F6r7eQdI0plxyePl4x3
         B1bLHKrmvcQ+Mi6FhOdM0OwDT9piU7vALt/Gn6wdO+cvSPPhU6Fyx5Od0j20xlJC/Gw4
         XIGMqqKUEDcauSI1CT36TmpdvEkY4+TteCHnSXvDxo7s34eAUunpeILMQaXSTj2KhVCN
         5wwR1mdgfz1xPYkMBVfPt6MIH27sHyZTwsS8gNBropZSG5m9vGtBYkxZB3UWVkqrcpvR
         bK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697883301; x=1698488101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zu42pQJStzejxYxI5j1H3uBlC7qEy33j9WdXMX2X/AQ=;
        b=p00OYFca56QxJ4ErRcE2CyBnCowauUizGKYdrMT0cB5MyQjP29SVrvM6eOzWumKbQf
         eda5l4k09gPiiwFTMZyer0S6GKWs+TKoEDelVr0F3A0lh0vmB2N2szyIMEE6eoYkexat
         nxaiK+n0wtuEezki/AwiHQqMmvNv8UY70DSkey+yP/RQhf1pU3+zKC8/zqofL93jf7V+
         H+760N7mtGbovXpWOBwzMonkK3rFk4SnsUHVAxIi1iJjEixkQ4pNZNTg1keqQ95xI/q4
         LfcR1lJBTB2Ct8m/iwkKqUNMxR979KeOJh19KoA7BGnhOWjXHreyaDbGvaCItoFxaM10
         m31Q==
X-Gm-Message-State: AOJu0Yz63Z+dWOs5ZRLM7ZkUIUz+OwDUGIus1AZo3wecvUgUbfkY1iAQ
        xQrXBDhvPLhFgFwjy0wEjQs=
X-Google-Smtp-Source: AGHT+IGEyGTqzXkocVX8/ecMNUuRxdd4+0q8gLRjkZ0gbP18EcvYStdDZo6L4lsZwM58quVnjk+OIg==
X-Received: by 2002:a05:6512:3b9a:b0:507:addb:c7a1 with SMTP id g26-20020a0565123b9a00b00507addbc7a1mr2641881lfv.14.1697883301146;
        Sat, 21 Oct 2023 03:15:01 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id d18-20020a056512369200b005007e7211f7sm803114lfs.21.2023.10.21.03.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 03:15:00 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH v3 3/7] staging: octeon: Fix introduction of following new typedef cvmx_pow_wait_t in octeon
Date:   Sat, 21 Oct 2023 12:12:34 +0200
Message-Id: <20231021101238.81466-4-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231021101238.81466-1-bergh.jonathan@gmail.com>
References: <20231021101238.81466-1-bergh.jonathan@gmail.com>
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

This patch removes the introduction of the following new enum typedef
cvmx_pow_wait_t and fixes up the implementations that used it.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
Changelog:                                                                 
v1 -> v2: Fix breaking change spread across multiple patches                
v2 -> v3: Break changes up into individual patches for each removed        
          typedef

 drivers/staging/octeon/octeon-stubs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 40c357c77679..a11cbfec4d35 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -233,10 +233,10 @@ enum cvmx_helper_interface_mode {
 	CVMX_HELPER_INTERFACE_MODE_LOOP,
 };
 
-typedef enum {
+enum cvmx_pow_wait {
 	CVMX_POW_WAIT = 1,
 	CVMX_POW_NO_WAIT = 0,
-} cvmx_pow_wait_t;
+};
 
 typedef enum {
 	CVMX_PKO_LOCK_NONE = 0,
@@ -1342,11 +1342,11 @@ static inline unsigned int cvmx_get_core_num(void)
 }
 
 static inline void cvmx_pow_work_request_async_nocheck(int scr_addr,
-						       cvmx_pow_wait_t wait)
+						       enum cvmx_pow_wait wait)
 { }
 
 static inline void cvmx_pow_work_request_async(int scr_addr,
-					       cvmx_pow_wait_t wait)
+					       enum cvmx_pow_wait wait)
 { }
 
 static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
@@ -1356,7 +1356,7 @@ static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
 	return wqe;
 }
 
-static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
+static inline struct cvmx_wqe *cvmx_pow_work_request_sync(enum cvmx_pow_wait wait)
 {
 	return (void *)(unsigned long)wait;
 }
-- 
2.40.1

