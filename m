Return-Path: <linux-kernel+bounces-6465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D445F819957
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE20B2332D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3FC1799D;
	Wed, 20 Dec 2023 07:22:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048431773A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fc7395f28so3795495ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703056924; x=1703661724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGJkO0kApul/wO135nEZ9Xd2t/pC262oHlFIcCTbaZI=;
        b=H9FMUcr3cL4i4jVfL/AoCzTFbJpn92cJwrt/I6AhJ0mQprzV0LPv04wQyUHQamP5c1
         SaAcGqsbZeQ2mlSsthZQ05RQNe8v24gYxXWhLS5IevYnvSTA2icTrdZ6doNw7H9Ag0mv
         tIPFFh1pk5Q7926ej0f4VzXELIa7LCFF/vjq50BLgnKGp8BCX1uBewxofBb1qJep9PWY
         1RzkHsR/xUn/rpuFxbxJ++/LW9o9vB8BYtwsuq6iQSWPobaaRlT0wDz6Su9FxURUoCOe
         v3uFUWQIU46ZtyGoSNnnykDkLV4KmYx6doFXMuHtw5OGUi/SUOKEYsiRwuRnzs98o2Gq
         +MPA==
X-Gm-Message-State: AOJu0Yx2Ja6O8NrOHJiVAgGGRX5psLU5ZfL0wey8HZ0qs3Je2bxju0H6
	znyR+wknEPMSgBBjkyDFoS6g41sjUROjfVDr0EUDhQWkH8W9
X-Google-Smtp-Source: AGHT+IGff/liQFCxpRedi+Lie0YDPN0KWxNWdsZZ9ehtlXQwZdg0YZDTdLkRfgUT6YCCizWwwmYeIcLT3Ha+BEW8dikRyTMjBIdV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d30e:0:b0:35f:ab18:74e9 with SMTP id
 x14-20020a92d30e000000b0035fab1874e9mr273092ila.2.1703056924266; Tue, 19 Dec
 2023 23:22:04 -0800 (PST)
Date: Tue, 19 Dec 2023 23:22:04 -0800
In-Reply-To: <tencent_ED8C99A7EB86C012DA86504993EEC1EECA06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000d801060cebd7ef@google.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
From: syzbot <syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com

Tested on:

commit:         17cb8a20 Add linux-next specific files for 20231215
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11bf56f1e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec104439b5dbc583
dashboard link: https://syzkaller.appspot.com/bug?extid=8ffb0839a24e9c6bfa76
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15903701e80000

Note: testing is done by a robot and is best-effort only.

