Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B897F1505
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjKTOAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjKTOAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:00:13 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6599BEE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:00:10 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6bcefd3b248so6530220b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488810; x=1701093610;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpI9gFjUfolIFijx5N96axTIOuBS4O5V9zNkug7v1zY=;
        b=V0am+9ESeSyfeRR+FBpXYV6KkAZxHA8lwC7VxqHu89gd/4IiZPKN2e2B8g2EO94hkB
         Z+GYnBdTCwyh0kUdV9EMGHUE8fhsbDeN9Lr0B7xoGwlIRMILzwi0QYv1JUPBkR2/BbqA
         dEiCOpzYfzAfg/lfQsj8TWZ3yCOYayNbLzdSvKjEAyNt4XzNlZVnOuXAKsfJvk9AxiW8
         l84u8b6TB7pe8pjcgvxZrHrN4UvZRiq2zmr2So2Pc20OAgV7CIVBICJBfViU+1niOtyh
         tk+erraSx78uWg2kAQN+Ip69lDWKWAV0557agHeS0UO7CFMmoEBojUjTyKs8SAU0G8h3
         TFWw==
X-Gm-Message-State: AOJu0Yy7VIVnYe91IyM0ioLK8z81LVPDE91pEsUmQ/XuiNHkSVQPVrcV
        1HEAl71djLdYUzzZiHfG1iP4cc8YeKTSnVQYOKur55gLDrkV
X-Google-Smtp-Source: AGHT+IH/v3SRnneOlFeLGXcQhupKdlMALhBheaY/StPMf8JqxYNzQDRVwV1fBlPrChahwsTI+Ew9R2jEWMmR6WUJnPxBhdAo5TqM
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:6003:b0:6b5:d7cc:4dbd with SMTP id
 fo3-20020a056a00600300b006b5d7cc4dbdmr1767455pfb.4.1700488809352; Mon, 20 Nov
 2023 06:00:09 -0800 (PST)
Date:   Mon, 20 Nov 2023 06:00:09 -0800
In-Reply-To: <tencent_0A6DB773A6D6B36B037E496063AC044D5705@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d12bb060a95e7f8@google.com>
Subject: Re: [syzbot] [dri?] divide error in drm_mode_debug_printmodeline
From:   syzbot <syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com

Tested on:

commit:         ac347a06 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16b7cdd4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1001c400e80000

Note: testing is done by a robot and is best-effort only.
