Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47B3756E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjGQUW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjGQUW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:22:26 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7801A8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:22:25 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1ba6eca72e0so3260427fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689625344; x=1692217344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGrQ+szKoMK+EaVan75CnITnplIPv8vValzWkyBMelk=;
        b=gbhqSZbGKYghGh+RWJCGyaya166Kcrm2i21A/OsvvOtDZU+S8ptcxXERWLib74kEAS
         Zc4r+7GfB5vtrSTQlfLZzNgQCgPtFzXi9IIjHDKQ1GTGQLCF5d0EwYlIX4SeJSobk6ou
         +Tv6FQVQVtE8rQPaevrc6zY2sbWNQtfv2S+/odLRfp9rygFGoSIgSN9hRKKJ5A8Rigvy
         8A9hWSdBUX5HX8oxhEb2YUuXMZeKFHeLkneCxf0ygkSceLBS0PgVIJCEamQdw2+/VsYY
         IF5FbyWk1JiaYm7c88M0WXJFrayEsBJGCX/3eFv8BoTks8H8oKIMwuk2GGKAOjpnkhrt
         3ovQ==
X-Gm-Message-State: ABy/qLaPXnOFaE+FegUmBPRrrZ4FM3nsHaNjt35pSodgKMrPhApeMtbI
        j4x8JuVKbTUQolQlxNOECYnKmGJ+lG0oUJL4GvAbbbl+Yriq
X-Google-Smtp-Source: APBJJlH3Timn+OhaHJ/79ZumgdgzTTzyEzblDmWTxmlZfYEFG5zG9Y/2M+u7w8vJLIufO3NBE/Ht7+La67whJbsd8/rLPvXWbJRL
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5aa5:b0:1b0:60ff:b748 with SMTP id
 dt37-20020a0568705aa500b001b060ffb748mr11252238oab.3.1689625344585; Mon, 17
 Jul 2023 13:22:24 -0700 (PDT)
Date:   Mon, 17 Jul 2023 13:22:24 -0700
In-Reply-To: <00000000000049baa505e65e3939@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077b5650600b48ed0@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in hci_uart_tty_ioctl
From:   syzbot <syzbot+c19afa60d78984711078@syzkaller.appspotmail.com>
To:     davem@davemloft.net, hdanton@sina.com, jiri@nvidia.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit d772781964415c63759572b917e21c4f7ec08d9f
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Fri Jan 6 06:33:54 2023 +0000

    devlink: bump the instance index directly when iterating

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=136a0414a80000
start commit:   84368d882b96 Merge tag 'soc-fixes-6.1-3' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=24d192d47d02d9e1
dashboard link: https://syzkaller.appspot.com/bug?extid=c19afa60d78984711078
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168fc765880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1376e745880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: devlink: bump the instance index directly when iterating

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
