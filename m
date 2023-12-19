Return-Path: <linux-kernel+bounces-4737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6882481815D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAE01F23DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346C87487;
	Tue, 19 Dec 2023 06:15:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BFB746A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b738d08e3bso440182439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 22:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702966503; x=1703571303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sq/Szv5lROvis43gxuf6LJLhUW+RhT5kP9APALjfg/8=;
        b=gugfvBNAeF+h1GQCI0iMCsn6l2NxCk165WigzeG2YDb86xXvQjCr0s8MlqBjwOjuVP
         0XGcPw3OpuCw5iNQEwS6ZmFNBXpb4D4jzLmtOpvWFr9DtcwD8StqW5MOXtLQhWHItqGK
         0JkPTdupL1FLvuPQLgn4eeliIVYFQfErvSVziQChvMjG9ULZ3HxjoiE7djhw76ehX1Ip
         UIcpIB/YFrnXe7f+3B7xJEODJo9wyiM+cgZNSsmbOCZvgXiEfScVHJhVv2776OJ7upjr
         K1mdh18vJThIbIs4JC0pMsnIs5kfodbwSv5V5H1ZDsK6nne8DWMF0RLTbguwrhabOvZl
         Dnjw==
X-Gm-Message-State: AOJu0YyAuRynWixthJezLqkIqWgIfrsLbImzGRDDMxiD9RcBhymSoDh3
	b5XkNWCFAblqfqVdTDzTXkaiqnS1ctIYKZdEb22nG3A/dZK5
X-Google-Smtp-Source: AGHT+IFoV/QZu28dBYZSeosOCtVwsWoTPYjF+U3ci6FMO2SbipZitb8VfpGM/IDQmrmxuUaZmRlkPTwDHQO0iOoD4qEECKWUo4uf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:238f:b0:46b:49e5:a22c with SMTP id
 q15-20020a056638238f00b0046b49e5a22cmr252833jat.1.1702966503755; Mon, 18 Dec
 2023 22:15:03 -0800 (PST)
Date: Mon, 18 Dec 2023 22:15:03 -0800
In-Reply-To: <tencent_D55B49852EFAAEE78C9D67DB46EB52F44606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008552b6060cd6c925@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in blkdev_flush_mapping
From: syzbot <syzbot+20e9a5e0dd424a875f55@syzkaller.appspotmail.com>
To: axboe@kernel.dk, eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+20e9a5e0dd424a875f55@syzkaller.appspotmail.com

Tested on:

commit:         5bd7ef53 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=115c1601e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e043d554f0a5f852
dashboard link: https://syzkaller.appspot.com/bug?extid=20e9a5e0dd424a875f55
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d37de6e80000

Note: testing is done by a robot and is best-effort only.

