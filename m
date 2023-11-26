Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710C77F9131
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 05:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjKZELB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 23:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjKZEK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 23:10:57 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485A818B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 20:11:04 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cfb96854daso10827055ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 20:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700971864; x=1701576664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8yB3Sbbae7n5Btibl6XLNJ/7B5TEslvAqAd7dAq1Xo=;
        b=WfHQECVKy1P5Lpkn1vdAjtlRf/gqmKm8AUWS3BxTOKmUegsC/6gYr65QneVRYZ+uZe
         m+A+L7dp2VUxsJ1EQu8YeDKp/ITyfWfR47aMb27n1xU2nzAAQPvX4ypZ5QY511mgYWj2
         +YBWtEHWjZKiS3fmzHud6vzG/LgtIBNES1Lu+X/DlU3h2ARuZQsYakYULanBgWg6Hvt7
         mbueUr+zcTw68hncCVCcTqqS8E5oKba/hlDGSZPN8+IQDblzWcau6EX9VSxugxo0Ydp3
         B0V9QyleVAi3MyI7fPj88SNmr5OKSnCsd6MoBmVVA8Rd0XZxlf8yAGYaIUksiLVZXfs0
         XDkA==
X-Gm-Message-State: AOJu0Ywo/pn6QgKvX9pmCq0DVHvcizc6kcQlQAwAnobmNQ05mNVOLEZP
        tcTGM24sWmxzGWXkKRLfA4pzNHI4DFYgD6T5koq6KuHYD0O9
X-Google-Smtp-Source: AGHT+IGTc2o/gZA9F23lYoONuyW4bi/N4fW3hNDFuiVBmexEM652hovOzTM64ggZ3D6vFx4swS6VhzXiPuc6zr9RjoygepA+xnB4
MIME-Version: 1.0
X-Received: by 2002:a17:902:b285:b0:1c9:ecc3:48c8 with SMTP id
 u5-20020a170902b28500b001c9ecc348c8mr1564615plr.2.1700971863818; Sat, 25 Nov
 2023 20:11:03 -0800 (PST)
Date:   Sat, 25 Nov 2023 20:11:03 -0800
In-Reply-To: <tencent_47250CBA28BB4A33079E2C1B9A4B071BF408@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b749f2060b065f99@google.com>
Subject: Re: [syzbot] [crypto?] INFO: task hung in hwrng_fillfn
From:   syzbot <syzbot+c52ab18308964d248092@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/char/hw_random/core.c:504:32: error: expected expression before '=' token


Tested on:

commit:         98b1cc82 Linux 6.7-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
dashboard link: https://syzkaller.appspot.com/bug?extid=c52ab18308964d248092
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169076d0e80000

