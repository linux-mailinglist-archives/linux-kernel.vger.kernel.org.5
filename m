Return-Path: <linux-kernel+bounces-13729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A5D820BBE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38B31C20E1C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B1663CF;
	Sun, 31 Dec 2023 15:16:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EFEBA28
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fc6976630so95338105ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 07:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704035764; x=1704640564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERXn+tLTNJVMpVARpfqKFaajgSMwYoA2QCmtE1NmFuY=;
        b=AdLd9DBa7HFHMyr/besuEC0FodQy+fBEDSzmAImD0QjPPBaEDUePixzqFn8liH6NWE
         tIZZyf1IJdUPzsLvZOifvap29KZWhAtQV7C7tVxLMEIp/T55AD/khojYBTH1JVHSGKeW
         rgIxZFVcKt1WRMO+Gc12Sy2tJjPnQRW0RVqHIvJtd8qvPwRtVdzD4C7tlQtX/RhGrAYx
         D4mvgANcJoCms7BEijLnNaIOFDb7ndN3GG6uiJTFLHUChcQcAt8HZsRJNEbw04DZRGeq
         0cjqOVisDoUPiHzjfC/vsLbYtyOoYG5U/E8Edg9fASuH2VZcxMQMD2uf+YXhyYfH/EBA
         BZvQ==
X-Gm-Message-State: AOJu0YwYjhWbweScYuzC/ThmQHdieI4/HjB66Ia4G4pQ+vEMAgtn1UGe
	zlFSnlsnhUFIyw6T/iyzXDxzCWewE6ZFbhcLgFqiD7yopLu8
X-Google-Smtp-Source: AGHT+IEIdHuxU8nTGu94WRSR8lPA2wJdjJj124l34XuaK+aT3x4/M8a7wvRZP1rQjw1+zi1B8eUwKPWNs6SLBNUnUTDhQfQj1Wrw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d87:b0:35f:8652:5ce8 with SMTP id
 h7-20020a056e021d8700b0035f86525ce8mr1682321ila.4.1704035764241; Sun, 31 Dec
 2023 07:16:04 -0800 (PST)
Date: Sun, 31 Dec 2023 07:16:04 -0800
In-Reply-To: <360d5a75-b06a-4b52-ba6c-e24a0bffa530@mojatatu.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000698c17060dcfbe16@google.com>
Subject: Re: [syzbot] [net?] general protection fault in hfsc_tcf_block
From: syzbot <syzbot+0039110f932d438130f9@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com, 
	syzkaller-bugs@googlegroups.com, victor@mojatatu.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com

Tested on:

commit:         92de776d Merge tag 'mlx5-updates-2023-12-20' of git://..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10cb54b1e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4e9ca8e3c104d2a
dashboard link: https://syzkaller.appspot.com/bug?extid=0039110f932d438130f9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15d12036e80000

Note: testing is done by a robot and is best-effort only.

