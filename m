Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6436476CB9F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjHBLTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjHBLTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:19:00 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568A8212D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:18:59 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-39085e131dfso1058965b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 04:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690975138; x=1691579938;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWvXpxCuJYpjEFo/W4sG+AcmV8aTSmJ5ToLMiyxysts=;
        b=VwUibei8Mhm6gJSJilNy+4fF4S4vqw328xyiWLVq0Gq8hK4jJLj93XM4o3oxZPxy1w
         PNxpBQOefyr9nfcHcb2hsirBtw5I8ttmw4hKA3rDBLqkw8/rI4/4vZ3nBUTdcTf3pfqf
         DNStx3yj2WP2ujh0DW5KFyx6xv05ZbXXiIhyKfxMr/Du2dlG6ZTwFXEm3VYVLbdkn/Sl
         3+5zBvz9uEC9XAnTOiJoYCXNLDgM6jr0WBkdaEMNbgDN7ByZqvV9J5Gg3fRE117tH+8P
         mLnyqqR00A5c/x4t7vmM+vUlaqDGPrv1KoKtQdhhxKq46L1K34VY4XJHYzb6oMm6Wk3M
         Ht/g==
X-Gm-Message-State: ABy/qLYUkl881Zqp3tBvjvi4RbHYfg4N9WGWkOjpCJ4/XP+7tk80VcjB
        xRNim1j6Ia0jLdXPfVvarHFSd5eaYJ7sWCFgBg6tbF7TltaoTt8=
X-Google-Smtp-Source: APBJJlFKRFyHPxPxPL0fIDfAh0MQOBXDXYHiOQoOgsYkNHrzRIU3fEVEh4ewUG1IAqV4g19Bng8BMMHXERb3gK6buSXLI6Lv+XLH
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1819:b0:3a0:9db4:a575 with SMTP id
 bh25-20020a056808181900b003a09db4a575mr30719794oib.1.1690975138674; Wed, 02
 Aug 2023 04:18:58 -0700 (PDT)
Date:   Wed, 02 Aug 2023 04:18:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076ffa30601eed47b@google.com>
Subject: [syzbot] Monthly usb report (Aug 2023)
From:   syzbot <syzbot+list7326d21fc77552823fb4@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 4 new issues were detected and 3 were fixed.
In total, 73 issues are still open and 322 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2254    Yes   KMSAN: uninit-value in mii_nway_restart
                   https://syzkaller.appspot.com/bug?extid=1f53a30781af65d2c955
<2>  2098    Yes   WARNING in firmware_fallback_sysfs
                   https://syzkaller.appspot.com/bug?extid=95f2e2439b97575ec3c0
<3>  1059    Yes   KMSAN: uninit-value in alauda_check_media
                   https://syzkaller.appspot.com/bug?extid=e7d46eb426883fb97efd
<4>  983     Yes   WARNING in smsusb_term_device
                   https://syzkaller.appspot.com/bug?extid=40ac6e73326e79ee8ecb
<5>  851     Yes   INFO: task hung in usb_get_descriptor (2)
                   https://syzkaller.appspot.com/bug?extid=e8db9d9e65feff8fa471
<6>  485     Yes   INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
<7>  355     Yes   KASAN: slab-use-after-free Read in pvr2_context_set_notify
                   https://syzkaller.appspot.com/bug?extid=621409285c4156a009b3
<8>  340     Yes   INFO: task hung in r871xu_dev_remove
                   https://syzkaller.appspot.com/bug?extid=f39c1dad0b7db49ca4a8
<9>  325     Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<10> 238     Yes   INFO: task hung in netdev_run_todo (2)
                   https://syzkaller.appspot.com/bug?extid=9d77543f47951a63d5c1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
