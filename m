Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06C77EED75
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjKQIUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjKQIUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:20:10 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C918131
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:20:07 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-280152bfd40so2079071a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700209207; x=1700814007;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GBJuMmbnu/8E686XEJesyf3DiqL3QHoO7CT+bcvUhU=;
        b=u0UTOA97hwJCe5xtzOiK2GsqVrNScTiDMaZK1ONZKK99vU8pz9gnQFl1gAGWYLZQoA
         +Lak1E/cgZPSCcKpgtXXykppRdgipVAKI3BZdkPLQmCpnE/V0NMQcOcgPJtQ42RXIsl+
         vZtSZQ9HOJsLmDIIRaMM+6onJVUEcD1uMm5CQNmZUB4SbRDf6zOYz4z6e4HrlqYTBVJw
         0QXD4pOZthN6YWgGVXlbLWeoe+mdhrOSqKSDK7CgCJwNkAUWOx8gBR0XiYZi26EYI+ws
         LJWuCKkVWtqHhdBRYeKOqJwXWQjCtCn4kUZ0XiKO8HHqWJ3qcLEjPIM+XktS6/s2pvzb
         V9DA==
X-Gm-Message-State: AOJu0YzvORFehZ2L1Mu+/d25OsiGEqpAkfgcIdAn/hp3d6Tq7f18utPG
        bZ0YFResLlQiwkhLgjvFL7vCfY5GOyg/Rm6F5CDZEZPF7wzmuDw=
X-Google-Smtp-Source: AGHT+IH2TvVhSHBiOLEAdQKbnXZq8KDCiZXdkKBAVPpJbABQdZO+VyCoJi4PbdfyeKdL1O2CiwJuYbD7w1VGvQtIEb5UD214U9E6
MIME-Version: 1.0
X-Received: by 2002:a17:90a:1544:b0:27d:1cfb:7185 with SMTP id
 y4-20020a17090a154400b0027d1cfb7185mr4931081pja.9.1700209207000; Fri, 17 Nov
 2023 00:20:07 -0800 (PST)
Date:   Fri, 17 Nov 2023 00:20:06 -0800
In-Reply-To: <20231117073947.15672-1-tintinm2017@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3cafa060a54cdf2@google.com>
Subject: Re: [syzbot] [dri?] WARNING in drm_gem_object_handle_put_unlocked
From:   syzbot <syzbot+ef3256a360c02207a4cb@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tintinm2017@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ef3256a360c02207a4cb@syzkaller.appspotmail.com

Tested on:

commit:         7475e51b Merge tag 'net-6.7-rc2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1437b648e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54e2bd738b08eef2
dashboard link: https://syzkaller.appspot.com/bug?extid=ef3256a360c02207a4cb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16de89b8e80000

Note: testing is done by a robot and is best-effort only.
