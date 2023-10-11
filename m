Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228367C5519
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjJKNRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjJKNRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:17:37 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CD08F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:17:36 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6c0dc76e736so8582931a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697030255; x=1697635055;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7iKdMcUthoS3NDhEdtHoyNemv5UcrorCPXVVjDEQPM=;
        b=C69uXzLzXZ+AmwIlSMPYXNctSoZIeUWmqpdqBnPKbQMvDRISR9XnKcIfrXS5S4Ji1v
         tV7EEEM1GCx9TRE8CJqJdXg/oWrNTQ5k9j4o98cjH5PXQuDf9bp//8mjXHttsKY5mdFU
         vVso49AxRb9KabbKORO77swHPJOYMWIQMf0esbbV49s2Zkl/k38R2KQoECx3bG9ml6la
         qhK6L+dfsSsZFMSni9ETo3MDDc4DhR1IPcyow24B6icwU4UNEf0GUKrhnz8WrnDtVOc2
         jhUM66xOyBIkXnBNnGmNqf0QmLzDxbK419zWvRM2jWm7Jitb0hBQnhz5Kps0CQNPNTrI
         15gw==
X-Gm-Message-State: AOJu0YwmbN/D2Kc90RrdIJg0HCIwW5y1m80+2L2H9jWQUPTFr9cwscmh
        SESiwqEOQnXAJe6aIN0DXYj3U5qRw0UC0JA5N4RbNjAMeb4o
X-Google-Smtp-Source: AGHT+IHKTLsKyZv0mXH2gggzX4/t90TgB6DW2x5X5Yf0CbH9lquwXol6gmgom17ssl1QK41W6Wz70+o3to4z4wN2t0MUIKqw6ep6
MIME-Version: 1.0
X-Received: by 2002:a05:6870:71c:b0:1e0:fd82:d6af with SMTP id
 ea28-20020a056870071c00b001e0fd82d6afmr7413367oab.7.1697030255723; Wed, 11
 Oct 2023 06:17:35 -0700 (PDT)
Date:   Wed, 11 Oct 2023 06:17:35 -0700
In-Reply-To: <20231011123554.2316-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090cd01060770a5e2@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in filename_create
From:   syzbot <syzbot+95cb07e3840546a4827b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+95cb07e3840546a4827b@syzkaller.appspotmail.com

Tested on:

commit:         1c8b86a3 Merge tag 'xsa441-6.6-tag' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10539c65680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b8c825e0d5f3f72
dashboard link: https://syzkaller.appspot.com/bug?extid=95cb07e3840546a4827b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170ed9b5680000

Note: testing is done by a robot and is best-effort only.
