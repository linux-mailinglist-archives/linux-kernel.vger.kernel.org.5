Return-Path: <linux-kernel+bounces-13725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5400D820BB2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38F3281C4B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB976138;
	Sun, 31 Dec 2023 15:04:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4666112
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35ff7c81f4aso65265215ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 07:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704035046; x=1704639846;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UY15SVoeT9C0Gyi7HV4n11Zmu0rvNwQzqwZr/tN/qMg=;
        b=ECnPHXzdbLO7taMTIGbD1cBGfxJTTNNw+8oGurHcz44/ankk+6DB/2Fc+/PEXhtuki
         AV4g6tFG6COFs80EkX+6qMrVNgMYB0dopIotELPJp/q9RpBwFCu22np0np25f3xvST/l
         PrwUk61YmM6qkpvvQ3J3dzPP+1per3JUCvhiyC78DSxhUrcvfuEV66svJcg+X4c/4Qms
         eFOURwymZW5Qt7aKMKTWyZW8dnJU4aJo7qPtbxJNOO818JsqZuRxTrJJwvefLDezW0GK
         7WuewXcho62QLuaAVLgtlSu8GmG9ljQh0bNfvUCAevKeiwAJSmUvOwdRaclKvGVUYuhI
         oiBg==
X-Gm-Message-State: AOJu0Yzz3jS/Ok0WRLGUJ26eH9saUtG/6tn5p6Mg7rgxkdv+Cn0d3/o9
	ed5LirjcUHse0TBDqrweMiFI4lLd+muC37XBcCKmAnwavGlQ
X-Google-Smtp-Source: AGHT+IGDW5FLMnCDtQkBvTtGcd8WyZLeLEsoek8j3QhvLQTOnvgyeYMg+JJdrrxFvbpkW9NCspiU0nbrcm2HeBga5n9pci9QEeKF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:35f:eb20:3599 with SMTP id
 s7-20020a056e021a0700b0035feb203599mr1477959ild.2.1704035046306; Sun, 31 Dec
 2023 07:04:06 -0800 (PST)
Date: Sun, 31 Dec 2023 07:04:06 -0800
In-Reply-To: <1882b96d-0625-4702-b496-161b387d089f@mojatatu.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ebae1060dcf93f1@google.com>
Subject: Re: [syzbot] [net?] general protection fault in htb_tcf_block
From: syzbot <syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com, 
	syzkaller-bugs@googlegroups.com, victor@mojatatu.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com

Tested on:

commit:         92de776d Merge tag 'mlx5-updates-2023-12-20' of git://..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=141ab32de80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4e9ca8e3c104d2a
dashboard link: https://syzkaller.appspot.com/bug?extid=806b0572c8d06b66b234
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e64091e80000

Note: testing is done by a robot and is best-effort only.

