Return-Path: <linux-kernel+bounces-13616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F52F82096B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 01:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312F0282C63
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 00:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BA5A5E;
	Sun, 31 Dec 2023 00:51:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C1A31
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 00:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fc6976630so90496865ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 16:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703983866; x=1704588666;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41dG4K2lSVUyXaKuwjXRp4+40HnWmJ9ZyCB2vC2WNBM=;
        b=aQ438DBitpuMmfWCby/7D1xI7ROGpAmZtahhjrtajWZjo12YMehDgUta/TKGcfW2AE
         WYfiGV8OtK5oth2dRHNqmRshNH/Zu/JJoCqysfJaynVheozNyJ+kV2qy2vhGcw73F08+
         Y3G1X9JEc3Jqbw6pECnXoGjrajbU4de2YZZcDHFu0eD4l0QphziwEAue86cuLIauHldd
         KkNGFQZjTApi/tPh4M02QquHUNi78WVzw3Ewe3tBP6KZ8pWWzdeXk+l1373ff1BZRO3a
         9yMnGCWmtxfSsaCY3FlYHWSduufc3Toai2pmeMHUYoDS6be7s8Rp19NolFYN6MxbhHAI
         7VOg==
X-Gm-Message-State: AOJu0Yw35IhNruXe7kW6a6YY370/pruiIwcBhbIXLy0/qN0jRIXRwxQG
	1EWG/MLClVA6PKFHGOWeB0eTOzPjyla9oXa/0+GMvU/+bUso
X-Google-Smtp-Source: AGHT+IHivW7H9OTJ3GqBK09sgcDmyMP57psYWcF3WUbYJ6GFzDws5YH3yJyaY3ofHVSR7SAfgwQ+pl7DjBg132MVmK+HIuhlIsPM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148d:b0:360:fa:2c2c with SMTP id
 n13-20020a056e02148d00b0036000fa2c2cmr999425ilk.6.1703983866386; Sat, 30 Dec
 2023 16:51:06 -0800 (PST)
Date: Sat, 30 Dec 2023 16:51:06 -0800
In-Reply-To: <tencent_A1836F2960A3B98451B765576926CA937305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f236f060dc3a94f@google.com>
Subject: Re: [syzbot] [reiserfs?] KMSAN: uninit-value in reiserfs_new_inode (2)
From: syzbot <syzbot+6450929faa7a97cd42d1@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6450929faa7a97cd42d1@syzkaller.appspotmail.com

Tested on:

commit:         861deac3 Linux 6.7-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1343c061e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=6450929faa7a97cd42d1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1141c9a1e80000

Note: testing is done by a robot and is best-effort only.

