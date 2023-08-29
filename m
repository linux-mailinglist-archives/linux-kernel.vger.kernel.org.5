Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D51078C51A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbjH2NWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbjH2NWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:22:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F30194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:22:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1D4C9210E3;
        Tue, 29 Aug 2023 13:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693315358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HZIcur+xewkLKW/qjIrg/ibBM/IsMy1nG6uPmP1nz7Y=;
        b=XXdzd63fUG9ulCUnDiwOdFm2QsuFqxjGaWyjUBWkZG/uy45XtmW18lYGdRrKzWVYeiynmC
        HiR0jX9eDcfGAlTqTpy33O0WgIqZRS9VyBc9l+M4Vn+bGtxRwLsruE9KhelUB2YTs0zUr9
        i9gkTssof0jUI3uVC2lbHvDVRxuXEVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693315358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HZIcur+xewkLKW/qjIrg/ibBM/IsMy1nG6uPmP1nz7Y=;
        b=FLTmrMsv7lKVprFZLRi/6BUCfVmSBcH9oFlWXQosyKmrX6z7G33Yk7qN4VOvuWXtr30EPk
        s3/EhqPgbchfXtDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E379A13301;
        Tue, 29 Aug 2023 13:22:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SmjUNh3x7WT0WQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 29 Aug 2023 13:22:37 +0000
Message-ID: <eea66c95-8b95-49b1-18f5-5bd92f73f60e@suse.cz>
Date:   Tue, 29 Aug 2023 15:22:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab updates for 6.6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest slab updates from:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.6

This happens to be a small one (due to summer I guess), and all hardening
related.

Thanks,
Vlastimil

======================================

* Randomized kmalloc caches, by GONG, Ruiqi.

  A new opt-in hardening feature to make heap spraying harder. It
  creates multiple (16) copies of kmalloc caches, reducing the
  chance of an attacker-controllable allocation site to land in
  the same slab as e.g. an allocation site with use-after-free
  vulnerability. The selection of the copy is derived from the
  allocation site address, including a per-boot random seed.

* Stronger typing for hardened freelists in SLUB, by Jann Horn

  Introduces a custom type for hardened freelist entries instead
  of "void *" as those are not directly dereferencable.
  While reviewing this, I've noticed opportunities for further
  cleanups in that code and added those on top.

----------------------------------------------------------------
GONG, Ruiqi (1):
      Randomized slab caches for kmalloc()

Jann Horn (1):
      mm/slub: refactor freelist to use custom type

Vlastimil Babka (3):
      mm/slub: remove redundant kasan_reset_tag() from freelist_ptr calculations
      mm/slub: remove freelist_dereference()
      Merge branch 'slab/for-6.6/random_kmalloc' into slab/for-next

 include/linux/percpu.h  | 12 +++++++---
 include/linux/slab.h    | 23 +++++++++++++++++---
 mm/Kconfig              | 17 +++++++++++++++
 mm/kfence/kfence_test.c |  7 ++++--
 mm/slab.c               |  2 +-
 mm/slab.h               |  2 +-
 mm/slab_common.c        | 49 ++++++++++++++++++++++++++++++++++++-----
 mm/slub.c               | 58 ++++++++++++++++++++++++++++---------------------
 8 files changed, 130 insertions(+), 40 deletions(-)
~                                                                 
