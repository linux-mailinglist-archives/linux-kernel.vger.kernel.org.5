Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EE0760104
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGXVS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGXVSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:18:25 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAABB171B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:18:23 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b9d8b76be5so9392417a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690233503; x=1690838303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fISgzzCd91Gj2U/gkz81qNRRRlc1K+b9y/Uqzybe3fQ=;
        b=K0h3yS0qMxBorQovCwe5/dgLHSRgD/DpdqH52uVQnQsQCV3Md/hJXTi3ckLug7BsAI
         YXsO2unh6HsTtRZ7zlr1cUvWxDTuEgtBAU61vQTyu9gzjjk11cZVm7xLmG/ot0WRpBiu
         i63TxqixGGg9LgDoiYsKdbpPXz5fOfIqe6t+D83Qb/Cqtdh/X7NmqH7wMQW3nW0nP0F4
         +Tp41NN5nQnJesZkvwEBWYoGS2nDSligP5q6nRBSyFInhBVb1o+8xO8t4tHiTMCTpVDn
         +MdIWDcXMpruNxV5HAS0Y2GOhpeT5wUdzcQD70UyKOgdubOX0qnACm7rZEIJe6WNqW+k
         MLSQ==
X-Gm-Message-State: ABy/qLZimhDQM8+FKyM039xboWHd/ezkuBqQRhSCShz2JxBcousbKE+8
        2xH1x4fI+zy+jdhAmy+/AymkQmA4N3eMSO0AviD+aW7iZOeD
X-Google-Smtp-Source: APBJJlHk6oTqxAMI0w9v9Q+HPlsKWKA/HtbUSkECk0SsualRSe5kQSUlByEONDF4yteCaaof/kh7pLqOuhIdzPmNrCyk5HqO1DGU
MIME-Version: 1.0
X-Received: by 2002:a9d:7488:0:b0:6b9:f343:acfd with SMTP id
 t8-20020a9d7488000000b006b9f343acfdmr9566732otk.5.1690233503160; Mon, 24 Jul
 2023 14:18:23 -0700 (PDT)
Date:   Mon, 24 Jul 2023 14:18:23 -0700
In-Reply-To: <ZL7fllo9Td1gJmHo@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b1f3e06014227e6@google.com>
Subject: Re: [syzbot] [modules?] KASAN: invalid-access Read in init_module_from_file
From:   syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com

Tested on:

commit:         910e230d samples/hw_breakpoint: Fix kernel BUG 'invali..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11e83081a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=34364e75687fa9c3
dashboard link: https://syzkaller.appspot.com/bug?extid=e3705186451a87fd93b8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
