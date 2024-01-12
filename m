Return-Path: <linux-kernel+bounces-24305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67F682BAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F101F241CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D1C5B5C3;
	Fri, 12 Jan 2024 05:12:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F27D5B5BA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bef6895f94so114499739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705036323; x=1705641123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUAN0/y6gnuitLGHhBovtNP9nlFi1OCZs5MJCuuE1xg=;
        b=im4ojZDLf9la7aI6TNl3xe0sO+GnjCdyvGXHtLqBB9hgUA5DL3o6tMU5zq0kFf+QQi
         2+eNDYT+gO8EqHFi8ihkLwyhDD8kcMij/CtjjR9ljeMKVSeN70PgWzhxKVXOXFOAvOD+
         TtbFPWFsvS2vv2y7MIFhVeh+NLNQJ1Et/bifWHok5LEU0vd/kKJguCucP4dP3UcXTxRA
         7PkzZaI2dpub/GI/YzSlHbFhphfng+e26vQFOn3rA6iasaNZc+TQ69B9n30tIVbJJ2Gz
         le00IlQSvOUsvspL87DGiX2LK/9pYOwQuGXKT7g4YfAssk6K16BHHlGPx3L95+fRPYyQ
         ahPw==
X-Gm-Message-State: AOJu0YxxTmM4GhG/vIIyWBDob2pi41i8Tqy77g6NVy0TnvWNuWegR7ry
	jmRYZvvnuPdzEcj3r1FqFjyJnbZzgYcYkGLdcsQTLudnMy3F
X-Google-Smtp-Source: AGHT+IHwgjci0OOkexwxyoVR7s0cy7iY68NrIkpvNzu9HfoYMfkwKzd2rLCaIMsOp56/ckPKJwn2V+XVBEorU9zkdD6UUT3e0Z7X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1407:b0:46e:6715:448 with SMTP id
 k7-20020a056638140700b0046e67150448mr6181jad.1.1705036323606; Thu, 11 Jan
 2024 21:12:03 -0800 (PST)
Date: Thu, 11 Jan 2024 21:12:03 -0800
In-Reply-To: <CANn89i+trzxhZXsW_kLpA2LZxRjRonunOT6dF2d8cgjsNJRPag@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065efd5060eb8b491@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in validate_xmit_skb
From: syzbot <syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com>
To: edumazet@google.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file include/linux/virtio_net.h
patch: **** unexpected end of file in patch



Tested on:

commit:         70d201a4 Merge tag 'f2fs-for-6.8-rc1' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=7f4d0ea3df4d4fa9a65f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c430a5e80000


