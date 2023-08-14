Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA6B77B7B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjHNLlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjHNLl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:41:27 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8A2B5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:41:26 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-684c8a66e86so4459082b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692013286; x=1692618086;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYyaxlor6vyYv1MBPcW8JJcV++VdlyqaPFFzlilQAtM=;
        b=ZCEp/ux9xdOfRDi/9ZCTuaWlb6FPVvD6pJdjX7COn8NLC/a8tLmWCD4Az358mXvJiv
         hWsdZvqpJo2liSpKRN0EzWP4zpXSankv9Ve/kx3SEaWXgDU2RhtD7uSgvBMro1UUX/BL
         UthjATY+sHE9PtiGQwe5GgtQCJK8lvKJki169EXP0mCjb/quC+N3We11PA1RLklq2hdv
         LLJfjSdxO6MccDPE09J5bwC5lhCnDQ0u6yEjwtezs0lIQjNady+08ECk4CEpni43wh6P
         wmkDCyPtI7D8+hIMXbeN1dZ+qtLN0kLQq9qB2TCD9tbP/LM8I0RBkOp7mmiiSOQRIr7P
         i8iA==
X-Gm-Message-State: AOJu0YxSHxEAtz2XpSzAxZ1Ku3XzjRaEyuj2T1hlp1D8Lyl+rHR4m/gD
        5wHiH4ican3nzUL6jHROk3Ylb9Nn0LVTIuVcVk8GRzBgXEht
X-Google-Smtp-Source: AGHT+IG7IyLd2ZryuvnaUg4uyyqsdvEfAinlGLVimeqjW21A4G3liQHzbHTSJ/HIGIq2vK8SfZKVKASA7olGWO/+gEf+5Pn6vddQ
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1a0f:b0:687:4554:5642 with SMTP id
 g15-20020a056a001a0f00b0068745545642mr4023872pfv.0.1692013286100; Mon, 14 Aug
 2023 04:41:26 -0700 (PDT)
Date:   Mon, 14 Aug 2023 04:41:25 -0700
In-Reply-To: <20230814105104.1365-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df93d10602e08a5d@google.com>
Subject: Re: [syzbot] [ext4?] INFO: rcu detected stall in sys_unlink (3)
From:   syzbot <syzbot+c4f62ba28cc1290de764@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+c4f62ba28cc1290de764@syzkaller.appspotmail.com

Tested on:

commit:         21ef7b1e Add linux-next specific files for 20230809
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14dfae3da80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28e9e38cc16e8f0
dashboard link: https://syzkaller.appspot.com/bug?extid=c4f62ba28cc1290de764
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14948103a80000

Note: testing is done by a robot and is best-effort only.
