Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9ED80B2B5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 08:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjLIG7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 01:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjLIG7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 01:59:35 -0500
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478510D0;
        Fri,  8 Dec 2023 22:59:41 -0800 (PST)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-5d77a1163faso21704207b3.0;
        Fri, 08 Dec 2023 22:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702105181; x=1702709981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7HyyIuO4SKyKyBceL5BuQSQ5m+etdZ0u+23B3P6Igo=;
        b=lor5k3MSieECNXvQg4ACYQU5Mxl9mfFjuu2rX5IrPzF4kj4xPUksbnqNnMM8SKN/2Q
         3WkZEdRydxoZA0AK4I398Xu0bZHlj6cbEHygEObUsXEN8S8SAJ3ZVB7Q4hzqYXSPQTa1
         H8c+UJJUwjulaRLwS0N19XBO15FbG1lUvLiolUG1xkQhzQIzjIGatVOYnlfEg1b1g4rn
         wXwZczKC1i8+SKyIzH8QcPJo8OfqHb2tfsm3WodbmOIFP7iJKqLVdzaIjwtXH50pWCCu
         OYrzFr2DhsB7qwtLYLEVh7Fn+4/UpsR61LLwZ8qO+kokz2efZHaBhf10lvCg7VIM43OA
         /d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702105181; x=1702709981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7HyyIuO4SKyKyBceL5BuQSQ5m+etdZ0u+23B3P6Igo=;
        b=dqjXV+OXfSkpBTeiP7ihzt0z40OVSzWt6LheqeILxumMiur1jdMRq9IEIuAFprgN9h
         JhCR2adh0IYAXKwnrzgp2nVZEMvTosLSPnII1ORGQczzWcr2Ocuj/Gv7BIb+H2P3ih0P
         VFX8KLY4xarHMteTVJi/PaRIopF0F0we3zsWz2qOYoKEUQ37x4u93JqaA3ZwHJtkK/eI
         dLdrd2Myoofna1spcedsC94G31nJYVpsNAfistSz9qK8QAast3CCaYtp7URzd6OFOJ6U
         httrupFrENpv4J7CUZRw5jfsHn4p4mCquh/LNstdMdnc55RitPVXJ5Zi6Ii3/GGqA20V
         8xQQ==
X-Gm-Message-State: AOJu0YzmdEXqIiERpn3CNdlYigXYU9/6rbMdeKjorgMkCZCTO+9ztueg
        R10eCzm4onTHwdXgbeO7cQ==
X-Google-Smtp-Source: AGHT+IGteQ1CEjfgmNHOonmlymj7glCZN8Z626LEQR0OLvqtfJs+kc+S7pyWNN9I9wFIiUm8ZkYGCg==
X-Received: by 2002:a0d:c405:0:b0:5d7:1940:3efe with SMTP id g5-20020a0dc405000000b005d719403efemr1025990ywd.47.1702105180858;
        Fri, 08 Dec 2023 22:59:40 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id x8-20020a81b048000000b005df5d592244sm326530ywk.78.2023.12.08.22.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 22:59:40 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de, tglx@linutronix.de, luto@kernel.org,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, mhocko@kernel.org, tj@kernel.org,
        ying.huang@intel.com, gregory.price@memverge.com, corbet@lwn.net,
        rakie.kim@sk.com, hyeongtak.ji@sk.com, honggyu.kim@sk.com,
        vtavarespetr@micron.com, peterz@infradead.org, jgroves@micron.com,
        ravis.opensrc@micron.com, sthanneeru@micron.com,
        emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com
Subject: [PATCH v2 03/11] mm/mempolicy: refactor sanitize_mpol_flags for reuse
Date:   Sat,  9 Dec 2023 01:59:23 -0500
Message-Id: <20231209065931.3458-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231209065931.3458-1-gregory.price@memverge.com>
References: <20231209065931.3458-1-gregory.price@memverge.com>
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

split sanitize_mpol_flags into sanitize and validate.

Sanitize is used by set_mempolicy to split (int mode) into mode
and mode_flags, and then validates them.

Validate validates already split flags.

Validate will be reused for new syscalls that accept already
split mode and mode_flags.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b4d94646e6a2..65d023720e83 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1463,24 +1463,39 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
 }
 
-/* Basic parameter sanity check used by both mbind() and set_mempolicy() */
-static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
+/*
+ * Basic parameter sanity check used by mbind/set_mempolicy
+ * May modify flags to include internal flags (e.g. MPOL_F_MOF/F_MORON)
+ */
+static inline int validate_mpol_flags(unsigned short mode, unsigned short *flags)
 {
-	*flags = *mode & MPOL_MODE_FLAGS;
-	*mode &= ~MPOL_MODE_FLAGS;
-
-	if ((unsigned int)(*mode) >=  MPOL_MAX)
+	if ((unsigned int)(mode) >= MPOL_MAX)
 		return -EINVAL;
 	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
 		return -EINVAL;
 	if (*flags & MPOL_F_NUMA_BALANCING) {
-		if (*mode != MPOL_BIND)
+		if (mode != MPOL_BIND)
 			return -EINVAL;
 		*flags |= (MPOL_F_MOF | MPOL_F_MORON);
 	}
 	return 0;
 }
 
+/*
+ * Used by mbind/set_memplicy to split and validate mode/flags
+ * set_mempolicy combines (mode | flags), split them out into separate
+ * fields and return just the mode in mode_arg and flags in flags.
+ */
+static inline int sanitize_mpol_flags(int *mode_arg, unsigned short *flags)
+{
+	unsigned short mode = (*mode_arg & ~MPOL_MODE_FLAGS);
+
+	*flags = *mode_arg & MPOL_MODE_FLAGS;
+	*mode_arg = mode;
+
+	return validate_mpol_flags(mode, flags);
+}
+
 static long kernel_mbind(unsigned long start, unsigned long len,
 			 unsigned long mode, const unsigned long __user *nmask,
 			 unsigned long maxnode, unsigned int flags)
-- 
2.39.1

