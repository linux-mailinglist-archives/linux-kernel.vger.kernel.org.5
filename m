Return-Path: <linux-kernel+bounces-12641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBC581F835
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B1DB232F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0A4749A;
	Thu, 28 Dec 2023 12:35:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B263748D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fedd5e6beso42657955ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 04:35:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703766906; x=1704371706;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDCjNsm95xS92ZHtQN4fTUOS4WdKJ+Sip/VFAsOxNcE=;
        b=hgE2nJl2bzpKYgggi4hf2B+AJCuPUStyY4kAIoz8eqqBequHsW8LwnobB5SKruMqBf
         5GXwhk/5tC7TTspvl87u8C4encDsh7Wcaf94Y6Y0ukvpMlNbdxup3dRQQpr2Glkeh51P
         u8qYz39unCtObbbK7tC+o84joJBGY8msGkB5N7Y0cijj1+PjBX3OZ9rnTiAU8xTWnEC6
         mu5h9PGiUvAYSA6YF3I8gzqkc3lcrel3to2tVjf6sX4rZ+4HwWe7dtCsiJJghPV6CavW
         wOWTDvuLv6/+1D8zyc/vR+X4MGteC0iFIJS4wYon/jagTbOCH4Cy533kDsPeO2CMB1/E
         bUFA==
X-Gm-Message-State: AOJu0YyLPXcNmErbZlst9z9x4TatBhpfHRZ/TG4g7vXl/VurgFZXt5nq
	HerE+F13zvOqc2I3WbDw7YNKB8DxDemdY0YBDGhpcBy4IIuY
X-Google-Smtp-Source: AGHT+IGIHTWMfWZ/Cgv7K3bGHLRRjlLV1SVj7M/090rf4K3vA5kUlptQ+z1492p2X5La8faqQ/bGtq7rQ6QFm197uz3zihLSl8gd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ea:b0:360:17a7:d897 with SMTP id
 q10-20020a056e0220ea00b0036017a7d897mr478109ilv.4.1703766906470; Thu, 28 Dec
 2023 04:35:06 -0800 (PST)
Date: Thu, 28 Dec 2023 04:35:06 -0800
In-Reply-To: <20231228120639.1817-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d8bf5060d91251f@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in fq_pie_timer (2)
From: syzbot <syzbot+15c3ba3f7ca8ced0914d@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5978 } 2756 jiffies s: 3785 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         f5837722 Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1743f3e9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7bcb8f62f1e2c3e
dashboard link: https://syzkaller.appspot.com/bug?extid=15c3ba3f7ca8ced0914d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16684981e80000


