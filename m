Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6DD7F3ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjKVAnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKVAnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:43:09 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38237198
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:43:06 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c203dd04a3so4482577a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700613785; x=1701218585;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBNtI+AGcsr8WlhJ0Bd5/4BtcfgBDU3IYU3vhda5aRM=;
        b=Trcc9BUsquACAvdij5W5MFhllajeNiyXHlLE//erQy6cNhcruIM0j5EzpHbewVocEV
         7EmqQOnMhEvKfT5HCqFkHKmaW38wz0vHowcV+AT8Dz1o9Cgd8zdk++39Kv8Tn4t41W1m
         VCBSTz2nokXFuUEt9LthNgZQqKAz1bAVkuRCgkr49FAt4chuQujpJ8KpYb7RkHZWVTil
         tODlblSypEJAsCU/Xp/qdJrCrQkKr3BUIRRCrX1ArG4RNTyQT4Qwxy361lNMGZ8mh3jP
         BvQKZB6oHmOxNkecX/YnWRsB/M5Mb16Ak7oMJL1NWaGxY/KobkJufMmhCnRU/VG7310d
         4UBQ==
X-Gm-Message-State: AOJu0YyA1sZQJGkmczbi7mU0So7VvreFOKLsg6sXscoURO9toQr68VLM
        eXfJVGRAtfQ936+cK5vDe9yAkbo43/o4JxRdoeVXu7UnQLxJ
X-Google-Smtp-Source: AGHT+IFi0yMZ/5N/bFjEd+J31AKUZginZooj8nWYgl5dLn6G9KCpmbCW2ZYlePNXHcPAa6SyjPeHoISrDQFSjRLIItsPAFzVLVUc
MIME-Version: 1.0
X-Received: by 2002:a63:190a:0:b0:5bd:64f8:ca66 with SMTP id
 z10-20020a63190a000000b005bd64f8ca66mr146664pgl.1.1700613785556; Tue, 21 Nov
 2023 16:43:05 -0800 (PST)
Date:   Tue, 21 Nov 2023 16:43:05 -0800
In-Reply-To: <tencent_8D86D7136FA361C960A3B7E4471779F77E05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000969ca4060ab3000f@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] WARNING in format_decode (3)
From:   syzbot <syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com

Tested on:

commit:         76df934c MAINTAINERS: Add netdev subsystem profile link
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=166ceb14e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84217b7fc4acdc59
dashboard link: https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ee2b48e80000

Note: testing is done by a robot and is best-effort only.
