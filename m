Return-Path: <linux-kernel+bounces-1790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 122B48153F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB261F237E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D4A18ED1;
	Fri, 15 Dec 2023 22:47:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F069C495ED
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b42af63967so126059539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702680425; x=1703285225;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZWZIC0FcoRkbciVDc3BkoS0NaydfXxlAVCYnHQk9q8=;
        b=DhjxwcEup1AK8EHfyG9rqbC7kVzgz1aznE4FUCi98nbYuxhHg7vrCMm5dwxrjwUjla
         cxpqTHFGxy9A4abkkcTL+7iUKEhnA8IDcuuAQLKRWTQ2lgyLZ3P6kTAM6oqWdz6qXegO
         U471O0mpUdflsVL4VScshcvD6lAVBB97mUwCqM3M747y2/rLRV84W8UsU65njrqyHt+j
         IG5+1vuz8CoGU7vk1+n8mrpVlGQ+yD1QYZOydmDame3IN6lCql938ujDxu6DhWT/sLXD
         z9NDX/iJ8daztVFvmDh3VFBzGXvf6k1h41LuD+KEwfPRa/rw7+YJu/wPx/kFylCvqoDd
         NmqQ==
X-Gm-Message-State: AOJu0YyqoKiGGNvsNkvW1De88ZGYi+qlRqUn9spPWBrXZR2nTpyQId9q
	0AIImvB1aJ3+Kp4C1/fnvmubyRllzG8gcovlxZbBN+5yLcH7
X-Google-Smtp-Source: AGHT+IF8ErutNgm2nKhcrvQd7qgl08tqQHShioYvHK7Pd5JAJTH0sNsgSRlj4dNZ0AM1OqNEzWqPQyh46GhmMkdI3CGKRcnOKdrv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a3:b0:466:63f4:c6f8 with SMTP id
 w35-20020a05663837a300b0046663f4c6f8mr380739jal.1.1702680425250; Fri, 15 Dec
 2023 14:47:05 -0800 (PST)
Date: Fri, 15 Dec 2023 14:47:05 -0800
In-Reply-To: <00000000000011da7605ffa4d289@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9c652060c942d35@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_cmd_sync_submit
From: syzbot <syzbot+e7be5be00de0c3c2d782@syzkaller.appspotmail.com>
To: atul.droid@gmail.com, davem@davemloft.net, edumazet@google.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	rauji.raut@gmail.com, syzkaller-bugs@googlegroups.com, yinghsu@chromium.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit c7eaf80bfb0c8cef852cce9501b95dd5a6bddcb9
Author: Ying Hsu <yinghsu@chromium.org>
Date:   Mon Sep 4 14:11:51 2023 +0000

    Bluetooth: Fix hci_link_tx_to RCU lock usage

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16dbe571e80000
start commit:   9fdfb15a3dbf Merge tag 'net-6.6-rc2' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
dashboard link: https://syzkaller.appspot.com/bug?extid=e7be5be00de0c3c2d782
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165c9c64680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f91628680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Fix hci_link_tx_to RCU lock usage

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

