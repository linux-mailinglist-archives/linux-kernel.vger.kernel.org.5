Return-Path: <linux-kernel+bounces-2487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20071815DCC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 07:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2E6B22A00
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 06:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969011854;
	Sun, 17 Dec 2023 06:57:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940B17F6
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b7aacf63b9so106165739f.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 22:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702796225; x=1703401025;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dar3TSSXdPRX5tsff7O/kbpAyVhQOMXba4mrYJbLJBE=;
        b=huhiw632fe6It74+8RJzO+uoGEUigqf/xiXlAZOmFlSLxtCQxhhyxjzUMZhEeRvfoA
         +hky5OyZCOZsYyIgM2M7u9pvifRHvHQoXRXchbfLXssCvbk8b7luCafgwvj0z0OopH5M
         iTkojAa6kCKV+Iq34OM3u9XHe0sffNQARJt/oaZxsH7ZWGNccljCzClwLgMK1nrqZnJs
         uEAfoJOOpXH3luJMuApu1iRh0E03X5vloD5mm8Wzvvst5gNlHhmkjE0BiDElrQCTS8P9
         1gWQVgv4d7XDgDEf0cMLKIZgNR0wvGBo6hOmCY0n1nayN5674HOAjgasYFbIkzXtXrqA
         i+iQ==
X-Gm-Message-State: AOJu0Yz5FUDlomrif5ZqKctxxwr/QLP+wFIcfrh+8mQAOzHdles0VNqB
	m+hInNiVV6EpIXn8z/egABel/rc3lGRJivm8/gWiGuRk3T4d
X-Google-Smtp-Source: AGHT+IFpaML9kmJSz+fuF3C9VwSpbwTqy8QOWELAB6ig5VxSwfFsJj0vK0IsE0rt8dbyZAxHv/2WIBdXz/kf5+BVy9vfYk7s1Avu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214c:b0:35f:964c:ce7f with SMTP id
 d12-20020a056e02214c00b0035f964cce7fmr378558ilv.3.1702796225199; Sat, 16 Dec
 2023 22:57:05 -0800 (PST)
Date: Sat, 16 Dec 2023 22:57:05 -0800
In-Reply-To: <tencent_3790AEE86ED1CC91A7DF06C852D3C650C906@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020c3bb060caf2482@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in bdev_release
From: syzbot <syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com

Tested on:

commit:         8c9660f6 Add linux-next specific files for 20231124
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1636278ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
dashboard link: https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=132ec6e1e80000

Note: testing is done by a robot and is best-effort only.

