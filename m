Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBB879CEA4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjILKpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjILKof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:44:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1341710
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:44:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A3EC433C7;
        Tue, 12 Sep 2023 10:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694515455;
        bh=0vm0WjqY/yZ4REeQevm7E3iHIjCxHwGi/2Qo/eVjqec=;
        h=From:To:Cc:Subject:Date:From;
        b=DclXw44iTx+1iK5F+v0dCXzfoo5AoqgxCmiAO2KJ8BeFHpuVrpeqPg/Fb5PlM2jMp
         ZuW4HHNav+LH/Y/y8/oR3zR+RLJLgJFjz8Dck1d1m9uQHsECTVKLIGDgzvfz6OXxUB
         Wi6RpdtsC0XbHbwxvLqGpHzlqVo4RL//7Y3eiNddqm0s5Drv1++dbIGhwthcI2NPhp
         Ip1l4OVOC4MnxI6zG06M4nJiTfVxK+yZy8tZMJbgdhUEvqiXlTKhc9soSf0S/jwmgu
         e8d59owV1LwLWA1IM5DJjbe4+mO6N9qocWWy9gin5z98LWE3QbvRxPQQmp0H5+m5oa
         rU8PiE4oHczMQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>, vineethrp@gmail.com
Subject: [PATCH 0/5] tick/nohz: cleanups and fixes v2
Date:   Tue, 12 Sep 2023 12:44:01 +0200
Message-Id: <20230912104406.312185-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a repost of https://lore.kernel.org/all/20230714120852.23573-1-frederic@kernel.org/

Just a bunch of cleanups, comment improvements and also non critical fixes.
Changes since v1:

* s/tick_lowres_handler/tick_nohz_lowres_handler (per Joel suggestion)
  s/tick_highres_handler/tick_nohz_highres_handler

* Remove tick_nohz_idle_stop_tick_protected() (Xueshi Hu)

* Fix "NOHZ tick-stop error: local softirq work is pending, handler #02!!!"
  message

Frederic Weisbecker (4):
  tick/nohz: Rename the tick handlers to more self-explanatory names
  tick/nohz: Update obsolete comments
  tick/nohz: Don't shutdown the lowres tick from itself
  timers: Tag (hr)timer softirq as hotplug safe

Xueshi Hu (1):
  tick/nohz: remove unused tick_nohz_idle_stop_tick_protected()

 include/linux/interrupt.h |  6 ++-
 include/linux/tick.h      | 10 -----
 kernel/time/tick-sched.c  | 78 ++++++++++++++++++++++++++-------------
 3 files changed, 58 insertions(+), 36 deletions(-)

-- 
2.34.1

