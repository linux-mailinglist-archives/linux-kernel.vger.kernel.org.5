Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D926E808B8E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443282AbjLGPN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjLGPN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:13:57 -0500
X-Greylist: delayed 605 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Dec 2023 07:14:03 PST
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D371D54;
        Thu,  7 Dec 2023 07:14:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44D5FE1A06;
        Thu,  7 Dec 2023 15:58:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1701961101; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=AKSiP3OsX4Hs2dJd6uAz8w7V1S9HQFgrRDQK5AO7PKE=;
        b=idsvjSmYdOIiXWH13f6Nu1MC0gH3A8QlkW9xyx1Gb6B6LrhS+3i8SDsunQP/TY5Tpb6KGL
        acTd+r4zxCgXpQR1WAddgGvtI9r7OZ4WEbbHYO0hBqB8a1z5a1im8hPZ3DvwPfwPmv8WGo
        i2r8qZyPr4fns3rOZBhrEiGQIwjg5c6/FzPd/ma80Y+VmMAHPGXFsjl0UkxT7xtdwlBoxN
        9wEVS+1mYcwZBYCy3ukc/XAM+xdRtAQkzKg46JD4oKuN036E90SmnR4Vl17iQ4K8MCl4V7
        WLKf97+nHDjlyuOvSXOsAGa1Mp8ogxJnmM6S1YLe4FI82lqkHso2/WzT5S3DRQ==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>, <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/2] Linux v4.19.299-rt130-rc1
Date:   Thu,  7 Dec 2023 15:58:13 +0100
Message-ID: <20231207145815.30461-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.299-rt130-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2023-12-14.

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.295-rt129:


Daniel Wagner (2):
  Revert "sched/rt: Provide migrate_disable/enable() inlines"
  Linux 4.19.299-rt130

 include/linux/preempt.h | 30 ------------------------------
 localversion-rt         |  2 +-
 2 files changed, 1 insertion(+), 31 deletions(-)

-- 
2.42.0

