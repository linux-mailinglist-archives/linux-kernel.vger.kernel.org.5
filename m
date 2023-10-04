Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1334A7B7635
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbjJDBUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjJDBUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:20:35 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564F2AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 18:20:32 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1bf00f8cf77so2140787fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 18:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696382431; x=1696987231;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWgtczkmIzedJU06HNmYindRy47DOTkxKzPlacWgFwg=;
        b=kesWnUNFHak8Q4YSYT681wn0PR7OOlV7unu5V8mDYosCwceltwy6DGKfHQDCOWEN5n
         msAGLhqo43p+ZAZNNmLXyxmVF938gX6Sa3BYvT1bhv3ofvDuOdDsshZc1LNGeMfwF/1X
         HJow95K5/awpCwIvkzt3IAUZdcnbf+AvkS/fifco+zPnzMD58DKs2OwR364zxYpqjQ1i
         oA2KNqqR7FIHyYX6yRl+5AnbQUDGyFOdNQmOJ4t1TU6GUnmNu3fKQ1mKbKH+G+0vhJLX
         izutNaNrz3KYwguFIjqGNyt9USymZsjY3q/uTpqa6h39u33cj4yAo8mHYczc89csYqHm
         7diA==
X-Gm-Message-State: AOJu0Ywtt/Kz4KzYD48mPNkjClCKdHQRJ60I1z0s6D+OzsjF8m7A49Ph
        lSZkNXLWw1DXYTtP2LaPy0G/Ibv6O5MuyzHXXe2jtkg2PliF
X-Google-Smtp-Source: AGHT+IHTy2aEVPtiCOu5eQQra9CDmXC/y9mehTlHqj/IN6AyWGzc3dQAc51rHCH47Zm/Q8KbG+CFUzAJjgaPCGNeMDWdc4NF3t7x
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5a85:b0:1e0:fb98:a6f with SMTP id
 dt5-20020a0568705a8500b001e0fb980a6fmr546780oab.0.1696382431714; Tue, 03 Oct
 2023 18:20:31 -0700 (PDT)
Date:   Tue, 03 Oct 2023 18:20:31 -0700
In-Reply-To: <20231004004602.1789-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ee4a70606d9d0c1@google.com>
Subject: Re: [syzbot] [mm?] WARNING in copy_hugetlb_page_range
From:   syzbot <syzbot+ec78016e3d67860eec28@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ec78016e3d67860eec28@syzkaller.appspotmail.com

Tested on:

commit:         c9f2baaa Add linux-next specific files for 20231003
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17bf33b2680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe9c462fee1649f
dashboard link: https://syzkaller.appspot.com/bug?extid=ec78016e3d67860eec28
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1624aeb2680000

Note: testing is done by a robot and is best-effort only.
