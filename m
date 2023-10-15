Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798D77C9B2A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjJOUC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOUC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:02:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB3FB7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:02:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so41756915e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697400142; x=1698004942; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FG9AttEioQfqRDZbNIP/22fcyG3rw6EjNALMu0XvLK8=;
        b=UYjsZzjVVt7NqtvwjChHG29M+rD7U1hjuaiYqWuS+705bWs+aeoVbSUERCbUuZcOvd
         dLtRQxpbUwVzNOHdY3K72uHbCEreRAytkRxfsCTIwoWClVMLtnMztxnjGjU9D7mWoYNV
         wMA/foKSVYL3TjIEojppl/sxt87Io4EmBa6Fq3IpeMd5ljelkE3qwLPaTkFEqWNsCInI
         fZObjUoPu/0GHnCsnkuqA1Z6FgiLymUH6JwGDgAwoFf3DzesesecFFGV8erE229tzFn2
         kdnBEAL26sMakEFF5UyHfQHZN4zuVfftrw7MkxdhZ/A/muln3ASalLvdq/T/Wr7M/kWp
         0+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697400142; x=1698004942;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FG9AttEioQfqRDZbNIP/22fcyG3rw6EjNALMu0XvLK8=;
        b=voULjsVw7etpjFIv+teB92EEQ1lrqnutkKu1Ikr72qE4Ra5573/8o6zFuHqZerVF7S
         dUcDAdddLXUq8xu19Bg29jEvAZFvYwFQpKfXD9QP7kD32iP/OxTJ2gtjq6tHFHg59w5z
         Eh2obcA08zCsfsTgZjTaiYq1Tgm+L8P/GV/R9aNuKArsVd7x94cU44zsaS4pxNO4Dy9p
         yF4v7BQgH7bOHerKo7hdl1o/twmO4It0NX9KBgKtohZG3BMcPvHKJ2foL8mIB7VT8wk2
         REn/5+jetQ5gz37nW1cNvKaLxGUANzt268MIh7oUEpUQjHd80FuHNxJLqeoKipQIpLKA
         XhCg==
X-Gm-Message-State: AOJu0Yzlu16VtCE6OHBYxZJ8LTht9Z9ddHzqxniZpP8K5haEvxVfl49a
        L/JU6RzvCxorwFXsYIoLPfrjyMxrCsDiKQ==
X-Google-Smtp-Source: AGHT+IE4bDbkmn4bZXjxYPES1Y7BM57oxEqu857Y/Z3/gW1gzo7nRe65Gb1fFRiWjp5zXul1UtQoaA==
X-Received: by 2002:a05:600c:2298:b0:406:4573:81d2 with SMTP id 24-20020a05600c229800b00406457381d2mr26922024wmf.39.1697400142167;
        Sun, 15 Oct 2023 13:02:22 -0700 (PDT)
Received: from lab-ubuntu ([41.90.67.11])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c4fc600b0040472ad9a3dsm5294765wmq.14.2023.10.15.13.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 13:02:21 -0700 (PDT)
Date:   Sun, 15 Oct 2023 23:02:19 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Calvince Otieno <calvncce@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Solomon Peachy <pizza@shaftnet.org>
Subject: [PATCH v2] staging: wlan-ng: remove unused function prototypes
Message-ID: <ZSxFS8EnFr998PqS@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are declared but not defined or used anywhere. Their 
definitions were removed 15 years ago.

prism2mgmt_set_grpaddr() was removed in the
commit 1e7201836c57 ("Staging: wlan-ng: Delete a pile of unused mibs.
And fix WEXT SET_TXPOWER.")
It's signature was changed in the commit 5a2214e2e02f ("staging: 
wlang-ng: avoid new typedef: hfa384x_t")

prism2mgmt_get_grpaddr() and prism2mgmt_get_grpaddr_index() were
removed in the commit cbec30c4c00c ("Staging: wlan-ng: Delete a large pile of
now-unused code.")

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
Patch v2:
	- Updated the patch description to include the commit history indicating
	when the function definitions were deleted.

Patch v1:
	- Removed the function declarations

 drivers/staging/wlan-ng/prism2mgmt.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2mgmt.h b/drivers/staging/wlan-ng/prism2mgmt.h
index 083a055ee986..8c3f1ac35913 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.h
+++ b/drivers/staging/wlan-ng/prism2mgmt.h
@@ -78,14 +78,6 @@ void prism2mgmt_pstr2bytestr(struct hfa384x_bytestr *bytestr,
 void prism2mgmt_bytestr2pstr(struct hfa384x_bytestr *bytestr,
 			     struct p80211pstrd *pstr);
 
-/* functions to convert Group Addresses */
-void prism2mgmt_get_grpaddr(u32 did, struct p80211pstrd *pstr,
-			    struct hfa384x *priv);
-int prism2mgmt_set_grpaddr(u32 did,
-			   u8 *prism2buf, struct p80211pstrd *pstr,
-			   struct hfa384x *priv);
-int prism2mgmt_get_grpaddr_index(u32 did);
-
 void prism2sta_processing_defer(struct work_struct *data);
 
 void prism2sta_commsqual_defer(struct work_struct *data);
-- 
2.34.1

