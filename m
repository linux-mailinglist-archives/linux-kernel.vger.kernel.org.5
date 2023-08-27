Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86281789DFC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 15:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjH0NUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 09:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjH0NTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 09:19:31 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4522BA9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:19:29 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26d4ced65c1so2600298a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693142368; x=1693747168;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8Bl24Vs9jVS4Sx9cEf6BXxIhWboxCJ7gVQAZ6Ue3AY=;
        b=UKEKvZILSVUNKXFqPiIY0W5fUfeDZyPkUS44d1wc1t8s1XJRy6kGoEH9W1JRipBFq+
         uFw1LRyCLsxSn7Hk3uROVGfLHDKd7rk7X6bqWIq4Nd9Eg5MO93557ZhxIcQvMnR9awP6
         wDeHN0rPtzmx/uvUhCH9SOwYLDOwi1DV9xTZ610NDBMvPhawdH3myjp+0ES+c+GBxpLM
         YSen4XuOohLmAghnsaGxspBHKaqWWz8Lg5RR5D19kPg+hMOnzB/LnXbg6ld7olfrSBIE
         dZm3ZAsndQirvNTbntN/l2zHWpbA8AtyM9uvOWr4wz+ms3tOe4N4QvCLdyxfEA+iLkEz
         pZNg==
X-Gm-Message-State: AOJu0YzmxiT8defP3/Ubh9YHFaiBRzxqPfaHQTrlqGaklGpPD6S658t5
        GhHDuCxglX4ZJloSuxi40Swsug2dkr8mL5JZl42UC0DhDweq
X-Google-Smtp-Source: AGHT+IHR+VJ9+SoQI4tOXSQ0M7qJryYCXnyA+Zqxam3A31JMJdn53qqELqrc9PvZrVYMKECi0d22ELa9Gqz1jzxse6L7LJD0R0B3
MIME-Version: 1.0
X-Received: by 2002:a17:90b:885:b0:26b:4c47:eeae with SMTP id
 bj5-20020a17090b088500b0026b4c47eeaemr4839642pjb.5.1693142368745; Sun, 27 Aug
 2023 06:19:28 -0700 (PDT)
Date:   Sun, 27 Aug 2023 06:19:28 -0700
In-Reply-To: <20230827123619.3750-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071802f0603e76d83@google.com>
Subject: Re: [syzbot] [kernfs?] KASAN: slab-use-after-free Read in kernfs_test_super
From:   syzbot <syzbot+f25c61df1ec3d235d52f@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f25c61df1ec3d235d52f@syzkaller.appspotmail.com

Tested on:

commit:         28c736b0 Add linux-next specific files for 20230822
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13e2b3bba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20999f779fa96017
dashboard link: https://syzkaller.appspot.com/bug?extid=f25c61df1ec3d235d52f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1362b3bba80000

Note: testing is done by a robot and is best-effort only.
