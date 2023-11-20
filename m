Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151B37F107A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjKTKfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjKTKfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:35:07 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078F0C5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:35:03 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c203dd04a3so2461022a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700476503; x=1701081303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JObl4z6Bh6idRl8uDGTWNHYOAgtqux6R8xUxgbY7vaQ=;
        b=EKCNgRaWk/zteIH6W2Cyuy5oIlcaTy6MErhUN+tKLA0oimn4RNMlaeaSqsbKAI2r2A
         77+uz9DPVID7aL6MWq1LO2ckDJfsk0oO9MtFNq69HKrFAZwijsSLX8REKQIG9eO4k0lY
         WxrfJ4prI8gim2ta9nEyhcnLrtjoWW0PVLe+hyYLMVoGgjTf3vQGZ1MtwHoZt+Bhd8i+
         0idzleRKN3yqVI01Vp4C4dS0n/RN3FGrVlsisFj+1MqZZs12GDOiM8CzrQ1kgVUAG6hW
         OWQMCTNYvlKzn5ewUaIuWfVoq1rp1ws84VZYf0k+XBywWjjL3MfiqrCLvGnOsqtiIwwb
         cVqQ==
X-Gm-Message-State: AOJu0Yzgb7LtB/d9igWwjAShQ43WJNqdq8EhvxyoCD977sZSsrv9YROl
        eP/U9AtY4alr6axr0j5BkIOBwxgq11mN/T6guWBuRKurWMPyLhk=
X-Google-Smtp-Source: AGHT+IE4RbbJk5lmSegFvm44Z17v6CqL5Ifz5KPpGh35hXAexl+CuedKdH362pg56U65YbJrQGrZKwggPwuP9hYGYsAiiR51Sdpu
MIME-Version: 1.0
X-Received: by 2002:a63:2806:0:b0:5be:1c3b:9b51 with SMTP id
 bs6-20020a632806000000b005be1c3b9b51mr1354572pgb.5.1700476503250; Mon, 20 Nov
 2023 02:35:03 -0800 (PST)
Date:   Mon, 20 Nov 2023 02:35:03 -0800
In-Reply-To: <83624771-69fb-8baf-ec67-28c402219b74@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ecdef2060a9309a2@google.com>
Subject: Re: [syzbot] [net?] [nfc?] memory leak in skb_copy (2)
From:   syzbot <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, phind.uet@gmail.com,
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

Reported-and-tested-by: syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com

Tested on:

commit:         5a82d69d Add linux-next specific files for 20231120
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10c62e24e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=49ad170540e06f6
dashboard link: https://syzkaller.appspot.com/bug?extid=6eb09d75211863f15e3e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16091d10e80000

Note: testing is done by a robot and is best-effort only.
