Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CCD799659
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 06:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbjIIEni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 00:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjIIEnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 00:43:37 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF561BFF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 21:43:33 -0700 (PDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-26ecc4795a4so3627635a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 21:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694234613; x=1694839413;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9VOH8rEmp3GKpBTMA8aMapsiHuFFJuPNIe8SZwLu2Y=;
        b=wR+rJ/Z5N4MoXKfhkvojDFuQjAsgfAy1sNYHVDY3UiC5tLqdZuptqyNLL3zo8Zv6E4
         4dFU1xbbbXaSUEvJpvbqjZJ4d11hlXKFcnLpg/LieaYiJ3wW4AP1O/Dk6LGRyL0K9RVO
         SfkjRJHoQxakzE4ANWNlsAol+XzNsXn5P2OzMFICovoj0wvDgyGA4g3fkEtacLc+mj8t
         pv77kBGG0NpF/yzoYvuiY3Doo7GFJ/oFq3Eqn3rWgvmbu1wtV1quWFrntCnsm0zXkmDe
         4A7V8gPVZ4mx3Cix4m9xym+udGmyb7tcDmii0CHrbEGN2AoBXbZ0FHS5Rh8ruf1bZsBR
         zGKg==
X-Gm-Message-State: AOJu0YzJSmsC/K86jwROkq/bYOndK4NlNlSDs2fVInVfL5wi1e8PFvXp
        LJvqjqRH5G9eBLpM7CocqHlJi1C18YZPw+Qt0K90jQ7QMlsn
X-Google-Smtp-Source: AGHT+IGMhh/j459Gzt/rEiiX1DNfKO4klsksx1Q7EqO75mEvJDscH3PEPRqqESz+KAP2R6r38tp5WZWFAHOZRTk6eRefYk49KXYm
MIME-Version: 1.0
X-Received: by 2002:a17:90a:aa81:b0:262:ef07:f30a with SMTP id
 l1-20020a17090aaa8100b00262ef07f30amr1097707pjq.7.1694234612944; Fri, 08 Sep
 2023 21:43:32 -0700 (PDT)
Date:   Fri, 08 Sep 2023 21:43:32 -0700
In-Reply-To: <20230909034207.5816-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004554cd0604e5bcc5@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
From:   syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com

Tested on:

commit:         32bf43e4 Merge tag 'thermal-6.6-rc1-3' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15137480680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e82a7781f9208c0d
dashboard link: https://syzkaller.appspot.com/bug?extid=b591856e0f0139f83023
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12eaf0e8680000

Note: testing is done by a robot and is best-effort only.
