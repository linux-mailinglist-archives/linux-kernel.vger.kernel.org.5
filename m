Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6377DC38A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbjJaARe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbjJaARd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:17:33 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEABB3;
        Mon, 30 Oct 2023 17:17:31 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5a87ac9d245so48984987b3.3;
        Mon, 30 Oct 2023 17:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698711450; x=1699316250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD4RKFVfAbTN2kU9bJZ9F+y9XLZ/Az1TURsN25S7xmg=;
        b=Dh4wFZfFnVQAcqLeqTB3vybYBdM1EMB5VBjz/9WWuUyVMM/WJXkwFiR5B6d7cXh79K
         Bbu5Xf2YCAHONFFjKX/To3rmm0RIDvhUs92RTILbZ46CYriRXuIpqKhMHSwdZ6BdsW34
         VmSrOvdr0vf/IXo//TOHeejBpx7BedafDRcj7eTh4rh+J5e+1QzR4CynXUaSptQxpiNs
         w7hp5qk3Z/j1fD9asbvOKGHPs9EqH/nNZdw4CdnE4S0GajsJVEtTpp99Lxm9zYI1S31h
         zUfKi7aPutymMpfDoFsHWGiKu8qX7L4QGug3+BB5wmgBDyNjoYMFVRkn5+o9d4bH78/d
         uQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698711450; x=1699316250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OD4RKFVfAbTN2kU9bJZ9F+y9XLZ/Az1TURsN25S7xmg=;
        b=u4SjTYqkuRya9vvPRIA9i7IIrYe2zlFmZ1djEub6E0U3Q7aFieTUVYUBVk/LknAP/l
         T9LjuHoKSy61xj9u3N+Tmbj6hwGTQhRuh1OvwGLGwoPMboff7TArh63ZA9GcxO/xY3h3
         p2UDaHu1eimugz6/K/hZkRDjJDTSLXsqSWccQGycm2eJSYrd65mGfBuWop8xtHCTbGUn
         FardLFUFnOeYtzzoztbTxd6w7vTOpNpsUgk/JWT19im0tnWJSLV2kKGLp2W6GtOlDlNo
         ZoMOSOvTlHfGaW57Eik2nqFlzOqiVsZQtRlRoCEHzo2jWfXkOv2RDwdTQhCDeZ17MGGZ
         mOEQ==
X-Gm-Message-State: AOJu0YwjQxYIJ49/PihprLgssV+BYWTKpPrSKbgPfE7WdJpD+XrrTe4A
        0r+CQ8nAyOYLn2aykz84FKGFeEhxmdJ9
X-Google-Smtp-Source: AGHT+IGzePeyJoClGwnIsWFkX4hXlTIZr0JUl/wQg+3Lp0v/LfNvyO3K6nm7n7V51FdM3fuJwQISgg==
X-Received: by 2002:a05:690c:f13:b0:5a7:d133:370d with SMTP id dc19-20020a05690c0f1300b005a7d133370dmr14467747ywb.16.1698711450524;
        Mon, 30 Oct 2023 17:17:30 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05690c314a00b005a7bf9749c8sm113824ywb.4.2023.10.30.17.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 17:17:30 -0700 (PDT)
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
Date:   Mon, 30 Oct 2023 20:17:18 -0400
Message-Id: <20231031001721.3972-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231031001721.3972-1-gregory.price@memverge.com>
References: <20231031001721.3972-1-gregory.price@memverge.com>
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

