Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D047B07C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjI0PKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjI0PKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:10:24 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80041F9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:10:23 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1dc580ed1e4so25423823fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695827423; x=1696432223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6qE2XlTa4u4RBDlvYz/Aw+cZGD4Gks8ccLO/qfOPBU=;
        b=lJysEJIC9qz0/4YlsqtTcN60GXIFp91GS/arzc+55wNNJGzPYaqvdI52wAyenrDyzT
         1rNkiNTtU+xhxhGdNxTJ1C/9Hz+932lQ9leXo3nn31dIZ5NOwWx2aQyIN+c0eT6kCt+q
         lUu8h6HZKVw3lqxS7l8X4pfi4kJ/zUbgZy4A6YdZAspf1gBEku1DjiUDaLSCaezkej2c
         hrwfd9EJ0um3GVSMBGPwBTjsdYS1U+SfNM4lhaSTXSTxNEIGLmvH5SwOBYk+dt98T7OD
         wD1QyQnyaCdO6/CoZ9I8BPKH2dj4q33UpTGji4RnlNos6qDWvndJ+aosCWhrvnZW4KZX
         Wq6g==
X-Gm-Message-State: AOJu0YyOEFMEeqo0SIqHB23KqsNrJ5niPUBoAWG0oX0LD2wnX0UNKWMZ
        yXSaXc9kd02qw8e7tEnua8AUO+n+bzNNMihfglJ0CdhRhRci
X-Google-Smtp-Source: AGHT+IEFVwYkF4pSZdjsYdqAD/xZB6kBdzYdkZYFLAG3QuG2GXvs6P/b93hLjfBc2ENBC9VtkK0vGxM/1mdAklvW/skrsm/5zsau
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c342:b0:1d5:a24a:c33 with SMTP id
 e2-20020a056870c34200b001d5a24a0c33mr861602oak.8.1695827422969; Wed, 27 Sep
 2023 08:10:22 -0700 (PDT)
Date:   Wed, 27 Sep 2023 08:10:22 -0700
In-Reply-To: <CAOQ4uxjssgw1tZrUQvtHHVacSgR9NE0yF8DA3+R5LNFAocCvVQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000258ac60606589787@google.com>
Subject: Re: [syzbot] [overlayfs?] KASAN: invalid-free in ovl_copy_up_one
From:   syzbot <syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com

Tested on:

commit:         8e9b46c4 ovl: do not encode lower fh with upper sb_wri..
git tree:       https://github.com/amir73il/linux.git ovl_want_write
console output: https://syzkaller.appspot.com/x/log.txt?x=10d10ffa680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb54ecdfa197f132
dashboard link: https://syzkaller.appspot.com/bug?extid=477d8d8901756d1cbba1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
