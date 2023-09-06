Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE18179445C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244298AbjIFUPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244328AbjIFUPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:15:41 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B46919A3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 13:15:36 -0700 (PDT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1c08a15fcf4so2826415ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 13:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694031336; x=1694636136;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxDBXq2Hpi20uQA2zG7inaC3KCzJVkcqHST+pWxvYVQ=;
        b=kAqniBSUfvICRft5i6ikz8ZHhHrHGVAx5cyKz52UVZTOKE5mEj84rj2+MKnSXSllfr
         iFZZ/tRzgHLoRm5tdxRwkefqGp2UjfI55Ob7ZygysY3KpOP/GycDri7xAbiB9uM5Hce6
         QYlKMAlJ+dhelkHG8ar1cDLgKwOUXxaVCd4HtspSJ8Tw/0qE6dKt0RkgPq48OtFltUZs
         YxR/58dPKnXIOp7d8i6yKP+gM+7A3S60V6VFQaimgPOATN1q+X4vEntIJA4RbtnNoehp
         pTGYTd1/ycC8X60UWA6pnSoeTOjGBgmWSIOZyXg8A7H8KfrYzfhLJwP0aMothxqKD4Ja
         1OhA==
X-Gm-Message-State: AOJu0YyPtcN+Zon6nIUuapSx61hawipVw20x/IrTZ3dE+apJxfJwz/OE
        /U1E7R6Ih1OzSPeScCoYN5no0NwC5CEScCCGPfSYME1Vlqiu
X-Google-Smtp-Source: AGHT+IFb6rUEdQUN7SqM06NHZJ/LDR5wo8XSqjHoU5vk+Gma6rHsvmN8ZJ5bHAsALnfeAH/3v4Z0MsorVdzec69CfvMQrsAZPYs0
MIME-Version: 1.0
X-Received: by 2002:a17:902:e850:b0:1bd:dcdf:6179 with SMTP id
 t16-20020a170902e85000b001bddcdf6179mr5728151plg.2.1694031336018; Wed, 06 Sep
 2023 13:15:36 -0700 (PDT)
Date:   Wed, 06 Sep 2023 13:15:35 -0700
In-Reply-To: <20230906124846.5679-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000598e50604b668a1@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_conn_del
From:   syzbot <syzbot+6b9277cad941daf126a2@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6b9277cad941daf126a2@syzkaller.appspotmail.com

Tested on:

commit:         bd6c11bc Merge tag 'net-next-6.6' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1325c2c8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11989808680000

Note: testing is done by a robot and is best-effort only.
