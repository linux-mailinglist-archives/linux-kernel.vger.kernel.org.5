Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4B778ECBA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbjHaMGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjHaMGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:06:38 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7606ACFA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:06:35 -0700 (PDT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5700e513e01so756782a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693483595; x=1694088395;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8384DCbBArmZ1ITIIwm8R7uT/K8qCVO4YutPTdaYzVw=;
        b=b72Hpd4DnRz9nblVnTIz2Lq9/rT5Bx8/6fBWwaFq0ZDGLHvYYQCelR4NQ7XbleX9f5
         5EA0o1NuPA6c3bdYmB4+ifKQuTlXqy0v9M9EonTiJIhQEMQ8w6Q8j6zWyNf30dXxPHW2
         IBX4v7s+PAv64xgiuxITL4eOBPFjyI0eFcjAmz5MrR7OZmc/eBPMtyOQTA3AMij9WxDo
         FsBEDctFyKi/76uMs0IDe42LgzPrrnEYWjkiqLqw/E85J51FRhK+LIP3v0cPo74WWT81
         YbSRMHawJrBNPm4VcuHU3o0GhckLosETgB5TJhvhOMg7W8IFRD49eofJ+o0YBfRnYn0W
         1wmg==
X-Gm-Message-State: AOJu0Yw/5HMzqtxcp9nvTi/p40Dgnw3J1XfReZsoyDDX3Ju5dMMhhVcT
        QIm7YC42qmpzQ48PX/z36ydYryXdoqJtbibACXyK0FrX9pXs
X-Google-Smtp-Source: AGHT+IENv7KGB/vYSoNCRdmfMnSU+i2NKo3ZEKBvnYTFaJX5Nakntv43A7sTJxfxP+1DxyZmHRfU6SASp4yqH5KkNbA7AIqLfrwc
MIME-Version: 1.0
X-Received: by 2002:a63:3689:0:b0:563:4342:4307 with SMTP id
 d131-20020a633689000000b0056343424307mr651604pga.2.1693483595007; Thu, 31 Aug
 2023 05:06:35 -0700 (PDT)
Date:   Thu, 31 Aug 2023 05:06:34 -0700
In-Reply-To: <20230831111335.4666-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d0fac060436e0b4@google.com>
Subject: Re: [syzbot] [net?] [wireless?] INFO: rcu detected stall in
 request_firmware_work_func (2)
From:   syzbot <syzbot+1425ba65f01a5682a1a2@syzkaller.appspotmail.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1425ba65f01a5682a1a2@syzkaller.appspotmail.com

Tested on:

commit:         b97d64c7 Merge tag '6.6-rc-smb3-client-fixes-part1' of..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11c061ffa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e04e5649b11b1a8
dashboard link: https://syzkaller.appspot.com/bug?extid=1425ba65f01a5682a1a2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1791ba2fa80000

Note: testing is done by a robot and is best-effort only.
