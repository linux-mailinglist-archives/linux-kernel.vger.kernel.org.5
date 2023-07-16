Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78E754D64
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 07:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGPFBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 01:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGPFBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 01:01:33 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A131737
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 22:01:31 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a1ec37ccbbso5502315b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 22:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689483691; x=1692075691;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc8P9j4aAtUD818FUv9FldLGl7WtvU/qesSGY59z6is=;
        b=FMRypqjotF0kCTr2lLKDPmPZ9XaMvJnSxPduBQ0Z9khboAdHbrVtSkYqNrSnhD42zD
         /BcCV2Qcd6/6xXGz2cptWBQ2AYn0AuTONnkCeVlLioO1YKjwoFiAnYHOas3DVHgS2tiJ
         cRaVF49cGSTlke7wUA0CKPzIGVgmzk/uVEolAAMXKpokYwE+8i5DsrcUtRVBxR2w/73w
         lN3f3G+3odTLFFRNLpJ0otNiddyukeDUOH1bcHJm09vXuWmijicKFGb9Swg3JCsTDfdj
         wX4Zq5P6pk3e45rNBA+ezUmudUJVTAznLQnTH2dQOb71TVnOBVlX4aYWU57HoIGAAAHx
         aZ2w==
X-Gm-Message-State: ABy/qLbSAmyKhypeb6DVOe+nc/X5bJ9ed4uAoGvWVa0l6r9RX4OAczBQ
        Z4wh0hI1vo0gk2Dug+asmezWeH55zguqZql294O1qARPTt3L
X-Google-Smtp-Source: APBJJlHiKkQSYHWZqiMGK6JjPBORaD5zWjOurp/X4RHYedM4t3zbGTgydgOk6gzh9XX0dFzBM53cFrKdyB0aFSTeEV/ZZD4WxY07
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1316:b0:3a1:e88d:98ab with SMTP id
 y22-20020a056808131600b003a1e88d98abmr11466633oiv.6.1689483691033; Sat, 15
 Jul 2023 22:01:31 -0700 (PDT)
Date:   Sat, 15 Jul 2023 22:01:30 -0700
In-Reply-To: <20230716043411.4950-1-astrajoan@yahoo.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004209890600939346@google.com>
Subject: Re: [syzbot] [dri?] KMSAN: uninit-value in drm_mode_setcrtc
From:   syzbot <syzbot+4fad2e57beb6397ab2fc@syzkaller.appspotmail.com>
To:     airlied@gmail.com, astrajoan@yahoo.com, christian.koenig@amd.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        glider@google.com, ivan.orlov0322@gmail.com,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, skhan@linuxfoundation.org,
        sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4fad2e57beb6397ab2fc@syzkaller.appspotmail.com

Tested on:

commit:         d1d7f15c DO-NOT-SUBMIT: kmsan: add the kmsan_exceed_ma..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=101d3fdaa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36e4a2f8150fbc62
dashboard link: https://syzkaller.appspot.com/bug?extid=4fad2e57beb6397ab2fc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15430342a80000

Note: testing is done by a robot and is best-effort only.
