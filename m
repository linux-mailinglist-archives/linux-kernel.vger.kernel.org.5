Return-Path: <linux-kernel+bounces-13168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460F78200A3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F4D284883
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5BC12B6D;
	Fri, 29 Dec 2023 16:56:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429112B66
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3601028d487so39044485ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 08:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703868966; x=1704473766;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcVXDKCTC52LBudLeIL1xmSr/5SC9kwTBjDg7U/qhA0=;
        b=bUpZOyObzptLlIsQS1g+5e4sKMFfgCAFufgyUL3tY/20HH6k/ei2agdlJXmufL/Hl4
         xwurBE7bN+RIgkBVta/6nRqB1MiHg+1pblIkLM5CoOsIu+MKRq+sL+xc1Ase+DN5thuf
         HQMPHmUadxlL49+ntA3MAzHdsZ459XS1e2WS8JtwS9RfvJijfCGI+tbg141YkHxW+BIA
         m7D0HLiY8siWlUv3MIFZqpSI+mquHR3VENribol4flX3UGCC9NVFPytkaEbW3cicSPRw
         r1wc/Hq4T9kHbVrszjxn3XrV61PA5TBBA+mHK4RGPAxjfUUi4CuN9LcHfdr28wzq4/7i
         ckag==
X-Gm-Message-State: AOJu0YzovURBWLgYeC2IdcYi94OUHMxSDV3rfW5nv0tEaPZN65P1w34G
	IKW4cRe9wvuVoNi5NTn2F7Qgx5GiI0UC631SXvwn1fGAT1zk
X-Google-Smtp-Source: AGHT+IEKaam3P5UaWG6eOgrWmrAKGMdmElc/De0jxXKADL49by1kFQEWypzLldZaFv3cEJeIejN4nhhz/UrZPqbyx3uUozjOtBWD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa6:b0:35f:535a:9c64 with SMTP id
 l6-20020a056e021aa600b0035f535a9c64mr1342361ilv.3.1703868966388; Fri, 29 Dec
 2023 08:56:06 -0800 (PST)
Date: Fri, 29 Dec 2023 08:56:06 -0800
In-Reply-To: <7227c8d1-08f6-4f95-ad0f-d5c3e47d874d@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c4bba060da8e89d@google.com>
Subject: Re: [syzbot] [kernel?] KMSAN: uninit-value in profile_hits (3)
From: syzbot <syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, ebiederm@xmission.com, glider@google.com, 
	hughd@google.com, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	paskripkin@gmail.com, penguin-kernel@i-love.sakura.ne.jp, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com

Tested on:

commit:         8735c7c8 Merge tag '6.7rc7-smb3-srv-fix' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122dcf81e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2fd2f495c90e6b7
dashboard link: https://syzkaller.appspot.com/bug?extid=b1a83ab2a9eb9321fbdd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f021b5e80000

Note: testing is done by a robot and is best-effort only.

