Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC33F7C03A3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343633AbjJJSnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjJJSnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:43:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A13BA7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:43:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c1c66876aso1087408666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696963387; x=1697568187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//91C+yAgD4Kx0xcvFBJTPE6fkDuCSSSI18S0IW457E=;
        b=LzjX/hzwObLfeQl1HZFPSjKSEKdRYJ0Sm+R/MkJR4rnKIR8Zth3lD0ZtFLWx5t8T9t
         X14/EM15pnYtFcFNaRYRlV9MTg1qMytBH6QCdEKNydHvgygbr0gCXzW3Qy+YUYIZ0lhp
         Jtoj4dk3ctMWEsjcR2unaPPh4o4I2v02kNobI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696963387; x=1697568187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//91C+yAgD4Kx0xcvFBJTPE6fkDuCSSSI18S0IW457E=;
        b=jseJGoHzvdZO0v9UtrnpNZXQous2HMluOKGRcvGLAPM9x29IvOIsvuxN+/RG2R9gDU
         c555gYd866D75ljXD3M5rCox0OgxZjbUtMTbwYQHaw5IJTklRTc7vPDNE0uOJdpF/q4h
         azDED7SOe1W5u4oqcwOjwfFIfoUho+EnK/0C0iaj4z6ge1VPykXkcy6Jj2lRUBlbGOB1
         uu++NkvU1Q/+ZQjmiyS3BnvPOPCjoQEqswmigLjJO0fyerYw/KqmI/tsmW9kiD7y9Dov
         pW1qeOPIqx2tJ55E6CQfDbBFRXqTuAmPv6W7V3yQqaJL71dRN0Yv1AxmHbpd1g5Wu3OG
         /S5g==
X-Gm-Message-State: AOJu0YyKA0rm27xihDb1BCIHfTvgfgFwkjJPPe5p9v1N7OHxz539R1y0
        b1DT5JcNi6Nm0LBunokoHP0fL91uATZdoYYjw8Lm7oar
X-Google-Smtp-Source: AGHT+IGn1ZpJ2yK64+G4AI5QPP190m5jYdFHLgL/2+2O+7R0u7LssihkvfB4IlV/L/3a2vYm440Ruw==
X-Received: by 2002:a17:906:8467:b0:9ae:62ec:f4a1 with SMTP id hx7-20020a170906846700b009ae62ecf4a1mr16380882ejc.33.1696963387364;
        Tue, 10 Oct 2023 11:43:07 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id rv18-20020a17090710d200b0099364d9f0e6sm8776027ejb.117.2023.10.10.11.43.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 11:43:06 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9ae75ece209so1088792366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:43:06 -0700 (PDT)
X-Received: by 2002:a17:907:2704:b0:9ae:5492:64e with SMTP id
 w4-20020a170907270400b009ae5492064emr14580442ejk.25.1696963386250; Tue, 10
 Oct 2023 11:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com> <108536FC-445C-41F9-8A87-B7D31A45AC4B@vmware.com>
In-Reply-To: <108536FC-445C-41F9-8A87-B7D31A45AC4B@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Oct 2023 11:42:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9dGfmA_zPof+CZdcZq6ZA41e6ycQus6P5CShLPiMoVw@mail.gmail.com>
Message-ID: <CAHk-=wj9dGfmA_zPof+CZdcZq6ZA41e6ycQus6P5CShLPiMoVw@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Nadav Amit <namit@vmware.com>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 at 11:25, Nadav Amit <namit@vmware.com> wrote:
>
> As a minor note the proposed assembly version seems to be missing
> __FORCE_ORDER as an input argument to prevent reordering past preempt_ena=
ble
> and preempt_disable. But that=E2=80=99s really not the main point.

Hmm. No, it's probably *is* the main point - see my reply to Uros that
the CSE on the inline asm itself gets rid of duplication.

And yes, we currently rely on that asm CSE for doing 'current' and not
reloading the value all the time.

So yes, we'd like to have a barrier for not moving it across the
preemption barriers, and __FORCE_ORDER would seem to be a good way to
do that.

I really suspect that 'rdgsbase' is better than a memory load in
practice, but I have no numbers to back that up, apart from a "it's
not a slow instruction, and core CPU is generally better than memory".

          Linus
