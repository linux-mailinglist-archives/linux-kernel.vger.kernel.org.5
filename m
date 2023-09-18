Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C937A549C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjIRU6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjIRU6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:58:02 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD04018B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:57:43 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1d66d948417so5512201fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070663; x=1695675463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrlFpkqR1pr2f3gmu9JtoBp0E9UhGnHi51HtueKJKcA=;
        b=FnK1TPorA1zbwjXMQesss2LNnv4Sn7c2LFvB8+WesDdbd57pXoA6XjYOSq4+Oc1O2u
         pcMj2EOiWyIetbydl/dIJP0UcJ8/2cMg26ipALM1TJlHH6h3BE51vVxfBGY2hwDqRhhK
         7T0vc1GLaQAWwWFEEUdtSaU+6LJvG1vnBDhhyAxHicASyDL1PiUo8hlYB8vGfcP3K6Ee
         PgpKy9h/wR4HnW1QNFD4dcYY/50gvJFGqVDaLsaMOse/z66NIl7R6IGu1cAvAs1ZASkO
         9Uk21ukUA4+9XibC2pJ6mQAGHX5Jbil5nTDqM5XvuhKnQdoWJkiEaSK0brKr8TIRerd9
         ewOQ==
X-Gm-Message-State: AOJu0YygxCwzkT06N9zNJS8KePV9BRLhRNKMmaNxQjriAzwX82/TVnrI
        uxfSaSQZttzOp0QkkF5TEach/ap+C3ke2mtb+WLN0ONmiWhM
X-Google-Smtp-Source: AGHT+IEb2BlEw6gq4OJewyzgaTfp1ThAQEwbYN0eBRzFm/WeC78oyKdh+09La/5ngEKuEhpKoOMnWUkcDZmyQ1+ta4mTteVPJyas
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c82b:b0:1c5:87d6:b779 with SMTP id
 ee43-20020a056870c82b00b001c587d6b779mr3528784oab.8.1695070663036; Mon, 18
 Sep 2023 13:57:43 -0700 (PDT)
Date:   Mon, 18 Sep 2023 13:57:42 -0700
In-Reply-To: <crdz3rljawhzb24yict4xxroodjtfhw22q4b3moh2uhmqgjq2h@gja4wnqjiubu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd57c00605a864f2@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in hci_register_dev
From:   syzbot <syzbot+410a8e33c6a740b40d51@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, ricardo@marliere.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+410a8e33c6a740b40d51@syzkaller.appspotmail.com

Tested on:

commit:         fd6f7ad2 driver core: return an error when dev_set_nam..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1764d44a680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba194e5cfd385dbf
dashboard link: https://syzkaller.appspot.com/bug?extid=410a8e33c6a740b40d51
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
