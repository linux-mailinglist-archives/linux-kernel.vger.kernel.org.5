Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861EB777B86
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbjHJPDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHJPDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:03:33 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32F32686
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:03:32 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2685bc4f867so1175666a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691679812; x=1692284612;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1DbV/Mskn+VGMrAykR6K8k6Loo+4X/sMsrhzXdknJE=;
        b=Pq4Cp2ifpP+JPvR+I0G+VWsFphbASpiqq1JJALgkjblB9jyeWEJZVa5xNbJAT5VOgD
         rZLb9eNj7buFS0gFbcieZ9E9raYpyvURXMyar8RhavpV0HoN5cHkRTnBmfD07ty7CLM5
         4U1OPsrUb7e92DZE1LnYPWJ54t9vyI1IwwyhZiWE9b8SxnZq78dRFhY0l0YH5tsyiofF
         7dGOGV3PeCCyn+/AK95fPqQbNq6Jgi94lEfS7CiMxTmkajKXz4v21Q6zltaKj27Hf5v1
         CApqoy1w0MpoBJPGv6HOmZmnEMh6v708uiBjPD93KoH2GoSyXyztE721RaSMEGQpMeVl
         HwPw==
X-Gm-Message-State: AOJu0Yw5IcRH1d7g9UEn1w/NZ5I36Y3HK6/CUkPD5vZdyuFhsj2l4Wm+
        SiLK/Kv6rxvbq1nzogbXDQIh1RCS8J/kWKnZPyTXVz3Lj7kS
X-Google-Smtp-Source: AGHT+IFEDpmZnNw2upO4kfJd7JbCBbyPTi+dHOtsBmPDKZcKFBo5tEmVJfj2vY3LFBYYyoXUx1XBf7c2yfLUtkW9yArsy36XD4Fm
MIME-Version: 1.0
X-Received: by 2002:a17:90b:f0c:b0:268:3469:d86e with SMTP id
 br12-20020a17090b0f0c00b002683469d86emr643516pjb.1.1691679812442; Thu, 10 Aug
 2023 08:03:32 -0700 (PDT)
Date:   Thu, 10 Aug 2023 08:03:32 -0700
In-Reply-To: <20230810141207.2398-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b623b060292e6c3@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_open_devices
From:   syzbot <syzbot+26860029a4d562566231@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+26860029a4d562566231@syzkaller.appspotmail.com

Tested on:

commit:         f7dc24b3 Add linux-next specific files for 20230807
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14cda407a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7847c9dca13d6c5
dashboard link: https://syzkaller.appspot.com/bug?extid=26860029a4d562566231
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112db1a5a80000

Note: testing is done by a robot and is best-effort only.
