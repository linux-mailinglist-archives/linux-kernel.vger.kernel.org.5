Return-Path: <linux-kernel+bounces-10608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DA781D74F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 00:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5329A1C215D2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 23:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577C31D68A;
	Sat, 23 Dec 2023 23:59:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F61D53B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b7018c9476so274482939f.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 15:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703375946; x=1703980746;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnE90/gM+FOrwq3n/A3KUGVcXoe8EyUry4mDboMk71A=;
        b=UODwx473g57DODoVGVoablqM60EecgXtmJW103ggrnRjSfZJfx1AHSKTD7uvq6Yl6/
         S6b32F56f6W81aQyza+dlnKhNEocuRry1585cpuCJZGc6w4Cp+km2aCnsEk4XGtdK6Mt
         T2KLOYV6LO2db56y/ChMACW4aKaitI1/CgpJfL7C1EPlBF91f42/T8yOu+tc46zHHC+3
         m844iXlPKYC3V92V5haIq8UfQHeKo2fzt6QbWiaiWLBYtdQW5HVTwMbJBs2NUl/fjv27
         R6OYdfMbQvmpkeB1yXX3bq35A6Ks9X11kjmI0WOdd4Ij4VJMJrd1p9lE+kF9YOwzuqs4
         lqFg==
X-Gm-Message-State: AOJu0YxUqVBN0+FoVN6YjklcHB9xTatgGW/FDfGpPGLTL3zpflzjs5jr
	L2NRLj6I3MGHzTED1N05faTsJi9KXbyGil2m+8CFyXwKLBGJ
X-Google-Smtp-Source: AGHT+IHdzy992p3eOYSCm1ExrqtgEjAANMZE46uTFzCGwczENlpyuH3RnOK6ks2u2GJyi5rfC3cm7A/jZHBGKzTo/cWixzyqFyxa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be1:b0:35f:e864:f6f with SMTP id
 y1-20020a056e021be100b0035fe8640f6fmr275747ilv.0.1703375945865; Sat, 23 Dec
 2023 15:59:05 -0800 (PST)
Date: Sat, 23 Dec 2023 15:59:05 -0800
In-Reply-To: <2592301.1703374471@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c1f71060d361ece@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dns_resolver_preparse
From: syzbot <syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	jarkko@kernel.org, jmorris@namei.org, keyrings@vger.kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com

Tested on:

commit:         3f82f1c3 Merge tag 'x86-urgent-2023-12-23' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132be7e9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f7c7b3fa354ead9
dashboard link: https://syzkaller.appspot.com/bug?extid=94bbb75204a05da3d89f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ef6e26e80000

Note: testing is done by a robot and is best-effort only.

