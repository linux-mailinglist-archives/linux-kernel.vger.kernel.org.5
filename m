Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963ED752C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 23:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjGMVrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 17:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjGMVrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 17:47:37 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E9A1FD8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 14:47:36 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a3df1e1f38so2059314b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 14:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689284855; x=1691876855;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUG8RKD0pfrG2394ON25fkHyWSD9eo4LkpOPF3F2CCs=;
        b=VO6Pc2oXPDCo1gDa/3SAwSE3V76hm8fmeJYx8CREOr//GfBm69IjRIz2Vd/evUszsF
         NX1Msn21qkxprsV2L8slv2Fyplb1Fu6plUc//pjAv0iYvhsnubdrlt0HGdNxre/hwz7E
         v5lq6rpMFC14HyVL0mxOHxVJQ93WMCclwf3UY346Gt9OHByNrYzdkZcf6kDF9d77ear6
         I/PBp9pbNHiQj3vLv4cEyJJUP3Jg+15q1aod/0bueEnu6mNgAlzB8H4ouXXyFhiyoFlp
         kSR72pgeZYqlJXxqrcIyIqxxPS3EaKtDIbZXmrkN95Bvps/gO8L9ofuauWY2WZkzlHc/
         6rnQ==
X-Gm-Message-State: ABy/qLbQJb1CyIh9QQ9fS7YQgr8CwoSM7IQvgOBGK9xKxAsO1HxJ4a6I
        H3CPqFOO0TniTi78nzeD3vRYKFzaVxd9s+WismFc2/EgdXfV
X-Google-Smtp-Source: APBJJlGoKW4zDGN2PvlsuktwYSqHm10JrHpVzazG0QH2nNwFSt1OcvwTZuQ5Nuj4JGXZ1da1F/RXi2zeYqC0EbyD4QYj/9abyOQC
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1810:b0:3a1:f1ce:10e2 with SMTP id
 bh16-20020a056808181000b003a1f1ce10e2mr3841051oib.0.1689284855603; Thu, 13
 Jul 2023 14:47:35 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:47:35 -0700
In-Reply-To: <b85911af-b7e1-0ef4-b102-1bc9c602a936@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be2656060065470a@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: use-after-free Read in bcmp
From:   syzbot <syzbot+53ce40c8c0322c06aea5@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+53ce40c8c0322c06aea5@syzkaller.appspotmail.com

Tested on:

commit:         eb26cbb1 Merge tag 'platform-drivers-x86-v6.5-2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119e1bd4a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d0f369ef5fb88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=53ce40c8c0322c06aea5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1405dac4a80000

Note: testing is done by a robot and is best-effort only.
