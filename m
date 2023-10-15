Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B927C9853
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 10:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjJOIMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 04:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjJOIMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 04:12:33 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34798D8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 01:12:32 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1bf00f8cf77so4893047fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 01:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697357551; x=1697962351;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7s82+roOPlfIxFxcesoe/agXXe1PG2B5JIfkV+Tn4I=;
        b=F68VQwy5LFDcxZApcWtHMi0JFRwjzy/vRQewl2I0DVITA5rdH1lTygKH7r0wp+UypZ
         zkRyFz91W33DLRuISpNw+zXLcZ3Xr8GK/GHPHQeZTQ5tFuL3IsxvyZeBsriHHqMsa3Mh
         G4k8oGGZCxgiZ3QQ2hLwgRIDFnHPrKHM+CvaHYvnBWra6t/Furh594p8ysmzrEKxFpVK
         ng+wiR4UEXpAILysZuh8rL27uU9SmLoW+0lN/q0f4HoiTbGRnvyUnpC2hhPN7PAidxDO
         YIOM1sRcx4HlBFmGPnXCDWvOjMiTB7C4IFSbZpgZmqJmnFBOF+74+JX2xg5q1+zVkczR
         vBEg==
X-Gm-Message-State: AOJu0Yzmhz5LwoTsHSUSb4cNSbV0mfoZCnNbYW4fDa3+//QnNPGMAsVI
        DJjSFWWoRN8dcsJTziYbpxWuh/YfcNf7GxYO4GQ/bZXUh2R8
X-Google-Smtp-Source: AGHT+IEMjWaIy/57FSEVmhDw40ov753cX5LYfycW4Hln1bHmXvX9Bu1nnktN5x4Oam9mGbywXo481e5Vb22JA32YcZU5nZTiB+C4
MIME-Version: 1.0
X-Received: by 2002:a05:6870:41c8:b0:1e9:659c:3819 with SMTP id
 z8-20020a05687041c800b001e9659c3819mr5453327oac.9.1697357551325; Sun, 15 Oct
 2023 01:12:31 -0700 (PDT)
Date:   Sun, 15 Oct 2023 01:12:31 -0700
In-Reply-To: <20231015074757.1816-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7568c0607bcd926@google.com>
Subject: Re: [syzbot] [dri?] WARNING in drm_prime_fd_to_handle_ioctl
From:   syzbot <syzbot+0da81ccba2345eeb7f48@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+0da81ccba2345eeb7f48@syzkaller.appspotmail.com

Tested on:

commit:         9a3dad63 Merge tag '6.6-rc5-ksmbd-server-fixes' of git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13e3e691680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32d0b9b42ceb8b10
dashboard link: https://syzkaller.appspot.com/bug?extid=0da81ccba2345eeb7f48
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=102c4e75680000

Note: testing is done by a robot and is best-effort only.
