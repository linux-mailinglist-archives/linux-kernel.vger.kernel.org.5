Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02B07CF796
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345478AbjJSLzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjJSLzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:55:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD76132;
        Thu, 19 Oct 2023 04:55:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A7EC433CA;
        Thu, 19 Oct 2023 11:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697716507;
        bh=RqzxDVJIn6SaPlB+MPCpu60PL8TAZpKyGGU/oT7X828=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+ZhNOxMvLIpscISoIBjI/R3TAf3zXOb07KrqDOnbeBw7Qog//OdwXtuLObNhsUol
         HFYz49iYHuV+dByD4W9XbS7I7ra8Z1za4Y6+dXdrAUdY/kCs1Ea60my5w7nv7a2aC8
         Z/estc3DFEAXn3dFoDdUlCaJfgS5SPttnmfWw2+rPsQjXlDhVt3bY4GxrMbil/er4j
         lS0Aru9X9BG88QrRHrCtglgjkMrpk55OFwlNrvgLwmdvgGQ2/FVjojM+QNpISSsvLS
         8polyEJbar564igIzNLVMwVIcDcTGtSu4+WsDaLzisi30P8YT67TTWql9kCNqBILPc
         fuFRZN0B0NeFg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 3/3] doc: Add refscale.lookup_instances to kernel-parameters.txt
Date:   Thu, 19 Oct 2023 13:54:52 +0200
Message-Id: <20231019115452.1215974-4-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019115452.1215974-1-frederic@kernel.org>
References: <20231019115452.1215974-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds refscale.lookup_instances to kernel-parameters.txt.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..cf4f3262ce31 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5422,6 +5422,12 @@
 			test until boot completes in order to avoid
 			interference.
 
+	refscale.lookup_instances= [KNL]
+			Number of data elements to use for the forms of
+			SLAB_TYPESAFE_BY_RCU testing.  A negative number
+			is negated and multiplied by nr_cpu_ids, while
+			zero specifies nr_cpu_ids.
+
 	refscale.loops= [KNL]
 			Set the number of loops over the synchronization
 			primitive under test.  Increasing this number
-- 
2.34.1

