Return-Path: <linux-kernel+bounces-13054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D89781FF06
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2282848F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763C210A3B;
	Fri, 29 Dec 2023 11:10:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB7D10A1B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bb454e1d64so103064539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 03:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703848206; x=1704453006;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Chb2vlA4LActVFiNDAWk46034fCzF24yUVD9dZLCdw8=;
        b=Pwp4jUk8k6x3x445OpdnpZibwXH+iyNwIG008CEUDeu1gRismTjuU9XIVgn2X22+/2
         +zFf/VF74Po6VvW5pEIrbtDtEBdkv+/YzGJFpecZ6hFDO4CKDgkL4UODD/XkDRh3ftlc
         LGTTzAJgkip5qiyjq0i/WTOzGWthuSL2FK8iTT7R/b2HH87OLhopBAe+WmEDZ/I70zwT
         QiBy8hDEb22OkWBsb2VC0QWGnT7Z7mqTGTft8rxUG/oYxBWON3mzv2vGE36s3y3nQL6J
         a/9njR7R2eCy54uoX5dGwTpriZHZ4ShJ9gQ+igRRcdwVleefJFvejZ++qUwGCU8e3SU1
         8Dvw==
X-Gm-Message-State: AOJu0YxrrTfpPQiA5cSSlIadkEqEdA8MHS1k8bQQ0jwQW/cRuk2AD4Af
	k/vaoCDza6uW6DwFZvXFXtd3j7tdk/fpNCDrBSl5mk38x8eL
X-Google-Smtp-Source: AGHT+IHAr/sReOuW9LQnCPgNK0h9F+fGh40frMAce3gfmCHtHoOoGhA/GPFuKB8kiqeobJrFgfXvBJqxqULrx4GYmQRVMrWcbGl4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4888:b0:46c:ff73:a8f5 with SMTP id
 ct8-20020a056638488800b0046cff73a8f5mr322643jab.4.1703848205863; Fri, 29 Dec
 2023 03:10:05 -0800 (PST)
Date: Fri, 29 Dec 2023 03:10:05 -0800
In-Reply-To: <20231229104551.1876-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000fd27c060da413f5@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in fq_pie_timer (2)
From: syzbot <syzbot+15c3ba3f7ca8ced0914d@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-.... } 2652 jiffies s: 13037 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         8735c7c8 Merge tag '6.7rc7-smb3-srv-fix' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16b4a855e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7bcb8f62f1e2c3e
dashboard link: https://syzkaller.appspot.com/bug?extid=15c3ba3f7ca8ced0914d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17522dcee80000


