Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D54753A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbjGNMJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbjGNMJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:09:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BFC212B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAC9D61D0B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82604C433C7;
        Fri, 14 Jul 2023 12:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689336539;
        bh=ueNI3t0Mv8sO9gYq/lortMTOageznrbcZc2q6B44u3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=TzSasItR7UHGVQ8cCetOx6g7JiXeMStQYKcjT/xkP6QKqg0fHijzi4DyvHfMQKwyt
         xdP8NO5QP3yEm5X0hS00Cq2l5QxpJUf+36hukZovjlw01f4taXtfXk7iyXr8uAmatc
         EcjLSDp9WjuqtidXX7sq5k56fezrKHo/osy5/bKItxPMDKYOB8qa/7AyomN5IyUNj5
         fy5A6NHTsRTywff+hA+dk75BBqy5EzilTCcloJH1gykb1PvaIRn3PVeOUXjLRRyvlC
         dYYvz44k8798Qbb7OSu0rf9ZYee0K+bLvchE/Crba7TqG8PAqxpJqC4Bn1iws8NUNc
         HxB0Cb6F06LgQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/3] tick/nohz cleanups
Date:   Fri, 14 Jul 2023 14:08:49 +0200
Message-Id: <20230714120852.23573-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
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

After a few exchanges with Joel I realized that some things in tick/nohz
are really not welcoming reviewers. Here's just a few cleanups.

Frederic Weisbecker (3):
  tick/nohz: Rename the tick handlers to more self-explanatory names
  tick/nohz: Update obsolete comments
  tick/nohz: Don't shutdown the lowres tick from itself

 kernel/time/tick-sched.c | 78 +++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 25 deletions(-)

-- 
2.34.1

