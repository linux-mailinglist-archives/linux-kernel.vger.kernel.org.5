Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073687F521D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344154AbjKVVMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343845AbjKVVMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:12:13 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986F9D47;
        Wed, 22 Nov 2023 13:12:08 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6b709048f32so265316b3a.0;
        Wed, 22 Nov 2023 13:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687528; x=1701292328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UftY+9nJn82Vz5RJpbG87UiQLd2iCLBgMyI8O4iubXI=;
        b=EU3eyIJ/OBG42+qF2vpTOldu0KNB6DVzZQCeaQEQGVPoYN//InAIWxAtun2WfIbfzH
         TWL/XIqYPkNYEO0ZcxkFbx5D0BWnzTmRCjmaeR3eE7HpgzthwbT3vkWN4waN4E4fv4lj
         ejhd+zXWGt2stqG8f3YZabC7dhahyRFITCiMxPGVDI1sUv9dGbQLI/kYdqeetVG/pnpo
         bHBy6XrK0QUFX9YoK5H199sT2humxLXx/3L2chjv8RHA4KcGrqsSvZRjfv30JMHC7dcG
         wEYsucJjsdGiZORhNIk4n+tgfJC53U1lsbcr1pC7bZUgw9Bz3ZnVgt0o6khP8OP6TOGp
         TE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687528; x=1701292328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UftY+9nJn82Vz5RJpbG87UiQLd2iCLBgMyI8O4iubXI=;
        b=fFKtZMn/rKIod9M/FtNiwFu98MJDfLm9Hfzh40zNv3kgktPIN0voao6anea9YcbUqA
         sHVrNVPAHqDuu4ubAAlBnF+qeAgMbT3fOtskJeuxVdhiErpiW+4Mdh3PhiqqBYjM6rq2
         lkXJZ6DYHkMBuu32pN8IKbgDCaS/t41bT1EMDfhFxeo8/L9nyveFOfP+KRMwzrSq016/
         GLKCh+31GpLjooUWWgNoGGk04Viv+iof+SbWuRUdE17ukE2aSQHonKawRrQWUF2ZTfND
         6VX2otg6qz0WRQ3iN+sUKg6ITAlBXEv5IBLPJnrQtjrA7Lg5ZB9TnchWDmZ/86QuUUiO
         7aFw==
X-Gm-Message-State: AOJu0Yz3APQDHBHmgxDc2CIDoDPbHRiMOs2xRbk4rEA5WtKVEd03ku5C
        B04r0jQ/9wT4014SUL3y7w==
X-Google-Smtp-Source: AGHT+IFApmrVmTMi/koEr4L/CLh547UBRzR9U2yTau9qj52IoeLKDXr1/nWf98+BfkPjiCFsngGxIQ==
X-Received: by 2002:a05:6a00:4ac7:b0:6c2:cf23:3e21 with SMTP id ds7-20020a056a004ac700b006c2cf233e21mr4101209pfb.17.1700687527998;
        Wed, 22 Nov 2023 13:12:07 -0800 (PST)
Received: from fedora.mshome.net ([75.167.214.230])
        by smtp.gmail.com with ESMTPSA id j18-20020a635512000000b005bdbce6818esm132136pgb.30.2023.11.22.13.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:12:07 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de, tglx@linutronix.de, luto@kernel.org,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, mhocko@kernel.org, tj@kernel.org,
        ying.huang@intel.com, Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 01/11] mm/mempolicy: refactor do_set_mempolicy for code re-use
Date:   Wed, 22 Nov 2023 16:11:50 -0500
Message-Id: <20231122211200.31620-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231122211200.31620-1-gregory.price@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactors do_set_mempolicy into replace_mempolicy and do_set_mempolicy
so that replace_mempolicy can be re-used with new code, not just
the system call.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..410754d56e46 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -809,28 +809,20 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return vma_replace_policy(vma, new_pol);
 }
 
-/* Set the process memory policy */
-static long do_set_mempolicy(unsigned short mode, unsigned short flags,
-			     nodemask_t *nodes)
+/* Attempt to replace mempolicy, release the old one if successful */
+static long replace_mempolicy(struct mempolicy *new, nodemask_t *nodes)
 {
-	struct mempolicy *new, *old;
+	struct mempolicy *old = NULL;
 	NODEMASK_SCRATCH(scratch);
 	int ret;
 
 	if (!scratch)
 		return -ENOMEM;
 
-	new = mpol_new(mode, flags, nodes);
-	if (IS_ERR(new)) {
-		ret = PTR_ERR(new);
-		goto out;
-	}
-
 	task_lock(current);
 	ret = mpol_set_nodemask(new, nodes, scratch);
 	if (ret) {
 		task_unlock(current);
-		mpol_put(new);
 		goto out;
 	}
 
@@ -838,14 +830,32 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 	current->mempolicy = new;
 	if (new && new->mode == MPOL_INTERLEAVE)
 		current->il_prev = MAX_NUMNODES-1;
+out:
 	task_unlock(current);
 	mpol_put(old);
-	ret = 0;
-out:
+
 	NODEMASK_SCRATCH_FREE(scratch);
 	return ret;
 }
 
+/* Set the process memory policy */
+static long do_set_mempolicy(unsigned short mode, unsigned short flags,
+			     nodemask_t *nodes)
+{
+	struct mempolicy *new;
+	int ret;
+
+	new = mpol_new(mode, flags, nodes);
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+
+	ret = replace_mempolicy(new, nodes);
+	if (ret)
+		mpol_put(new);
+
+	return ret;
+}
+
 /*
  * Return nodemask for policy for get_mempolicy() query
  *
-- 
2.39.1

