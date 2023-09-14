Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E9F7A0996
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbjINPqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241163AbjINPqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:46:32 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8D6D7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:46:27 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1d63b88c1edso845463fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694706387; x=1695311187;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RArJlo5ye8urnOy2gyd9OsYoAqUo3/gdNcnqcjssqdU=;
        b=A63JVWTIAVT4U8ktgFRZhT06tLOAXuPWKswhNsynux6eQIhYXiSYkhhsimloHlfsRg
         UcVZbR9qfJtpT56AWz1ehHVLK71pbdL+PGCOJ75cCeKTAD4TJx7lKW9PlIsqau71lCjx
         B4VNyUU5Hg5RZ0+6VOvHymS5eoIpBTdcc22BJTNqPqtW7jKOLr7Zddh5GkbS/iZqRtJE
         Q+lC+KMG843mfjoTUgaUn5l3Lr2zFXpBXpg8eGWAdqD6mvajOJ7RYgBghPn2i/nMJAq7
         CRwJUgIuq7AcCEyWroJym1YuJslCKM1p67h+sm/P4ywkEKUIHmi2vb0H7Y9RYAzLy6DR
         EyZA==
X-Gm-Message-State: AOJu0Yyb8iQaCxwKfz8D7BoBgZ1Etvp2bNr26fFIXjNPre32GoFm76OO
        2lpuV8qvwMyUEvBKIlZnzfyJaXjy2FFmD9+y9TjlcbGTtncc
X-Google-Smtp-Source: AGHT+IF6uNb9IK2O+QDjpLsm23ly5Qk2+0NB1BGNDr1vVzmcpsj6r1rN9DM0+mzTY/GGTklQy/xV7wXLSI31ay1LERgmfbbhfBfA
MIME-Version: 1.0
X-Received: by 2002:a05:6870:e6ce:b0:1c8:e107:4193 with SMTP id
 s14-20020a056870e6ce00b001c8e1074193mr2009281oak.3.1694706387368; Thu, 14 Sep
 2023 08:46:27 -0700 (PDT)
Date:   Thu, 14 Sep 2023 08:46:27 -0700
In-Reply-To: <6fd7f735-6262-73cc-c5d2-b508c25b360d@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037c27b060553949c@google.com>
Subject: Re: [syzbot] [io-uring?] UBSAN: array-index-out-of-bounds in io_setup_async_msg
From:   syzbot <syzbot+a4c6e5ef999b68b26ed1@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a4c6e5ef999b68b26ed1@syzkaller.appspotmail.com

Tested on:

commit:         ff035989 select buf net iter init
git tree:       https://github.com/isilence/linux.git syz-test/netmsg-init
console output: https://syzkaller.appspot.com/x/log.txt?x=13421bbfa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4894cf58531f
dashboard link: https://syzkaller.appspot.com/bug?extid=a4c6e5ef999b68b26ed1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
