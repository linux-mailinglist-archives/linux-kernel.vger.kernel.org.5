Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9AF81315B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573245AbjLNNZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjLNNZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:25:01 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D823114
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:25:05 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28649b11e86so5879047a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702560304; x=1703165104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vR1dSMrNJq6MetWio2Qge6plfx6tMVvSahb2loPLYkM=;
        b=pRUpNTIgkXi09XXufYjLNQxF95JE1XTO/veMfTCGrG4JPlk8qGp+cyzJPe61+e2W3S
         Yz50O0SraQ+5iV1iHeKnl1w2alSuFvLWT0wcypYUcOOAcgOUFTfQ7+0RhTnbF9ZLyU0r
         q2T9h5NyYwhs8DWgA40D0XhP082H8Pr8Qcdj+GQI0vC/5B5CrgMYpjf/FpPfqcJriIez
         SaoKFlTE4H2HTfzDlLv9ngYvJ0WEPri7K2PobuSQi8qbe/ikLLvf+OOAY6ZmP2spw6oi
         VbT3xODTgtQk41kKWCUMmirVnnxg+26uTX1mNSMvS8syKaGKZVSdpdQZA2PyBtIBCAsl
         DEFg==
X-Gm-Message-State: AOJu0Yz1X5SScIEgLd3areDJvAZjbniXurPN41mYSFHPTyIoEfvPT75I
        7zKVONy2UxlxyoJLdYuTxc8iIn3vdIyuBbISSu/ph4Km7IfE05Y=
X-Google-Smtp-Source: AGHT+IEYbyWoolRmam/yUb89GDrVS+J/1Gr2hM1ujpnkAYVayZuQk6N0bvQAVWbt3J3XnyfU3Fg0fqH9rlQiTEf/wSWYugl9O8/7
MIME-Version: 1.0
X-Received: by 2002:a17:90b:4d8d:b0:28b:16c1:c494 with SMTP id
 oj13-20020a17090b4d8d00b0028b16c1c494mr185712pjb.0.1702560304676; Thu, 14 Dec
 2023 05:25:04 -0800 (PST)
Date:   Thu, 14 Dec 2023 05:25:04 -0800
In-Reply-To: <20231214.214313.1429518668067958908.syoshida@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b4c3c060c783635@google.com>
Subject: Re: [syzbot] [dccp?] general protection fault in dccp_write_xmit (2)
From:   syzbot <syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syoshida@redhat.com,
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

Reported-and-tested-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com

Tested on:

commit:         5bd7ef53 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154b3ffee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6597c2e8d31ac85f
dashboard link: https://syzkaller.appspot.com/bug?extid=c71bc336c5061153b502
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d75c06e80000

Note: testing is done by a robot and is best-effort only.
