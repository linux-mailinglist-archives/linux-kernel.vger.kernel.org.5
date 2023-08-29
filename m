Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E0278C0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjH2IoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjH2IoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:44:00 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70B5AD;
        Tue, 29 Aug 2023 01:43:57 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5650ef42f6dso1886451a12.0;
        Tue, 29 Aug 2023 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693298637; x=1693903437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s0q2qIosoGZVkmv0AAiLLF1YR+rHVAiblzZq0h/Aw34=;
        b=ftcHEa+kjfdyKLaAe314p1GY932hohZpiHbMszK5OP91S/Qja445Df6xc78oyrNqf6
         604Sy0OTBUsRBCVczcfEqJVnWdUw1L6RQQeUXT6iuHxJwIJwIVrCM+1OTR5yBbLphLUl
         VLkj8NQohKwxg+BYKRNsZ89NxjaOC+0c1gpU4ZjEkOKoozA08iVLoNR1FB0gfArgnuOU
         zqIyjhWfhb7GGKfvmmg0WklrMYt830XoKp02S1DKpzPw39BcVVhx8WIBNkeMzBmOeC72
         gA8vAF0QUUW2jB4J/s2g5ruTKDsNFqPnQRQc0ywU8azeKAu9QQsNI4hMagzbuJBWffXG
         YfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693298637; x=1693903437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0q2qIosoGZVkmv0AAiLLF1YR+rHVAiblzZq0h/Aw34=;
        b=LbY8l9998frRqzdkIvMhHnNrm93SosrBOZTzZcN9E1M/yFZRfdrPhFRd/ixJ+Oib1d
         g50jKf7mRhkodg1B76S5JHv3DjCguoWIcgRSk/UywiTra8uEqkE0RDrUVfP+74yBswnd
         nMES/mV05TweSOEoXtp7a+40jTRR+NyBi3kC16tU4qvjv/bhNTuB25B0v7iBMoV2fV2L
         Kzbj6cweYTtoAkq0/lkGfVZ8zmZSTvY+2Ad9E07+o89jivmhH++fSZ6GCF8MmRcdUXRS
         XCmv5qmoSjsql0i8j2AiRIShUM2dVK/lBjA1op9qKLYnZHeOYXIxEwVnkHgZ5KOG4hWG
         x65w==
X-Gm-Message-State: AOJu0YwrjVVRQ6C+I8wxsxwxPi27oOwh++cwTAsbkjIM2NNpBKH/6KK+
        iAMwkcM2koSOsrSbNshYzLy2Eqe/uCSvVuQm8Os=
X-Google-Smtp-Source: AGHT+IGdJ+EQ5pJpg/DziKslCdP8Ho5xUYdr0rxpWXc29ILsIwg5gA7ua6XMK5QK6v/P8GWQiaLCb81lUg5jbiLQoRs=
X-Received: by 2002:a17:90a:de90:b0:268:10a3:cea8 with SMTP id
 n16-20020a17090ade9000b0026810a3cea8mr21462078pjv.9.1693298637144; Tue, 29
 Aug 2023 01:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230829142043.02a8416a@canb.auug.org.au>
In-Reply-To: <20230829142043.02a8416a@canb.auug.org.au>
From:   Donald Hunter <donald.hunter@gmail.com>
Date:   Tue, 29 Aug 2023 09:43:45 +0100
Message-ID: <CAD4GDZy-qKdOh3J6RpGaHjNagA6pyGmLSnRsqhRiP_LxpwLgDQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 05:20, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the net-next tree, today's linux-next build (htmldocs)
> produced this warning:
>
> Documentation/userspace-api/netlink/netlink-raw.rst:14: WARNING: undefined label: 'classic_netlink'
>
> Introduced by commit
>
>   2db8abf0b455 ("doc/netlink: Document the netlink-raw schema extensions")

Apologies, I seem to have missed the following change between v2 and v3
of the patchset. I'll send a patch to fix it.

diff --git a/Documentation/userspace-api/netlink/intro.rst
b/Documentation/userspace-api/netlink/intro.rst
index 0955e9f203d3..3ea70ad53c58 100644
--- a/Documentation/userspace-api/netlink/intro.rst
+++ b/Documentation/userspace-api/netlink/intro.rst
@@ -528,6 +528,8 @@ families may, however, require a larger buffer.
32kB buffer is recommended
 for most efficient handling of dumps (larger buffer fits more dumped
 objects and therefore fewer recvmsg() calls are needed).

+.. _classic_netlink:
+
 Classic Netlink
 ===============
