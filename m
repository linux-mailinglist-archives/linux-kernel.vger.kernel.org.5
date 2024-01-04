Return-Path: <linux-kernel+bounces-16629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C3A824172
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE3C282CC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFF6219F0;
	Thu,  4 Jan 2024 12:15:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C01B219E1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b7fb305084so33756739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704370504; x=1704975304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+tg6/rtzxT7P2S9XCL/lw0Gixdpe9jWfwXuZSG2csg=;
        b=P9gSmf90YRGACuPWVrSiMSJ/1wlIUO7GZOY2u7EAd2VZDnKyeBcCWFeOInLSc+HjPE
         eoO+dH2ldhCbIokjEqbJnpWcW4NaSFHfzXTHCeoLxs3KbZNCoyD5EOGmcC9FMe1uAeQm
         MOe4p0HZ0Dzf/uvXsuIlxFF2jI8OAj/kGw+icGXhbVNQxveNL+cDkFOhE/DPeSzWCD24
         EiOS/b5wia2cA3Nft44F6UyLysHCyTpDzPLLdtyD5giLQDN0l2+9cQrwADF88OZEA8+L
         U8x1mNzmeWKVG1QQupiDy+GBzG9sD0jnrhSBNq+t/S1UYRpuzMP/aDZA+xbytEDMyn6x
         jz8A==
X-Gm-Message-State: AOJu0Yysg3AbeCEXxzcY4D0wDQBKwUlmrtUAhdMPBXTU7EuiotFG3jzd
	dKVc4cO3n3cI/WFTjza0wru2UQpcLqufUJTtHGlraXyrVNRt
X-Google-Smtp-Source: AGHT+IESzHW0wNDn1m1qcuEnlH8sgILt3mQffpE/HrGVkjECWldbjNDjwqv7eB21BVlVls73czWzYD1WuOPOFNH/fnF6HDJ1rtUw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1605:b0:35f:affb:bd7b with SMTP id
 t5-20020a056e02160500b0035faffbbd7bmr67832ilu.2.1704370504184; Thu, 04 Jan
 2024 04:15:04 -0800 (PST)
Date: Thu, 04 Jan 2024 04:15:04 -0800
In-Reply-To: <ZZaZtg3GrtfspDko@nanopsycho>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077bedd060e1daeef@google.com>
Subject: Re: [syzbot] [net?] general protection fault in qdisc_create
From: syzbot <syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com>
To: jiri@resnulli.us, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com

Tested on:

commit:         866c2695 net: sched: move block device tracking into t..
git tree:       https://github.com/jpirko/linux_mlxsw.git wip_tc_block_fix
console output: https://syzkaller.appspot.com/x/log.txt?x=165bbaa1e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4e9ca8e3c104d2a
dashboard link: https://syzkaller.appspot.com/bug?extid=84339b9e7330daae4d66
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

