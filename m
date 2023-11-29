Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3977FCDFB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 05:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjK2EkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 23:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjK2EkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 23:40:00 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A410019AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:40:06 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cfba9f385aso52972335ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701232806; x=1701837606;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njfRGqhqsOoefYaD8f7joXsFG8v3nrWUT7SaDc0RrfQ=;
        b=BJ5tRqAs0bR6TRpGgQfuomXJqRPRM0aGhxzc5PasI3VPEY/DZF6EcYG8vuNg/vB8Hg
         QYN2sTC54PUWifDCHuxfVhKjeSjPOP3VX325KXKEyns5h3/AGCZ9CridQ1IaYXiUBJ6G
         7SMlrTP14tse7kglIc976GcTlyHJ5p3/eN4Prii7UIU0ep/lPCGvJ7ABqu2HmZfC1exc
         dcRM3T7vOOPdlanlh3IX5fTwJ6Pfg+ZcQlYoDrfhkGO99AumV+zIjlmE8ySJmlgQ6dZC
         SWpe0sl9hsMsPPtK8Re+cPXYLwLeKxwW1pS8TZFbNvKYasMZqo6vEQVcfO5YBW2TMFFu
         mycw==
X-Gm-Message-State: AOJu0YwmLiTiqvhbkytsP3oYEivK7/2JjCEcQaqNXGDokEQ1xoDQbELU
        XuQZp5H8CDLyc3jGBB3dwS1h9oxBRIx6y28aBFU4kX4N6FcU
X-Google-Smtp-Source: AGHT+IHH25QxRos0Y5AS+cc4fuWQ+7K80XpjsFuiLhSt8moA0mwdMYbLS+snQKNTpdY9sv4fk5Xxoi0wsoHDXrM+VykPeyG1rEAM
MIME-Version: 1.0
X-Received: by 2002:a17:903:1d0:b0:1cf:e028:4156 with SMTP id
 e16-20020a17090301d000b001cfe0284156mr1469057plh.8.1701232806210; Tue, 28 Nov
 2023 20:40:06 -0800 (PST)
Date:   Tue, 28 Nov 2023 20:40:06 -0800
In-Reply-To: <tencent_A6904B6E757F76B566FE3D0F37BE966C3609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001837b6060b4321e7@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in rate_control_rate_init (2)
From:   syzbot <syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com

Tested on:

commit:         6e2332e0 Merge tag 'cgroup-for-6.5' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11050a52e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=102b18358d5797d8
dashboard link: https://syzkaller.appspot.com/bug?extid=62d7eef57b09bfebcd84
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17139952e80000

Note: testing is done by a robot and is best-effort only.
