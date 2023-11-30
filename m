Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2177FE951
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 07:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344626AbjK3GqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 01:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3Gp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 01:45:59 -0500
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DA71AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 22:46:05 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1fa183935d6so954600fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 22:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701326765; x=1701931565;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCN9RDnDnMg6Bb8DWhfV+gBxuJIbFpZtaeHd84DuJPc=;
        b=MqpNP7DbgbFVgwSrNE1Fj1xI1vc3MeMebiHLKWj4CzjcABV9vOekHmBle5s/qFB3QH
         SxLhMpxrpsi106r0Qfj5PulZwKxGFl8LikdViU7bQlyPWoCJwLf5F6OdokMPi9SNdm9c
         c0NMcKpVTeEBhV0cfflXECmssmuz4RwRmvFp4n5H8DkJSGPsi0uKpEKM4YYYiRVtmoHc
         2dAyLDwEfob9IJUATDHgew5PgERVCtRCHiYMOjEYaQEvn/419r9CYcsoB/Fs/XVl/Ycs
         0ny5Rsds0p8qKPVD9pemI1Dp/lVZcqGtLFgVO+++8UJSiJgMUdlUKvrr4RIv1eu/kmRx
         fecw==
X-Gm-Message-State: AOJu0Yy72bKsAG6XpcIBO8nJ+dE34eHopkWsdZZ2y1vDpmQaF7E2k90g
        B33SqJZa3sFmRV3ZjnLT2tIKv2wOBwrO9Gvgm8vfAkLAY7mS0pE=
X-Google-Smtp-Source: AGHT+IFWayGZ52G/f3hqIoEGPX2Uulo+JNK5kq1Y3i1V3Pp/FveHeNvnW0xVP/zycNET0NMhnD3cC+vuvPU2HybJ0VtrySU9hv9E
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1681:b0:1fa:1ee1:17e3 with SMTP id
 j1-20020a056870168100b001fa1ee117e3mr722778oae.1.1701326765211; Wed, 29 Nov
 2023 22:46:05 -0800 (PST)
Date:   Wed, 29 Nov 2023 22:46:05 -0800
In-Reply-To: <20231130062513.547394-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cc70b060b5901ee@google.com>
Subject: Re: [syzbot] [net?] general protection fault in page_pool_unlist
From:   syzbot <syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
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

Reported-and-tested-by: syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com

Tested on:

commit:         a3799729 Merge branch 'net-page_pool-add-netlink-based..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=127a08bae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=abf6d5a82dab01fe
dashboard link: https://syzkaller.appspot.com/bug?extid=f9f8efb58a4db2ca98d0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c4e3aae80000

Note: testing is done by a robot and is best-effort only.
