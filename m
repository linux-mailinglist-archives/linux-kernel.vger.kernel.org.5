Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737FA80A79D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574373AbjLHPkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574379AbjLHPkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:40:16 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0CD1996
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:40:19 -0800 (PST)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6d9dc17134dso2360075a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050018; x=1702654818;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWtiugmZ6LcQca8zeFLfrq6YxpjpLZLymePOCAzvu0Y=;
        b=WQZw1gEy/xkG4yZmUvV4iXpje+xBOFv0Oamm0xRkD7L6Nc/B6PFeRkRjSUeAGeCZ8G
         0R3kAKQZMrKNpsWb1LZrmPsLrSFes0Llg9mNle5wI74L3NRb57uu1xMxjE3l3wKRIqZR
         QKyChsqIE22dx+XHw25S8QoKdz9bXhw17tj+cqDG1QcfyijEm/JDfo64oOytXfi2Sm3v
         RfIR5XDJiqhtf9rn4Kxqe9lhB2k0+ydc5VjWIevzEp1Y6cG/YdE88/NEgIc3meu2lU38
         g+nWyVcjGlxZFrbW5YAcrsG8H7sTzgaMIbY3Cp4wJEJvdt93x12nuBu+tJIIIYqOYhD5
         /DlQ==
X-Gm-Message-State: AOJu0YyJ+ZbqrVh5fSEdVc8ca4FYrZk0yWCeInMweU/PhE6u9BDI9iRw
        2GwXY0USSxSS2vaLfdDXWvU6xdhDcj7rE0pXG76Wfz1WZStv
X-Google-Smtp-Source: AGHT+IH8rGk8g1hG+8plzvOjBagXtrOuADWbXztcg8D0CEOp/qSUwUarictuSwnhuFrh6nwj/2xf5eDzRPbi08zGmSbJLvBmYfc3
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4428:b0:6d9:e844:f3e with SMTP id
 q40-20020a056830442800b006d9e8440f3emr167109otv.1.1702050018397; Fri, 08 Dec
 2023 07:40:18 -0800 (PST)
Date:   Fri, 08 Dec 2023 07:40:18 -0800
In-Reply-To: <CAMj1kXGdLTsDnvqb3pe--eW3p480kbDRfyydMCUOW1m-3Bf9cg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc9918060c0166e7@google.com>
Subject: Re: [syzbot] BUG: corrupted list in efivar_entry_remove
From:   syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>
To:     ardb@kernel.org
Cc:     ardb@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, nogikh@google.com,
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

> On Fri, 8 Dec 2023 at 16:38, Aleksandr Nogikh <nogikh@google.com> wrote:
>>
>> If a command spans over two lines, syzbot expects a colon.
>>
>> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
>> efivarfs-list-corruption-fix
>>
>
> It is Gmail that is breaking the line here
>
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git:

"git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git:" does not look like a valid git repo address.

> efivarfs-list-corruption-fix
