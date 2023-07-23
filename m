Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE2275DF84
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 02:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGWAql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 20:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWAqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 20:46:39 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA981BD3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 17:46:38 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1b0812d43a0so5968146fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 17:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690073197; x=1690677997;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grODwHE+scxzQkeLpWQAf0wsTshAQ0G4fhShNxUTEfE=;
        b=FWTCbO2amufR0cgB8I3D5aDxytYn8uE9nDkW/XyesawjdUvKWJfVgrFUJQ8/Z82mT9
         mXFjYucD1+hgXL9Lbhx+2S1GGPnMjhdQlRhEw3RfhstUxUk0AXqBER6kQjADivV5hzq/
         MNZyqhecwMOo7/cCjNeUuSIoWsJQenAIyRAKg8V95UbjKuU2RX1KAuebU7e5AE6eaWqU
         f25unPISDPL/YadomDrQFDplTe3B5NkIxhQN4V5SihK43/BBQqenAR+1VAjfplDO8FlJ
         53J/AKEe5B91VQcssXlHgFpnzA5sFXaCA2QYgimkkx+nQ7cAu3qBdusSUDj6Lm/+bSfa
         Lo+Q==
X-Gm-Message-State: ABy/qLasqyOkgDYpNcfx+Php3EYKHoAlk/YQQvWmXw85oWosrppqJgjO
        U39SRP8sEEWoE7ejEBLZbII9c0mdepDQXmwOv9P4hmraDNu+
X-Google-Smtp-Source: APBJJlGYctoRFxJ3j3p0cGmnmo361f80ffu2556xHJnMepSFLmkuBWyJgLwXyOXapSXvlGPsStjAp5qnVGwcHIgaHkmq/Qem5dL7
MIME-Version: 1.0
X-Received: by 2002:a05:6870:7988:b0:1b0:5d42:a889 with SMTP id
 he8-20020a056870798800b001b05d42a889mr10617227oab.4.1690073197431; Sat, 22
 Jul 2023 17:46:37 -0700 (PDT)
Date:   Sat, 22 Jul 2023 17:46:37 -0700
In-Reply-To: <20230723001457.979-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093cf5a06011cd432@google.com>
Subject: Re: [syzbot] [serial?] general protection fault in serial8250_tx_chars
From:   syzbot <syzbot+837b8c9032c053262db8@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+837b8c9032c053262db8@syzkaller.appspotmail.com

Tested on:

commit:         d192f538 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=123825e6a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=837b8c9032c053262db8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e80b9aa80000

Note: testing is done by a robot and is best-effort only.
