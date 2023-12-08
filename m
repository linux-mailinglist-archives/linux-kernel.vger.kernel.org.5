Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CE8809799
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444178AbjLHAtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHAtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:49:00 -0500
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261E01712
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:49:07 -0800 (PST)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1fb05b08fd5so2550144fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701996546; x=1702601346;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AgJoOovxWHsbX8BqN87XUWbk/EHBUVnwib0dw3NfPw=;
        b=xLLmKwmsnDsecuouRFlyUTKQWw9BCeafylmMH3+sUNSJhWSV1BBB+twDcVVKoRORrP
         VBnIAq2AG1bbKVH3xLJbDT3thuwZIqMghZc3fXlRJxjzYaoI8la7RDXYvdMy5KU2JBwz
         QuXiRt80vhvXkoNcypvSTceNegiUFxlPYtit5apcW7JN+RwNvJg8Anr2CU+k025A6gXL
         +bBzqS/hgCRyXYMSKNA6Q2iY9kOgTt6fNC9o2pd539twlVyCWct/1kPUGDlGGdFL9sKK
         GIfqZRunekV3bToVV8gHViZ/oZ+XSreEDM8h7hM2PBCC3ptM5QIByTenIz/fmXWVxLzj
         MiOw==
X-Gm-Message-State: AOJu0Yww0GapFKjDjAaPyAtJ3fehJpTi8TQjKCr9bZWuAczRFZnHsiWh
        Z3BCpDHnmL5AoOEkBlEkCpp3zAblQ3BrR0MW6ZAz6eyh3b+YF/g=
X-Google-Smtp-Source: AGHT+IHAHAB04jleZEFYVJHYpr+/lLXxxwBsACBQITOx5I0RUArn6U79nKtgAjQkF3BtmjcOVkKNCXIW/+6Ae4no3e/WTWWQvuIk
MIME-Version: 1.0
X-Received: by 2002:a05:6871:5226:b0:1fb:483:a1d5 with SMTP id
 ht38-20020a056871522600b001fb0483a1d5mr4113375oac.10.1701996546405; Thu, 07
 Dec 2023 16:49:06 -0800 (PST)
Date:   Thu, 07 Dec 2023 16:49:06 -0800
In-Reply-To: <2527e5c5-f99c-4f1c-bd46-ed97060e8ca8@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ebccb060bf4f3cf@google.com>
Subject: Re: [syzbot] [net?] WARNING in ip6_route_info_create
From:   syzbot <syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, sinquersw@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com

Tested on:

commit:         ac408ca0 net/ipv6: insert the fib6 gc_link of a fib6_i..
git tree:       https://github.com/ThinkerYzu/linux.git fix-fib6_set_expires_locked
console output: https://syzkaller.appspot.com/x/log.txt?x=14a55d1ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=c15aa445274af8674f41
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
