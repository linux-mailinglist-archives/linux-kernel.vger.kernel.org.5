Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3687E1840
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 02:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjKFBPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 20:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFBPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 20:15:09 -0500
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5619E0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 17:15:06 -0800 (PST)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6cf61d80fafso5723395a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 17:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699233306; x=1699838106;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIox3F4MiqG8TxsO0HEjtYkMTrcLIgWSkaFAIbL67EI=;
        b=awpVeMRFYbOLlTuQ6hERzJLZNNbzYf2+jkgV1ZyNyyIKpmWp6wTCC/oy92aYMJuudM
         iTirmWnqsHG8yQ5kOg2p/4068PpCfSNgt8yA7MNkVXe7BN71qVncHyI/MU7zFxWeNKF9
         I7G3+7k+iDggh5oci7R94+7vhqfx4jn1u+YUg85vTGMVzAM6e0baFbDNqhkcDB5sz0fL
         eaEb7ErFHPq2z0bJop0qt3D8eSKqUTFq6IRipk0OMYBSe7nexLUjTa1fLsMoYwogmtDO
         OpS4NS6m4fKyYj5eDC/2+TbBtBd4RtJsX5vj06DTfim4qHsmC5UV5V+v7kvZqW4+4iUV
         dNbA==
X-Gm-Message-State: AOJu0YwOmaV/7+PSiOhRi8tUgYzadvMltKSvtvVCDF8h9ujMqeLtWoLh
        ZqgSIWpslsvIIRytp+Mylbk2e2w4HSqKnZ/0vj8tFvMBftFPimo=
X-Google-Smtp-Source: AGHT+IHJRODSgUUzu9S/SUqIer3tS8JzGqDTu+nmWYRZYRycvaZ6SN7D6rezgEw7RlT/Msu4wjLhPW/maV7z/9Xzs4hWZ5AgMsXP
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1147:b0:6bf:27b3:3d29 with SMTP id
 x7-20020a056830114700b006bf27b33d29mr8610622otq.5.1699233306288; Sun, 05 Nov
 2023 17:15:06 -0800 (PST)
Date:   Sun, 05 Nov 2023 17:15:06 -0800
In-Reply-To: <20231106004650.2795828-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ca8d106097195f1@google.com>
Subject: Re: [syzbot] [net?] general protection fault in ptp_ioctl
From:   syzbot <syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com

Tested on:

commit:         4652b8e4 Merge tag '6.7-rc-ksmbd-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11cea00f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=423e70610024fd6b
dashboard link: https://syzkaller.appspot.com/bug?extid=8a78ecea7ac1a2ea26e5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1219bb08e80000

Note: testing is done by a robot and is best-effort only.
