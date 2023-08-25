Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF8C78824E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243713AbjHYIkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243725AbjHYIjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:39:39 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E63E2100
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:39:30 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d7838958d17so334439276.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692952769; x=1693557569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz7ljQ7E7OwRN19RZKfE2GaR4aCOlo/7tnXUt2WSY0Y=;
        b=PTzD1hYppLmp2N5hoa1Gh+U7zcBCpiRqC6a3m88zZaMQZWRWCNBa7zTFd6c6zmRsK2
         DJpjVyYwra0jzLjSlB5zRKGZsSZG6Z/883ExXKsRJdjc/wCiLV0yCbOuyICuSsJf5k76
         BTwu8z5Edum37JkZQB/D7vSi0Yt09euL9dodlnjh1v4dyfDZg6Njc9XiD9/uD4g0ymw2
         C2tygiuQckDmByN3QR6goRPY9I38DWHAtP1CYnSkHwoeHUhHq3wckdcPW3pktdKyj31S
         Q/zMMB25dvGZewy1Fsko7LIdq4HE+w19R0bd20TpHNJeERLat4bcURDuD2zR1Qzkh5i1
         Yx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692952769; x=1693557569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tz7ljQ7E7OwRN19RZKfE2GaR4aCOlo/7tnXUt2WSY0Y=;
        b=dzA5jk4YhNTtpQdqV//5fOCDxynvZiNiEL5JyhIDcGnQx1F90q88boFECDdMMVJlzJ
         8A46VAp+uCgZDiRHmxrJ6q3B7Me+g6+rG8Ib4EetbhzGmGcgTzFxQV/KG2zLSPk4qv/T
         SgjmY5z+dxPgTAr0m+525jO2VZ/yBb9xomf2kt47squddqSB8iEu/p9lUi8nEwymGHfX
         qsncMxfVSiL3xy24K6X5WVz29nkZdfe4z4fj12zkmZ7d7fpiTT3lQqApVewlgjyobXMM
         /dyYyebDJtH8HevLj50ijrRQF/4ww+1i5+/DEhsUAJcx9ZoCq4phj+/lcLoYsjZVImK2
         LnuA==
X-Gm-Message-State: AOJu0YxkSVwE+arkw9ZfhumSll8NB6LVProYv5K4hAvsHzZr7YnCj4Du
        FBP9WVIO6AySIod3g4POBZIEBwgLbWdjkqaUEvJ7PQ==
X-Google-Smtp-Source: AGHT+IFY9czPR/FB9mAap65bZMqsOEWQmdE15Ju6xMq/8hkAGp/uQrK2O51JEMB7mcqymLZJUpU0pOCo84Dz2ZWyHMg=
X-Received: by 2002:a05:6902:601:b0:d78:5fa:9c60 with SMTP id
 d1-20020a056902060100b00d7805fa9c60mr3844386ybt.64.1692952769413; Fri, 25 Aug
 2023 01:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
 <168155744546.13678.7653611641170146532.stgit@skinsburskii.localdomain>
In-Reply-To: <168155744546.13678.7653611641170146532.stgit@skinsburskii.localdomain>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 25 Aug 2023 10:39:17 +0200
Message-ID: <CACRpkdZbLX5LCEbGhnRdF9UGsZi81z3sQ-cNABE4wVA+mGb8Qg@mail.gmail.com>
Subject: Re: [PATCH 1/7] x86: asm/io.h: Expect immutable pointer in
 virt_to_phys/isa_virt_to_bus prototypes
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Helge Deller <deller@gmx.de>, Omar Sandoval <osandov@fb.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 7:42=E2=80=AFPM Stanislav Kinsburskii
<skinsburskii@linux.microsoft.com> wrote:

> From: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
>
> These two helper functions - virt_to_phys and isa_virt_to_bus - don't nee=
d the
> address pointer to be mutable.
>
> In the same time expecting it to be mutable leads to the following build
> warning for constant pointers:
>
>   warning: passing argument 1 of =E2=80=98virt_to_phys=E2=80=99 discards =
=E2=80=98const=E2=80=99 qualifier from pointer target type
>
> Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: Dave Hansen <dave.hansen@linux.intel.com>
> CC: x86@kernel.org
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: Geert Uytterhoeven <geert@linux-m68k.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Chris Down <chris@chrisdown.name>
> CC: Helge Deller <deller@gmx.de>
> CC: Omar Sandoval <osandov@fb.com>
> CC: linux-kernel@vger.kernel.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This is the right thing to do.

Yours,
Linus Walleij
