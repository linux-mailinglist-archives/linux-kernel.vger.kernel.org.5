Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C44376A56C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 02:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjHAAVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 20:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjHAAVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 20:21:31 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAB119A1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 17:21:30 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-563ab574cb5so3264569a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 17:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690849290; x=1691454090;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+wox7n0HGm6/MIYHbn+fgxMoQ9mtfs5CTs8dCYiGjc=;
        b=YKTsvhZ2yK8ijk1hvQnnvPjyJrUl4x9YYQigtkgJOdxwi8e5EDHLvzyUyj2vk/YVzV
         ekiC0pO2TtKJD66SiHJZnIibf42rePRdof640KqRxj8VIzBlJzSPwl8Nv3Cf7/N3ldth
         dGMqUsC83Gp+4oqcau6yKS4sZjKLLuPF6Ar5VeXi38GKp2ChE+gXsXyVmyb3mAYFif3I
         LTM5a4ZPX5OMHhjtleUviJslPw3SL0x8d4c4d6bDV64KvtlRtwrsXi/jRI1b44l8L2S7
         +6WP4Z/eh60ZvzMSyoYaPBCZME3nj2v23uiDCoQKCCLsFq0viP/MBQqDXzccOwOjHXbc
         JtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690849290; x=1691454090;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+wox7n0HGm6/MIYHbn+fgxMoQ9mtfs5CTs8dCYiGjc=;
        b=aVqG4vrz8OAfdHezIMLGZfny3BM0t8WuTWee0gYdFmYvqU9PNpA997SwF9JBMSVBHr
         7eJhOLf0xCHgWBvte+ednP02dlkZiMZka6PIydO0sh0FTWqmGScRSv5sva471k2foV/L
         T279tv7rw+N06ARkP76d8xW775lyy8p/rRp8zb8wR0xIk7oN32b7vi8Vs8rwnNp0db1R
         6drZbTT5YFaQpzwttfJ2FzvQ9iKVzmUOrzKANVWkNgLpml6xNJdlDlxjaWlYwN98Y/lD
         yyUT5iGKu3P0brPgxeCIPrmS1YhMtXFoB1i1DAjRMaOiGHIR7HoDwE8GL71eUZUkuUBN
         75UA==
X-Gm-Message-State: ABy/qLajqGIuQsw+XOZPiFD3ygEAEtgNExh18rq7rOg0ur9Bk1nfWtDk
        eLSqoppp2tdwgVjUYLCEdzW+WZhqW67N
X-Google-Smtp-Source: APBJJlE0OuN5kF9ibnyFOkVhExXmb05tVThZCevDMYgY3YUyE3ZrbAfNXVORndtQ7keq6D5QKaDiMrGmSoTP
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a63:3e41:0:b0:563:9037:b725 with SMTP id
 l62-20020a633e41000000b005639037b725mr50244pga.3.1690849289749; Mon, 31 Jul
 2023 17:21:29 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue,  1 Aug 2023 00:21:20 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801002127.534020-1-mizhang@google.com>
Subject: [PATCH v3 0/6] Update document description for kvm_mmu_page and kvm_mmu_page_role
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>, Xu Yilun <yilun.xu@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 3rd version and I made some changes according to feedback:

v2 -> v3:
 - update the description of shadowed_translation [sean,randy].
 - update the description of ptep for tdp mmu [sean].
 - update tdp_mmu_root_count into root_count and update the description
   [sean].
 - update mmu_valid_gen with more details suggested by [sean]
 - add extra description for tdp_mmu_page [sean]

Mingwei Zhang (6):
  KVM: Documentation: Add the missing description for guest_mode in
    kvm_mmu_page_role
  KVM: Documentation: Update the field name gfns and its description in
    kvm_mmu_page
  KVM: Documentation: Add the missing description for ptep in
    kvm_mmu_page
  KVM: Documentation: Add the missing description for tdp_mmu_root_count
    into kvm_mmu_page
  KVM: Documentation: Add the missing description for mmu_valid_gen into
    kvm_mmu_page
  KVM: Documentation: Add the missing description for tdp_mmu_page into
    kvm_mmu_page

 Documentation/virt/kvm/x86/mmu.rst | 44 ++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 9 deletions(-)


base-commit: 0b210faf337314e4bc88e796218bc70c72a51209
-- 
2.41.0.585.gd2178a4bd4-goog

