Return-Path: <linux-kernel+bounces-17401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2C1824CB2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59EF2856FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4077E1FC8;
	Fri,  5 Jan 2024 02:04:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4B1FA5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fffb6fe5bso8967595ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 18:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704420244; x=1705025044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RbdQNgZhlBOjHEKv4A23bmkYAW5rjv68FkHH8G1De0=;
        b=AKbsNtXoxSJvb0za2tN8Kz0Jb42rX1PGCRe8wDEQYCX/1sL9Sz99zjMaWKq8ZnW4dI
         DuveR68imgF0+gtXrrfbaDXIwv1yidHQfOUs2c48qN27roBab+L6VXiWRzveiqCitggD
         b/DZyVL+Lt2Sp76S6NIDs8ScMoPoadbYOXPXjphl3KuxuuElUiGxAuQMfTTRoXJfvgTL
         tMnvkmqmpmDCXZh5O3fPBP44z8g9TvLjPhXibGBXnDoZf5wcKGQ5/Yus8z0sZyd6HIFo
         iaGpqZgZczl4MJtxK/AhKsgqVTByVerqGfVQa1tva8H2kU+dyk0LHQT6z4KvkutA6a4u
         rWVQ==
X-Gm-Message-State: AOJu0YyJRrS5phDQp+HVizWnnsECnou4XdLYmt8r8aJA3L2kfCS6GLa2
	0VsPBLuth7z7kjgC7aGhoLws7WJyTb8Bv9WWXkw+13ZCvMoH6ZE=
X-Google-Smtp-Source: AGHT+IEnAPcrBY1vGmfkIT0Ny3+54+CxvQ0X1m6/zsgpSN1/FVXlmwOgOf1xsRA1HquLdV7wy7APQT37/WTexpunDC82WBOIewuZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be2:b0:35f:cb88:883e with SMTP id
 y2-20020a056e021be200b0035fcb88883emr225708ilv.6.1704420244719; Thu, 04 Jan
 2024 18:04:04 -0800 (PST)
Date: Thu, 04 Jan 2024 18:04:04 -0800
In-Reply-To: <20240105012326.2516274-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c136b060e2943ae@google.com>
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer
 dereference in do_pagemap_scan
From: syzbot <syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com

Tested on:

commit:         861deac3 Linux 6.7-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=165ad77ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=298e57794135adf0
dashboard link: https://syzkaller.appspot.com/bug?extid=f9238a0a31f9b5603fef
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12250a09e80000

Note: testing is done by a robot and is best-effort only.

