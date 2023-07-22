Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679F575D876
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 02:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGVAyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 20:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGVAyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 20:54:32 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DEB2D79
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:54:31 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a1ec37ccbbso5838258b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689987270; x=1690592070;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YU7b2jy/oiwLwvdnTnUmnOLPItVO1ca16X8B8dlSKHg=;
        b=Bzs5+7zRXQVu4eJOtcpWjyYzsQBQiCZdysNq6u9AoTjsfmeWOEEBchecejb4BhsqVQ
         eVTF4oHzDOmvNyeBwMoGcs0zqXOtu+SAXM04h47tXjlnDhloRSjIX4U/iLXAWUd2Om0x
         OvBb3wiKY+x4h4fOspUTuPxVFzYtFZ4fFiqQD8Ks/YKSvwVXWGkZAekdgy3ByxgBwkmb
         RqMhDbTYyg63/C8fQaGIFePgbbcXkrDi423cQVdexPARFrv49D3B90e+NcdUNH7JRZfy
         DZuE1cn0DHlTIv/mJ+74uMEOOWsfQKdotrb+uWbIHL50GzKrllXS+BsWwM0zc+/mpW7x
         3ewQ==
X-Gm-Message-State: ABy/qLZZmw+EFqMVpJY1fZcGU7AicBV26borE0L6kao+kVHPa1urpWZ+
        8MH5K/KG3NOvxhU9qTVIzUIup9fQGSJiztciaYz4kuQp530q
X-Google-Smtp-Source: APBJJlHa2SqoziovalSoIswyrlJ6RbhZR+Y9SPSmKxTew7I3f4Tk/Wumzw7jGjo6qm7x6Hjmm+jUzv13Y6vyEllFGmzcPECQ2U5L
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2086:b0:3a4:8884:3b71 with SMTP id
 s6-20020a056808208600b003a488843b71mr8136707oiw.11.1689987270569; Fri, 21 Jul
 2023 17:54:30 -0700 (PDT)
Date:   Fri, 21 Jul 2023 17:54:30 -0700
In-Reply-To: <20230721142839.388-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eff402060108d2e0@google.com>
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in ingress_destroy
From:   syzbot <syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com

Tested on:

commit:         03b123de tcp: tcp_enter_quickack_mode() should be static
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=143f7cd6a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32e3dcc11fd0d297
dashboard link: https://syzkaller.appspot.com/bug?extid=bdcf141f362ef83335cf
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bf3a52a80000

Note: testing is done by a robot and is best-effort only.
