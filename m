Return-Path: <linux-kernel+bounces-2142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34793815882
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 10:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480D81C249DF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 09:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A184914018;
	Sat, 16 Dec 2023 09:19:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A214010
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b703513168so166607839f.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 01:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702718344; x=1703323144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHOaDtLQj0LVbYHpiDDUC0HL9T+GyNK15FqZKzRWwb8=;
        b=JKw+mbzfFUID4WPxvvJaKB54knOZiV3DjsSLDFPRxiBvF1hevAqhqFPtScL0uvGwS5
         vGVm98X3R0+1MjwPrWrxSgWkcI/N3xKQsf3HQt1Fv0lj2L8SdmDtmjivYl4w7zmuzpY+
         JZWnsgvuc2Zr9GzTBsXK5mwhiHTgpuGQPXA4Mf4XI7pcpTmQjdNMWeRNULHNzLOcBPRf
         F0KTmXMbV+/PSw5cxqYmshh9cCD0gxqmqFu9TSVzrR3Cd8N2WjdR6U2g5gc7/dHg+xrt
         YKS+MB2sBdJLsjTMgeWKw5qk2VquIqYoYBfQ5nUQ7jZPSdLjrWtznVQ8N/cqH7MbgTIF
         TgYw==
X-Gm-Message-State: AOJu0YylJEoocbn60c0GB8avh69/wV+Jr/Ed/hHCj8Ia0jLDVLj1oTyO
	fvuYdvZCv/bqMp33hEfJN2sobou3WUgcYKcBgh/FFiLdXQgY
X-Google-Smtp-Source: AGHT+IF/ccgnluBL0uQkJChKI3GLSojI6PswOKcs1SlK9Oi2nPNcDv11LxH7XLepAGE4E2RwdhdubAF1Muzh/Q65Tkc1YLnK6CD/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3783:b0:466:3aa7:45e4 with SMTP id
 w3-20020a056638378300b004663aa745e4mr535061jal.5.1702718344237; Sat, 16 Dec
 2023 01:19:04 -0800 (PST)
Date: Sat, 16 Dec 2023 01:19:04 -0800
In-Reply-To: <tencent_F3CD8D809237DDE95DB69927CFA68DBF2507@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f982a060c9d02eb@google.com>
Subject: Re: [syzbot] [block?] general protection fault in bio_first_folio
From: syzbot <syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com

Tested on:

commit:         abb240f7 Add linux-next specific files for 20231212
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14b24771e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc2485c21b49ddc4
dashboard link: https://syzkaller.appspot.com/bug?extid=8b23309d5788a79d3eea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14840371e80000

Note: testing is done by a robot and is best-effort only.

