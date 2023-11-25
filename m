Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608E27F8D57
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjKYSyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYSyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:54:00 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98740F3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 10:54:07 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cfa392a13eso18651805ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 10:54:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700938447; x=1701543247;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7cwREvOXWT3hEhw9BX2KKETmIIsgJqgxROY2YXvuYQ=;
        b=Hf1rnuWYOqsmnkRaukoDw3z9ZdtSLg2vOGEBjcD1kOlXF/lU2GY1ZnvLxb60lGZq/u
         l8FEW2Nv2VyeVz8Pbzk+oz6TgQg7jRMpdl+8TfNryDoO+6+AVmHEk1HaLHUTyl5PVsrD
         ctUE5n5nH6/+7ZM6UyDCjY5tAtBNy1+uAY229PxA6Ks+Fs5cmaW3dsXCP8tybrP50QPS
         o7t2L88M+5+7aoam+jKD+B7ZVbx7qVTx7dFSamDwQcDdqah4UhDPEGxcnG0A2n4XyzVj
         Sx1+wN1zT/ddNw83gFxFFwu1kAnoTWpJlKyBDLhhUhLV7K4kSGRnX6XHnJpg2KRcg0Hh
         ZH4Q==
X-Gm-Message-State: AOJu0YxJ1XXb5R+63RmKC2luhDpSKbasLap6NArPoqFBQDGTNe/4JYKO
        +26q3kbC4Oyu+9XEDirzOzV0WzivDwi+X1OZbtmGDcdepwSP
X-Google-Smtp-Source: AGHT+IFsHJbrj8tawgd8wr4MPhqfDgWPYBPTeLiYRW/WvQGOEl2Ay2ZBGg2xxVYCR9Py8gdIg4mUmDJWd0m7IbAMS21Z5zJmBeYT
MIME-Version: 1.0
X-Received: by 2002:a17:902:9a44:b0:1ca:858d:5be7 with SMTP id
 x4-20020a1709029a4400b001ca858d5be7mr1358254plv.3.1700938447221; Sat, 25 Nov
 2023 10:54:07 -0800 (PST)
Date:   Sat, 25 Nov 2023 10:54:07 -0800
In-Reply-To: <f0c24608-a74a-40e3-a7b6-7dc7ca285a35@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee78fb060afe9767@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     code@siddh.me, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com

Tested on:

commit:         be04e5de lock
git tree:       https://github.com/siddhpant/linux.git lock
console output: https://syzkaller.appspot.com/x/log.txt?x=170076d0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e6a76f6c7029ca2
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
