Return-Path: <linux-kernel+bounces-4995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC908184F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 061A5B23746
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C38E14271;
	Tue, 19 Dec 2023 10:04:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A272314265
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35f9c70248bso33965385ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702980245; x=1703585045;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/GMZdKeyiRmKy8aTbykUFUsBWvVE3dT4rhCchLiO+8=;
        b=GJmhI0Q1NxkDmgNB5bD6cph+MxDucCiDhwd+OjbIKcLtcTyNekJffyxJwqStiLzmJM
         DeHCACbSJZFOY9eqGRn74S9qlbd5RNFTJ8FKGL2JJOHzerXHDJ6b4v5Q9KpGlf+9fVMD
         yO41t/uDaVu1Z0bWq7t/HBr3fMp+zXrj0o63AXVikdzrsL+LUzxxXXMlZvSzxdczfAFq
         GOR5BFSntXagYOpsFtFx3mrg12lxh1JrmGqo47bZEwGdBDOAeTJjj9yh1MGsMfCm69gj
         kEmqHHY3wVoy1Jw2IftB80Oa5Atkp1I67swJl5qKlQxgLioKgwpigjGHYoczK+ScQX81
         /gPA==
X-Gm-Message-State: AOJu0YxhKbJNgWnu5SNXfdfzkOYHAKHV5CfONhYLW2iVeX1Hm8IORftk
	PtD78PbJe8wfKym2QIaugU9qHzE5cYmg9kZwokFdySEExuoi
X-Google-Smtp-Source: AGHT+IHRXxJHrDUIT3WRaezRj/DuzwAFunjMI9v3rv+So1+NmrOtalK4f0UUvAthnq/GcJMZrszg/g97CKegU269CpL0i27BF05z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1528:b0:35f:b16a:d0d3 with SMTP id
 i8-20020a056e02152800b0035fb16ad0d3mr513920ilu.2.1702980245794; Tue, 19 Dec
 2023 02:04:05 -0800 (PST)
Date: Tue, 19 Dec 2023 02:04:05 -0800
In-Reply-To: <tencent_B6953CE9AEEEFACC2C788A6D302F656DD80A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c38af060cd9fcc1@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in
 getname_kernel (2)
From: syzbot <syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com

Tested on:

commit:         3bd7d748 Merge tag 'io_uring-6.7-2023-12-15' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1013149ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=33f23b49ac24f986c9e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=109c16d6e80000

Note: testing is done by a robot and is best-effort only.

