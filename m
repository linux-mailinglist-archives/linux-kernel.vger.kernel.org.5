Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EE17F9183
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 07:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjKZGIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 01:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZGH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 01:07:59 -0500
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C43610D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 22:08:05 -0800 (PST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-285b68ba797so517592a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 22:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700978885; x=1701583685;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaZ5PSKK/hT5zEcM7h3BHMOyNNWSq+NRByhLaX3TyTU=;
        b=NfNQNoBxKTmMad/sxhi8ppR5bFFfK1zZIRSOEGB9X9KTPnc+aL2ZeLdenA3KtDOQr9
         s3zVy48gQ4sgntSRUBZ6C8Iy25v/6mGDVsoAhFhp2eITMkG5fqAN1fIbDwqMJU6tFl5S
         8XFWr+WTNqMNwH/iaVuar/Qw/Ac0rCJbuwfjdPZAiKEKFPAcpDosn3MLkbdHedru+lLN
         cckekXRe3uF/OP+m+t11aMSW2jf0QxqDiRBUhituUP8MUzsc4Y6YoO1w9eITHXoQp2L6
         xHaV+sZnS3X04nOK3dKUIzQ/31vR5d50jhRMY7SYJxpi4E9GxvJU+kKrp5gSxcMx5tgE
         J4cQ==
X-Gm-Message-State: AOJu0YyAHNzPsuFEo62ebrbSYXiPay4HVvqfjKWpuN0YQuP5w66FCiFm
        hnDnxnXSxVglHdQLoPTIKDukaYY7IlUVktnn3nQJ94DkqPba
X-Google-Smtp-Source: AGHT+IFvMesqT0WcrGICmXFbyIdf7K5ju+nmC20pPFCP4P32hUPyiVgrev6YfWKoev0hc1C2+erVwDdpS8NhJFoyiT/SMN1wxhgI
MIME-Version: 1.0
X-Received: by 2002:a17:90a:7808:b0:285:b687:b836 with SMTP id
 w8-20020a17090a780800b00285b687b836mr456119pjk.3.1700978885110; Sat, 25 Nov
 2023 22:08:05 -0800 (PST)
Date:   Sat, 25 Nov 2023 22:08:04 -0800
In-Reply-To: <tencent_0C6106DF136B0364296703BF044A977D1705@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037b3e3060b08020f@google.com>
Subject: Re: [syzbot] [crypto?] INFO: task hung in hwrng_fillfn
From:   syzbot <syzbot+c52ab18308964d248092@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c52ab18308964d248092@syzkaller.appspotmail.com

Tested on:

commit:         98b1cc82 Linux 6.7-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=161857af680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
dashboard link: https://syzkaller.appspot.com/bug?extid=c52ab18308964d248092
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16732694e80000

Note: testing is done by a robot and is best-effort only.
