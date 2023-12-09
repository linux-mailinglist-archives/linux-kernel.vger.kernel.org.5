Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F6F80B2B1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 08:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjLIHKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 02:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjLIHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 02:09:59 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5037F193
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 23:10:05 -0800 (PST)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-58d0c968357so3255075eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 23:10:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702105804; x=1702710604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1H7FBuRRymT+i/RuD/6cWcDH+gzYyqrAqT2TyDeE6Us=;
        b=PgOsDcay4D5vZ8fhgZKd/dPUnXG3J8wupdfaoHnaj4uNskUAJAcyNc1MJ/UHHaKlpy
         YfavJdpkTUa1g3vLH39IpmRG3p7AACcX2vUGQEICyqcGUuhTAusmkO1YC3MQJIg5Sbht
         bNeNPX4VESbASc7hXgKAr+PsgN9vZu6qidFY6nQZ5YjlnWODcNZ9be7NNh9fXAxjsIwm
         y9g2nHWaZQrHu111ZnwqBJMBuIFFh4QPGS+oqsT24B+dGxGU/qm/p7D5xaLqKpqGmrYj
         QgmAG0+I2UP2ZMSUoRcvYs2XLqHMSYWU0nchlqL2mjY4DMa0MrGceBNFAbnuvAokuuxn
         dgEA==
X-Gm-Message-State: AOJu0YyJ3aWL972tvWf9zBXku5IM7pZl+C2+EE0f6iquNyQjcUwn2b/V
        m0f+b/x0UIyjjYRf89uFEwIcK0kCFae6uFTbQwnyfohPoJAU
X-Google-Smtp-Source: AGHT+IHSVyGyXNa1GHsUczDX1+qO24/tXhtEx1VvrR1XDUJuCJtPE03O3XowFWpdWuhZQ0XPef8EgwkTZ/DEBwm27oB2jnxOcWAM
MIME-Version: 1.0
X-Received: by 2002:a05:6870:7099:b0:1fb:121c:c29b with SMTP id
 v25-20020a056870709900b001fb121cc29bmr1588574oae.1.1702105804771; Fri, 08 Dec
 2023 23:10:04 -0800 (PST)
Date:   Fri, 08 Dec 2023 23:10:04 -0800
In-Reply-To: <tencent_140DE9120A5D895DEA192FCF900D9FA5F807@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd1538060c0e6346@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert (2)
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
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

syzbot tried to test the proposed patch but the build/boot failed:

net/qrtr/af_qrtr.c:293:44: error: 'struct qrtr_tx_flow' has no member named 'failed'; did you mean 'tx_failed'?
net/qrtr/af_qrtr.c:299:49: error: 'struct qrtr_tx_flow' has no member named 'failed'; did you mean 'tx_failed'?


Tested on:

commit:         33cc938e Linux 6.7-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11343fcae80000

