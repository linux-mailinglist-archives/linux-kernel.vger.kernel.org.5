Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4767F7590
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345190AbjKXNvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjKXNvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:51:01 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC3910C6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:51:07 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5be154fe98bso2711283a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700833867; x=1701438667;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaCvQYyo2VFVYNjFVBLzWkRzqr86vKYEa3lSL2JItig=;
        b=dqqLgq8KA6rnANMwW8a6Yyu70ttWoRFQaDdk0CNtUrrdglooW4lk8133BhRN7TA2S4
         SDGnWI2yQWwydYnVat+CaAXnkxLVMoXQDOT5MobrQRil4JGXP/vJ4E81/UN2lKb/oV35
         2H5RJOetJ4KJkqNV9QColxX/wg9eIaTmHQBk4/dhh7VOzvwRx6I3H+guvrs/xAGRCnWe
         tYCKJcJSboL/SpRjkNrHqSSEy81dC3gKgFDg15otsuqbFpbRd57yZcBtB4DvSDwh3m17
         ReyxhcKaMDfxHgrzWyDvyv+d+RPlXsGasb3ofJynepDJyUfwcom4qxnlit1L1NmvQtvR
         0PHw==
X-Gm-Message-State: AOJu0YwaWzxSyG5i7sdnGe6twrdrd0FSizHt23VDHMnfzOI7jytPw+JI
        PsIyg2SFgoDL7dcn/3LLGon1oEWerQhrsF6yDnp5Xt8wnQaD
X-Google-Smtp-Source: AGHT+IEVMsVECypD601e10UPbV2qwhzfn0OmxALlv8G2pl0Hiuc/btR2TotIAoBV4PdA53yjGFI3ydJIt9SGHBU+B/AZZTmH/ijp
MIME-Version: 1.0
X-Received: by 2002:a17:90a:fd82:b0:283:a54c:63c6 with SMTP id
 cx2-20020a17090afd8200b00283a54c63c6mr1251354pjb.3.1700833866833; Fri, 24 Nov
 2023 05:51:06 -0800 (PST)
Date:   Fri, 24 Nov 2023 05:51:06 -0800
In-Reply-To: <tencent_37ADAED3EECFCC9567ED06EA52C2C6488906@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007464b3060ae63eca@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com

Tested on:

commit:         037266a5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11cb73cce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af04b7c4d36966d8
dashboard link: https://syzkaller.appspot.com/bug?extid=c5b339d16ffa61fd512d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1743bcd8e80000

Note: testing is done by a robot and is best-effort only.
