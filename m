Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A64A7E24E1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjKFN0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjKFN0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:26:13 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624B010C3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:26:04 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1f057511202so5692128fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 05:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699277163; x=1699881963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpNXsDaVFHWmSCR1Klz1JrKiKF9Vln8yknbntuKibpg=;
        b=oyYFHSNEtwwL6yWfvL0mF7tb2T0GEgEGus044lrA0FB6KjJnfTlhIRCZ3wWA4jq14y
         51GnOmnQcWjt4w1nrEjzkEb67ZQ+JGuqsLeTGb3hAeIjmPFB1AQgmjcopVyfZ/WE2APb
         29FjKK/jbV47cLIvDlFtT7P/J6E2+AGbOX6cQ2/hwmzZ0N86mKLP8qI3IWXnxXuV1L8p
         1eZnIgm9cIQ+v0pXDpg5ilPKOK86pua+Nouqzjc/eVT9zJZBj62ke9yn9s3HTrFNQTnw
         8ib1eQ8tYsIXSVr7SsrsLyeboKPw8nWJ7FUOHBnCNZU8a2kWFlJTh7H/mCwJPo0Obv0p
         T/2Q==
X-Gm-Message-State: AOJu0YyzvpCP289QGunpJl00EDK+NJmdYQXL/feFSyocGzKHA3KIWlXF
        24ApTOnOpX5Kv92TncGMCn+e+SJDUdeKlXh/fweJL09aILpb
X-Google-Smtp-Source: AGHT+IFiq+lVzBihK/+U9oZnMhBjUxB5KRXYqxSSpRqqUcvM3Gm8RitFG3mf7uR10wjml1t1OSIovdRsPcD4niIp9vLIzWcD5Aiq
MIME-Version: 1.0
X-Received: by 2002:a05:6870:8911:b0:1e9:af97:9fa3 with SMTP id
 i17-20020a056870891100b001e9af979fa3mr14041602oao.5.1699277163688; Mon, 06
 Nov 2023 05:26:03 -0800 (PST)
Date:   Mon, 06 Nov 2023 05:26:03 -0800
In-Reply-To: <tencent_564ACA75C777AD66F83C0D370896CA360E09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b77d1d06097bcb66@google.com>
Subject: Re: [syzbot] [net?] BUG: corrupted list in ptp_open
From:   syzbot <syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com

Tested on:

commit:         2dac7569 Add linux-next specific files for 20231018
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=149170c0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e86de086e9dddbc6
dashboard link: https://syzkaller.appspot.com/bug?extid=df3f3ef31f60781fa911
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17e6a047680000

Note: testing is done by a robot and is best-effort only.
