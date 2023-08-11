Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E7F7793DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjHKQGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHKQGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:06:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E51AE58;
        Fri, 11 Aug 2023 09:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691769980; x=1692374780; i=deller@gmx.de;
 bh=bM/lxnNu93m6Yx0W4MNwa1wlMBa9CKt9oNj9d9WdiMU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=DB/k8079UF6IJPmJiOv7LCySVPuyAtSZty4jVagS3n6XurZ17SKGoaBZMrjxnZHhpst6+9k
 5tRahp4Z3UBTiOWKX+Tc1PQ1ACve075dQScNN3WUnRPMLnJbPyIXeFKZR/TkSkjs3z7HFcATp
 VQwHhSJ5sMCsRw4SDngebkUKylrVR5n51aR3LnSB9ZlpoyaSFDMhLZbr3/A11YMqwXfn8I6up
 zaoYXSpvEwFXdpJqy5IHi1nIOtWDt1fTFORAMZXGt98a2zqbAa/gntiAsRXixSqAZpHorCf9i
 xQGTvvlPhF5fgq3j6xbYazZRLae2c3u3aI2p/RtwGAUqku6pHHvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.154.87]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ygz-1qWPf52wDD-0032vD; Fri, 11
 Aug 2023 18:06:20 +0200
Date:   Fri, 11 Aug 2023 18:06:19 +0200
From:   Helge Deller <deller@gmx.de>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: [PATCH] mm: Add lockdep annotation to pgdat_init_all_done_comp
 completer
Message-ID: <ZNZce1KGxP1dxpTN@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:MqD9tjnHfgm1cT35TMquLYoF0rtz68dGu4LVqCJ6Ts7lXGdq3mH
 iwboquz5neAbw11Nuv26zG9hwiyhqMgVopgeoLs2UPPDz/U8Rl+WBarNGwPEX7ZeKiv3MAE
 VouUDbr5482Ugnj4sXCpsGu36V8vseEPpmctPg7ie1ZJ616I2PW8aGTB0wM4CMsty7VCjzk
 8fzZlZCjdvXQUNh+e5A+w==
UI-OutboundReport: notjunk:1;M01:P0:KubA4rTKNXk=;VPc061pTwBvEjwtoI6BYpjeuJAZ
 EiRxYs8QaJ4H/sNSzLbR9fCmwQJyy1iqO6eHvbQC0vPiWEuc+ewLrtOtAWgFICqepco1cy9U4
 Z+g0F9fQCzCWdep4lQzJpri6+BHkuzPEhV8dHTPgrOIx0OJWALeTWAKcbV+yLQLeKAIfppiHp
 dzyjmXkWL7guHQ5dr5KCxljKcTWwjDhVcfrac/7lnqCL4l8KBq+x2P7bgUu8eaJtZJltPiQ8t
 0gwI6S10DqzHN6VrpkKY6GutpVda89o8qI8upplT6500ZnF/uzgyLM51dcURebWcGrOrxL9/k
 Ufojztl8cMngJUy2VDQEL+4oc5+zWW4e45bhWm++Ugc40eTsVEMXGXwBAfSFpbYuDYynKl21p
 rACWbGoWYYbe7Mzf8hXL1zrGKnVmkwHhcv5OoCaYhSnKmTA9UyjEF4ErmMssYSp46SPmEHdND
 BhEW+Zt9MTHe19Umn0ZORLEIE4nCLvDL+1IbzXJkAUtPVN5qltfbfJxJoKsQmyrrLCT2KNwf9
 bgqvoU+3lTpENu2ATwJbCRz/JOlKyhcZAgsukJ4vmNs6sKh7Abp96jU7JOHzg1Uy92ElwWczQ
 M36cqnqHJ0Uq+sY1YWFBucFLk9/Oz9fp0pO0uqulNesv+G5dBH6jAHh+hh6UCS65DaAfwIOW8
 jcPyzLodUZ0jHQTrK3+VSSMn7ddt4/dbkcFqKhnps2pogj4enfvZr2D7d8v6wr2iriLAFkm7Q
 q2e19ZRvqB0yANSoMsw8WAGiIUTM8EZBXVUZEloSTVc/XHXB1b7CQkURaYWuat2oW4B1s+vl6
 VVGKFC/LNzBnR/hhOmDm56VOWhvqOxnk22O72R6TYxWhHmg8r7mK2JY4Qc/1KulUvTZJGzHfD
 TCh+5EgLhBuUsePJ3IdJQxO0LozL0t24+9Ns9CE9W3T+Df6zTDTJnfsqn9l5iOdF/7UmXXuyP
 NUsjcJw35Rc1YCd/JqDRzCbYt4A=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing lockdep annotation to avoid this kernel warning:

 smp: Brought up 1 node, 1 CPU
 INFO: trying to register non-static key.
 The code is fine but needs lockdep annotation, or maybe
 you didn't initialize this object before use?'
 turning off the locking correctness validator.
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc5+ #683
 Hardware name: 9000/785/C3700
 Backtrace:
  [<000000004030bcd0>] show_stack+0x74/0xb0
  [<000000004146c63c>] dump_stack_lvl+0x104/0x180
  [<000000004146c6ec>] dump_stack+0x34/0x48
  [<000000004040e5b4>] register_lock_class+0xd24/0xd30
  [<000000004040c21c>] __lock_acquire.isra.0+0xb4/0xac8
  [<000000004040cd60>] lock_acquire+0x130/0x298
  [<000000004147095c>] _raw_spin_lock_irq+0x60/0xb8
  [<0000000041474a4c>] wait_for_completion+0xa0/0x2d0
  [<000000004012bf04>] page_alloc_init_late+0xf8/0x2b0
  [<0000000040102b20>] kernel_init_freeable+0x464/0x7f0
  [<000000004146df68>] kernel_init+0x64/0x3a8
  [<0000000040302020>] ret_from_kernel_thread+0x20/0x28

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/mm/mm_init.c b/mm/mm_init.c
index a1963c3322af..b390b4b27dad 100644
=2D-- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2377,6 +2377,7 @@ void __init page_alloc_init_late(void)
 	int nid;

 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+	init_completion(&pgdat_init_all_done_comp);

 	/* There will be num_node_state(N_MEMORY) threads */
 	atomic_set(&pgdat_init_n_undone, num_node_state(N_MEMORY));
