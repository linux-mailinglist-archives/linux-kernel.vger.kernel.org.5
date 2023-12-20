Return-Path: <linux-kernel+bounces-6431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6248198BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB1D2885FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B821401D;
	Wed, 20 Dec 2023 06:43:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55B013ACD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7aacf63b9so33629539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703054584; x=1703659384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGlEjSAHnBtCLlsDDaOQ1qsonCVPPhN5ND5K9+RQgSE=;
        b=D3kLH3G3xnlHyrFX1k4rmFLRFxHEnrPiJZYstW8awjCd4i+/lylEBI+WZJdQwupI6G
         hXe4mo2klhV9XwxrHIegubTTAs55ja3JoBKHGbVTMlnYyjvgKSpuFi+/tZE+Wm345IR8
         oxS3MNa4u6w/QshSHBmzKXoZjFGEMGwRfwMv4r01GNeMeJ1shmUrw2oiGHzjGCc18F48
         4sX8vYmr7blo1Gti6g1nyniET9UYaUHwh5ml/nLWGUHiGMIJvUWJxrmQ6uiWB7gRn8Wt
         MyVRJ7Ep+SAPZRsPCxzeTILshIrigkuH0jUvnxfo/ebRjiDgFy8638gUtPvX78MD7OW1
         pdQA==
X-Gm-Message-State: AOJu0YwCXNdwhYCA5OUrxhmzt6M1iYdAawHb7wJ+1XI8dkKiIlF1/7J1
	2FrmiS0Js1bVLAeE8yfFV4HhOnMn/110veEoS2/An/wIa+U+
X-Google-Smtp-Source: AGHT+IHzU9ID4FIAUmeLJ8cojUf4Bpp2mkxS3oUOk/Fav/KqdpyNKdUsbmPqD8xL1N7zWiwTD+qoL76nvdEUXOuNQEls1397ohnL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410f:b0:468:fbcd:15a1 with SMTP id
 ay15-20020a056638410f00b00468fbcd15a1mr335796jab.0.1703054584084; Tue, 19 Dec
 2023 22:43:04 -0800 (PST)
Date: Tue, 19 Dec 2023 22:43:04 -0800
In-Reply-To: <tencent_2D9956CFC10D9425B98DCE12085DBEDDB607@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000847e07060ceb4b3e@google.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
From: syzbot <syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

crypto/algif_skcipher.c:126:48: error: invalid use of flexible array member


Tested on:

commit:         17cb8a20 Add linux-next specific files for 20231215
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec104439b5dbc583
dashboard link: https://syzkaller.appspot.com/bug?extid=8ffb0839a24e9c6bfa76
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a124e9e80000


