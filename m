Return-Path: <linux-kernel+bounces-12893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D74581FC32
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3621E1F21AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 00:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639CC15A6;
	Fri, 29 Dec 2023 00:33:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF641385
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 00:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35ff20816f7so47532425ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 16:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703809984; x=1704414784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8LFWRKZFTee28BEvYyoB806h5WqzikJrgfjrbXJnCM=;
        b=KHK3QSS9jG7utXhJKdxdXmlzl4l0gHh3kCG40U2Dbk4YNuZ64qxVFn0/CcJxpNs6GZ
         1VAOep2FJK9FZKmGXLJiMTzxwkbqu5mIFH54PoowG71z4Nw8tTNL4UQvJVqON3nUG2yt
         UtXvi5iu1Ea+06kEP1sXquwnE+8lLOnjkhI9vSbkevmhciAm+eYBLVV4W72VQIjMPog8
         AjZMUf0A4O64RyRR7mu8YLhYwA6jx5s87GNhAV1Ul06cn0DZq4SN/gXpsV1QjpsBfeVV
         e9TqbxrvMOluHhRYCoAgwwy19doce35mTjpNT/jy7LrhwSSPgSMV4O7UJz0SaiIyBvgV
         VOVg==
X-Gm-Message-State: AOJu0YxB9njP3WqlQtV5wMfY8K6pTsyuDnL/iFivKjqwX9VcsPlX4MLa
	gzOz3ezU6au9lEPFyQiHbGYfApBmn677Z+ZqxGf6HduBBp+v
X-Google-Smtp-Source: AGHT+IGScT6M4ej5GC4F+tBL/eXnha3gHIv+oZMqFrULVyb3It5/DdktERBmHKhsbxnxXO9pcl2pcvv6D0iYqegIkm/8ddG5wOHU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:388a:b0:35f:f683:f76a with SMTP id
 cn10-20020a056e02388a00b0035ff683f76amr825032ilb.3.1703809983899; Thu, 28 Dec
 2023 16:33:03 -0800 (PST)
Date: Thu, 28 Dec 2023 16:33:03 -0800
In-Reply-To: <tencent_F13E97D036504AC27443760366CC3C433609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000daedc8060d9b2c8d@google.com>
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (2)
From: syzbot <syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com

Tested on:

commit:         fbafc3e6 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=132559bee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=6c746eea496f34b3161d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12db5255e80000

Note: testing is done by a robot and is best-effort only.

