Return-Path: <linux-kernel+bounces-12422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8A681F48F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 05:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F7D2B21CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2781872;
	Thu, 28 Dec 2023 04:23:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BA137B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 04:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7baec3f92acso253260039f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 20:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703737385; x=1704342185;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd9vr80+WFGKnhM1JNQ66LsYvSI4r3S79KXgQZCzYg8=;
        b=jevDTzkjGkf5pBkjMblhxyQObAs9tHanRqNPgcYCl/MgeI687kmfduHxtMPXbcOtqy
         /qTkHzrmDYnsqgnvKPlDSa32LcXOTBiy8nyXL+1pTltpOZ2BzBrPmUqAtk05RFdANcgX
         XM3TMEZMC/O0QqZglVZ/vMCCQ9xR1i3AKIxpbxZ3/CC7HNUkpogQqJ5uUA2i1Mb9MObP
         cEG1YS7Cg7UbodcxNweHVYwhyTjE/l+QI2oXiN+WGxZRfqaib0KcyDal56UzwA/hxN8z
         d2EUcSFbZzm+iO0Ae8VtRsjKlYY5V5XzJaPIKaltRBFzbQVd0Dan4DtVEzLEMAev4De0
         Itcg==
X-Gm-Message-State: AOJu0YyDmUJvuzBGGN7ID0AY8Il/K+ctKSYuOhy+pRa3g5Ui6Lu6hdeV
	twuMPnYbyqE9iWcIZHHEOncWyWxuVKDvRxvwWodDttdno0vV
X-Google-Smtp-Source: AGHT+IGaH2neAkdIoyk3jyVZ49xeJ9vANxYmgJtaoyxGuIkm1BlzltdENKQP89j3UrTnEYAGl/eH773XOz1+ZzVlXzqXfTbc77Yh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:18f:b0:7ba:cef9:803a with SMTP id
 m15-20020a056602018f00b007bacef9803amr69602ioo.4.1703737385611; Wed, 27 Dec
 2023 20:23:05 -0800 (PST)
Date: Wed, 27 Dec 2023 20:23:05 -0800
In-Reply-To: <5e2ad1d3-32cc-4f94-963f-a066d2a21536@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8f9a6060d8a4520@google.com>
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (2)
From: syzbot <syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com>
To: chao@kernel.org, hsiangkao@linux.alibaba.com, huyue2@coolpad.com, 
	jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com

Tested on:

commit:         94da00a0 erofs: avoid debugging output for (de)compres..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=13715b95e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f711bc2a7eb1db25
dashboard link: https://syzkaller.appspot.com/bug?extid=6c746eea496f34b3161d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

