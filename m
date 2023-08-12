Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7720F779FFD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 14:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbjHLMha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 08:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjHLMha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 08:37:30 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489F8195
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 05:37:33 -0700 (PDT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-686c1c55bbfso3442893b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 05:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691843853; x=1692448653;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fm29EsWwTl+YgJJisxUD4hqUDFNNI83dV0XeCsR9cFU=;
        b=lYLB4PZXvwbc1ABAl+5HSblThtgRe4A7lHHQsXoVt6TOIeb2IGx/WX+cjSIRSKGZPS
         /PKJ1USNseQALAIAco38RfLk7Cg9FUKB4bRcUC0fajyF4FriflDSSFrA6LfekwvLYhDU
         Lycix43sIm2aqNbyyz3JUJJptwhU/fLEM0IfsBerJ2jvmHm9qLqDAS4kfuA6HFYwHotz
         7AA2uCiLwLF99S//slnryMnjeJIaAsgEHUGCShNOd156CGjORRqgzT+LviCjgEzMgzSA
         XrikT0BvudnlrfB92GkmJUX3WniGDnjog2pvnFOXEJeOgIZZDK4boTBmbwiUnQUFCypp
         jFqg==
X-Gm-Message-State: AOJu0YyrzfZrjkoZmjol9Vy7D1z50OEcfdcaZjB1w8GSszfTcLgJcKTB
        NnVSn9Nb+me9Dbx5KEnGtnuy2wJfNp4JZQp3h31Gq/p92hRK
X-Google-Smtp-Source: AGHT+IHp+bgIoAM6YfZWF+1iNFFnhE4N3Mm6m+W5ReY9a4LtpqoV+sZrbgceAYeJVznlfJGiUrLNhCi+tPSzaleE2ZeQDB0/E3LR
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d13:b0:687:55cb:efae with SMTP id
 fa19-20020a056a002d1300b0068755cbefaemr1942622pfb.6.1691843852851; Sat, 12
 Aug 2023 05:37:32 -0700 (PDT)
Date:   Sat, 12 Aug 2023 05:37:32 -0700
In-Reply-To: <20230812114311.788-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd68da0602b91785@google.com>
Subject: Re: [syzbot] [net?] WARNING in rtnl_dellink (3)
From:   syzbot <syzbot+4b4f06495414e92701d5@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+4b4f06495414e92701d5@syzkaller.appspotmail.com

Tested on:

commit:         048c796b ipv6: adjust ndisc_is_useropt() to also retur..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15158c3da80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=4b4f06495414e92701d5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=109521c3a80000

Note: testing is done by a robot and is best-effort only.
