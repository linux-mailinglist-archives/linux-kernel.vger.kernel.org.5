Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDCC7E506D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjKHGqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHGqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:46:07 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25779185
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:46:05 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1e9c315a081so540937fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 22:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699425964; x=1700030764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NoCryi7cjZzZ/DlhjWuAtm3yrhBlPFstxR5DdUlAwYk=;
        b=I5RLCcWWC2qQ3ZL6cNocr4J1HiLjCjz2ppa20Jsalr+qDfSI8Ewwr/IJM8sEkO6awx
         fKWSyUxeOZftVpb2Vu8R50RwXzITMPf4IUXjaHUmOi+zNhZlh9eNwXbypLKM07CUamTw
         eK/D9OsQMzvUKB19XSvItX13SVEWp/q02q9B2FzvA5K/3USnzJqOqbH69HBwldE9I2Yl
         r3efGeKGUaSE55ajuQicFffxkA2hPl7u2/ycqSzGJVhWFmGLDyHOnTkR3WUmryMYmRR9
         Otx+2NCZ2cQ4az/lOfGNkRRtOEPplzCjJdiXUiRdQCzCBTcW2IzgHjFDcEGRIGAMGSaP
         J1rg==
X-Gm-Message-State: AOJu0YygbhVfAwRUt5Rn4XqDl6Xmv6egAObuDzdpfayGODBGlSi5GFhX
        PFb1t6KsG7OAHpSRJt8gq4IJkmEcMfVDZg0pXBh8nRIcHKcB
X-Google-Smtp-Source: AGHT+IGAhZZyxTqvCCKmeUatOBwbnU8fMYjwaNZNXTxq2B4xh5FS4SojDM0nylW7ZOb6/gxDmvnIEfJ/4tipXURQi/P3hIZn7QPD
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1e84:b0:1dd:69a:665d with SMTP id
 pb4-20020a0568701e8400b001dd069a665dmr2239280oab.3.1699425964564; Tue, 07 Nov
 2023 22:46:04 -0800 (PST)
Date:   Tue, 07 Nov 2023 22:46:04 -0800
In-Reply-To: <tencent_E23E9622360A4AE4747176DF66203CBD3609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0db9606099e70a1@google.com>
Subject: Re: [syzbot] [block?] WARNING in blk_mq_start_request
From:   syzbot <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com

Tested on:

commit:         4652b8e4 Merge tag '6.7-rc-ksmbd-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14ca647b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5316ad879647e3c5
dashboard link: https://syzkaller.appspot.com/bug?extid=fcc47ba2476570cbbeb0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=126f8204e80000

Note: testing is done by a robot and is best-effort only.
