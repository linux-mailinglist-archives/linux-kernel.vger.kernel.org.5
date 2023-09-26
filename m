Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52D47AF3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjIZTO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjIZTO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:14:26 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FFDDE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:14:20 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6bdcdde1df9so20304052a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695755660; x=1696360460;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9PmlP7Y5UoxMXjOGsmxEgQMBWWhN1CDILnI2HWTU3Y=;
        b=iTqVEXQnt8u+ZZWK9R+HlmazZgBF6vCc8JHjzlzNNVh4aLpd1sWzTo/GnC4/FRqPHN
         XJZ7sWeWMIdFyGF3YFeI86uFFR7IEmjaD9e4wd5RpeAUpTmDSZFYglEpDaqsBLo8OYJS
         gxC/ujFsVBIbKrBQCM9sSUrE4SFl2M+e0DjVPjnl7MEDDnBlLW3etYytt+KW0zus5wmH
         WfzX0LV57bvei6ZoXwFc7RKgvQhNeH7v8EPQtunnJN5lWC7JFSf4WULCrLFWSFP49jED
         4SwH9QVJC62q4/kITCWUwXYiyKp5NAaYlclGO20y/QvcRdtq2sTvIrCPZp5MiZPgVNwv
         P02Q==
X-Gm-Message-State: AOJu0YwMtQwtscWicQGSxLx6sl1ihZ3bye6R30Z6YNUhDPtxUKu7/1oJ
        GEy0PMOjUODirGgm35tBrfSCTOCxWSTAUZblLOUrVfFMmx3Z71c=
X-Google-Smtp-Source: AGHT+IHCle0c7PN0TBNUEdeiNereyLBhp5ZDwcCTWRfAyhvRKOxdGoC2UAZsjJDu7q4jrEOfhGbQDx8iew5md2qyoO6QdnGM+yOK
MIME-Version: 1.0
X-Received: by 2002:a9d:7d87:0:b0:6c0:a3e0:f9e9 with SMTP id
 j7-20020a9d7d87000000b006c0a3e0f9e9mr2732348otn.4.1695755660088; Tue, 26 Sep
 2023 12:14:20 -0700 (PDT)
Date:   Tue, 26 Sep 2023 12:14:20 -0700
In-Reply-To: <mrce6emi7jvmoe4fgxt7lgrgkswkinc5u3hpl57gr5oaxau55o@fdvuaqxcsgu6>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bedf08060647e102@google.com>
Subject: Re: [syzbot] [usb?] [media?] WARNING in imon_probe
From:   syzbot <syzbot+1c41b2e045dc086f58be@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        ricardo@marliere.net, sean@mess.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1c41b2e045dc086f58be@syzkaller.appspotmail.com

Tested on:

commit:         a48fa7ef Merge tag 'drm-next-2023-09-08' of git://anon..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13257bd4680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8dfc2c52f63929e
dashboard link: https://syzkaller.appspot.com/bug?extid=1c41b2e045dc086f58be
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ca18da680000

Note: testing is done by a robot and is best-effort only.
