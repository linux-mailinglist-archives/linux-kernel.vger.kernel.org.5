Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB127E2728
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjKFOkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKFOkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:40:09 -0500
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5FABB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:40:07 -0800 (PST)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6ce26047c6eso6584348a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 06:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281606; x=1699886406;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EgYmRdZwzC6VytRMW+dp9atBVUh6kd4waF4tC+Vgbs0=;
        b=ftbBUseVuPohHC6B6VmsfYmNWh+zEQ/mGyxkQtdN5KGGA+G0LvV7MIuJQYFsmWnEJ8
         Ymcb2Zs0bRgBsIr4qbRWjoOKCQydEoowmmtwAnEZBILLKK7GoxmzVmrqbR5pVzP8C0rg
         4yfoWXVJgxBxIZYC/Q1JJodY6MOlpG6ElRpVfCJgx+GTZiUA6Ejh+E2b3R+KYAquwL/M
         qDT8WSY/xHAxQG5hxd2vA2eyciecqBOMZA7d6FY8TD+a75Jt7AGQT9fRvxjFydObbCqo
         LZHxnNr7aV1QMW0GrkKhIRP9ARoeiJYotb97ZQsxVCzHBpc5sm+HlP9M8hUgp7QY/uCA
         g8tg==
X-Gm-Message-State: AOJu0YxATpT5JT34GWo+B50Gto9bF9I5cvRF0djG3NJP0qqrz7iTudTV
        wY0dA818VoJoC1OI1OGZqKg/sQHq+ea4Er8xPUPu4ZYTAUKQ
X-Google-Smtp-Source: AGHT+IGtEePF5KYsceQjeeK7auSJN5mIf70iLMeaEiQkDt2QlLVtKrGhI2eCSYykCIzwYHJQv5LtJxS0TzhJFBVMHJCLRVXMnBGR
MIME-Version: 1.0
X-Received: by 2002:a05:6871:486:b0:1e9:ee3f:4c7c with SMTP id
 f6-20020a056871048600b001e9ee3f4c7cmr13988260oaj.2.1699281606523; Mon, 06 Nov
 2023 06:40:06 -0800 (PST)
Date:   Mon, 06 Nov 2023 06:40:06 -0800
In-Reply-To: <tencent_77D0E91EEE8ECDB47BF26C5C2FFD6E68960A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087d02706097cd47b@google.com>
Subject: Re: [syzbot] [net?] BUG: corrupted list in ptp_open
From:   syzbot <syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com

Tested on:

commit:         2dac7569 Add linux-next specific files for 20231018
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15765a5b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e86de086e9dddbc6
dashboard link: https://syzkaller.appspot.com/bug?extid=df3f3ef31f60781fa911
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fee497680000

Note: testing is done by a robot and is best-effort only.
