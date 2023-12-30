Return-Path: <linux-kernel+bounces-13340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DF58203C0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 06:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642661F2197F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 05:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F4323A0;
	Sat, 30 Dec 2023 05:58:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E87E1FC5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fcbe27a7fso89101345ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 21:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703915887; x=1704520687;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lwZ48+JpUMevhsVZiE5wN2mptsDirY50qTd4Umw6YA=;
        b=mwf/MJ8v+ksJtYd8Y7nUXykuQTRsUhtFs7Vjr1adoUlmSzBdMrjqP0Ayko8bL7J57Y
         Z1PuKvp+YOTsP4B44A5QB8ccOc/4T9iRzgBC8yZsBeFM0yN1k7LkCkVz2zimOaUe5dNZ
         vHF0CvD1/HAaGx5YjCDm6N2RcHBss660NvsojyVlyNHQUXJEmjJ18g0LXx31ouY4r4GP
         z117DEZzG6XnGtgHf43UaqQVc+5//3/2sc2ebeYK5vlnRhYoL0shL1u9kDojRgkpX8Yz
         jg0RDbx4xlY3sTOFFldH39RB+dp+uC3qc1x8J6fiB1DsqYg0KKQuremUbq7J84KbBFjl
         kukg==
X-Gm-Message-State: AOJu0YwO7uw+JHfkBw2ZXn/1HUrRDs8lGfHDHiE1zUtuvpF62SJe8nNx
	ixzXrH61YjADNOfI0SWYzlMv7p9WtczDBFYJ27TAQbU2oNjE
X-Google-Smtp-Source: AGHT+IHVOFefJcugTz+dxCVjve8Dqvm80RxX1lrdiljOD7BmFfXQdo8SuXk6ai12BL5Bd6awbJCVcKqg07THWEqecXMkKes4kyz0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:35f:d5ea:8a86 with SMTP id
 15-20020a056e0216cf00b0035fd5ea8a86mr1734386ilx.5.1703915887313; Fri, 29 Dec
 2023 21:58:07 -0800 (PST)
Date: Fri, 29 Dec 2023 21:58:07 -0800
In-Reply-To: <tencent_B8F776D76766DB936C636F496403A1844A05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030ca46060db3d5fd@google.com>
Subject: Re: [syzbot] [kernel?] KMSAN: uninit-value in profile_hits (3)
From: syzbot <syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com>
To: eadavis@qq.com, glider@google.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com

Tested on:

commit:         d1d7f15c DO-NOT-SUBMIT: kmsan: add the kmsan_exceed_ma..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14287b09e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c990527cdcc61224
dashboard link: https://syzkaller.appspot.com/bug?extid=b1a83ab2a9eb9321fbdd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14033b31e80000

Note: testing is done by a robot and is best-effort only.

