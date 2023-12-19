Return-Path: <linux-kernel+bounces-4556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4F7817F42
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0026B1C22B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81297187F;
	Tue, 19 Dec 2023 01:26:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0910E6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fb31c3157so8735975ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:26:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702949165; x=1703553965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sACSJYdB2RKqEXXi852c+Eq6QERquM02Yy1t2drQ/2M=;
        b=vY2mb9oKPP6z+uEC1owVqr5j6zW2Zx16mw0QZabUz3cgqfldgZiF2JOrsyn6i68rNz
         H00GgpRTamstAKUT1XmHxeoedyOxAxJ5Nxsl5NqQCLNH/Oh2CNgYaxXpsrbC/wKvp9oz
         jV1q0sPShTRQz0Y15DKw91gOuaZt4KB+sgTniRNRFgVgAJLS4vAngLb5uZTuTiNAaIuf
         2YVaB8y3Tqo2XaWZlawL/6wOx+ik9nUKBcwPwXjNOI+mTRcB1Lw+BEdom7cCNAwuTwDN
         EHYEmb2OuqGSWhc9ZMqgz0daRcmPAm0Yuxxgz2Lh4y+P2uavD2mh/lj7tqRxQAvLL+6y
         Z1Ag==
X-Gm-Message-State: AOJu0Yzino4uQPUHUio3deFAbHchWe2a+SvUB0OWkUTPCT8Wssi3rQvl
	WCuVkdOmOzVadDrjGMq3kOLaax8hbtCCZb71VcwCO1utASqA
X-Google-Smtp-Source: AGHT+IGlk2f+hAnUHD9jJLwQUgxiG4iHaWvJB/37ZnbfzpW1DT2CVW6h55gVBhJt1vGTExKhgU6gwDbQMiIAvNGfWdhp4n6Ts0wR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1baf:b0:35f:a1a1:207e with SMTP id
 n15-20020a056e021baf00b0035fa1a1207emr29554ili.0.1702949164804; Mon, 18 Dec
 2023 17:26:04 -0800 (PST)
Date: Mon, 18 Dec 2023 17:26:04 -0800
In-Reply-To: <5b6b9fff-e0db-4f13-866f-42aa2756c47d@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009fad2060cd2c01a@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From: syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To: code@siddh.me, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com

Tested on:

commit:         0ee28c9a Merge tag 'wireless-next-2023-12-18' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=12137de6e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41c2ccedc0d88330
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=173f78d6e80000

Note: testing is done by a robot and is best-effort only.

