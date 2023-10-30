Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433F27DBE88
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjJ3RLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjJ3RLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:11:37 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D95DD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:11:35 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so4126566276.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698685894; x=1699290694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OD4RKFVfAbTN2kU9bJZ9F+y9XLZ/Az1TURsN25S7xmg=;
        b=N1GdYG4P65gQF4znv9e+68hQG5cK3J2IAyrw8REWMpoHQd3NemNpm/o964TXrqMHE1
         GDmh4YKVz2RFHpCF33pkpKEPpj15ELSJ3SaR4l5zIX8CvBpPmNu7Sj2cZg1ApoQnB5PA
         chWbviL/6GyfgcpcgtLBalAdY+bsAkG6fPWxZe5HBdym13s7GXksW9imhTVpUMHyQ78+
         /ZHkNyicWDkN4mF5sq07tb/mdgoHWYdCKSuL5mTmoLbGlTQ5MnvfMiyE5NiOUIfspAAL
         SHPGfhXWeT7yD6Gza8PyEUgs/eGyGmvx+cHRHWazAeELxZ0I7DjBFu6TjY6q50AEJjKI
         oiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698685894; x=1699290694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OD4RKFVfAbTN2kU9bJZ9F+y9XLZ/Az1TURsN25S7xmg=;
        b=PYh35ryWpp0vqPBhqaCXgj/VzYwgfTbrWsua9rYUJxVrH4o/CtvQTfZptbK8deoaQW
         NRJAtxmgLq5JrSK/9Mc22SsF+pAjS8a/9m34JWyHnIhyQq9erzpkdba6Syi10hdzrAHX
         JJ2t3KF5+vdGX/JCwgsa/7N6JWYkcbkH8zRiTCT0+vg4lxlgVJLEzkTEKZqcNSIgbp0O
         2i3nw6Wb9JXxFIXrvmVhFW81HRmhXoX94euv6QL/sO0APBgYz1pIrrwaqCBfQLe1wZ4p
         2Q4v82qtspyWxzMeM2cwc9JESc/r7lK70ARuYCJuUf59ebOG7vXej8UQK+5K6hliUG3Q
         KhcQ==
X-Gm-Message-State: AOJu0Yxg2LIhYFhdUJLAdsAhBfkcyTFOVkJOxrigJGcVFliLbrf41YbC
        sxUB9DoWm+tNDwFt3rxy1Lbh0tKBflPS
X-Google-Smtp-Source: AGHT+IHEEN6ly0K7R76O9mvrLqb/1j89l7BbhsS0Jo9/JLJkPfcVgkNQAIfbMvygj6eNS3q9Y+FxNg==
X-Received: by 2002:a25:403:0:b0:da2:a918:36dd with SMTP id 3-20020a250403000000b00da2a91836ddmr5037133ybe.36.1698685894487;
        Mon, 30 Oct 2023 10:11:34 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id w73-20020a25c74c000000b00d9ca9243ad5sm4068996ybe.38.2023.10.30.10.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:11:34 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH] base/node.c: initialize the accessor list before registering
Date:   Mon, 30 Oct 2023 00:42:39 -0400
Message-Id: <20231030044239.971756-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code registers the node as available in the node array
before initializing the accessor list.  This makes it so that
anything which might access the accessor list as a result of
allocations will cause an undefined memory access.

In one example, an extension to access hmat data during interleave
caused this undefined access as a result of a bulk allocation
that occurs during node initialization but before the accessor
list is initialized.

Initialize the accessor list before making the node generally
available to the global system.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 drivers/base/node.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 493d533f8375..4d588f4658c8 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -868,11 +868,15 @@ int __register_one_node(int nid)
 {
 	int error;
 	int cpu;
+	struct node *node;
 
-	node_devices[nid] = kzalloc(sizeof(struct node), GFP_KERNEL);
-	if (!node_devices[nid])
+	node = kzalloc(sizeof(struct node), GFP_KERNEL);
+	if (!node)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&node->access_list);
+	node_devices[nid] = node;
+
 	error = register_node(node_devices[nid], nid);
 
 	/* link cpu under this node */
@@ -881,7 +885,6 @@ int __register_one_node(int nid)
 			register_cpu_under_node(cpu, nid);
 	}
 
-	INIT_LIST_HEAD(&node_devices[nid]->access_list);
 	node_init_caches(nid);
 
 	return error;
-- 
2.39.1

