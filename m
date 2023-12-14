Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D284A812B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbjLNJ1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbjLNJ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:27:47 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA20811A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:27:53 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77f642b9a22so34348585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702546073; x=1703150873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhYfjmCuo+1PmykwAbTfpZ2TUHkUhq4/jZFz8YOijBE=;
        b=4b0PGEy6Ck3efn81p1R6h4Mz8IPgnfLmCDc2bqA05UYp4Iby39EIbzJmD+T/HklIqx
         IM75z4yxQ+Nclcp5+aO5PwBe7BejZaJ9W5slbQrleprMfAImmD7ZN6AA6lPsLRIAq0dD
         InnqG1gVSHVLqb0KyA1pEtEsocRwvXi7MqPEC/oEAdUquUNcZnrY6gqxQgbQ9AuV/0/H
         fIlLYthAXTDeN41cc67WeykfRCt5FsD6vWvtF+DHk5uMTpMde7k6xWrKm+mMeBxZcwG1
         uVkNyUJ361X1zyYPoxuBBkssWFEesakEhyYkBAJaWk2pDXhSNzDBgrscDItS3uC4o3lL
         Hcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702546073; x=1703150873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhYfjmCuo+1PmykwAbTfpZ2TUHkUhq4/jZFz8YOijBE=;
        b=pSORvK2/KuAZrz5lejTXUcOEhXJxHzeDWl+CNrZdK5hmmLMvdoxoHjjSXaodMb48s8
         6fcgGDYdJoCAhLIzZC739ldXFyx5ki6Ql/NEU0F9rlLs+qY3syDjNwuN/v7VP9ay6q9J
         ZBUvPv0JJX+awvdZHHZcI0+/2JNYMQqazSB2QBhVNjQv5GF0+rCc7CFSfkVTbSwmbqv0
         XLo/ke5YpOvYIeZ9tSp0b2PeSQs5gzPvfPFT42VEfJoFDFvSI4cStYfhq5z3oymSK4Hd
         RPsTJcwBxRW7TxzsU7HZzA9WAqbGYKlzIuPMoN90hYkDksfnuj8k6PW6CDLJMVcdLR5o
         uwsw==
X-Gm-Message-State: AOJu0YzeMMZL+2b8pjkEu2wmUiZwZv9Fr/umesNLSqRUFeRU0ndWU9QN
        JvKDGxnsdu+r547tec4uLpNbHKIk2YCSL+NKAb+ESA==
X-Google-Smtp-Source: AGHT+IGPeRyQ6RFb0LNRVAmTAjz6D/BLrIPEIBX/hvRCVDcF3XdP39DP6Xi9DDyhYJG8Do/386lzxUJhjWw2XzYVS6Q=
X-Received: by 2002:a05:6214:411:b0:67a:11bb:50ab with SMTP id
 z17-20020a056214041100b0067a11bb50abmr13759578qvx.23.1702546072745; Thu, 14
 Dec 2023 01:27:52 -0800 (PST)
MIME-Version: 1.0
References: <20231113105234.32058-1-glider@google.com> <20231113105234.32058-2-glider@google.com>
 <ZXiVX5FAWZqHfr7m@arm.com> <20231213121605.GB31326@willie-the-truck>
In-Reply-To: <20231213121605.GB31326@willie-the-truck>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 14 Dec 2023 10:27:12 +0100
Message-ID: <CAG_fn=X60dDWKAC6Yswr3RCW15Jpd8BOtRCYP-ijCDZZDzo14A@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] arm64: mte: implement CONFIG_ARM64_MTE_COMP
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, alexandru.elisei@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 1:16=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Dec 12, 2023 at 05:16:15PM +0000, Catalin Marinas wrote:
> > On Mon, Nov 13, 2023 at 11:52:30AM +0100, Alexander Potapenko wrote:
> > > The config implements the algorithm compressing memory tags for ARM M=
TE
> > > during swapping.
> > >
> > > The algorithm is based on RLE and specifically targets buffers of tag=
s
> > > corresponding to a single page. In many cases a buffer can be compres=
sed
> > > into 63 bits, making it possible to store it without additional memor=
y
> > > allocation.
> > >
> > > Suggested-by: Evgenii Stepanov <eugenis@google.com>
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> >
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >
> > > +void mte_tags_to_ranges(u8 *tags, u8 *out_tags, unsigned short *out_=
sizes,
> > > +                   size_t *out_len)
> > > +{
> > [...]
> > > +}
> > > +EXPORT_SYMBOL_NS(mte_tags_to_ranges, MTECOMP);
> >
> > I may have asked before, what the reason for EXPORT_SYMBOL_NS? Is it fo=
r
> > the kunit tests? Otherwise we don't expect those to be accessed from
> > modules.
>
> It looks like it. The Kconfig option for the test is tristate and it call=
s
> this symbol directly.
>
> Will

What Will said.
