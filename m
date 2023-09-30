Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE897B3F05
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 10:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjI3IKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 04:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjI3IKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 04:10:33 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3897C193
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 01:10:31 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1c8f14ed485so31635594fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 01:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696061430; x=1696666230;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5glKcCAKLWTatjK8MgeD0rc20gjwod9yAwBhDYVon4=;
        b=ZyouKxcJUGRGqi4cwLEzeaNMZqi1oexLCej6L+vyVahu/RzD7B706oezp2YYJoFBK6
         DL1o/RIj9WMe6/zn+m75F6HOdLc+/2PlexOtwrPwTvWjKGHbFAzdmTncW0TPlTbnFpen
         gsWAP6O+BHx8FhMPAwU6PhTX25d/6wneyxAWOg9Bjes4YswqNM/y/jvxwCC9u5721nRk
         VqHh4hIF0hNc3haPIMjW8MZrRwhdDprsXCoULurYX7zD8eASfqTPA8o8t/yYAbNhyvUO
         iO3Y5B0RMLzU21pdS2HMqr0XEtnVCJ8yHMgXgjcKsCtIqRWP/ZJh9tka+LGxZuWsl5CW
         20/w==
X-Gm-Message-State: AOJu0YyE9bT0B0BF39sSft556KT1av61tIlpCesHvUr6l79XSzrJMlI0
        pNWAU4H2vvzrUvUJV5CQf70T5dgL43J/Ka+L7ibl4mSMRv/W
X-Google-Smtp-Source: AGHT+IEMapBx7oCl6mfS8R+NQF/zOjZb84DdeiWnNjrQpYZorfRLPsKt/BZ1/vF757XZicapYUZIxxjDQCsIvMg+uQM6HCMy6Fc3
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5b12:b0:1d1:3ad6:bb99 with SMTP id
 ds18-20020a0568705b1200b001d13ad6bb99mr2260762oab.2.1696061430538; Sat, 30
 Sep 2023 01:10:30 -0700 (PDT)
Date:   Sat, 30 Sep 2023 01:10:30 -0700
In-Reply-To: <20230930074624.1542-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015a94a06068f132c@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in tls_encrypt_done
From:   syzbot <syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com

Tested on:

commit:         6465e260 Linux 6.6-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=156b6fc6680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d7d7928f78936aa
dashboard link: https://syzkaller.appspot.com/bug?extid=29c22ea2d6b2c5fd2eae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13cc351a680000

Note: testing is done by a robot and is best-effort only.
