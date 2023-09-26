Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12257AF05E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjIZQNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjIZQN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:13:29 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736B0BE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:13:23 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3add3240d52so23393961b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695744802; x=1696349602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghMxj6Q7DUFUv4QcWBQyCNlsSSFlP9qfCWzVXyW67xc=;
        b=jCoDWDCHSynW8Uba2CEpDkiGsgGrmaHhBgo8G5cQTiQ1ELv/TZcbDm9roH6rfAztUq
         Q4PVqkNL28GVxMEJLBK7Ui0d6QuyVGFQ0BIPje0rYWzqdVw59sQ5I1DkJd5QpZyLOKnJ
         MrkNwfvpQixPmh0y1SfG36KnAq4vWt8l8BP6ApyXBbQks6GZc7SrSpYlFSzJfhmQ7Rjt
         KSF0zGv+CrSXIA+6v7B4lmMDLZjIU7TMWnKXd+xc6UaBjn2p+BVMTLfxqHG2t2myLHlq
         wFwZT/tKd6Eb+YnGN1KzM3kePKFiJOHCSCtn245FUlGuiSjbsW2+lpMNO7RQfGHMEAB8
         pLPA==
X-Gm-Message-State: AOJu0YxkgabHr+8wk5oGLgYSgskXWzsRpOy73+upNeNTy6i60hh7RjqU
        hJNigdCgZku413j0Fl9Gs0lY4H8J7O40J+VhKywzuVizqFvWWA0=
X-Google-Smtp-Source: AGHT+IFJu8R7r6R/i2Zmu5Lzt88ngYl65Fkgewf10P4lhSnqWqJcx4CHcghNoc/QOaFcSeISwiqKvZzltzos2fW8FQSYP/dbTcd2
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2a65:b0:3ae:526e:2634 with SMTP id
 fu5-20020a0568082a6500b003ae526e2634mr1596935oib.9.1695744802823; Tue, 26 Sep
 2023 09:13:22 -0700 (PDT)
Date:   Tue, 26 Sep 2023 09:13:22 -0700
In-Reply-To: <kwwrx7p4nfr4qkv5xxpo5nidyyjdbytsulpu7lj6yujmzrnxb6@q63vtmlo3dqa>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a28dd0606455a6b@google.com>
Subject: Re: [syzbot] [usb?] [media?] WARNING in imon_probe
From:   syzbot <syzbot+1c41b2e045dc086f58be@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        ricardo@marliere.net, sean@mess.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/media/rc/imon.c
patch: **** unexpected end of file in patch



Tested on:

commit:         a48fa7ef Merge tag 'drm-next-2023-09-08' of git://anon..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=150188feee7071a7
dashboard link: https://syzkaller.appspot.com/bug?extid=1c41b2e045dc086f58be
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17cadccc680000

