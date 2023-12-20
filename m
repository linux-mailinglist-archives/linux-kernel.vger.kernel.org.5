Return-Path: <linux-kernel+bounces-6416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A54381988D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8BA1F258DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FCC1DA31;
	Wed, 20 Dec 2023 06:16:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149891DA27
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b7399e0707so650973739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703052963; x=1703657763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ck/4otRA/Jx0soGoKFhD8nnwAK5Rhcb6X+WqGbGgkPQ=;
        b=jMfNT47KAxwonS0KoiL+lMUai5PsaUYluS3LKGhpQShgqKWeEsxjQJWaVpydu7R9Wp
         C4gp4ojpBSSMFXn06TbAZs4IGCgVLpMllLLI9+OtWXDZ9/E3NiqHMZaiHBAqu2Y/psgj
         PpKSz2uc2SEZbnz+Prb3t+nz1HZmesTIBQtdsxnV4OpgS0QWDZWoDrsiqzf4sMdz8tTG
         wIl9Z0TN/Rvm8QYGKGRXXw369dX3rNQTjjgsB8qjy/KLEGY28gfz19cNSQX/Wv5zPWjW
         mZHXB0oC3MUZ8o0wSDzLLe7TE7hvRGoYa0oXD2JZCTiBGyUKCdJezDuxX7uc8OcPYsKB
         nILA==
X-Gm-Message-State: AOJu0YyVAFPnaGVrfQ0xHSoIPN54/FEHqVd9uAVugIhEIINbHUXXU4kc
	dmi8MAlPljjp/TLtRfhiIqsip98wWFi7+HsR0IRJpSGfnK14
X-Google-Smtp-Source: AGHT+IHbIC9sweTsqj/SYJddc6Z2bMFaV9GzRFMJso7eF1CWkhcs4EwscynO4qECPgG8F1R6CgF+4Qulo7A8BM4bNgtJ7naFI5vJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2056:b0:45c:34a5:6d09 with SMTP id
 t22-20020a056638205600b0045c34a56d09mr1043513jaj.2.1703052963239; Tue, 19 Dec
 2023 22:16:03 -0800 (PST)
Date: Tue, 19 Dec 2023 22:16:03 -0800
In-Reply-To: <tencent_D1BC2F696F3495C4E80AEC1ECD7C79366C0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e85dbe060ceaea60@google.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
From: syzbot <syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

crypto/algif_skcipher.c:126:41: error: invalid type argument of '->' (have 'struct skcipher_request')


Tested on:

commit:         17cb8a20 Add linux-next specific files for 20231215
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec104439b5dbc583
dashboard link: https://syzkaller.appspot.com/bug?extid=8ffb0839a24e9c6bfa76
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d50921e80000


