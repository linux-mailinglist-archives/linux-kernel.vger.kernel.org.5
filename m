Return-Path: <linux-kernel+bounces-12420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE0E81F481
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C431C21AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E37D1C3D;
	Thu, 28 Dec 2023 03:58:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5360136F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 03:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bb3ab75c49so6776339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 19:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703735884; x=1704340684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BR8ESoASuU8V2RWc34DU7+3qPu93Hk6sdH8cG4pUQuE=;
        b=C6owqL5YSMQRsPdXDASr4mM4hNF4Fpj4noPdTAJqrTVTa+A5yJ/zDoWslkeCvY8Fps
         QoRLs/khiyuIW9bgexESW5bNIKzws7CbRU9EC9mI9i/Usx3iT1qBkXTaNKDR05fQP5TQ
         fyInMrG+bYcx/glLeUX6G4FFvfmlYwIienaxUB/HA4wQFRKQ521z6r08f3mZG7CKtNwN
         +chDLicx1ihpg88lsrTr6llJS+l6Hh1VwRrN9at1bnYSiw35PXilEk2GbFxQPlz3Uz5/
         s3kggpSF4eipsx8czZslkmV6Jl3Q5CEuYlMSu/gHZAcWlzm4SlmiWL5SGb2iQmtX1cJz
         9KNA==
X-Gm-Message-State: AOJu0YyC5A4PsKDzmhGayvSFyV4y82pdzZ6fWr7jnevqpecom0pwKkXM
	tETPdE7apUP/PLT1ungZPfM8XBKd3qaU9b1psWqJrjdFnVRF
X-Google-Smtp-Source: AGHT+IEP0QvhbaZW3pduNGj5tGoAXor/EUbCFTykclDEmBcqVr+ckbo0XgxqPTMmuEtoUl2/HrHAlRLEShi2mqTFslyL0khjgl+G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:35f:d9cc:1c9b with SMTP id
 k8-20020a056e02156800b0035fd9cc1c9bmr1701210ilu.0.1703735884090; Wed, 27 Dec
 2023 19:58:04 -0800 (PST)
Date: Wed, 27 Dec 2023 19:58:04 -0800
In-Reply-To: <59815d0e-2f44-408e-a81d-989df3323f72@bytedance.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029978d060d89ec2e@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in
 scatterwalk_copychunks (5)
From: syzbot <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chrisl@kernel.org, davem@davemloft.net, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com, 
	zhouchengming@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com

Tested on:

commit:         39676dfe Add linux-next specific files for 20231222
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=104d06d9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3761490b734dc96
dashboard link: https://syzkaller.appspot.com/bug?extid=3eff5e51bf1db122a16e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13756fe9e80000

Note: testing is done by a robot and is best-effort only.

