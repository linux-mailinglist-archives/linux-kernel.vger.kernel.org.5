Return-Path: <linux-kernel+bounces-3842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D578173B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A1F1F21485
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982C318E03;
	Mon, 18 Dec 2023 14:36:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27461D144
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7aacf6534so356369739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910178; x=1703514978;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7LnU8RknCJWsPsqm7RXDpRlRmyk9PFdTymemdD1BB0=;
        b=Pc2v2z9pP30HIdgwWPZ+yYOIEKd/pMQg1OZYCEFNwGEej7hCG358tBkPmN7+HqqCGC
         JK4F1rsoCg5TpYrD56WvTpfhrhsMhJXy8y6WuEdmeoNG0cNtcvvmbZ7QG4WCN8sd350s
         gvpzIGDAcmrxdwOalLmhD52BtrlRc5yUWylyUww3b0c7HJPe4pYlDEFcqZQBRgYZ/rMH
         bXASL6urXwalv7yD/R0ZBRXVBR8L7bwLP5q8aV3aWg5Rba8gG9sBjdscdIQlUHIbQQM1
         vlTwqNSI8l9+zLwqYmGlyorN/m2dFRaKD8vRgwKYt58QRQVk4gHX1s62qDW3BNnButeM
         4l7g==
X-Gm-Message-State: AOJu0YyEFemloMX1p665d2k1k3mSkWbd2UOEZJUucSl8cACxkAvv6KrF
	qNp332H2Qqpl0eGBfkmqBTw4qf4b7QcVa32Y7lF+td5+1KUI
X-Google-Smtp-Source: AGHT+IFkNLsPR1axQYWCJ+SpPnOFsw/t4pfNw4EGH7RocShupcn9OymSX8sxcFLnEQuyCg/HvO19Z6BN6qQXhx9SP+LRAN3o0G5o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:da01:0:b0:35d:70c7:4c5c with SMTP id
 z1-20020a92da01000000b0035d70c74c5cmr528892ilm.6.1702910178612; Mon, 18 Dec
 2023 06:36:18 -0800 (PST)
Date: Mon, 18 Dec 2023 06:36:18 -0800
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047de92060cc9ace1@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in j1939_session_get_by_addr
From: syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
To: Jose.Abreu@synopsys.com, arvid.brodin@alten.se, davem@davemloft.net, 
	dvyukov@google.com, ilias.apalodimas@linaro.org, joabreu@synopsys.com, 
	jose.abreu@synopsys.com, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@rempel-privat.de, mkl@pengutronix.de, 
	netdev@vger.kernel.org, nogikh@google.com, robin@protonic.nl, 
	socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com, 
	tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
can: j1939: transport: make sure the aborted session will be deactivated only once

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d9536adc269404a984f8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

