Return-Path: <linux-kernel+bounces-13712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEB9820B86
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7741F21C67
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B46A63A4;
	Sun, 31 Dec 2023 14:35:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9195686
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35ffb5723e9so68837325ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 06:35:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704033305; x=1704638105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCueiKiN0GnkiTtAHxd2qHT++MKc3o8qWx28OZrtfG8=;
        b=YG+RvbkC+PZw1y/pcSgtbSO5aCXHTcM5JIAO3acfcY9RJiVGFdyYsFLiJ0DLCvRdfG
         QaALNxgwj8MbMcGlSIBBwplSEeykNbECjxKWyCjxlWmcvPsrbBJJRhIdCPg9+62iNsmb
         44aVxDXUPj8nsCuZQ69b7eoQHIORj+zxUlvLis8VzVezg9iMl8A9L3OMz5OhGqxZYjQ1
         o5c+tmMITH08r/Lw+2kUrmTSSFJryOU8rXTcMxP6VtGNi8rnS61mUwbUjwvcyy3m3Nb+
         xIUJtIuXe1oOnXV9YycDYVinKj3gqY/ZMWmoMByXLk4XDe078PkE/w3dpenWpIFkNV3e
         9Xvw==
X-Gm-Message-State: AOJu0Ywae4eHkuHR0iYUXHk8Miz9RrDcf5pmFROQRtgYP3Ph+gphjkYs
	BEzjzpKuRLjVuR7fUDx3Yflb/hc1LxW9rzQuXV/c/ZHC84iu
X-Google-Smtp-Source: AGHT+IGAvhkrORVeVhMPpx5OIiTSIS086ZNN12GLpzZ6Z8Ln85PlALz5NoJaLYhuQepZpu/ry5mAAeVJuUAgJ/Nj400t5atGEVvH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6c:b0:360:128a:fd59 with SMTP id
 w12-20020a056e021a6c00b00360128afd59mr1400309ilv.4.1704033305361; Sun, 31 Dec
 2023 06:35:05 -0800 (PST)
Date: Sun, 31 Dec 2023 06:35:05 -0800
In-Reply-To: <675e418f-ef2f-4bb7-9fde-337171aea92e@mojatatu.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da0463060dcf2b01@google.com>
Subject: Re: [syzbot] [net?] general protection fault in qdisc_create
From: syzbot <syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com, 
	syzkaller-bugs@googlegroups.com, victor@mojatatu.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com

Tested on:

commit:         92de776d Merge tag 'mlx5-updates-2023-12-20' of git://..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16a43d1ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4e9ca8e3c104d2a
dashboard link: https://syzkaller.appspot.com/bug?extid=84339b9e7330daae4d66
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1662b9a1e80000

Note: testing is done by a robot and is best-effort only.

