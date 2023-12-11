Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C0680C8F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjLKMEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjLKMET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:04:19 -0500
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34C910C9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:04:06 -0800 (PST)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1ef4f8d294eso6743208fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702296245; x=1702901045;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDJUaE35Q5eJ9ESGe76MeoQ2cPj301p0wZ2CK8kCF40=;
        b=IKm8zBgF8OdPYhupyKaJ/jP1fg7POCqKFnxu3PYfvbYD8nvy8E3lnGFYvs/rKLDp9N
         06bpbNtsYAvLbYRA8ll50/oHboV8r0GqyEFUIlSXhGeYc37sMUzmhGTv0q1wy6NkpjWd
         ZSU5RiF5BmfukTpThAbR8ijSn1SxGGKehsPUvDKau5M9Gh6x1UaKgbbWd69LTMX3XYHh
         VIh8RhaabkSGvykTgpy04Af0mjcPMbrgbGXR0fcWj/1lFCN6+MVx+Rb4Taiu123ADMpw
         YMWNTYEdUpwdj/OJx/D9wr1gTvd799aAELOxWojCI2oTt2qUh0OLa/ncJt5Bs8OFNMMH
         z44g==
X-Gm-Message-State: AOJu0YxT4sJ1bmBbsat9ppF3M2sUUGIL6keyVfqxk6r/lBL8VXGp4q8W
        XILuwWqrQ/9lvH0AWAI/OHalKHrQog+Ty3/kgAV9s6UsRCEI
X-Google-Smtp-Source: AGHT+IEpu3Rhuig8FQQm2LdUYSYrZrmJdqm7y+zGZ33VE69FZlz3JLxFDCCB3mF0tfrY72/mMQduf4Ivns8gxGgr7bTGx4ohYgn7
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1703:b0:1fb:512d:f394 with SMTP id
 h3-20020a056870170300b001fb512df394mr4838184oae.3.1702296245624; Mon, 11 Dec
 2023 04:04:05 -0800 (PST)
Date:   Mon, 11 Dec 2023 04:04:05 -0800
In-Reply-To: <CAMj1kXGsvR1vAfEe=9v4i=OtLpqTGCB8G8jgAvmo8_Zw3TcFnw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005e536060c3abb99@google.com>
Subject: Re: [syzbot] [efi] BUG: corrupted list in efivar_entry_remove
From:   syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com

Tested on:

commit:         94f7f618 efivarfs: automatically update super block flag
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
console output: https://syzkaller.appspot.com/x/log.txt?x=1118cbeee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef72ff9ec2bc7165
dashboard link: https://syzkaller.appspot.com/bug?extid=1902c359bfcaf39c46f2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
