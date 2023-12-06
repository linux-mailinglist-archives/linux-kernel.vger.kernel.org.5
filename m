Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87234807979
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379556AbjLFUgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjLFUgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:36:05 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A12ED5B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 12:36:08 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b8b91c5638so335503b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 12:36:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701894967; x=1702499767;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpNbwOXTQE/pK8Y5FKL4XcwMcPxfIP/Q/V7UQfxy6YM=;
        b=d2YTthw8n0JWDsnWKb9wS6SqTkGw30jyTyE2VWnGBZPC2TvHqVLJ0hoF1iJZwIGm8r
         3Vugpn0S0hUyaTUnVT7h7st0+J/Xjs0Jawv8u4hDyjNJ0nhmTTCH8wWJPP/l2f5xOuEG
         Hq1ZAlOlNm/BvNPSEYMvmjMKwfmS9W9xEBgBohHHrTAU0IjerPiXxDljTQZDhV1mX43q
         z5zPERGeFyc5IGST8bfspruddeOgwuy0WmPKbAMtRAaQye7IkPzj7obmasCwXNtfxO2J
         UfThoV19WlJxDAKoony+ttPzJNqtEgjnSPrSssGH8JhqxI7AhMyotH9vsxrlnde84FQ8
         m3GA==
X-Gm-Message-State: AOJu0YyBuPQsjY4tj6LB38tdrHwaiefRi2JLHWjulWDx1xXMGfvrgmB+
        Jo98HPu1p6zDoUnTHPmU/D0cg8asjf096DfhuJsrwTKWw6MH
X-Google-Smtp-Source: AGHT+IEyWCgNr7gxZR5OshHlDIhRJ2iTV2R4/qkUBMTbCdJf0LCUN9ecFLDTPTstODpJIP/y/ivG8obuX/Z8yzu/tAH5w4/8wWla
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a03:b0:3ad:29a4:f54f with SMTP id
 bk3-20020a0568081a0300b003ad29a4f54fmr1315439oib.4.1701894967425; Wed, 06 Dec
 2023 12:36:07 -0800 (PST)
Date:   Wed, 06 Dec 2023 12:36:07 -0800
In-Reply-To: <CH0PR10MB5113DA035381743379D344F99584A@CH0PR10MB5113.namprd10.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa801f060bdd4cef@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in pagemap_scan_hugetlb_entry
From:   syzbot <syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dan.carpenter@linaro.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        sidhartha.kumar@oracle.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com

Tested on:

commit:         41f87dea kexec: select CRYPTO from KEXEC_FILE instead ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-hotfixes-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=144310d4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3513b9514190e290
dashboard link: https://syzkaller.appspot.com/bug?extid=6e2ccedb96d1174e6a5f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
