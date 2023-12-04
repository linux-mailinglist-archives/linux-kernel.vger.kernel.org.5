Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098438036E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345083AbjLDOfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjLDOfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:35:19 -0500
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8E1189
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:35:25 -0800 (PST)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-58dc5e3cd7bso5393900eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701700525; x=1702305325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7LnU8RknCJWsPsqm7RXDpRlRmyk9PFdTymemdD1BB0=;
        b=UeViRpFvTwR/jmnm7LpqDOfMFOM5lpoTujer1SLMgE4++WhtpzcyOmDNGwPPJHTZdu
         WnDH7YfPAarA6f/qwqTuqUIpKA6bMZ9oq8LMHA6ldhgJCAMpnmgjTwxiueSCtUGX1E5+
         SfpMRfM3MUgJugL1xuCn/alyFU30se/pUk4swUjDADvRxjoYL8tbKlK9I3o63yFyaEmg
         JVClb3BSsttBW7MkvAGRGYBZRBDJ2KqiYNma5QELiWTsQ0wmza8YaOCEwQTyLv+p6iVc
         uh4e97hyDmTbQStymYMeO19O9u98D0nk2nnvIAMj/M+DE3KKe945dpKOcn6/QHgo725d
         SjJw==
X-Gm-Message-State: AOJu0Yy6XXAK8rtSBqZFV1nzog/vwQlPVvB/bp6qoNKpUw0HnHbpWRwQ
        nZec1Y8E/1q3MTd/APvT7hvCYtiP+t5r6s58Bcz3EYVOdYbX
X-Google-Smtp-Source: AGHT+IHT3NWz/uh6K0jGolZs7daejkq97Tqs4R/UZgXVTOfGS7B2im6mm2gusbDRj6n3heAiSw2fT9HRkL/yzzPbyEONKMNUWrjB
MIME-Version: 1.0
X-Received: by 2002:a4a:eb85:0:b0:58d:3c4b:ee40 with SMTP id
 d5-20020a4aeb85000000b0058d3c4bee40mr2648387ooj.0.1701700524964; Mon, 04 Dec
 2023 06:35:24 -0800 (PST)
Date:   Mon, 04 Dec 2023 06:35:24 -0800
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e04c2060bb007f9@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in j1939_session_get_by_addr
From:   syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
To:     Jose.Abreu@synopsys.com, arvid.brodin@alten.se,
        davem@davemloft.net, dvyukov@google.com,
        ilias.apalodimas@linaro.org, joabreu@synopsys.com,
        jose.abreu@synopsys.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        nogikh@google.com, robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
can: j1939: transport: make sure the aborted session will be deactivated only once

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d9536adc269404a984f8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos
