Return-Path: <linux-kernel+bounces-16645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC88241D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B641C21AB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E72231D;
	Thu,  4 Jan 2024 12:36:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A876021A17
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7baec2c5f38so32176439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704371764; x=1704976564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnfgk01a3g86X9fQqV0fYMeKAyJYVz5+yFgT5er0kOs=;
        b=SZM19zhNJk7ylF4wP6TUZS5RMJSSKDwe7eWPW15TWYupeQjUgPhvJonmo2vRFviqvw
         sXBzj8Ahy7n9keFo+NFHNA1L95wbe4mIDODWagf//JMfSy+OwQqNEnWub6mVM3j2jfWd
         hNVnx2WtlWAgAAtmFZXOo0KHuHC4aFtDi8Sa6YYQKib8spTA9nrY2kIKLBYxqujt6uBk
         lVyjhOrEDdLVfSObCMyn1npl8TctNyP3KKDZsS99XzhcIUaIid6LWWC+lY8emlJFp/42
         mYyXHDjyehekGBlb7YOXfT6bSIw5oZ/t03FQ2dD/e8v5I5LDqn8ScDOcG0m24zThzogh
         eJaw==
X-Gm-Message-State: AOJu0YwzCYCUdyOFKw4mMJOz2UW274gNqjA2lnw2E4j4PU5hPXfyLfO1
	QPf4TBlAUTIdXb11CRwdvqdhvidpR7QyDoLe1NCo0yTMex7T
X-Google-Smtp-Source: AGHT+IFAnNDTZ9wRWay/3neFZv6eaBVy6lNczbhSA4tPrb1Eu4oe4JIWEJWHuGzHg10RjT9qTaJZFNKhiNZYkpAUhavwqFwbVNkm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d98:b0:35f:eceb:fc42 with SMTP id
 h24-20020a056e021d9800b0035fecebfc42mr48255ila.3.1704371764415; Thu, 04 Jan
 2024 04:36:04 -0800 (PST)
Date: Thu, 04 Jan 2024 04:36:04 -0800
In-Reply-To: <ZZaaH6ToPq6xsJVC@nanopsycho>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095543d060e1df978@google.com>
Subject: Re: [syzbot] [net?] general protection fault in htb_tcf_block
From: syzbot <syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com>
To: jiri@resnulli.us, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com

Tested on:

commit:         866c2695 net: sched: move block device tracking into t..
git tree:       https://github.com/jpirko/linux_mlxsw.git wip_tc_block_fix
console output: https://syzkaller.appspot.com/x/log.txt?x=106b1061e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4e9ca8e3c104d2a
dashboard link: https://syzkaller.appspot.com/bug?extid=806b0572c8d06b66b234
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

