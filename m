Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072A2792B38
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbjIEQtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354829AbjIEOrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:47:16 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493E218C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:47:12 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 876B83F171
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693925230;
        bh=rzFgsndX7w8S+56ebJljaAcGYfZE/RwhA8W/mv/VYpQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=c/mXKnKqg0gJQPOVDjUAgT9rHvvtqPndxuDx08oKjvM2Z4ZmhhjP0qZQPxfv4h3Sr
         q77JaO434hR6qm/OXARrYw7BqQ9LS01n9+uasMNawIEwkT8IBdnbF8W44swD6JNqEV
         7TyWL5wV7nXYv09K+KtPH5hrTCKaTveFbk9H6vusplABUNT2wSCuupAMtvl7xU5O/X
         pl9JIbS9BE1Fwi/rsR51KfbBWUM28kJD4SfvSZkI2nRqW5yXaBB84hdHxFGsmtyKL7
         2sj5CA/UfqNSoBpXfKvxqzn2oo8CUlO3gNrd0iecXyGU/mJXQx5+e+GqP2vHzIu1P1
         kNfJRmEwtRbkQ==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4108d23b401so26404521cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 07:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693925229; x=1694530029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzFgsndX7w8S+56ebJljaAcGYfZE/RwhA8W/mv/VYpQ=;
        b=bT6x+ufUOkRfzLx20EQ/mCpHAP+/XhhjPyiilx+43sRLBcyMuHI2pMoUoJhttQ+Nln
         5F9+lav9nBLy9ZfgZ3guVsk3jKF4vwx0QF9JsRprpwi+9ZYPQNVCXXdjEMBHuHswRgv5
         OIE5lCcG+MkozxZ8Lj2/eHhUUq5qiAidqRkSwy1AEBC0ztmO08BIHrxdkYhqqJkw6Sxk
         ubM8jMbU/Kpnktym+aB2BrSlGbSR+yWhedUir5Lx3ATFtee1iY6nB9SdoIW7VyJqP/3m
         6VY3DQL8HEU7s1BECcbBkooH2dq+AptXn+bqNrKOCEEB9q4g24+2i5aqAIlIKQY1Yq48
         Apag==
X-Gm-Message-State: AOJu0Ywgq7nHabv7g+elm0Gq12dc/Sou29pZL/ExvIBshjtwg0GMhFjw
        XhR1hbAM0gkITfVqoIIw302+hbCN4MihguHs7BKobZ2GryQUGFepPVi1v/C7VwMzFYGlebKUL+0
        tRFCqW3/XzKQHXXfOG47IGPsGB0EeW7xDBtVt2CeIKkAoaryT0u+vwfNLQA==
X-Received: by 2002:a05:622a:24d:b0:403:e3ce:565b with SMTP id c13-20020a05622a024d00b00403e3ce565bmr15680314qtx.4.1693925229632;
        Tue, 05 Sep 2023 07:47:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzwdOm8ynmTrUyJwK/Cef8pNwzy6prPH4Opu96AVUP4rWCuvwXXxlLGG0Mwy896KMQhh05vlgznBGZ1rDAqao=
X-Received: by 2002:a05:622a:24d:b0:403:e3ce:565b with SMTP id
 c13-20020a05622a024d00b00403e3ce565bmr15680295qtx.4.1693925229374; Tue, 05
 Sep 2023 07:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230726173024.3684-1-jszhang@kernel.org>
In-Reply-To: <20230726173024.3684-1-jszhang@kernel.org>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 5 Sep 2023 16:46:53 +0200
Message-ID: <CAJM55Z-3feN9sw6MSqdHPkG8U-VyosAr7pHRynnQ+nZpbCQKkQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] riscv: vdso.lds.S: some improvement
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 at 19:44, Jisheng Zhang <jszhang@kernel.org> wrote:
> This series renews one of my last year RFC patch[1], tries to improve
> the vdso layout a bit.
>
> patch1 removes useless symbols
> patch2 merges .data section of vdso into .rodata because they are
> readonly
> patch3 is the real renew patch, it removes hardcoded 0x800 .text start
> addr. But I rewrite the commit msg per Andrew's suggestions and move
> move .note, .eh_frame_hdr, and .eh_frame between .rodata and .text to
> keep the actual code well away from the non-instruction data.
>
> Link: https://lore.kernel.org/linux-riscv/20221123161805.1579-1-jszhang@kernel.org/ [1]

Works fine on the VisionFive 2 and Unmatched.
Tested-by: Emil Renner Berthing <emil .renner.berthing@canonical.com>


> Jisheng Zhang (3):
>   riscv: vdso.lds.S: drop __alt_start and __alt_end symbols
>   riscv: vdso.lds.S: merge .data section into .rodata section
>   riscv: vdso.lds.S: remove hardcoded 0x800 .text start addr
>
>  arch/riscv/kernel/vdso/vdso.lds.S | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>
> --
> 2.40.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
