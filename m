Return-Path: <linux-kernel+bounces-6769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975B9819D44
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D58283C07
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC9620B3B;
	Wed, 20 Dec 2023 10:46:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A637220B0F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b711ddbf1aso620861539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703069165; x=1703673965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhwzOWUIe96iXfsL8wEvV3x/PRT5cLa0RWrM/Ei2Up4=;
        b=f3FGKV/+Y3GDcCsUL4Liv4MA6Irp0Z1J6ZzUOPdpYsIh3V6gwrFsWNP8H2+/e0teUa
         b9nCZS6hUP3kSA9qHjA822DRNnkviyIsiq757HdPaJbhOOlgC9nVHJ/CUM+1UeuNkSq5
         JQgfmkPdvcCWmxdaTvRAz5F+jEPFhEjsk4OgjEk3ahCk+ibr5rQtyH8l2DdAoH2UVIoZ
         DkW79GTf7a1D8doaj0D1bhA5ENcLs0BnJJ5beoFnnjo0wKqp9vcrEgYQbeiwcvu8cE3B
         DVJZebnWZ1FxcsTkuU7HbRfKyYQAVYoUxGbweSljlr4PGrADhE7LYxoEujkU3YSX2ZZH
         8iiw==
X-Gm-Message-State: AOJu0YyocRzaTZpP1ipQlYo9hGU7ijpL8CYUaaDCsn17TWy7Lno72+eb
	tSWOaRQ/7woWQlaKL8ucsGJ+3YLb45z6EoJapnDb27o20/Ro
X-Google-Smtp-Source: AGHT+IFNXWncyNrQZzeUhOfSAETvn7BIzH5vusNvny18nkb634b1+Uft8GqKyL+w7pgui0okkCD/UYsOcGkyLIFdw7JSvi7HEoFK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cb:b0:35f:c8aa:b526 with SMTP id
 i11-20020a056e0212cb00b0035fc8aab526mr142232ilm.2.1703069164758; Wed, 20 Dec
 2023 02:46:04 -0800 (PST)
Date: Wed, 20 Dec 2023 02:46:04 -0800
In-Reply-To: <tencent_35D11227DD835DA5994ACF968DCFA58B8D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097f1b0060ceeb0af@google.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
From: syzbot <syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

crypto/lskcipher.c:218:20: error: 'struct skcipher_request' has no member named 'areqlen'


Tested on:

commit:         17cb8a20 Add linux-next specific files for 20231215
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec104439b5dbc583
dashboard link: https://syzkaller.appspot.com/bug?extid=8ffb0839a24e9c6bfa76
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=155c7011e80000


