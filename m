Return-Path: <linux-kernel+bounces-11926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D52281EDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE93E2826BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840B28E3F;
	Wed, 27 Dec 2023 09:18:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B87199AF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7facde6f7so594702639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 01:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703668706; x=1704273506;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AlwDskA2iMpMQVUSwQ/WnNn62Sn2F2OBeZ/jPc+/pVk=;
        b=gtyKErMWFVAVZch0K3vL1Dua45vbh0miqiwkpUldU0DgAUmZVdGBrhOPgv/k27KA87
         R5K0WpEr5lCZEfyRS2Q3Klxq3LP1C32NB4OR2tiSv8o4GVaVLm50NR838PChq+Ok165X
         5iUaTSkjH0c6YozmnILcQh+KiBRZOCKhn4t0YV+848dcuKd+LJx2bIdnMMAdHgQ+jKQY
         oLLLwkesCokl+o0LbruUkN3y6zDKprNsb5jv9oIGAwfx2sg+IJ86ihdn4+hJF9fDaFCp
         8lYV1xJetuI+NJLed0Pu8oa90hRoKHIa7oStZCXMY2PUu1iBxXGIo9Ry8tv168qTggX0
         e6Fg==
X-Gm-Message-State: AOJu0YxbjcS5n3euz2NHnX1CGIjLE8M7q4zrFEO9B6pRT7DXeotRz9PL
	gzbomQKpan9oI5iWWQ9sGPafOizDnvxap4oI87usPLsMtEws/3k=
X-Google-Smtp-Source: AGHT+IFAdDOzYNIj0dLVpmIr+xe9CCVI9dZ1GdUvIxlEHRSBA6dBZvB8P0qOpv/wGNN+XMIDkryDHJUCXw2IWxF3hUczc4xr9nZM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d13:b0:35f:f01e:bb25 with SMTP id
 i19-20020a056e021d1300b0035ff01ebb25mr786160ila.6.1703668706535; Wed, 27 Dec
 2023 01:18:26 -0800 (PST)
Date: Wed, 27 Dec 2023 01:18:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000117048060d7a4879@google.com>
Subject: [syzbot] Monthly net report (Dec 2023)
From: syzbot <syzbot+lista2146b62862a7fa40918@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 11 new issues were detected and 4 were fixed.
In total, 73 issues are still open and 1360 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  15039   Yes   KMSAN: uninit-value in aes_encrypt (4)
                   https://syzkaller.appspot.com/bug?extid=828dfc12440b4f6f305d
<2>  3912    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<3>  932     Yes   possible deadlock in __dev_queue_xmit (3)
                   https://syzkaller.appspot.com/bug?extid=3b165dac15094065651e
<4>  863     Yes   INFO: task hung in switchdev_deferred_process_work (2)
                   https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
<5>  691     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                   https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<6>  600     Yes   INFO: task hung in rtnetlink_rcv_msg
                   https://syzkaller.appspot.com/bug?extid=8218a8a0ff60c19b8eae
<7>  411     Yes   WARNING in kcm_write_msgs
                   https://syzkaller.appspot.com/bug?extid=52624bdfbf2746d37d70
<8>  378     Yes   INFO: rcu detected stall in corrupted (4)
                   https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e
<9>  263     Yes   INFO: rcu detected stall in tc_modify_qdisc
                   https://syzkaller.appspot.com/bug?extid=9f78d5c664a8c33f4cce
<10> 254     Yes   BUG: corrupted list in p9_fd_cancelled (2)
                   https://syzkaller.appspot.com/bug?extid=1d26c4ed77bc6c5ed5e6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

