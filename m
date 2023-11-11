Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6B77E8924
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 05:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjKKE3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 23:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKKE3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 23:29:08 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9001FD7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 20:29:05 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2804a04e233so2608134a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 20:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699676945; x=1700281745;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e06a8X/EStFBv/rOIgbSPAh0XSqeJuJSahC714PKc5k=;
        b=RNhtbmOthQIMR/e12TyW1ix8Zj8ge01k8FNRXkLGr9mur7IaNZ+dTi3WYaj7z71A+s
         N1dblVR6E13vcFqx9XcItPyET69F99esim3Y1Xl5EMTNN0SbM4c0SHCeIXVzueeiywDX
         MtSmP8hD3MwOlFzi2ObyrJgWKdkP2ZuuZ9Xdy4L6LOUV45WmHTrMt298qU8tj9P2rXGo
         JN0b+vrsXQGLsn5sfJGq4SLuAR67oYU0LFnOYPsqrWr/6K0nvx4ZjyN643rbSBof85Jr
         KzuNEXvoVS3cmWWvhuQeo4GSX9QEA1JIPgiT+6yvPyo6Z+vvJxuFJDZBodIrcZzc1nxS
         UbzA==
X-Gm-Message-State: AOJu0YyBT+v4b2RsRqDIpPOx/S78Px4bzXdU7xIl/2Cx5Ik6sQhRR8/0
        70tseJY9FOMiCu7nzt4Qca3QkNywmvkssa2aVFcd5hOsNeYH
X-Google-Smtp-Source: AGHT+IFwAFTLqoDavBH94L0CbgAnBMvNA+BkAsvP0qPsvNLT0V2abrC+9Y4Ln6REipfdOIl/uTbOLPkgc7UHeMgajc5GWOY5tJSW
MIME-Version: 1.0
X-Received: by 2002:a17:90b:3ec5:b0:280:929:b64f with SMTP id
 rm5-20020a17090b3ec500b002800929b64fmr280844pjb.0.1699676945107; Fri, 10 Nov
 2023 20:29:05 -0800 (PST)
Date:   Fri, 10 Nov 2023 20:29:04 -0800
In-Reply-To: <tencent_BB46336B9E241B574B011B9B25C6BA6BBB08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008bd40c0609d8e035@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in create_pending_snapshot
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com

Tested on:

commit:         30523014 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=164c7d88e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=4d81015bc10889fd12ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1047e947680000

Note: testing is done by a robot and is best-effort only.
