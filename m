Return-Path: <linux-kernel+bounces-13828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B3E821303
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 05:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8061F22286
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 04:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8ADECF;
	Mon,  1 Jan 2024 04:27:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A716A4F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 04:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b7f4024988so1084197039f.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 20:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704083223; x=1704688023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StQig7Kya5NVkMBq67pROu+BhdvapNEqC8lR4LDn5O8=;
        b=d6UoLu0hfNkPJ5brneG15SF1wllA7nSVVM0jWw+poFktLKw2op5JxUsJbB2j3T6PBq
         YgJPFykxKIOIKwe0xzWguddiJGDUx+tcnOi2IqYwhyyBYtfl1wC1HpsAARwoGCO257Am
         3UA+393dMaWTnJLM8Tm5YZDFV/yo4oUUUn7OrsfMd6bCOKG/Mjw9Ic57Ap4DPPhFxSmf
         3LlnopJv2Q2TxFSAx+6Ba0+ndA5YH6Rh2/8dFNdDQu3LgK4ZJ7D0u/o/vSgweOz7ZQVf
         HF6wgCvsy2oJgLMrZmwmikk4zvQXqIHD/4lNz5ZqMQ+5V1oPH0AJeASyt5McTli2efqu
         uWhQ==
X-Gm-Message-State: AOJu0Yzx6nsYSA6kvRqzO6rds2d5pLSqKleJZT/8fZM/7/GX61jdFRXn
	/QMB+2bYSSN9zTzJ0/UHcQLgUDFXWukknYgS8Hea7CnwYiLH
X-Google-Smtp-Source: AGHT+IFN2epWv3Xgp6OCxJnVMqdjrAltygEK1iYb3yJusQygXgYNsmW9LEonuXlBY8fdjDG/cQHpRu9VSO/GjW4Wpa0wSkK9tNcB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d18:b0:35f:f01e:bb32 with SMTP id
 i24-20020a056e021d1800b0035ff01ebb32mr1875132ila.4.1704083223482; Sun, 31 Dec
 2023 20:27:03 -0800 (PST)
Date: Sun, 31 Dec 2023 20:27:03 -0800
In-Reply-To: <tencent_A9576F5763C6CBF3660361296723B2A44605@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003418cd060ddacb28@google.com>
Subject: Re: [syzbot] [dri?] [media?] memory leak in get_sg_table
From: syzbot <syzbot+9b4adfed366b14496e7e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9b4adfed366b14496e7e@syzkaller.appspotmail.com

Tested on:

commit:         fbafc3e6 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=103d8899e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e81921f96ae24ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=9b4adfed366b14496e7e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=113c3829e80000

Note: testing is done by a robot and is best-effort only.

