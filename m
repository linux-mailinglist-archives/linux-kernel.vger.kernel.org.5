Return-Path: <linux-kernel+bounces-12630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A552B81F7FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D678F1C23510
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C41A7469;
	Thu, 28 Dec 2023 11:58:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D607A6FD6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35ffb5723e9so40678075ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 03:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703764684; x=1704369484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bmj/fU3ExJnfSF47OMzKNqiO6h6v27r6V5UqzFV96so=;
        b=icOue98P6y5ma7bkae/VS0uUcjDjQtE2yiDrUvQJAkS0hxDCop2SikxvjBBoDVyift
         Bmmf6vT0qinbzZYnXxlqNQgWSEkK0B+Xx73FHMfl16qugzeoM7cd+2m+PiHlp9LVaXj0
         iL0JsJYQr2A6fO//6vhnBq24WwpX1ak2i4MHYd8huZRtGCcXi9+AEdt9Mp3nqI/ZtOeM
         aDpsyqVa6CKWCBjCw/3j9n6TFdecoBpYTPUtfI2EHqeXrjnFkC3Euk1l7Zazs7y8uk20
         XteUPQ36bBrZrWd0J7P3tr2nlBglJ0yIXzSt0Iq/5LXI9YHXpTNGuSHYdzyFcbB4YJ8h
         aApg==
X-Gm-Message-State: AOJu0YzhpFr5x8nKOClN+TRu2sMfb5JSIEBFbRddRsegQ4k0H4d6ahXm
	ssdMbFgPBNRRo5s6EL8OM3TAb2hW7lG7LPjuzL6LmZAhfqlG
X-Google-Smtp-Source: AGHT+IFiFrGQQUVjEoNVUCJPyG7ISS2ISKzLaxwNmuO1iDV8oH+8xRuYnR284oJRRqUGi7w2SjVMr4n+wwPFCmz9nIM1zXnt4da3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0c:b0:35f:b715:ed36 with SMTP id
 i12-20020a056e021b0c00b0035fb715ed36mr1386221ilv.5.1703764684162; Thu, 28 Dec
 2023 03:58:04 -0800 (PST)
Date: Thu, 28 Dec 2023 03:58:04 -0800
In-Reply-To: <20231228113657.1673-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7cd53060d90a0d8@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in l2cap_do_send (2)
From: syzbot <syzbot+d6cd076b385aefcb6b16@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d6cd076b385aefcb6b16@syzkaller.appspotmail.com

Tested on:

commit:         f5837722 Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12fc9ba5e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da1c95d4e55dda83
dashboard link: https://syzkaller.appspot.com/bug?extid=d6cd076b385aefcb6b16
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15177855e80000

Note: testing is done by a robot and is best-effort only.

