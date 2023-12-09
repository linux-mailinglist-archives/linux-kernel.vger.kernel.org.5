Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2653F80B224
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 06:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjLIFQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 00:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLIFQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 00:16:58 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1102E10EF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 21:17:05 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1fb0a385ab8so5548675fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 21:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702099024; x=1702703824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+jayjn7hl8L101rO7dZUiA+ywMw3XSub4EQZn9f05M=;
        b=ulPby7f34Ddx2/Q5/uErI56AcbjM42g4t7GF5InfAABR7W7CENRZ+SA7DHjteI0u7m
         wzDtXXa20OqWHYbqCPVJ9fLfAFzOhXtWRPuma6OhuAn+8O6TAPRhMj9FACw7fN5Ug0zA
         a/BjYKjSSv1fpKjUeFFSyL82vBgmoOTIxj+H6F7si8FM+4prZRSUb4j4pavxlpbmFFXo
         BKL2uGwlL1GHMJfi4Z1BpT/v41/XHT3OHSiT0Nj9YzsBaDE9r53DFgw4nUyUcgbNagtl
         8moB0bHpNRYWZYstfnPW4hIsbEZbv393vbjg+BWhmURzsnO5b1Q83tvh1u3V49zDUhf9
         +pIg==
X-Gm-Message-State: AOJu0Yxvk2nnVmJkR7YY2QSlo/u3UyGvxbkzlCdP0Ipahiu8E87cTJHv
        A/IhSIDTmLT/Wxgykj5EVOKhwR5qG3YT4RsQvJERelcwe2JO
X-Google-Smtp-Source: AGHT+IGQK5ROWMKXJmr0d+72qXUJmzOicTOQzUSyIOd+KcjKwjcM4g/6acoBv5lNf/bI7phxHfqaIkU5UyS5d/2j8G4LuUc1Qndr
MIME-Version: 1.0
X-Received: by 2002:a05:6870:96a1:b0:1fa:e0e4:f9b2 with SMTP id
 o33-20020a05687096a100b001fae0e4f9b2mr1172399oaq.6.1702099024378; Fri, 08 Dec
 2023 21:17:04 -0800 (PST)
Date:   Fri, 08 Dec 2023 21:17:04 -0800
In-Reply-To: <tencent_170675C9766F66183C77360A96A237AE4B09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b884a9060c0ccfb8@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert (2)
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+006987d1be3586e13555@syzkaller.appspotmail.com

Tested on:

commit:         33cc938e Linux 6.7-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14433bdae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14de5e6ce80000

Note: testing is done by a robot and is best-effort only.
