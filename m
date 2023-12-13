Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95778121B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442875AbjLMWlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442856AbjLMWlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:41:37 -0500
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A016FF7;
        Wed, 13 Dec 2023 14:41:33 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5e2f9e9a2e8so9246787b3.3;
        Wed, 13 Dec 2023 14:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507293; x=1703112093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuinRDVwejGOUKweWBi5ia3P52oTVKxYpBkFwLpVf+w=;
        b=OFd+6VPBWT0NKrSa40iFNFZ9Fsymh0gee0FX90ynk7NUyN8gYViZCNZoFBnGDksux8
         K2czosLyK0bkEQ4thL8yL1v/WBpXdSH6sMh2RzMRw+rOtSRxgPvcIiI0ZzwNu4X9pcCE
         ozmfU4I/RTzdpomIZ7ZpG9tTuIOUaVNGvXnsiKLfANX5PCs9q3QuNRIVettWPkFRsGL8
         H9PK2nFb2HL96PEInUHcJuYPDzyTuuf0Xu+uUCwb32qTYGATfDa5mkIlkrshza/d5ndU
         dpF+kMI1whPX98lBZXHHjnFLeOaLOV1esdXt8+lU5B1JkZO8Ne/tpx1QkNGB3OywQUyp
         f0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507293; x=1703112093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuinRDVwejGOUKweWBi5ia3P52oTVKxYpBkFwLpVf+w=;
        b=rNmDdNBBfGmsvA3pv30Ebd2yO7xgOE1wtq1upfsbhns+kJz0JDIG121DxxoICl25Lq
         LcLF1gG6h9FWuNTjxjox8RPWbLr6C7M4dEL6Ohpd17zrqhFMneBA7H3cAaVJfIwzsy1V
         wft7Ze7I2pXT3Jb6JjFina+Vf+krFUEXdiW6pNZaQ9BQk4YpX4mkeuhD06S9dkXkidXt
         xYevxeUHjm/gOdDOFG75aJOe6f2iuZGZFggnLqgVDTSE0P6EvvEJIO9SRzHy94IF+OiI
         jsNv5LosqNJKy8wXiND6UhP9lizjH7Q/9gDXE6CF+8S8Jm5xBEF+XHpeYEwcraS3QTtE
         KQyQ==
X-Gm-Message-State: AOJu0Yyqo4s68wuWwLNX9p6x2M+WHHP1I4eognoBqTvdaRFFMtHicXKO
        mbXXSgKm5WF4rx01dh4Tnw==
X-Google-Smtp-Source: AGHT+IHE+bJ2FUrqt3NqWqPmzMopz8vaM/IYN23kqVq6QW7HNCHLcVB3AOGmYUfKzjdNksIM6oT1Ig==
X-Received: by 2002:a81:d248:0:b0:5d8:10a1:f504 with SMTP id m8-20020a81d248000000b005d810a1f504mr8354579ywl.82.1702507292772;
        Wed, 13 Dec 2023 14:41:32 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm5050583ywf.42.2023.12.13.14.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:41:32 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        tglx@linutronix.de, luto@kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mhocko@kernel.org, tj@kernel.org, ying.huang@intel.com,
        gregory.price@memverge.com, corbet@lwn.net, rakie.kim@sk.com,
        hyeongtak.ji@sk.com, honggyu.kim@sk.com, vtavarespetr@micron.com,
        peterz@infradead.org, jgroves@micron.com, ravis.opensrc@micron.com,
        sthanneeru@micron.com, emirakhur@micron.com, Hasan.Maruf@amd.com,
        seungjun.ha@samsung.com
Subject: [PATCH v3 06/11] mm/mempolicy: allow home_node to be set by mpol_new
Date:   Wed, 13 Dec 2023 17:41:13 -0500
Message-Id: <20231213224118.1949-7-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231213224118.1949-1-gregory.price@memverge.com>
References: <20231213224118.1949-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the plumbing into mpol_new() to allow the argument
structure's home_node field to be set during mempolicy creation.

The syscall sys_set_mempolicy_home_node was added to allow a home
node to be registered for a vma.

For set_mempolicy2 and mbind2 syscalls, it would be useful to add
this as an extension to allow the user to submit a fully formed
mempolicy configuration in a single call, rather than require
multiple calls to configure a mempolicy.

This will become particularly useful if/when pidfd interfaces to
change process mempolicies from outside the task appear, as each
call to change the mempolicy does an atomic swap of that policy
in the task, rather than mutate the policy.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 7956edcc57fd..705ddf1ccdd9 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -306,7 +306,7 @@ static struct mempolicy *mpol_new(struct mempolicy_args *args)
 	atomic_set(&policy->refcnt, 1);
 	policy->mode = mode;
 	policy->flags = flags;
-	policy->home_node = NUMA_NO_NODE;
+	policy->home_node = args->home_node;
 	policy->wil.cur_weight = 0;
 
 	return policy;
@@ -1625,6 +1625,7 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	args.mode = lmode;
 	args.mode_flags = mode_flags;
 	args.policy_nodes = &nodes;
+	args.home_node = NUMA_NO_NODE;
 
 	return do_set_mempolicy(&args);
 }
@@ -2985,6 +2986,8 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		margs.mode = mpol->mode;
 		margs.mode_flags = mpol->flags;
 		margs.policy_nodes = &mpol->w.user_nodemask;
+		margs.home_node = NUMA_NO_NODE;
+
 		/* contextualize the tmpfs mount point mempolicy to this file */
 		npol = mpol_new(&margs);
 		if (IS_ERR(npol))
@@ -3143,6 +3146,7 @@ void __init numa_policy_init(void)
 	memset(&args, 0, sizeof(args));
 	args.mode = MPOL_INTERLEAVE;
 	args.policy_nodes = &interleave_nodes;
+	args.home_node = NUMA_NO_NODE;
 
 	if (do_set_mempolicy(&args))
 		pr_err("%s: interleaving failed\n", __func__);
@@ -3157,6 +3161,7 @@ void numa_default_policy(void)
 
 	memset(&args, 0, sizeof(args));
 	args.mode = MPOL_DEFAULT;
+	args.home_node = NUMA_NO_NODE;
 
 	do_set_mempolicy(&args);
 }
@@ -3279,6 +3284,8 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 	margs.mode = mode;
 	margs.mode_flags = mode_flags;
 	margs.policy_nodes = &nodes;
+	margs.home_node = NUMA_NO_NODE;
+
 	new = mpol_new(&margs);
 	if (IS_ERR(new))
 		goto out;
-- 
2.39.1

