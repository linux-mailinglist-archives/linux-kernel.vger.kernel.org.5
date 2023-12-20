Return-Path: <linux-kernel+bounces-6948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96011819FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F76282EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5D72577F;
	Wed, 20 Dec 2023 13:16:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB51825767
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b738d08e3bso603835939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703078163; x=1703682963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yfeog/nNuYRye71DBiEYkoP5y1Dsc2gQsX9HXnoIgY=;
        b=L2QiX4xH3sEpo3cXg3csgvjRkIkdMRgDd17Hy09qbYVdsAduyKXnpJ5AYFIxdAPTKk
         fhISgVDwGJ0JnOtf7eC1iQO7sE3iXV9rDDlWxZT3nst/1/iqFWB+SiHFgrPOQYFHyeic
         WRoQQw3lXrgCvXidXbZhDufXjZsiBPzukbWBPQrF3jpOP26PP+o24vrEdVQ7irRQ9ETt
         lTzg1CH6OTu/Y35Ba4ANjutZ8KJq1uiNXWtRlpVk7htXMZ+5kRhrUaFFpcSZgL0cx+LH
         OkS5UsvZHbAUnrKe0bkvD0lC3fDYMKW9/UKAEe4I7xQ69ti9BWJQA9vHp8+ycr0lLmfF
         ImbA==
X-Gm-Message-State: AOJu0YwVeqMhAGCGB43zncpeBiaYG2B3p2F4phs6GPt+C9wtu41BjozV
	/lpzStUoi/X1o67TeItpbf3sEmxNX+7/t9GyVVoTnUnbPDs8
X-Google-Smtp-Source: AGHT+IEmY0xb+WKglDYvf487bSXQtBbCudKOtBei2RJDh16Ucq/fMv7Q5BcnMqqrYsXikT6SUK1vF8J80wYT6A24oaIX0WSYZ4bF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:238f:b0:46b:49e5:a22c with SMTP id
 q15-20020a056638238f00b0046b49e5a22cmr497893jat.1.1703078162977; Wed, 20 Dec
 2023 05:16:02 -0800 (PST)
Date: Wed, 20 Dec 2023 05:16:02 -0800
In-Reply-To: <tencent_08175DFCDDF2993CCFAB0D88A5BD0D889207@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eddcb4060cf0c85a@google.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
From: syzbot <syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

crypto/algif_skcipher.c:120:39: error: 'crypto_skcipher_type' undeclared (first use in this function); did you mean 'crypto_skcipher_tfm'?


Tested on:

commit:         17cb8a20 Add linux-next specific files for 20231215
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec104439b5dbc583
dashboard link: https://syzkaller.appspot.com/bug?extid=8ffb0839a24e9c6bfa76
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1546519ee80000


