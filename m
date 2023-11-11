Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AD47E88E4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 04:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345635AbjKKDOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 22:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjKKDOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 22:14:08 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0343D55
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 19:14:05 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc5ef7e815so26069955ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 19:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699672445; x=1700277245;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zsQfK3khrVm7AtTi6cOcJgERlxBmSXjFeSSjk7EZFI=;
        b=voi8aj57NG0pUPLT5oxeiirNoHOfcTa+0QtrRe+UAiNgEi1rzoFK7vD6iVf8qyPMPq
         GK7+tPXLmFxnaDDImuzxrUduRFqXczlK/kL9VTiQByZfkG+5piwefr5Nlji7SWSirKxc
         LKWQ4xGSIACkQ76a5M2XcEaY0xVwYsjUZOhhf10cHITGQe7fju89iZhZvTtV6MgvgXTx
         UDWdY60v0fEVdPuFowYE7ReSiiHNiPc2LV6SUcmihFwfBH30iuzgxYzx/kBkvdnooS6n
         wThqblPhGoJb88icgVs6SVHe1lQnMt8R9wcD2gOCus+6/gmKT2wpk35nq0m2OidjI1lo
         r+Yg==
X-Gm-Message-State: AOJu0Yy592X1AgUBdi4woiqLNZ6j5rGWrCtFZYaLCfLvJTwIYfXrbQg0
        JEATwdOyReouDsGGC7xDDrzx2WVaC0+D55Nn0Y5EhAfvMK3j
X-Google-Smtp-Source: AGHT+IFzZkyZwvkXOQKh6ZRqLmBmrC5pcpNN90X6ZrCVFYh6HTF02yhEdoWwF9W8WOcO/EbGN5ro/waB31436o6Sqjdm05G/DsAr
MIME-Version: 1.0
X-Received: by 2002:a17:902:9b90:b0:1ca:2620:78ad with SMTP id
 y16-20020a1709029b9000b001ca262078admr305962plp.8.1699672445411; Fri, 10 Nov
 2023 19:14:05 -0800 (PST)
Date:   Fri, 10 Nov 2023 19:14:05 -0800
In-Reply-To: <tencent_4FE7DB06CC92DC064989ABAECD6EC7CCB706@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057e8d10609d7d4b2@google.com>
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

syzbot tried to test the proposed patch but the build/boot failed:

fs/btrfs/qgroup.h:433: undefined reference to `find_qgroup_rb'


Tested on:

commit:         30523014 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=4d81015bc10889fd12ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ce1eff680000

