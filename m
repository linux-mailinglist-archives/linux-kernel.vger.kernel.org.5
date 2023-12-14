Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F50A813364
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjLNOl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjLNOl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:41:57 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6A310F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:42:03 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c68fc4928fso3297989a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702564923; x=1703169723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkImJGj+Gw2w5mahJbE2VfaWHmOQLP30ii5xl59opSc=;
        b=dyT2r+3wtamq7BECSLn8cR6ES0Vsz8rnmcBG9Vnqt7snvTSvLy/1sjLpsLcUvoHSwG
         s2JmM/RSlkvvOzou6A6ioxJPfim11lnOYamKMIER0QWzqQ8fEnGuOnPcuvw/PnBwkdDK
         BZkj+wJOW9EnQiLxoSlqs2DH55oOr0wPZCP8x2Dxv0CtfBWnuxdMgHznoGNnu6Fuh1OZ
         R0gvGvFbHAO27SiYopwRKUHBF3PXCfxEwA7ABncgA0isPdQZQWeiRpNT3zRgbkENS49E
         45hHIcffBdZt3aZRKVsGWpnQ1FAlSRmVCNPlvj14u/rvOwAtw6nBuJAr5FqMQp+wdhjB
         X7kg==
X-Gm-Message-State: AOJu0Yw/fKLAXBLQ1ZqA1wnZY9c/NwRGmmhziEknE5FiF3HkEPGkQFfP
        FMWUM5IGx7GdcU/3SqM4SfyFRs2jDfw43DcQ/8QxYEmV7ILx
X-Google-Smtp-Source: AGHT+IHbRU2t43Yj5CjRVJGEesJ4dMZcDboxxn1iYuOgIrhWgTHynXtOzWsXRrj5DLGPEWAp8dhVK2+5SUe0VZKFh4spLjjfhX+l
MIME-Version: 1.0
X-Received: by 2002:a63:3202:0:b0:5ca:32a2:cb9e with SMTP id
 y2-20020a633202000000b005ca32a2cb9emr505684pgy.0.1702564923397; Thu, 14 Dec
 2023 06:42:03 -0800 (PST)
Date:   Thu, 14 Dec 2023 06:42:03 -0800
In-Reply-To: <tencent_2EA5A7E0C6D492E88651C99CAECCAECBCC06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000775d3d060c794996@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dns_resolver_preparse
From:   syzbot <syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com

Tested on:

commit:         48e8992e Add linux-next specific files for 20231213
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=156a0801e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978b8aaa2e92a8f
dashboard link: https://syzkaller.appspot.com/bug?extid=94bbb75204a05da3d89f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162b3ffee80000

Note: testing is done by a robot and is best-effort only.
