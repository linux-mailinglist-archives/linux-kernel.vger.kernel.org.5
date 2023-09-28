Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34807B1B3B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjI1LgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjI1LgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:36:16 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BE912A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 04:36:14 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6c626bfcd3fso3619958a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 04:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695900973; x=1696505773;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVFYUsiW8pudEMKNduuRyk9dTgtXBZVjxUM4J7GMLk8=;
        b=magE4/p8k9ABbti2JZ9jjKbti0iRTQsw/HwUELqYX8lQf40oSMfxuDpITdycN7KCwd
         ouY5W2wkKpdE+YaMfvpXnemVDZmgcsHc/+HPiZ/6ywwj4Dzxrus8BOq8UoivV7B3FY6i
         HKqXB3eVBrIIKvUW49WxZOa4pKmI5B9nlZs91NCfrDAyBLOr7fDNAF5gAroV9BhVCcuQ
         n5PplIUlKwcYjHfQSVNzxT1j8gdd+nFOZVbRZzPaM8AxaYhdunecIXYsUk2rxBN2JMuq
         zYaoHUBzs2NNlCLIFtaFgUQRBi16eVG+ngjJDHNxZmG2nMfke40Oc01tx4pQvtGzqYXm
         QL3A==
X-Gm-Message-State: AOJu0YxKGQhltEvaXq0slPjsCJNnilQKRnAtnCRL3MesAGGoB6YsUNEv
        vC1qGgA63Px92B4Z5KronrVJ+SU5n/geWUn0/OzOCTMxivej
X-Google-Smtp-Source: AGHT+IFuUN+pfXbgSG7XyYjEdTscrmxOWxfPRLyffb8dayvTfEoC0uoIUwYDGj3oN8Cy78fjOQrzXHVXSIJysxbpJXyUkYYzmEqF
MIME-Version: 1.0
X-Received: by 2002:a9d:61da:0:b0:6be:f835:6e5f with SMTP id
 h26-20020a9d61da000000b006bef8356e5fmr239884otk.6.1695900973638; Thu, 28 Sep
 2023 04:36:13 -0700 (PDT)
Date:   Thu, 28 Sep 2023 04:36:13 -0700
In-Reply-To: <20230928112020.1277-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bacdb060669b7d8@google.com>
Subject: Re: [syzbot] [pvrusb2?] KASAN: slab-use-after-free Read in pvr2_context_set_notify
From:   syzbot <syzbot+621409285c4156a009b3@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+621409285c4156a009b3@syzkaller.appspotmail.com

Tested on:

commit:         633b47cb Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=103d5e12680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acc0013b40e239a2
dashboard link: https://syzkaller.appspot.com/bug?extid=621409285c4156a009b3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14381d0a680000

Note: testing is done by a robot and is best-effort only.
