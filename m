Return-Path: <linux-kernel+bounces-12427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE9481F4B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8986B1C21AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 05:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5DB23B7;
	Thu, 28 Dec 2023 05:30:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6CF1FB9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 05:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ba8f33be6aso634123139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:30:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703741406; x=1704346206;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FTtElzYgj1bBO7G5x7pVd9jlkFrck2GDrcJBe+8RQo=;
        b=rdgiwW27ET+D8intya872lskhFBj9taeNS9cZe5RpF4WVqk4Pn0bAyS8mF5uspg3Ta
         4XPX+kYzAkh0ymlTyGFRXpYvMcuTf+bnxJjUzlQGoGy4nl2XyDLz0Te4jEnkiDjW5gvV
         79Y2TbX8GeFCdlF4z99hp+orJtQ6UKgEwXUsZ20XpQEwReRZ7nDk6ikrvSDZam9NhYJ6
         EQCRQQt9/1mJ1pxKOxBAX9oBzQhEbAp/S1+UrL4HOc7bE6dXXs4vGO09LRYWnaXQaIB4
         wdNxCG2sxmF7ESW9wc72tth+yzMieRmUh6A2rxDHBRT7dNx9PRXOZ6/NuaWOkje9lDLL
         9coA==
X-Gm-Message-State: AOJu0YwtRcTreajHitlyElxuehsqYGUXauiYbas7ZK1uQURk9+914/fa
	9ZX+MknFor8vEY5nXME5/9JxekqCUF/IDl8sycyR/JChLOHKm/I=
X-Google-Smtp-Source: AGHT+IFLelhkkfXy1tu2gScGRvBqf7UJaxmhLhxIGJQpe7S6hLB5Rk8xEvwfs7pQ9K4LlJIw//v2ke62L7Y+6AloQYxcKXTCP//9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b1a:b0:46b:6ac1:d1bf with SMTP id
 fm26-20020a0566382b1a00b0046b6ac1d1bfmr286835jab.2.1703741405866; Wed, 27 Dec
 2023 21:30:05 -0800 (PST)
Date: Wed, 27 Dec 2023 21:30:05 -0800
In-Reply-To: <20231228045734.1589597-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049325f060d8b35ad@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_cat_case_cmp_key
From: syzbot <syzbot+50d8672fea106e5387bb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+50d8672fea106e5387bb@syzkaller.appspotmail.com

Tested on:

commit:         fbafc3e6 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15b83d1ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c8a595e80000

Note: testing is done by a robot and is best-effort only.

