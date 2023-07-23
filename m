Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5085975DFB5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 04:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGWCV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 22:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGWCVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 22:21:25 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31660E6A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 19:21:24 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1b78a4797e1so6309656fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 19:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690078883; x=1690683683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOA6MBO5eeYzMXhIGdW4VuAaS2Ls3qmxsIYYP7c8nLo=;
        b=Nq2G6D7WwzL1xzCF3Ge/3yPzN7roRl4+ioLNh9CX3YK1Zd+KNPh6xoihpzY1wdAimE
         Mx1uFzQAisIFUUF4WnBhZlXlOJwMOPB1kXHKWHuG3xj0+0ELSdcoCO/i6T1yMJXdzv6m
         VY3kEtjdZ4dIv4aS5Ema8RBRzJXF2/41ylBxYO02A+2j+nknORicQAlzRPEnM9up2/3y
         +XT5jC3FEXRt8rTVJDVvSvzPB6VIE21FO6Wl8NWekGjMdIFG4eg52tUPmLatetXyrWyl
         /eJ/F1W/8m0gu2hR1tmP4rClQMeFUlKBhEjxHggb47IPr/snwu6ZEDtzbQSFZT3aymiq
         1QXA==
X-Gm-Message-State: ABy/qLarmyzJGv/cZz1NV7cCcmOaojTjEOX3b5ofzvKUBNlFDTWLi+I3
        GAS68nM8k5mXdclpSqULSz9vC2jskcAuRqNcSJ0v4max1n5X
X-Google-Smtp-Source: APBJJlHiUKIeM3iw2P9N2qCURKs/ollmVxptg5uOxvpuK9Fk8papl1lHycvMuqMND1sI9IQ/uSo6Fghq1Bu409FlOi4ik0e5zw5T
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a8a7:b0:1ba:e6c9:7ad with SMTP id
 eb39-20020a056870a8a700b001bae6c907admr6815673oab.7.1690078883592; Sat, 22
 Jul 2023 19:21:23 -0700 (PDT)
Date:   Sat, 22 Jul 2023 19:21:23 -0700
In-Reply-To: <e5a6c3be-6dd3-4c85-9c5b-f9fb7aca0b36@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fc04d06011e274f@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in
 read_descriptors (3)
From:   syzbot <syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, khazhy@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com

Tested on:

commit:         fdf0eaf1 Linux 6.5-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.5-rc2
console output: https://syzkaller.appspot.com/x/log.txt?x=158187d1a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77b9a3cf8f44c6da
dashboard link: https://syzkaller.appspot.com/bug?extid=18996170f8096c6174d0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1120305ea80000

Note: testing is done by a robot and is best-effort only.
