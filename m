Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C3F7F0F42
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjKTJmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjKTJmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:42:07 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E51CD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:42:04 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c16f262317so4553370a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700473323; x=1701078123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H08qQxC2xlOFrjQTkA/nZQnXxn3Q/Q9oHV1Av3nms6Q=;
        b=icLmawD2L+XRYsso83mFFAxfFDxSR2g0JpDjtx7nXhurq3uLS9lCj10GsETUjpGKfX
         SPPuvdgGz2pE97AcxXvo7n/eXzC/4CJe837ZbsAXd/CzkNYRFTtjjWn5o7ws9Q0SebfF
         cV8RVSmP57K0F3zW6dUcxbplRrD56kdcEs3yIAZzTbXHYd3Hj4mlR3IlXKCiekWXz/Ha
         asDnx1IsSSZUxWMlSIBXSw0iCuMUW18B77pjZwhHPw9FP2TqH4/KPuQo1IJgLowBPk8j
         ybN/DIxjohL+320hG5sTtct3ppgx8AecMgF2+dfx9Atn2CTotCYT2iV+ljQ7n6/GB+5t
         HFHQ==
X-Gm-Message-State: AOJu0YygrkchbY133fficPKS3EK0eF6KqNcD39luVMDW7QVT4BInk/Oo
        Bj7U4k54XMjCItva80LrzTCPVflMhz0CGnfJb0CdzjgTFz9iBks=
X-Google-Smtp-Source: AGHT+IFkQiwxiMOTToWNHYgrFIYfrYYEZuFQPDUKwVGPcHvPzFi3L0yGFl8O3uscbykFmIQeHAGI8FHqa0+Fpg5tgDSqqCEDnGVg
MIME-Version: 1.0
X-Received: by 2002:a63:d47:0:b0:5c1:ee2c:cd45 with SMTP id
 7-20020a630d47000000b005c1ee2ccd45mr2648248pgn.0.1700473323701; Mon, 20 Nov
 2023 01:42:03 -0800 (PST)
Date:   Mon, 20 Nov 2023 01:42:03 -0800
In-Reply-To: <31a54742-5633-42a1-bb5f-7769703bcd9en@googlegroups.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068cc2f060a924cec@google.com>
Subject: Re: [syzbot] [net?] [nfc?] memory leak in skb_copy (2)
From:   syzbot <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, phind.uet@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/nfc/virtual_ncidev.c
patch: **** unexpected end of file in patch



Tested on:

commit:         5a82d69d Add linux-next specific files for 20231120
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecfdf78a410c834
dashboard link: https://syzkaller.appspot.com/bug?extid=6eb09d75211863f15e3e
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104ebaf4e80000

