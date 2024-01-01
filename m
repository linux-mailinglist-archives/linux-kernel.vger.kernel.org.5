Return-Path: <linux-kernel+bounces-13816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8338212DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 03:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2170F1C21127
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 02:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291BE81B;
	Mon,  1 Jan 2024 02:45:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6447F9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 02:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fd42a187bso59241645ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 18:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704077105; x=1704681905;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kS7kDRo6FcBGmx7H+u1tlBLA+0dKmu0JrW5YNpFdNwg=;
        b=sJlzfaUqwvtJuzpruCD/rgjWS35PR3F5nJ05+4udAvjgXCg/NLmeWLc7yFAHTYtAPd
         wju2LX9z/xqWPEgCE8IcWTEb536ORcIu5BxopIOcxZodU+2r4ZNr//wBzM06nWhlH08B
         Egq+9EB+K4BvsxIal1BId4W4H6evKbYQhAoBn/VxVWnPKHWrwA1qbCWdxBaK2wO53Bjz
         ON/luhr7vy+4B8AI1PzyXJtsWHz3iAVB2Ailz10o8uqAYvkXEOwvsyezx/MQ0zy+m6lx
         lkk5vgWPJbtvkRihpEDxg1N7lAJXfOwfvQCEwZNb+N14501+dUb+VT2cGFyHHXYoneCv
         3nMg==
X-Gm-Message-State: AOJu0YzES2DMlCwNxI8FOfHt8xsluWhl3t4+F8eOuqwGmvZnZnGbamYf
	SBeFhYZpgwoCGEyRBlgSmpN0FbADfncL2VgReOIVxGcbHMhx
X-Google-Smtp-Source: AGHT+IHWgIDaxGQvYi1VTahp2UD0hE1QPRb9wJ2oDiHh45bb6w7nY9rFJDruDzFCV5t69FfGrpwUWh5NNzRlmwLO5jv1I3vxSrB8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b89:b0:35f:fc9d:3872 with SMTP id
 h9-20020a056e021b8900b0035ffc9d3872mr614193ili.2.1704077105527; Sun, 31 Dec
 2023 18:45:05 -0800 (PST)
Date: Sun, 31 Dec 2023 18:45:05 -0800
In-Reply-To: <20240101022525.2537-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b84f1060dd95e44@google.com>
Subject: Re: [syzbot] [dri?] [media?] memory leak in get_sg_table
From: syzbot <syzbot+9b4adfed366b14496e7e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9b4adfed366b14496e7e@syzkaller.appspotmail.com

Tested on:

commit:         610a9b8f Linux 6.7-rc8
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=115abdd9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcb7609da8da79e3
dashboard link: https://syzkaller.appspot.com/bug?extid=9b4adfed366b14496e7e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c685b5e80000

Note: testing is done by a robot and is best-effort only.

