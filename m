Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269F3756BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjGQSYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGQSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42C910CC;
        Mon, 17 Jul 2023 11:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AE39611F1;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E639C433CC;
        Mon, 17 Jul 2023 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618219;
        bh=Rx3IagpFD1K12Wi7aJatBEkFkuZtRKx02tROUR4AjB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SH9a7G9eLKs+onDjXxQoux1UkS3RP2QU42yjP05U2RSvJs58WIQO6FJkRccn5ZnNh
         wMex8yEUhH0OdQfrvXxUCFIPBz/cEuCjdSRWHcWRKBJt/g3FUss4WV4wOdkceDJak4
         yh/feEWTpXPtzoDXXE13gHd5+USiQnOmK2ktoWnA4U+uCIfpmvclp7dR/06ZHWNn+R
         i6b1pm9EGHmvxQMjdarivd72NHHEuJNqs4clF+IPY0pVbtUvl1jCJLESd5OgEWwSMN
         OdS2WbdWxeGcLoAV3TK4ybFkGSbx1GY2a9AmW8gVrOmbIpwNWvTjl/C9HVQ9s15KM0
         V5TedLT0MUQ0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2762BCE0836; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/18] rcutorture: Remove contradictory Kconfig constraint
Date:   Mon, 17 Jul 2023 11:23:23 -0700
Message-Id: <20230717182337.1098991-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
References: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TASKS03 scenario specifies both CONFIG_RCU_EXPERT=y and
removes #CHECK#CONFIG_RCU_EXPERT=n in order to be consistent with
CONFIG_RCU_EXPERT=y prerequisites.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TASKS03 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS03 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS03
index dea26c568678..2ef2fb69c360 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS03
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS03
@@ -6,6 +6,5 @@ CONFIG_PREEMPT=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=n
 CONFIG_NO_HZ_FULL=y
-#CHECK#CONFIG_RCU_EXPERT=n
 CONFIG_TASKS_RCU=y
 CONFIG_RCU_EXPERT=y
-- 
2.40.1

