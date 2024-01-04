Return-Path: <linux-kernel+bounces-16659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975A5824200
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4477D28735F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B2121A1E;
	Thu,  4 Jan 2024 12:47:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B7C219EE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b7fdde8b59so34572639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704372426; x=1704977226;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhdZhVM9hd6zS0zhf1fproBxRxVbTWRWZfmYHGWqTPE=;
        b=N7B0Fy3+W9Apj2PHFN0jtgS5qwl48xyAj6BMNXRnDis1DZvRsDLTo7VwZgY8bclHLP
         BdG17K8n8DLZg/2I6E5HEhK4XmCPKUCuf8pcKgiVi/pGTTbnQIcHjQNs6rF+KvrGyV1y
         c4B76E2+LEcMh/Vokps+gq00qmc4SAOvL+i9q9QI7rD0lwk0blQ5vZ0iuRJp4W9L123V
         c+DXrZbOt14pZ9D0OWt+GHXjYKQRH7r69sjTv5InZegC8AYsaipauQrf4IgthzS4oedy
         4AXoXFYuqIh/Bjef2X1QbyMyT0wU6U8+adg+TX6fepLCzzBpO+ctvaWPp/6SND01BmtO
         GFNw==
X-Gm-Message-State: AOJu0Yz4OEurBifbaWEvwtxVg3pCaqGSPwz7bXxwhmiG2s5drBdmTHib
	GvszDCsSaYwXkzcVOYnf7t97uzrJIgobD6QiwkjU5ufq+Vhk
X-Google-Smtp-Source: AGHT+IGdu19ASS4QM2psMgOgjkgVZ30LHjYMpl4iRXmaNYOEpgfYr5/it1Xcqyz+Z1eSKAz81pY5l7sGQE3Xz8Y/nFo9GR+lSohm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6297:b0:44a:fe65:d743 with SMTP id
 fh23-20020a056638629700b0044afe65d743mr20982jab.0.1704372426058; Thu, 04 Jan
 2024 04:47:06 -0800 (PST)
Date: Thu, 04 Jan 2024 04:47:06 -0800
In-Reply-To: <ZZaaMF3CZcsp5htH@nanopsycho>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005306b060e1e218e@google.com>
Subject: Re: [syzbot] [net?] general protection fault in hfsc_tcf_block
From: syzbot <syzbot+0039110f932d438130f9@syzkaller.appspotmail.com>
To: jiri@resnulli.us, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com

Tested on:

commit:         866c2695 net: sched: move block device tracking into t..
git tree:       https://github.com/jpirko/linux_mlxsw.git wip_tc_block_fix
console output: https://syzkaller.appspot.com/x/log.txt?x=14a03de9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4e9ca8e3c104d2a
dashboard link: https://syzkaller.appspot.com/bug?extid=0039110f932d438130f9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

