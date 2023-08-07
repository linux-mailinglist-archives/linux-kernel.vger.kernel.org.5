Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B56771F0D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjHGLAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHGLAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:00:34 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4B41703
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:00:33 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-56ccbd1615dso6640879eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 04:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406033; x=1692010833;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/c5lQJrnT2mNwrQK7i4Ch7raP8VcpoU7hHlcjeux58=;
        b=g3hMOw+Rc0PzZZrYwE9RiTYm0q/yoTbXfxNIEDY54vFzg4NlsDqWZceD4KOd938dIL
         ba/9I8H8KHOp2QPV94JAgWPVr6c8qAPkp80n+n5NrKAkSABqUibD1laTcDi6C+RWUeA0
         fPRuZj09H8jDxXg2kgT4pVp8S7gQRK4BXrKVORUxnyAaI4WdfrZdpER+rErfDIrw8m7e
         58Z7Xh1Qz1Us9aitoAvb4+5Ui4dvUKpMwsIbBWuTuQG3Rn9NXWinMTqmBNLEb98TBkkA
         lYl9+Yro/zf3SyQlWVqKaxwKrYoFUks1oeenez+oJsGJuTnkZPjYIHKBbXlO1GCwY5W1
         lsqw==
X-Gm-Message-State: AOJu0YyHUuB+OFbOxTC+E20F4niMqd33gEZo9T+Llg2QKVSTJkQn9+Wu
        bMnHW4Eg7Eu0d1vzTomk+s6A/iGJYk31GGhn825KpU/plG02
X-Google-Smtp-Source: AGHT+IGD5c/SBsnDHOLBz0l1l8hV/NeXm3IyvNBjwpDX05/pCwYQ6svuVfn3r1K0HR4ZrggN6gpaUiIKvbzODS1HyIcX/Myl120D
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a1f:b0:3a7:2639:f835 with SMTP id
 bk31-20020a0568081a1f00b003a72639f835mr17094640oib.6.1691406032895; Mon, 07
 Aug 2023 04:00:32 -0700 (PDT)
Date:   Mon, 07 Aug 2023 04:00:32 -0700
In-Reply-To: <20230807105706.1870-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c311b106025327ea@google.com>
Subject: Re: [syzbot] [wireless?] INFO: trying to register non-static key in skb_queue_tail
From:   syzbot <syzbot+743547b2a7fd655ffb6d@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

scripts/extract-cert.c:46:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
scripts/extract-cert.c:59:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
scripts/sign-file.c:89:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]


Tested on:

commit:         f8f02d5c USB: OTG: rename product list of devices
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=8655a96dbf308a55
dashboard link: https://syzkaller.appspot.com/bug?extid=743547b2a7fd655ffb6d
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117b1179a80000

