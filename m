Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF4A7B3CE2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 01:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjI2XGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 19:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2XGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 19:06:19 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A2CE5;
        Fri, 29 Sep 2023 16:06:17 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5855333fbadso3430328a12.1;
        Fri, 29 Sep 2023 16:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696028776; x=1696633576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JS8hWFdIolHgfI50iM7ndmrsQjVMPHZC5aONoPIyZAA=;
        b=CfBKlmgl+KVpyJDrsWOB29yivHL+JR8WDNZoXy8VesIGsC3yzGCeQfEEJQNyI2wSt1
         3v1TocjqXfHi9HxlO+zEQwJeAqORp/c5ustAbh6HVvdSlIDBk291jmvVnRK5JCXg8yjs
         nb0EDkhJZZ0Th8UrcPv6gy3YKdsU+/qFTUqta+OJ89DC5yZ5SbFMNAhtt5UiosbY9Q9t
         Pb9wOZAC1L6dyRPO6m6wDZKvGFjOMzvv5FiyVBlQ/YhQZk8ZSKyxWeGFJuVW/UjbKFvZ
         ok/18fGRxnWxpovVpluH9Fb4gf0AAxCWkDfmxvMtQnndyN6OTPAJsae7RJp9vPNWhgRb
         5/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696028776; x=1696633576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JS8hWFdIolHgfI50iM7ndmrsQjVMPHZC5aONoPIyZAA=;
        b=JdnGEY52qwSCFB5kGpo5Je8WeVo+mmhV5iCnntLF4Udm34KB5tSeaGBAZYWP2OURrM
         V0HTE4Gb2EeRYIklJ2lrSvlydrUQ3v9hAXHcqgXPnfFkdnkW3BZqW/NsGnXmDQ2OZ3qd
         Wz+a3xwvCcDgZZ5/2litmvrZjQfDVy3xdSlBW0/I5eK7GFA77fFDn9ToW7qUwhosGOZR
         lOcpuwT43VC+bU9sRHNcQvD185YlfD+M+42l8nwBaL4iol8w1Ql4269T+BKC2orqkZ6z
         GH3Xt09KCy3X8nEvBwGIjArlUzkKPxa9kY5gNlMfJv8foG8NtIjahg4zMLlK4O5eTJaE
         1DeA==
X-Gm-Message-State: AOJu0Yytgz5Keu+GcXe0pRCHTPX4flqx5L0bbCuVIFTY8gwL7OrKWiXE
        ShEgNfE7SCdjMd1mMg/bpGQ=
X-Google-Smtp-Source: AGHT+IFfV8wZh0MisNVzSqo3/Gyg2t0pUDH20dbx9PffJOXhqMoMkk633+SsFUvK1DyB9oSWjLjjtw==
X-Received: by 2002:a17:90a:f697:b0:277:298:deae with SMTP id cl23-20020a17090af69700b002770298deaemr5133437pjb.11.1696028776410;
        Fri, 29 Sep 2023 16:06:16 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([36.129.58.185])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090a5d8900b002630c9d78aasm1967024pji.5.2023.09.29.16.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 16:06:16 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     alexghiti@rivosinc.com
Cc:     alex@ghiti.fr, aou@eecs.berkeley.edu, conor@kernel.org,
        gregkh@linuxfoundation.org, guoren@kernel.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        liushixin2@huawei.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com,
        syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com
Subject: [PATCH] Test for riscv fixes
Date:   Sat, 30 Sep 2023 07:05:49 +0800
Message-ID: <20230929230549.45206-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <CAHVXubhG2c=ShFHF4hMMFm8=BYDTyDUduOizujbUWQBW+55wTw@mail.gmail.com>
References: <CAHVXubhG2c=ShFHF4hMMFm8=BYDTyDUduOizujbUWQBW+55wTw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Fri, 29 Sep 2023 10:25:59 +0200 Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> I'm still not convinced this will fix the kasan out-of-bounds
> accesses, the page can be valid but the read can happen at an offset
> not initialized and trigger such errors right? I still think there is
> something weird about the stack frame, as to me this should not happen
> (but admittedly I don't know much about that).
The added check can confirm that the physical page is invalid (whether it is a 
vmalloc allocated page or a slab allocated page), and exit the for loop when it is invalid.

Perhaps we can trust the test results of syzbot.

Thanks,
edward
