Return-Path: <linux-kernel+bounces-25272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ECE82CC78
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 12:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328691C21E70
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC757210FA;
	Sat, 13 Jan 2024 11:23:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671F210E4
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ba97338185so744752539f.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 03:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705144984; x=1705749784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z14o9M1FaLdELHR0JarXC5hIlTJgwZ9DahMSqziCXco=;
        b=mV14ETk61sobyOe2Q6pGMfDG4oQdZ1xPS2gIIFxIhtR0DBKl1INI0d1SDb8ewBWNPE
         imfQl8IYhAjVrjHxRqHumcdGvtIHcNlI2qye3FUfTJET+UcuwQ2BLrbdGgN4I6KJ3NH/
         z00NK1zQAvbtGti26RjtLKAbMD0F48ubpmKCer4OgSdIhknjRwN8iRjehPrvlMukc5uq
         6vE3OvKK2QnCG9EmblSxNNPqAbHGpFh6oMbD9cjNWReI8R5Yt/KGhLNFxdhBY2EfZOI8
         Z9MdT6g2BXiu6I337DEiGTITchEwGzhMsl9QQa3UB6fGkP1M8XAJP0Onnu16OSokqGDl
         VHpw==
X-Gm-Message-State: AOJu0Yw8Gob8M5gRMz5M1QsGHdP01AMffGWEpUO2e6+OiLeQhvVqJgvJ
	wVsFhXx/NfKL3LCOVJ1AR+HkpxoCbq5jPpW8dHw3vwlJ3JGa
X-Google-Smtp-Source: AGHT+IFgynJnxpwAxoxfVTWKGV7tDktTSPm/EGkIEjNpAP8szNPUMROAJN1f0tIwmfgl8aR/KL4ubdpp68SM+hjSE6aY+5kmPj6V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1645:b0:35f:8652:5ce8 with SMTP id
 v5-20020a056e02164500b0035f86525ce8mr327944ilu.4.1705144984143; Sat, 13 Jan
 2024 03:23:04 -0800 (PST)
Date: Sat, 13 Jan 2024 03:23:04 -0800
In-Reply-To: <tencent_53EC36AE4A8A751776E7672A3C8737D69709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000120e53060ed2010a@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in destroy_device_list
From: syzbot <syzbot+a5e651ca75fa0260acd5@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a5e651ca75fa0260acd5@syzkaller.appspotmail.com

Tested on:

commit:         23a80d46 Merge tag 'rcu.release.v6.8' of https://githu..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16dfa2dbe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36f64072074e3eab
dashboard link: https://syzkaller.appspot.com/bug?extid=a5e651ca75fa0260acd5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13271683e80000

Note: testing is done by a robot and is best-effort only.

