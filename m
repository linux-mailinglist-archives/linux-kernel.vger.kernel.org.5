Return-Path: <linux-kernel+bounces-21229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC827828C4F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2A128970D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873053C470;
	Tue,  9 Jan 2024 18:17:10 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19723BB48
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bedda4c4dfso76445339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824228; x=1705429028;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcHn6R0kM4wu7czQlmwhjkl60nxtGTWgOJfTqRXOE/8=;
        b=KHfnxSqJvkUMdokZFAfaBYp/xJ1cugdPqmKF4+cnGgTsKHUsEtA73kXa/Cx2wpcWif
         YfQsalix9iFzxkd7JKU6Qwl5xpnF4vhg1ZjWNtanQmYig9Zc1WMzZOwmSFEumUUJl/Eh
         5hkNUazVvEJxYwZ57Y0mGpseMRnBlWzBLQXBigWW99YBh+koFydYcHul5ciKoymmRuuG
         95kTy2+BLfeh0VjgpEbU8DV6fRQNzqIP/BFZgoIAiVe76/Jygylxb9BKQuv68IRPJpjo
         gx8ibscjWJoVrlxfOnbmOtn7aGcyUXWu0qo5f9vlqFRqNdB9pW0TPbx0EuK+RGhcBbZd
         i0Qg==
X-Gm-Message-State: AOJu0YyYZ7qfemv4QzWaBuukp8KRKehLT0UeGwSXGhA2eeux+O1NwNE9
	PLCRqYA3kzsRcR2qevwaOP/7jvUqksTgXXVmz4hXDYWpXxWP
X-Google-Smtp-Source: AGHT+IF1K/IDh3z8SPSxlJkiuGM3psQ/kDI85PpxKFIrtgfNmPb8qQt2O25MmwDNXT7o4Q8g5VXcwdb4gplMyCypgXLNsEw5Zwfw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:618f:b0:46e:3965:4547 with SMTP id
 fa15-20020a056638618f00b0046e39654547mr85478jab.0.1704824228085; Tue, 09 Jan
 2024 10:17:08 -0800 (PST)
Date: Tue, 09 Jan 2024 10:17:08 -0800
In-Reply-To: <tencent_0A35775D67883DED3600968C369A4A207409@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000850a7f060e8752a7@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in __sk_msg_free
From: syzbot <syzbot+f2977222e0e95cec15c8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f2977222e0e95cec15c8@syzkaller.appspotmail.com

Tested on:

commit:         9f8413c4 Merge tag 'cgroup-for-6.8' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13e7b575e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d908a1f683257685
dashboard link: https://syzkaller.appspot.com/bug?extid=f2977222e0e95cec15c8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1482db4de80000

Note: testing is done by a robot and is best-effort only.

