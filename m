Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E354976BAF7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjHARSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjHARSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:18:17 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCF22100
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:18:16 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-56d0f4180bbso4945eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690910296; x=1691515096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lVeKq7FzrA8zpaWVb8WBRY41fSXAU8sM5RKZuACP/E=;
        b=oZV13r92MVDAp5Le6pcqZhs+Cx194TWvATG0jqNsJiWAlOebdfvMW8qY7WqsSVUKhr
         bA5iwvXzaO3M0RJIoREZKCqGpaebvOWUoqXgGtNmOFLRfXv4TYpdt6IEdO+ooAZgHa8R
         +Rh+R5OLgya8ckaTfj3i5Y+SzJybZJ/XCa6CR+s2h/j9VzgSmyLdrFlFc59pjjXIRrbB
         LtE6gt3NgxzXXP9KYKML+RjAoJ383eDOO/K6bb1m9V0oP01UduJjkdnxIlzm/8hQr5jG
         ok1TFOOrzIbCqXwi8/XPZFg1d5LbDGWh+ZhWeHN/HINI5Xsm4lq+WX8POytOFQ9/3Obp
         P5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690910296; x=1691515096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lVeKq7FzrA8zpaWVb8WBRY41fSXAU8sM5RKZuACP/E=;
        b=RwZCUDpfgjBtMqevyT+A9/ROx/UzzWlGlMI8zKxmQAx8934Rex5Cf5VTo+XYxjJIn6
         IPZ1Mt1eARf8SuRNmiu0oM77QyFm1I8U++O4ozdpdcskQr7MPMUaANvcu3GgP81+zMCm
         yjE+wG9xPVdGolWF7HsBwFCAB1BwmA9yOtTse4O+6y7GMCpS5+bakZNsEI0uAVaFgN9e
         NMCaPMoPFwwowXYDzpQRMKJ9bOK3Pv9bJMmraQsDtFADsYoAeZk57+U7R8rIhHYRy8oC
         YreA2sG3M2BHV+rxetgc2/mzSL6TWXEn59/uEHIe8Hp4PWXUycpPuSzqmgZXZlDL61kt
         xgKQ==
X-Gm-Message-State: ABy/qLaC75s1nMzWtX4Ew6FfVi+GxoFBILvFxxy7y5oxY41tCfF7QDLs
        ZvWQbttrB5fkoKD+xlnW3VyxftVgjNtkE9HozcaSQg==
X-Google-Smtp-Source: APBJJlH28E/XfL7JZrm7ZeIynJrP1Sh3tHyJVBOaUxj3H5FfAq1biNm4w1Wy+tLu2K6GHIXmKjv3/UZtWZDl1raA7Yg=
X-Received: by 2002:a05:6358:60c7:b0:139:d5d5:7a8f with SMTP id
 i7-20020a05635860c700b00139d5d57a8fmr3371801rwi.30.1690910295394; Tue, 01 Aug
 2023 10:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230728113415.21067-1-will@kernel.org> <20230728113415.21067-4-will@kernel.org>
 <CAKwvOdnPWL7ts0PC_NxqxZZRgaT=WLZGQQ-3cVii-jG5GCNjfw@mail.gmail.com>
In-Reply-To: <CAKwvOdnPWL7ts0PC_NxqxZZRgaT=WLZGQQ-3cVii-jG5GCNjfw@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 1 Aug 2023 10:17:38 -0700
Message-ID: <CABCJKueCWThVG9sBhWppHTUiuxinXf0MO6-MsMnmMTG6tv_j0Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] scripts/faddr2line: Constrain readelf output to
 symbols from System.map
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 9:42=E2=80=AFAM Nick Desaulniers <ndesaulniers@googl=
e.com> wrote:
>
> On Fri, Jul 28, 2023 at 4:34=E2=80=AFAM Will Deacon <will@kernel.org> wro=
te:
> >
> > Some symbols emitted in the readelf output but filtered from System.map
> > can confuse the 'faddr2line' symbol size calculation, resulting in the
> > erroneous rejection of valid offsets. This is especially prevalent when
> > building an arm64 kernel with CONFIG_CFI_CLANG=3Dy, where most function=
s
> > are prefixed with a 32-bit data value in a '$d.n' section. For example:
> >
> > 447538: ffff800080014b80   548 FUNC    GLOBAL DEFAULT    2 do_one_initc=
all
> >    104: ffff800080014c74     0 NOTYPE  LOCAL  DEFAULT    2 $x.73
> >    106: ffff800080014d30     0 NOTYPE  LOCAL  DEFAULT    2 $x.75
> >    111: ffff800080014da4     0 NOTYPE  LOCAL  DEFAULT    2 $d.78
> >    112: ffff800080014da8     0 NOTYPE  LOCAL  DEFAULT    2 $x.79
> >     36: ffff800080014de0   200 FUNC    LOCAL  DEFAULT    2 run_init_pro=
cess
>
> Sami,
> Should we change the llvm-ir linkage type for these symbols from
> `internal` to `private`?
> https://llvm.org/docs/LangRef.html#linkage-types
>
> Then they would not appear in the symbol table.
>
> At first, I thought other modules might need to directly reference
> this data, but with the local binding, I don't think they can.

For arm64, we don't explicitly emit symbols for type prefixes (see
AsmPrinter::emitKCFITypeId). These mapping symbols are emitted by
AArch64ELFStreamer to mark data and code regions. According to the
AArch64 ELF specification, "All mapping symbols have type STT_NOTYPE
and binding STB_LOCAL," so I assume changing the linkage type isn't an
option:

https://github.com/ARM-software/abi-aa/blob/main/aaelf64/aaelf64.rst#mappin=
g-symbols

Sami
