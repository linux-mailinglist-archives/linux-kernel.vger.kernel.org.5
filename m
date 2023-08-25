Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A19787D16
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjHYBYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjHYBY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:24:27 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE5DE7D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:24:25 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c0888c175fso5569185ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692926664; x=1693531464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b93WikqS+4vnaWooWK5ySt/jG9TwR95PJARN0StjRRQ=;
        b=B0Q+SEHTL9vnTCehScwxiaAUPNHBUXtHbBRhAlWnsmcVbzLc8l4K3fRKCCZfiUI0v0
         GkaeaRLGiDT1e6mmJQ7pynjmwqKRRfmYR5ugtUg11lvCLfMz/vSRGRvicEpFIqkvQzaD
         gYr/BHHvlOxn53zG+bKou6UZBPVfIlAwYOLrLofpflWuTK46lgDJroZYxNqT0YZgDHyf
         GLKHLn2UAslzkt72sqhDN6Wlh4Ixe8dNY7aCJ1x32hGGpgaIui0jqpuVWMCfCKBTw3Xn
         mtY23X6EP97PGAtlie0IOaPx+dsivrQGDDOu85Jm3Xy4Q080uacQa5QyfYoKFZOBv4ff
         blLA==
X-Gm-Message-State: AOJu0YzxXVBAnPmlnGpzqR/ItMZpbfHLDGQX6lOe/KfUnUKTzIvDP/2H
        dgQAJt4zEBhpl28f5uY/NGfwdtVAlk+wqTQjpZchGAo4pCi6
X-Google-Smtp-Source: AGHT+IEq/WVy1JE2cKNmXFY5Gt1H059eLRy0i02jARwgMWQ5Zi4t28ZQ/f2if5Pi5iqHKoP9eFJmnhQGueycWk3asnJThNYiC88z
MIME-Version: 1.0
X-Received: by 2002:a17:903:1c7:b0:1bb:d27f:ac46 with SMTP id
 e7-20020a17090301c700b001bbd27fac46mr6751001plh.2.1692926664665; Thu, 24 Aug
 2023 18:24:24 -0700 (PDT)
Date:   Thu, 24 Aug 2023 18:24:24 -0700
In-Reply-To: <20230824233602.3108-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a71b10603b534ab@google.com>
Subject: Re: [syzbot] [dri?] kernel BUG in vmf_insert_pfn_prot (2)
From:   syzbot <syzbot+398e17b61dab22cc56bc@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+398e17b61dab22cc56bc@syzkaller.appspotmail.com

Tested on:

commit:         f8d6ff44 Merge tag 'nfsd-6.5-5' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=160a9a87a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4a882f77ed77bd
dashboard link: https://syzkaller.appspot.com/bug?extid=398e17b61dab22cc56bc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17eefce0680000

Note: testing is done by a robot and is best-effort only.
