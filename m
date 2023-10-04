Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8B7B8DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244736AbjJDUUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244615AbjJDUU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:20:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD1810F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:20:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99de884ad25so40041966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696450813; x=1697055613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9mTC8wA+MdwB2bC0d8PKAI3uifJR/WN1f9PPReg/+E=;
        b=HbWJBPX6OsgNdQzdfCuCBUESjrTa+a9B1CrCFpRjvCsH/T3DmAB7uOx1djaXW2VfC8
         8xUbRtwPfcQnrVw7ADjov4KN0/jyzOzcZdKaaRLjrsRZ/z7ntPkx7Iw4Ah9FfOGFVlsr
         XXgBU+WTYTgzDV0nE3UuI1sqpMKjRDwH2RRsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696450813; x=1697055613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9mTC8wA+MdwB2bC0d8PKAI3uifJR/WN1f9PPReg/+E=;
        b=uQ8Wru66Lui6AXw/EFH06gn3+qr4nIjtlPOPGx9FbSwyTEOENWNl1xIA99kEU7zo7U
         AUZZv9ssjtQ+i6g/BDYmRqaGvwxvCHaC5T241D2n2W4qCDaSOizyzisk8yDyfOV+3RV8
         AD7/niP+u4tLy3Ftup/R+y5FjPQJryZQkrcE8tDSALRjm1IVxCw0FANFuT44t4+cUgB9
         tqYZtyVpPYnbaD0KayRsQEcMEFbT/8+8cbpZsbWzH/KGTLF76TPSlnocHIoEAo2+7990
         q8vZ+XvSPt2ulQh7P1FZHh6Y0MzgflGi3Up/xg7e+ak3KYnd1LnPvUDnMvxVwYfZtC9U
         HVlg==
X-Gm-Message-State: AOJu0Yw15WIyvvvartxoS8QVyG/XEsoK7FOAYxriOGGzNzGPkQZcdV3x
        V+qPwDNaph1Iliem3tRmkCvfn9BCBy8Z5giEFlww2Q==
X-Google-Smtp-Source: AGHT+IH36JuPGAS2Fa2jtqJrXaC2v60BIBY4uBGTgtgY/BLQWmmrw+YEpSrtbiexLM6hf+qjTnPwXA==
X-Received: by 2002:a17:906:714a:b0:9b2:b9ad:ddd1 with SMTP id z10-20020a170906714a00b009b2b9adddd1mr3256581ejj.28.1696450813107;
        Wed, 04 Oct 2023 13:20:13 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id pk21-20020a170906d7b500b0099bcf9c2ec6sm3284864ejb.75.2023.10.04.13.20.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 13:20:12 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so336338a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 13:20:12 -0700 (PDT)
X-Received: by 2002:a17:906:538a:b0:9b2:b269:d563 with SMTP id
 g10-20020a170906538a00b009b2b269d563mr3404125ejo.63.1696450812025; Wed, 04
 Oct 2023 13:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <ZR2U4DLycLT5xFH6@gmail.com> <20231004192404.31733-1-ubizjak@gmail.com>
 <CAHk-=wjuRGzhuETLYDoi4hM6RAxHVL0ptuRb3TH-od+348Y8zA@mail.gmail.com>
 <CAFULd4YRHmQVnwaORm7=7kUs7DYG7SfwdTXAitDt=bxiMU5AoQ@mail.gmail.com> <CAHk-=whKc9UCsrZ6sNRb=T2Yhy4Dhr=LUBi9r-gPhfwCmuOeZA@mail.gmail.com>
In-Reply-To: <CAHk-=whKc9UCsrZ6sNRb=T2Yhy4Dhr=LUBi9r-gPhfwCmuOeZA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Oct 2023 13:19:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcTXGJ7-cS_V4pWakQKh7rViKbzjxAfiaQ=nDvF7s+gQ@mail.gmail.com>
Message-ID: <CAHk-=wgcTXGJ7-cS_V4pWakQKh7rViKbzjxAfiaQ=nDvF7s+gQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/percpu: Use C for percpu read/write accessors
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023 at 13:12, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 4 Oct 2023 at 13:08, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > You get a store forwarding stall when you write a bigger operand to
> > memory and then read part of it, if the smaller part doesn't start at
> > the same address.
>
> I don't think that has been true for over a decade now.
>
> Afaik, any half-way modern Intel and AMD cores will forward any fully
> contained load.

https://www.agner.org/optimize/microarchitecture.pdf

See for example pg 136 (Sandy Bridge / Ivy Bridge):

 "Store forwarding works in the following cases:
  ..
  =E2=80=A2 When a write of 64 bits or less is followed by a read of a smal=
ler
size which is fully contained in the write address range, regardless
of alignment"

and for AMD Zen cores:

  "Store forwarding of a write to a subsequent read works very well in
all cases, including reads from a part of the written data"

So forget the whole "same address" rule. It's simply not true or
relevant any more.

                  Linus
