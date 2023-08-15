Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E6477C8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbjHOHnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbjHOHmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:42:55 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C3E1736
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:42:54 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso5104831276.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692085374; x=1692690174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAQfC8Fk99VKXGvykRcnXCDXuQl6wZXlhTPZ78iPS24=;
        b=pAgTYUwGaIFdx5eLvLdZU3jJRUWKNxuF5n/OPgySmUjGdU8SXpEE6AtbXT2gdwCQP9
         gMe/DNfv/rj1WjMNqp6MkdJmCcdjutwIM/lQMM2c9nEdXHKY9rho8a1CE7L2a9Ky+M7Q
         l37zR8KQ2A9KromftjpezDMFdIBE/9m9flyL+fwp1/+pXK9/gT+AOqAtzu1jN0vULDcU
         t/d7H0rMQOGD/Ex6u9EKrN84uEGcO3aH3i+ZB0rOlgMjRz+YKrb5GDQgdN3etgG9miZd
         x7c/MVPyjI7zikIJ6DBZBaImviz2DEk5gz94lDyXTRHFfZPL1Jra3lj6s99Lb6G4uRhd
         jPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692085374; x=1692690174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAQfC8Fk99VKXGvykRcnXCDXuQl6wZXlhTPZ78iPS24=;
        b=eO888r03FpmvG7AKM9N7fDnQBYAXtZz915jyCqgxRk23YHWdHPN5avRLrqGmfhEBjQ
         +ZLU1klwclcs8NVY9eDWBI/pU7u56X5bIjdq6mLtR1IemLddraCPpR0j89qQhiQOIDOE
         stDtRviUBn9DUPZVO/iGvlTb1J4mmdXWKhnygn26uMPLhVmGTT2RL1GL7jA+4Vz1H2iK
         f1tFLeuYis7fMA3T7hQA3w15AISPtrMH4PUzUs/LjYniqMFnNC9yWCDKC4n2oDB4Gp+Q
         E1LnM7gjMqHhR91lwsnKDABKhl85A2gvqctPW6qDxkkIu2up9BewYl3zWcMJKd0yps8g
         PNkQ==
X-Gm-Message-State: AOJu0YwQK4bRpo/DUSWf6O+CExmQHVsDseWGyH+HTvm7IhAnbcvUntHE
        zIxMq6v6H0haKSHDRUtJexASjXal5UllQE1/zsNEqsJXyvigPOCk
X-Google-Smtp-Source: AGHT+IFDQ5yjy3RJRehLsSgIxf5pspuHEFGdUfMHD78IpF/c7/o8oIdh4kFoyKOFD7wT8BGLpm7/zzaiE8Xh7Iy0tOI=
X-Received: by 2002:a25:ae52:0:b0:d67:5d71:d817 with SMTP id
 g18-20020a25ae52000000b00d675d71d817mr13014469ybe.61.1692085373841; Tue, 15
 Aug 2023 00:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230809-virt-to-phys-powerpc-v1-1-12e912a7d439@linaro.org> <87y1icdaoq.fsf@mail.lhotse>
In-Reply-To: <87y1icdaoq.fsf@mail.lhotse>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Aug 2023 09:42:42 +0200
Message-ID: <CACRpkdZuLeMKg1vG9+8tcUtWUNN-EowhpPmt6VnGuS+f9ok81g@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Make virt_to_pfn() a static inline
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 9:30=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:

> > -     return ((unsigned long)__va(pmd_val(pmd) & ~PMD_MASKED_BITS));
> > +     return (const void *)((unsigned long)__va(pmd_val(pmd) & ~PMD_MAS=
KED_BITS));
>
> This can also just be:
>
>         return __va(pmd_val(pmd) & ~PMD_MASKED_BITS);
>
> I've squashed that in.

Oh you applied it, then I don't need to send revised versions, thanks Micha=
el!

Yours,
Linus Walleij
