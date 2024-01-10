Return-Path: <linux-kernel+bounces-22381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC6C829CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552A41F2161F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0CE4BAB5;
	Wed, 10 Jan 2024 14:56:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3CA4BA8B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3608dc76b97so39148695ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898564; x=1705503364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeGFFm/lsGLYFv54kWCQ6QNjq1r7LPUufAsKlcrGVto=;
        b=lBi42bIaIh24N011+HGs37hwnMVRlvA6bQ5me6r3BfYCKY3G+5z6jzvCLxwiED1A1v
         Pkoz9LnaZzofF1FGdEyK8GVDJWHr0vXI998o+dPAQ/VKavkJre7nUZF1f2FzDTLnxOsX
         BHMF58H5hOngJscAzD1Bs7CBDN1yjMZyProVW1z5TUIAbr5IAY4wn7piuts5yErG121f
         DrfrJBMPp/CdU/Oxd9KtpphX/Fwp2PBXLZPTFO3oOEoXo7RKAIf+H7ZVYPjX574vu1Nv
         uy7QKIyk9AtEjlAV7OH0XVDkJOO2G5uGZSFyVsJYcAYyeF7r5/d5G967IF6/WN+J6ZpR
         XlzA==
X-Gm-Message-State: AOJu0YxYhoi6KFHOOfFheZak/21AJoHAbfdLW8hWvnEKSwT3KAFOoVG4
	QgJDvLFCtRx0ObXblRccecZlSuRGeOQhMpWT+9NN1vLsLSvr
X-Google-Smtp-Source: AGHT+IGEQ/mvKH8mjU6L3CzDNHzhE7XAIYkwYSXTVKqYeEHcn20VG/ANQYH4qok/OJvzCLUfYFLXm7cFcR6fsgAWs11b//dt1vkj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca1:b0:360:97cb:111b with SMTP id
 x1-20020a056e021ca100b0036097cb111bmr134832ill.4.1704898564285; Wed, 10 Jan
 2024 06:56:04 -0800 (PST)
Date: Wed, 10 Jan 2024 06:56:04 -0800
In-Reply-To: <00000000000049c61505fe026632@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d6ecb060e98a1cb@google.com>
Subject: Re: [syzbot] [udf?] WARNING in __udf_add_aext (2)
From: syzbot <syzbot+e381e4c52ca8a53c3af7@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jack@suse.com, jirislaby@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 2aa91851ffa7cdfc0a63330d273115d38324b585
Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Date:   Sun Aug 27 07:41:46 2023 +0000

    tty: n_tty: extract ECHO_OP processing to a separate function

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129425e5e80000
start commit:   b19edac5992d Merge tag 'nolibc.2023.06.22a' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=33c8c2baba1cfc7e
dashboard link: https://syzkaller.appspot.com/bug?extid=e381e4c52ca8a53c3af7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1515b4f0a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: tty: n_tty: extract ECHO_OP processing to a separate function

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

