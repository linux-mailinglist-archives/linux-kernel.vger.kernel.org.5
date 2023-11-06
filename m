Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E597E182F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 01:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjKFAmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 19:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFAmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 19:42:06 -0500
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EF0CC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 16:42:03 -0800 (PST)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-58794776af4so1902641eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 16:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699231323; x=1699836123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgDDeMN+iVSrZlQe0l9CVUCWL87FnwRocMxoE2UWBjY=;
        b=T9v3fZC/Ktelm8sNSTxCH5whXHd+JfTzs4c2lT12vU7zHMAGS7XHdfslqLDnHetgOA
         9nL8pxZ3YSswwcpfMOsd8m9qx33ls7OckVZcsuXXBeAKLgvZqbYnN/4YcqSJt0tT2mpt
         /hBicodbqtFD8y+JBODIAD784xMlny1Pg5/KD2ii2a+uF9iDRfJXSuUpKsRzccajqRQS
         ToWfTqXixUbMFij5tZy8ghePEMRYkKOid7zlZOktyDGwghbxHz37NfOTEcrvrakaFCrS
         wvuQ78V2NHQVmjbpOpqHcG7tmgOyi6PdCqsEHdBUxjM+aHHcsO+zzSVBVViOySEWDrrE
         8lbg==
X-Gm-Message-State: AOJu0Yxgyik+8+NeloCCwRYaCn+JW7wixpnNjPsdEElZylIRyDVj2teA
        pz2q7aQrXU8V4/4PhpTeb7hZT5+QJXY1Ef0Wai+whf7PtO1TNWY=
X-Google-Smtp-Source: AGHT+IGo/9AmKs3qsobCdINCZ6a9EfretX0UOOLHHokJfe8tWtdrBkB/ZVhjwSeFEFR69UJjQg5cZhdIGq+r0Z8sV0b1Jhgt+Iy1
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d183:b0:1e9:b451:bae6 with SMTP id
 a3-20020a056870d18300b001e9b451bae6mr13812615oac.1.1699231323211; Sun, 05 Nov
 2023 16:42:03 -0800 (PST)
Date:   Sun, 05 Nov 2023 16:42:03 -0800
In-Reply-To: <DB3PR10MB6835DAA3622E958256A1B2BDE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000694e240609711fad@google.com>
Subject: Re: [syzbot] [net?] general protection fault in ptp_ioctl
From:   syzbot <syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com

Tested on:

commit:         77fa2fbe Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16ba847b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ffa1cec3b40f3ce
dashboard link: https://syzkaller.appspot.com/bug?extid=8a78ecea7ac1a2ea26e5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15841787680000

Note: testing is done by a robot and is best-effort only.
