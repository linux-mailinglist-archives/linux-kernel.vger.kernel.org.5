Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D27F7F048A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 07:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjKSF5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 00:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSF5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 00:57:08 -0500
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223BA192
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 21:57:04 -0800 (PST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-283a0f1dde1so1658437a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 21:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700373423; x=1700978223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v46mbtTnvoDYYvE8oPNqS+RGsR2MLoBplF8u/J0fxA0=;
        b=d8tBlM2qPLHJPedTrd5h61pWZ6WcB/i2RB1czT6aL75jbPxzMw0TR7IfdmVtB4KZaY
         Qxr3sklpYLLdlO4BW5XYuK2n9FrpkRlPfB9zgGZbrrwxYpk9Rt/nGZa4Z8ED8nh5GPZk
         bIgwJLiVa3wkgx9Tvsp2kiX91vXozQawOf35ejfxndgbQ5cbBm8psKTt1R5MMvMVafOn
         3COF+HNjUcTt3fanFAjbdsW3mVQnoSSeN4hsJS8ggeUQW6a4XCliZc6kHF6pWUQ5W+vt
         FBlvvnt5CbBCLbnPt2OVLesvuWKgRb7h6eZj9kbixN4VzEhgMmra5l2h4suPiGDzikoR
         6jcQ==
X-Gm-Message-State: AOJu0YzG8231G/0GGckEtIagvdDFM64s7ptyKzvTGyG+6+n3FP3OGJ3d
        cYbQrky01pdL9aE2+qBKEK0rL0RPRGKOHk3sDLYDkSW94LjD7u8=
X-Google-Smtp-Source: AGHT+IEDMZ4SDjxU4YCw8X4J7kUOMiEjWvjQa29QrdLrgknruK0lC5b6/lb31PVe4IRW3MWkRYjPKqAm03BuGC+CLu8/hPsvfugs
MIME-Version: 1.0
X-Received: by 2002:a17:902:ec8e:b0:1cc:38e0:dbab with SMTP id
 x14-20020a170902ec8e00b001cc38e0dbabmr1311736plg.3.1700373423674; Sat, 18 Nov
 2023 21:57:03 -0800 (PST)
Date:   Sat, 18 Nov 2023 21:57:03 -0800
In-Reply-To: <20231119050630.124949-1-tintinm2017@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e75e5f060a7b092c@google.com>
Subject: Re: [syzbot] [dri?] WARNING in drm_gem_object_handle_put_unlocked
From:   syzbot <syzbot+ef3256a360c02207a4cb@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tintinm2017@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ef3256a360c02207a4cb@syzkaller.appspotmail.com

Tested on:

commit:         037266a5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14fa1a14e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54e2bd738b08eef2
dashboard link: https://syzkaller.appspot.com/bug?extid=ef3256a360c02207a4cb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c76af0e80000

Note: testing is done by a robot and is best-effort only.
