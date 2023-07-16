Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09C8754D84
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 08:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGPGsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 02:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPGsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 02:48:36 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1032B10E0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 23:48:36 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1ba2fd68c2bso4508466fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 23:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689490115; x=1692082115;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvcpKRFP5mNFIMpzevacdyJ/WkFBedJhSQl9OXkDdsE=;
        b=VujP4yoT+H5IE6OKJOCOqG47VzjXYdXZ9vY8NdZ6slh+nuGkaEViZuOkLxFHjIF8xG
         JqVwV8gD9KWFobe0Enk8CCZ/sNrh//SP+adpx67/F1TrN/jqkSWjfqBsrz1WSFhQMjeG
         aEjY6BNn9fA+O77usBFBowT3XgufJdgyVDNeCtLc5LfawelkPGzXPhK8wOdnccMgiTba
         Y47RU+iOX8aCef0sZPo/dHqPOYXJGdfy1QM0qQXgs2asMn1eONRGNC2aJfu/6QfHWw6s
         v2KeQRQmmkYFtjI93ZOqupPZkSpsrdfZc/65BVDL3AHtA1UZz6mEAdTvlebihgZJqjHd
         ES1g==
X-Gm-Message-State: ABy/qLaaoljG7VNZhTXMuXU53BV0bI+5rgcInzD4cynmid1RDmnTLYkN
        DYBkrmFn6CXP5g5IjfBBMcug99j+DgIpof401EcMihrd4dK6
X-Google-Smtp-Source: APBJJlEEXVJZGSXaEU7CmwYzUPQNjFYSsvBxoW89aSx58YiuhKa52pi39dKlXKf0Z5l/9ASSJisJvvJz17jd2txPaUelxPFndsPJ
MIME-Version: 1.0
X-Received: by 2002:a05:6870:98a5:b0:1b3:f0af:da1c with SMTP id
 eg37-20020a05687098a500b001b3f0afda1cmr8202208oab.8.1689490115445; Sat, 15
 Jul 2023 23:48:35 -0700 (PDT)
Date:   Sat, 15 Jul 2023 23:48:35 -0700
In-Reply-To: <20230716062501.123-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ec9010600951215@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in sta_info_insert_rcu (3)
From:   syzbot <syzbot+2676771ed06a6df166ad@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+2676771ed06a6df166ad@syzkaller.appspotmail.com

Tested on:

commit:         3f01e9fe Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12c30342a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87ef4ae61b35aae1
dashboard link: https://syzkaller.appspot.com/bug?extid=2676771ed06a6df166ad
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1426f30aa80000

Note: testing is done by a robot and is best-effort only.
