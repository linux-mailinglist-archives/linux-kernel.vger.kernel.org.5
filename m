Return-Path: <linux-kernel+bounces-16582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D149B824091
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8568F1F26D59
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E7021116;
	Thu,  4 Jan 2024 11:26:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3521101
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fd87e7a04so1884435ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 03:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704367584; x=1704972384;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zf4xGckuuGU+O0q7ocjta7VYftbovTunKuMZtmBVoZw=;
        b=QxycYwHb3IYyggVNJes16b7Vfx3yZ3BL2TqoYq99oWmnx1+evtlAhPBlp8ao17nzoM
         lVK9bSLxOsM8nUZASrtOlU4Rvb4Zt7fr8dyBigh6Tytx/ai679TFSfXLzwxOgrcxtl/f
         7xe6qZnJHumMu8LeLBeYF5xUK22XRboFqgPXIC6fKlK35ZOlo0fPrIUMm2WXLuIZ68tO
         2vLBrff8wo1aO6WWviGo43siLY7ImMrsVB2VNQNH8BienBtvlT725RLHiGjC2sY5N+U9
         uAogl7AlD/HfmOat35bRzhfsiIjzXUkfmarhrXdFlIgIBC30rWH3wQ4kaROBbeSmP+cu
         upjQ==
X-Gm-Message-State: AOJu0YysIy2lwviQSlU0Bs6gYGT4OLgXhNKMrE91yfenOyGqp8kWK+ZI
	fIz+5tmYVnFMAoZ08DUwMMld0QBlCwePHPV6xgJjBoiITdD0
X-Google-Smtp-Source: AGHT+IHl6WIB2IxLCvxfXYcXCvwD+l+V1PRl/AEUZ0Q6cdbARj/L27Pw2qSKFMJ9L6HdqWDwjLG0jmmdgFaticIinQ9dk4Bbdy9k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d19:b0:35f:d4dc:1b1e with SMTP id
 i25-20020a056e021d1900b0035fd4dc1b1emr54343ila.5.1704367584559; Thu, 04 Jan
 2024 03:26:24 -0800 (PST)
Date: Thu, 04 Jan 2024 03:26:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071caa7060e1d0087@google.com>
Subject: [syzbot] Monthly bluetooth report (Jan 2024)
From: syzbot <syzbot+list440a8a51f30afd02cbea@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 1 new issues were detected and 0 were fixed.
In total, 32 issues are still open and 58 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  17084   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  9083    Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<3>  6476    Yes   possible deadlock in hci_dev_do_close
                   https://syzkaller.appspot.com/bug?extid=4e3a76c5c505a3f49083
<4>  4881    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<5>  3386    Yes   possible deadlock in hci_rfkill_set_block
                   https://syzkaller.appspot.com/bug?extid=f93d183bc91522d90de9
<6>  500     Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<7>  175     No    possible deadlock in hci_unregister_dev
                   https://syzkaller.appspot.com/bug?extid=c933391d8e4089f1f53e
<8>  127     No    possible deadlock in discov_off
                   https://syzkaller.appspot.com/bug?extid=f047480b1e906b46a3f4
<9>  101     Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
<10> 33      Yes   KASAN: slab-use-after-free Write in sco_conn_del
                   https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

