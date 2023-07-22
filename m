Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5075D976
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 05:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjGVDnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 23:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGVDnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 23:43:41 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332CE30F2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 20:43:39 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-560ce5f7646so4648787eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 20:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689997418; x=1690602218;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAMEMAdmbmttw5YPvNXuauoZBE1q9FfZAQHS9dSgDjE=;
        b=hdpHLORmytj1pJWLKDLkNC2HoJBtHzFEJAfWUDU/W4KNYUZ7zvg2kJxX5DE+qqGkiw
         JlRR2D7yrhFbY88kJ/oxmGQ6Hbq8kcKspQpZ0VggwIalS5Cl/chl7aC7E1DBM+Vm/8AN
         pIcNftU7tr8EEyQb9QvWfgQFLqjnB6a0K69vdytg64vbx9Ac0iHOXirUT57WovJ+iLPV
         MgENZMBn85t4uCuRzsg45k0ZqSlY9xHioeU8g9WXfpFaVvT9kGOIFvUY1FiMjAgEmv+h
         MynTEi45i9Rt13NbbeAA0qpMnyD9P2iacrvEWXRqM4wU3J1DatYki+4KKmvp9RELq8hG
         LLFQ==
X-Gm-Message-State: ABy/qLYYUsgAX3d+MesxVDijk/VJwbFMGtCQrI66uQICCO/di1e46Fwo
        FHeoWmp4teY+KoUZ8vbt4DQqWvRiBxz+A8AUbsCWp5tvfeCJ
X-Google-Smtp-Source: APBJJlEy9qyQ148ZIoOWJ4EYZ/oCstSNClRmiVPCL1SHHGNqvxM1pHgpncz3oWi77/QVcFat4l68BAu4nr7IhaTf6yAXnhLT53UB
MIME-Version: 1.0
X-Received: by 2002:a05:6808:180e:b0:3a3:d677:9a8d with SMTP id
 bh14-20020a056808180e00b003a3d6779a8dmr8384853oib.0.1689997418550; Fri, 21
 Jul 2023 20:43:38 -0700 (PDT)
Date:   Fri, 21 Jul 2023 20:43:38 -0700
In-Reply-To: <c0c7247d6a133b188c8e9780f243ae29@disroot.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cddbf806010b2fe9@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_show_options
From:   syzbot <syzbot+155274e882dcbf9885df@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sel4@disroot.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+155274e882dcbf9885df@syzkaller.appspotmail.com

Tested on:

commit:         aeba4568 Add linux-next specific files for 20230718
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12db078aa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7ec534f91cfce6c
dashboard link: https://syzkaller.appspot.com/bug?extid=155274e882dcbf9885df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=158d50bea80000

Note: testing is done by a robot and is best-effort only.
