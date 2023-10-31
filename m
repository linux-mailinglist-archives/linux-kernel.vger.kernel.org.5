Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF30A7DC3AD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbjJaAi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbjJaAiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:38:23 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A094A99;
        Mon, 30 Oct 2023 17:38:21 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id 3f1490d57ef6-d9fe0a598d8so4137823276.2;
        Mon, 30 Oct 2023 17:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698712700; x=1699317500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD4RKFVfAbTN2kU9bJZ9F+y9XLZ/Az1TURsN25S7xmg=;
        b=VkQ7OU1xlX2UrJqR70nb1pd++N1HYyZIUKoCcl6LGVfaOkxhCSyMV+5wlX2qbt73DL
         aXniR5moJE+uvTc8euJlTDgyB2ESEM0iEPAhtyBb1V+Xlc8YuL7V3k7UIQSF2uD3fDVN
         8+GpAm1/VuJ3s4SL50BcskgzHO7CDKprWl9knHpXxPSgjXRHDidOmsOMfljtu1R0o3MW
         vL4wmTSlM9xpKIdMCZu2aXgOPk0bcl8r1lI5gHiH9lLGy08vnZpp68jQM9wEOVZ53i72
         kPMBph6QNQuToWzXPgfuq4POIay5q8JPF4l4Z8ASVdFRaqW/iVM08/Am5s5S/XFmTl2F
         VVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698712701; x=1699317501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OD4RKFVfAbTN2kU9bJZ9F+y9XLZ/Az1TURsN25S7xmg=;
        b=g8R3a+pV5+GnpeoAFdigJwROJ+YhDXCSRqgS3GtChdg7/Iny2qrNiOfIa2IBD4NNx9
         /kxoDJs/yUNn1zllJYaOKY0vdZAuEavMXkVue97+HjK5YUtwHVHxWdGXXKM1AGx1Josh
         rsmsT9fgVj9/KfEj8xSOxePmXo00iQrkOp7LTl2ATlFZ8hJzgpNIFg+Ycb4pGLvjEZk1
         c8PJcDu4d6bQbVeVSUh9TQkSqlxgCELq7CE8f097zq6i7ltfLkLye356kltBYfoaa+M7
         lpa7/gY8DExCgQdB+xseaqnPy6uZltGokOpLGVCuYVmNt7dkkH+J9NTB0qsO4+hPawii
         OlxQ==
X-Gm-Message-State: AOJu0Yxbm3wfm/ocQV0SqaVNQxGQaPRScsAxNxIkq+HGk9aJZKEN6K9b
        TCnAX1btG6INwrIY2OA+UUsEqBfblUQg
X-Google-Smtp-Source: AGHT+IFfmuVE+ioJmsCa3B2MRGYbfibjNOTfLGweeVtA4hU+86oyAaa9aIfB3b+hqlewkbs+8GiZ7g==
X-Received: by 2002:a25:83c2:0:b0:da0:3535:41f5 with SMTP id v2-20020a2583c2000000b00da0353541f5mr10377007ybm.52.1698712700698;
        Mon, 30 Oct 2023 17:38:20 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id b19-20020a25ae93000000b00da086d6921fsm182750ybj.50.2023.10.30.17.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 17:38:20 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, weixugc@google.com, apopple@nvidia.com,
        hannes@cmpxchg.org, tim.c.chen@intel.com, dave.hansen@intel.com,
        mhocko@kernel.org, shy828301@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH v3 1/4] base/node.c: initialize the accessor list before registering
Date:   Mon, 30 Oct 2023 20:38:07 -0400
Message-Id: <20231031003810.4532-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231031003810.4532-1-gregory.price@memverge.com>
References: <20231031003810.4532-1-gregory.price@memverge.com>
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

