Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DD275C6AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjGUMPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGUMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:15:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B5F1722;
        Fri, 21 Jul 2023 05:15:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so16360915e9.3;
        Fri, 21 Jul 2023 05:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689941738; x=1690546538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ufZUhVBWubr/WTaq0aEw+CJySZhvmfhhfIecrz7+9U=;
        b=ngXt3/5IjcQ5FeSVpAB5CJWWCfq57AVWQMRgHJf1UFTkWKS6Vol5+pfmrsJ7e7JTjB
         9vsGmJK1cKXNoFyFsF0LzoPxAlMi/X2sQTIz2dPcMahZhin0+7MPa1jamxoo0sfV3OWx
         mOhYByha7gEywSe+/PA/omaRRDBI5WwTMg9vIuS4HZ7gVyziDLQWN1euhcqqoPzPySX7
         fpyZtFTHaT+LOsxtbpZsM082ZNNb9VF5E807zs9EU0dLDKDmDe1NsgFQbKq2BaX5cygH
         qU64788SreZNPA9uTNlyTN78jxwihTJ3ITuU7rGHg2kTyplRZ+eviry2qq8JsF+BH9wy
         5ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689941738; x=1690546538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ufZUhVBWubr/WTaq0aEw+CJySZhvmfhhfIecrz7+9U=;
        b=YrWneiG+C6VFE7WXIwid8tQCDiWPMTF/wZREO/HZXGUd0Sd5TVMP0dsDsb34Yy6Ifd
         ae2Jxg6QU2Bsc9D6Wn38c5gLfXukT/oCYGVYOjRnlXEjC9EKe8ktM1qwslSVqktAFhIZ
         cZNbYqGWgJ+yOMtuej3TQZUOdfq0f0xhwLPtXAWV55rYUAfeykGC7hoP6D9AsVRRsqod
         QxbVWEl4lJzKoDiyt5F3GKaxUk6b3VR6DNogazCr08TlUxFHEipcGL0NjlaKqE9Bt5AC
         5ziivtyWLoA9lwSabCoiaJuDtzaxnL4TTmFWjCLqUSbLzWe5iGW9VTFzrH1xqk4BjEnB
         UF6Q==
X-Gm-Message-State: ABy/qLZiOqwjossIzrKXdyLYPTOPcqNaoO58uAoJNFNXCvT9+ZN/wVwj
        jXxDCYV6/7aPymoM3GMhOC4=
X-Google-Smtp-Source: APBJJlH01s69HMne/7tJZA95TeBUjgSph2Rv/TtHAGSE7xE95vH09iC4HMDB0vzqU86TitE2gIw3Iw==
X-Received: by 2002:a1c:e90d:0:b0:3fb:ff34:a846 with SMTP id q13-20020a1ce90d000000b003fbff34a846mr1463983wmc.22.1689941737470;
        Fri, 21 Jul 2023 05:15:37 -0700 (PDT)
Received: from localhost.localdomain ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id l5-20020a1ced05000000b003fc02219081sm3203827wmh.33.2023.07.21.05.15.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Jul 2023 05:15:37 -0700 (PDT)
From:   Levi Yun <ppbuk5246@gmail.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, osh@joshtriplett.org, boqun.feng@gmail.com,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, qiang.zhang1211@gmail.com
Cc:     Levi Yun <ppbuk5246@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: remove unnecessary check cpu_no_qs.norm on rcu_report_qs_rdp
Date:   Fri, 21 Jul 2023 13:15:33 +0100
Message-ID: <20230721121534.44328-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wherever rcu_report_qs_rdp is called, cpu_no_qs.norm value is false.
Therefore, Remove unnecessary check in rcu_report_qs_rdp.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 kernel/rcu/tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1449cb69a0e0..d840596e9903 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1962,8 +1962,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
 	rnp = rdp->mynode;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	if (rdp->cpu_no_qs.b.norm || rdp->gp_seq != rnp->gp_seq ||
-	    rdp->gpwrap) {
+	if (rdp->gp_seq != rnp->gp_seq || rdp->gpwrap) {

 		/*
 		 * The grace period in which this quiescent state was
--
2.37.2
