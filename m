Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983867EA92C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjKNDjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNDjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:39:07 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AA8D42
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:39:03 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-58b57d05c70so4800033a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699933143; x=1700537943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6uGRbqXiV/RdBfoy3VcxyedeP5/+ifHUBxMJVggmy0=;
        b=VD5RzpA3EBIuASEOJTgPp5x1mIQJESMrAVOR6rzJmK9xPhmygCNm2216v0/Gh5AC06
         LrJl0bue5w15oiH48F4E6cOFc99nsp05kvpAD4je3bG88G/kQ9lcwOCFescYiTVguig9
         O18GbJIX2Kski5LunsuIfBSqkTUAbjBWln7plEjoS2VpNAuUVSgnOYBuVMwksGIjWphm
         +rXeUxn/RF9u+4AEvKryXlya3PuGHKfF1pEYkvQ64TFIBXzLLBPBSA2Zb6L3CxEkYtG6
         5Mh0OuzzU2G05a7+4SJxGTSd3rv1A75RfxCJw1WppJuRKjoixH9zuirzMz0d5nqSJWKe
         V2nQ==
X-Gm-Message-State: AOJu0YxAnX3yI2CxrtqjQrcH8rmuDsQAaQG88LrTtn9VecIKDodHNS61
        Gh4UoWZ55GeU9ZhPSk5a1USOTMMtUF7FauwuYRsKJ+VmT+QR
X-Google-Smtp-Source: AGHT+IGtcPlt1JGrz4cF9ZHE0B+Xu9g9wgw+bvqNKMnJtW7SyiQYk5c84YU7XnNStLyWfphOPcGT7QAm6u8kOMhD1FdNCIq9/Q0t
MIME-Version: 1.0
X-Received: by 2002:a63:105f:0:b0:5bd:4149:a123 with SMTP id
 31-20020a63105f000000b005bd4149a123mr240302pgq.7.1699933143096; Mon, 13 Nov
 2023 19:39:03 -0800 (PST)
Date:   Mon, 13 Nov 2023 19:39:02 -0800
In-Reply-To: <tencent_C03638974A36004A90741B76A566583DCD09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022e7ce060a14878b@google.com>
Subject: Re: [syzbot] [squashfs?] KASAN: slab-out-of-bounds Write in
 squashfs_readahead (2)
From:   syzbot <syzbot+604424eb051c2f696163@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/squashfs/inode.c:128:60: error: use of undeclared identifier 'sqsh_ino'


Tested on:

commit:         13d88ac5 Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=604424eb051c2f696163
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1566c75b680000

