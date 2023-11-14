Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99497EB6EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjKNTiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNTit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:38:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2364A102
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 11:38:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F03C433C7;
        Tue, 14 Nov 2023 19:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699990725;
        bh=45LHKBvxRLtlehANjo+Al/s7FKl4mwViffJbKagGPlY=;
        h=From:To:Cc:Subject:Date:From;
        b=GK/fct3vyU3IRXukiPzWyvLC6TJU2yne+N1fnzydjL8y18nDioK9Oe3bPmY1SojDL
         zJbXdPif6ZvIHrCpBRarEvm4ECED+7odYD0q1KyYHWe9wuOIpb9r3S0jeu2JtjPRax
         OOMaC3usCGuLEa6KtCdLdxq66bITXUcD8NZp9qZeHTJcEssu0pdka3j950a3X54RX0
         FNXva8lsp4UPby0PWJ2F7IA9UKOnkaFtifLCsdoXe4FXRu4YjM+FByQy+zSF3UtzSp
         KEqhIxFJ2E7tAVJe+qx9KlCQUvfKzMDdFHe4gICRg7DYXhh+GSdVam8kc1MMTiFqsM
         H29lfgzM/9YYw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/2] sched/idle: Add a few cpuidle VS timers comments
Date:   Tue, 14 Nov 2023 14:38:38 -0500
Message-ID: <20231114193840.4041-1-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Those are the scheduler specific bits extracted from a previous series
([PATCH 00/10] timers/cpuidle: Fixes and cleanups).

Thanks.

Frederic Weisbecker (2):
  sched/cpuidle: Comment about timers requirements VS idle handler
  sched/timers: Explain why idle task schedules out on remote timer
    enqueue

 kernel/sched/core.c | 22 ++++++++++++++++++++++
 kernel/sched/idle.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

-- 
2.42.1

