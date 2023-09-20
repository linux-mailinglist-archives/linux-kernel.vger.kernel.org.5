Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36467A8284
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbjITNAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbjITNAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:00:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B994CA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:00:32 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695214830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MpfjV2rJpptIwzlMt8WrwhYsJ5cE2BZ6BwW5p7/lBhI=;
        b=1AfNO5qYrmo8d04g1S4tlpwsNsrn0CnCeK39rTBs+8KhrHr8RCpKUmRer4Mrz93G4tAFGx
        +67fKadYlNShlz2G9U3waY8kRzLAFDhsMQHT1zmkZY9QP4kfjuhAJ/083XTm9MPjS2GEU0
        S13k9J5xSCfOEoft4z/wiV0VHeH6ol2Tb6tQuB60WP/Vwj9DWtIurwNC/C+ytLtzonamDa
        EO2egBFzTCtA6W9up1tSEdFkQaokhabxJb9CXUgrugtHENU58ZI7fWPLUkvHaS9m8rFX56
        y9xtORboHqoe9My6HF7UuqhO9IBiSsnTbfgle9hlf++fijxET9u0rbW8DGT9lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695214830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MpfjV2rJpptIwzlMt8WrwhYsJ5cE2BZ6BwW5p7/lBhI=;
        b=lNs79iYGnu+flQfJMONKTo5ScKwXNpS6Bs9ZsRTcd4yYl7AcaDbgoZJfOIanDneQLgcJNk
        EmdzjvFbn4pyjSCQ==
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/2] sched: Small cleanups
Date:   Wed, 20 Sep 2023 15:00:23 +0200
Message-Id: <20230920130025.412071-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

#1 is follow up to
	https://lore.kernel.org/20230913090330.GC692@noisy.programming.kicks-ass.n=
et

#2 is an update to a stale commit I noticed while doing #1.

Sebastian


