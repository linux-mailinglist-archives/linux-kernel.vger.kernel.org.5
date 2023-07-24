Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5012176001E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGXT4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGXT4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:56:35 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3EA171B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:56:34 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1ad17b9fcd8so8453584fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690228593; x=1690833393;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bqy++k90y41wMJfzlow3b+lCJ8ynuiD7DIqIylcfRDo=;
        b=Wde2ebJZ4VjOSXgSzyZwLwVHu+itXbzX2rJsoVrXWRr8bIlQhQKnspY30wZcrPChm0
         n2/3Hc14J10/PeZT9fKykOyfk5kWibTCW/XU4oPesUpP+2CeneNXctZldnzxMGNcgI+6
         EY0/wzav/XKcalpiIDWtcNRgkIyhco2la4TyZvp6iZ1JwWiWH1sJlbpzpfS6y4NLP2Ll
         DNpxffAssP3QoRh5qkwqLhnKtTPOgXMuMWL9Ow1jPrXro2w2+TsBxDrXT5oequdRY5nz
         8jUEn4S2yzkbEQI1vQlE9ODmeKNaDGMy/eS5oSYhZ3gUsT3R7rn8bvoXkXhzKK3kbiDt
         bwhw==
X-Gm-Message-State: ABy/qLYqQe7ZP6UUUNZqccSpvpv8bcQ7HjOiB3+ci2sIQVAgBHMg+cAK
        mHz/a0+L/dO171A6woianFBdA4MNWnDIBPDiRcJTdCkbF1PR
X-Google-Smtp-Source: APBJJlHlWs+LFB7k3NIuMhWUm8QZfovlY8FvMe8cw31aYRNPGdP4kGfjP2cedYFiR+mvcbKKTWKUqWkzzDN0Hlb3tS+kAExpxT+o
MIME-Version: 1.0
X-Received: by 2002:a05:6870:76b3:b0:1bb:4279:4be9 with SMTP id
 dx51-20020a05687076b300b001bb42794be9mr7995398oab.3.1690228593707; Mon, 24
 Jul 2023 12:56:33 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:56:33 -0700
In-Reply-To: <ZL7U/V3SFaJndkhW@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ead1d006014102dc@google.com>
Subject: Re: [syzbot] [modules?] general protection fault in sys_finit_module
From:   syzbot <syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 910e230d5f1bb72c54532e94fbb1705095c7bab6: failed to run ["git" "checkout" "910e230d5f1bb72c54532e94fbb1705095c7bab6"]: exit status 128
fatal: reference is not a tree: 910e230d5f1bb72c54532e94fbb1705095c7bab6



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6
dashboard link: https://syzkaller.appspot.com/bug?extid=9e4e94a2689427009d35
compiler:       

Note: no patches were applied.
