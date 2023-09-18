Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A907A4E90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjIRQTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjIRQSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:18:49 -0400
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB8E10FE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:02:41 -0700 (PDT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4902f6d8defso1966843e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052764; x=1695657564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MN3C7HktW+hyR/YxBYqVeq+lZaf9y1QwOQ1Er5em80=;
        b=abrx6NlKCUHMMw1UYdoqJ1LHoZza9X7l9Y9ZpBwKogSGyuLMDnii3OqnL6nTc65LXA
         nNNORln5qSFnTGiUx7Ggdg0OdgVLK8mr6rB6/Vo6Q7nlmxv7j2HrK+cBsOr6jOtkCFum
         iEowNWW7gC0h3okQ+pEwsFiQV1e34AhxOhPRWtfP+0XfQCmKQIre9w5mfjwj9ayFYsbo
         3r/tcidhD/aUON9FndbqxRq9o7oQkwOh0O2IT5aMcgaqRy7eA3sa8M/NJ1I5XV6JKtVx
         NqU6APk7VuZuLzmaSW0GGzcp61IKG4McdfXABZ06ag0uU8bBSVoTt/Zqc0TmKPDXeBHT
         lkPA==
X-Gm-Message-State: AOJu0Yz6nnWph5ui/YWxVC+HBFnA6mrfi540+pWPLl9H4EKmc8MiOuKl
        CmF+/BPDt13Ji/hwoKdiKN+Zma7cm++7jAbNVacFlery3vaj
X-Google-Smtp-Source: AGHT+IFEoooJ0IVZtjiDAsqJWnWrZ53wVpJltAh1fGc2kUi59YuifG9GZgRgc1jjXaGd2G/ImCYylezxGiwrmHGe6G8lF32FlSZH
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1829:b0:3a7:2434:615a with SMTP id
 bh41-20020a056808182900b003a72434615amr3987317oib.4.1695042886335; Mon, 18
 Sep 2023 06:14:46 -0700 (PDT)
Date:   Mon, 18 Sep 2023 06:14:46 -0700
In-Reply-To: <1fe06726-85bf-7231-f33d-d73e8cfbaa4f@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e80ec0605a1ed4b@google.com>
Subject: Re: [syzbot] [mm?] WARNING in page_add_anon_rmap
From:   syzbot <syzbot+6e4f59235036c3c2e296@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6e4f59235036c3c2e296@syzkaller.appspotmail.com

Tested on:

commit:         7fc7222d Add linux-next specific files for 20230918
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=149fa9f8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79253779bcbe3130
dashboard link: https://syzkaller.appspot.com/bug?extid=6e4f59235036c3c2e296
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1180f972680000

Note: testing is done by a robot and is best-effort only.
