Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA58E7BCE36
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 13:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344705AbjJHLhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJHLhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:37:37 -0400
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89095B6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 04:37:36 -0700 (PDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-57ba1b829e2so4873004eaf.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 04:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696765056; x=1697369856;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzcTrVTmosEvDzMUusiCgzk7cGHTQh4FEFDZlKIlmOI=;
        b=oeS37XeuHH1AUNrbgvokFULAvhLU58OHZQ81kcfIEhVTEGLYgolkLM2tIN2cvQa7gE
         Dk3CbaphxM4arzrKO7MuNby2QZtufbAd9u0zL3iqdpvdw7AkSOENBtP/0kJDA76xPg/R
         Bnd6+38CioqKXepUEAPadgQ0PlRJni3hXrmvx5NWzEC/D7DBMcOBUqGbS3NRxpCyRp41
         A971kEH1w70L8gl+o8ZgXTg2cCyEBAYcaXAr6mcve4VKXzNhRwJIIYWbx5754XuuZAnh
         EvRrjIRQBMBy96qocaifoZ2bGCd9js23hTpISdkvWjrjP521jNXY0uKVvZiQrl4gGrcD
         QP4A==
X-Gm-Message-State: AOJu0YwNo4/5toZcpqzO3ujeEozHCE03kVUdwyMULnPCRxNfBg7wBzkZ
        SyYn9+SGe6osr0dgSm52+JBTsonS8hhxBcfc+bKbO497xds5
X-Google-Smtp-Source: AGHT+IGQwVt00gq33jpPiw0F43S+w543tE04AtO3vWY8vLdVl9OdAgRHpYDJZXPrCqldPCBQEPmv7fgC37Vi9/oXFFH41hvDdtU8
MIME-Version: 1.0
X-Received: by 2002:a4a:4990:0:b0:57b:3a08:62b3 with SMTP id
 z138-20020a4a4990000000b0057b3a0862b3mr4324620ooa.1.1696765055915; Sun, 08
 Oct 2023 04:37:35 -0700 (PDT)
Date:   Sun, 08 Oct 2023 04:37:35 -0700
In-Reply-To: <20231008111554.2010-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006cdc4c060732e606@google.com>
Subject: Re: [syzbot] [net?] [usb?] INFO: rcu detected stall in worker_thread (9)
From:   syzbot <syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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

Reported-and-tested-by: syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com

Tested on:

commit:         b9ddbb0c Merge tag 'parisc-for-6.6-rc5' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11f35345680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a5682d32a74b423
dashboard link: https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=155fb231680000

Note: testing is done by a robot and is best-effort only.
