Return-Path: <linux-kernel+bounces-2138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD8E81585E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 09:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600BB1C24A82
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 08:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEE913FF1;
	Sat, 16 Dec 2023 08:11:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA2134A0
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b7317a556cso231619939f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 00:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702714266; x=1703319066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stKCNPf7MrdScRFIz52dvcQp0ICXPKW5KxHbQB9PF9s=;
        b=axyWxxhFGYpkG6jPm7ToKLIrbPuYody8HDgN1bLS2P1y7Ef3ujhzkFPaEJCNkctjkR
         NKD/U4zpdX7GbJAuVvMjDeEHJ9Mvp3EFbb52Xh5/yPB819fmS7sgh8n2OGqD0nqnRJE4
         ltuRagzjsbUG+AMPCGrgOd3YpqQhs7BEvwjXSZ24sI192jMVi0W+DdyNKo2fFLh7WB0i
         ErnUk8eg+0HnQsz+TJxEj8z4gJDgWT9CrrSzCHsahGuiV3mQqgUD6hXM+V4B9WBOMRPI
         7pLRHg91NnPnvdnTAa/Q1aDsjGRyr2rIB0CefjEPwz7zB3oYivIaLyT7Lccbeci2NIZx
         Z76w==
X-Gm-Message-State: AOJu0Yy4AKNHrzNZAD/9NFSvrVo6y1okDFNSj9HUFzO721dFqYqon6mb
	zCAJvS5WiSzPcko0+iZSQawZfXk+8JI3NNa6KcOoQqgXnHQ3
X-Google-Smtp-Source: AGHT+IENpvYVHAQWc4nVHRBP0sSef7ET8MguUu3rLPKjGeCZ+b4BRFjuukVr05Qi+sXT+KuVQde8wqRq3cypdoV084hQW7Aw8nuj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1445:b0:464:1f14:eab1 with SMTP id
 l5-20020a056638144500b004641f14eab1mr602746jad.0.1702714266126; Sat, 16 Dec
 2023 00:11:06 -0800 (PST)
Date: Sat, 16 Dec 2023 00:11:06 -0800
In-Reply-To: <20231216070012.1643-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc92ae060c9c0e8b@google.com>
Subject: Re: [syzbot] [block?] general protection fault in bio_first_folio
From: syzbot <syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com

Tested on:

commit:         abb240f7 Add linux-next specific files for 20231212
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=126c1aaee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc2485c21b49ddc4
dashboard link: https://syzkaller.appspot.com/bug?extid=8b23309d5788a79d3eea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1644417ce80000

Note: testing is done by a robot and is best-effort only.

