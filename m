Return-Path: <linux-kernel+bounces-17976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB27825633
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2355E1F21599
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039A12E3EF;
	Fri,  5 Jan 2024 14:57:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5648C2DF8F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35ff23275b8so12122785ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 06:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704466623; x=1705071423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nl5bqvUR1HOZ5rsPTwxmCCNc/lWY1QotfCXXvDlGr+g=;
        b=nn7grzRC+HUukMs4iNFw217+iPzuSwvdqwO2gBwv2ZZRefTONj5THnF8AHcVxqRZZo
         attvGxyZHlOaWKGjj5DDk0VALdHITCba0bL73sB0dyM9+qvNzE9yX5R5U49fU0CUOs8z
         7/PD3i/E/matGX7kuPORDT4IRW5QDsqJCDEYfpuEa/6eYYOnGMFOhfkAopnORv5UsqcF
         WzG/N9fREub62D9ZWizGsn2VOuNUppvKvt4VreqxMmxYAewJ52f0fSeN1evAqoqWd7DU
         lkxy8uRTHfcCU296e01GMBLwqnrDW4pOmb2QqqLLrWzZNlI/rL3blgqdR/JLWWXYx8Mz
         3Pwg==
X-Gm-Message-State: AOJu0YwmMQ9UjObW1vTAfVaNpb/BzDzfZLqZ32wFJpGx9X3kqz5mRKiP
	pTwvz6y7kdWjoopGepgK0n3RjXJJyR56G3TT/sQviLMV0SH3
X-Google-Smtp-Source: AGHT+IFYZ0LlixXZslfSIMOSGO+LuNB8GDKXKlknKWmnMQyT/Sr0IDG1S+KzmkOvMb+NxNa4DbECT6IIviS1t6HAUfqk+BVRY0bu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:35f:8652:5ce8 with SMTP id
 j15-20020a056e02218f00b0035f86525ce8mr277395ila.4.1704466622595; Fri, 05 Jan
 2024 06:57:02 -0800 (PST)
Date: Fri, 05 Jan 2024 06:57:02 -0800
In-Reply-To: <tencent_E0365C961437B24AA074DD76D3674A3C5D09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000924fdc060e340f5c@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_quota_write
From: syzbot <syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com

Tested on:

commit:         f5837722 Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16076105e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
dashboard link: https://syzkaller.appspot.com/bug?extid=a43d4f48b8397d0e41a9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16723a4de80000

Note: testing is done by a robot and is best-effort only.

