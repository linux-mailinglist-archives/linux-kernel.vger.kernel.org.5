Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED3E77A0C1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjHLPSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHLPSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:18:24 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAB410F9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:18:27 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26b30377d94so1857345a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691853507; x=1692458307;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmNdlZ2TQRZz6Ackco4rUE3n5qM2chsNj6qTum/ZdnM=;
        b=SamTrBl5jRPiuRRUckRL1JIKd6qTwwTtIg3hJaQketVXCPDREuTqFL/8uu8+LgmBPp
         fsl6etfw5zni2rjT240MeCbS1M6N5THTAeuYcaSX/7U9NseAGis5FMxhfVZ0KNRzbHYJ
         xxL1O0l62QBU55OmxX2JInu8cpk4UQS9AmQSB2Ua6uWWcGq1BRQZ1nxDm8c/KL6W39nR
         uW6NiqQYPZLNGcOIiKIcD5O8z4/cr2eOMezspETksKjATfMsPqQvBYSHm9QceG+UmZFg
         BbFoJ1SHpvaf8s/Gu0WMNkPpW7R8TRCHC/RbVwIgPfluZWQt3scyI0cf5ack/mNqfiBZ
         pcug==
X-Gm-Message-State: AOJu0YzppjkGBIhBLZ/9otqfYdzji56KGpLeakuVVSYz1ry057P2pGQc
        jeY8plxhbrGwqDVs/8EtyoRu3+wNV3bi2LnPhpKyJbN7o0Pp
X-Google-Smtp-Source: AGHT+IGDAtJavGFKm/xFpZmWbR1JC2sNM8JYuGNVy3KlT8yRwojYSzZhvKT2Ro9uKFDun+A1h9KY8Cj6aseqtwkfqLGGuMzRctTA
MIME-Version: 1.0
X-Received: by 2002:a17:90b:10a:b0:268:9d34:ae86 with SMTP id
 p10-20020a17090b010a00b002689d34ae86mr1265850pjz.6.1691853507285; Sat, 12 Aug
 2023 08:18:27 -0700 (PDT)
Date:   Sat, 12 Aug 2023 08:18:27 -0700
In-Reply-To: <20230812143302.999-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050592b0602bb579c@google.com>
Subject: Re: [syzbot] [net?] WARNING in unregister_vlan_dev
From:   syzbot <syzbot+662f783a5cdf3add2719@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+662f783a5cdf3add2719@syzkaller.appspotmail.com

Tested on:

commit:         048c796b ipv6: adjust ndisc_is_useropt() to also retur..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=118377fda80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=662f783a5cdf3add2719
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=165f1d63a80000

Note: testing is done by a robot and is best-effort only.
