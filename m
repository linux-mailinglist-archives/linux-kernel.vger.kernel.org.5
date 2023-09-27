Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB407B018D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjI0KJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjI0KJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:09:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257F110DA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:08:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c60128d3f6so271625ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695809324; x=1696414124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+0109Hnx9kemuPMlRKLMOKu7MOL7tHz3JqA7OO+XZ8=;
        b=0Z78nAUeJBs7XcY7O4iKSnvjDMUMqqU4xhwZcSBlmO0Wpp4rV4aNQTbxYjKud16fop
         x5pthIwY/f0amjIZ4d5t3lQeCwFMTXd0PXDRscncMlCFaPcz/fT6sREScVZ6BetF/0jU
         6c0xO00KfHSZFQHv7cTBaYptbKYXqylnLpMd9AdC/eRWDFc4P9eCn9E2cK4IvTH9uA0z
         5r4kFBLUlhxktCZYGtVhXWEWcsWMKoT0fFJCF5aPFGaRE97hkjZe5EvA+dc6ehFujimA
         /oMKkgg2j7LKsTQS9FITGWwPDEqoDMsnvdx9v7dSBqljJ9nIa4urJDMlfcZt41jldXav
         iO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695809324; x=1696414124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+0109Hnx9kemuPMlRKLMOKu7MOL7tHz3JqA7OO+XZ8=;
        b=CgZTNmHrOkrrCktt03nAn94o7rYYdqD4A4gmr3IJnoDxDRGHZLhfPLfJ0FuEFgXXFL
         cmHgyWHc4m92V2p/SEWtA7LjTXKupZgmgAp/dh3bbb0ZGtSIbJdze6E8/B3+6bwNnYXa
         70rRClzzcVV2TyRuaraeQ771OvoiP45jGW2/gpMD5PCO52Bf0ViAyJMguuelegSJfaid
         cU+XvYVdQqRP91zsi/Mm2K/5owYGW6e5O/Fo7whjPZxxUCKDQO2l21rjMrCU/EVNYWpd
         CqxtroZCIqo3NDas4J5fh/qU80P7tvrrGAXH1OecXgSKDGfPorXTGCE12nQzAJ2XkXtJ
         Kvpg==
X-Gm-Message-State: AOJu0YyJ+k166y+zIba2ZTHXPFdaMODA15RKKy9gM9ydELFXOY+mcrR3
        oaencLWhD8MJ8WQPeT5vgFyHP0wmWnrpD1yZce/Btw==
X-Google-Smtp-Source: AGHT+IH6K+5arI22wv/ElFc7XIdj0Hu0aH/vgPvWGTLzPNbGOd7dq07dYCEiX3+1MZD/rkNQ3VaIVFrGv7BnO89ED1U=
X-Received: by 2002:a17:902:f2cc:b0:1b9:d96c:bca7 with SMTP id
 h12-20020a170902f2cc00b001b9d96cbca7mr403770plc.25.1695809324164; Wed, 27 Sep
 2023 03:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <918e147601697b1d4b8f8589f5751e05d6ceccdf.1695371055.git.maciej.wieczor-retman@intel.com>
 <20230922141441.3353077-1-peternewman@google.com> <xnjmmsj5pjskbqeynor2ztha5dmkhxa44j764ohtjhtywy7idb@soobjiql4liy>
In-Reply-To: <xnjmmsj5pjskbqeynor2ztha5dmkhxa44j764ohtjhtywy7idb@soobjiql4liy>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 27 Sep 2023 12:08:33 +0200
Message-ID: <CALPaoCgm8ed0p3Nw53d=Hgs0WnunkRUwAriyuKqu6+5Ty-QVTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] x86/resctrl: Enable non-contiguous bits in Intel CAT
To:     =?UTF-8?Q?Maciej_Wiecz=C3=B3r=2DRetman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, fenghua.yu@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        reinette.chatre@intel.com, tglx@linutronix.de, eranian@google.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Wed, Sep 27, 2023 at 11:20=E2=80=AFAM Maciej Wiecz=C3=B3r-Retman
<maciej.wieczor-retman@intel.com> wrote:
> On 2023-09-22 at 16:14:41 +0200, Peter Newman wrote:
> >On Fri, Sep 22, 2023 at 10:48:23AM +0200, Maciej Wieczor-Retman wrote:
> >> In Intel CAT CPUID.0x10.1:ECX[3] and CPUID.0x10.2:ECX[3] stopped
> >> being reserved and now carry information about non-contiguous 1s
> >> value support for L3 and L2 cache respectively. The CAT
> >> capacity bitmask (CBM) supports a non-contiguous 1s value if
> >> the bit is set.
> >
> >How new of an SDM do I need? The June 2023 revision I downloaded today d=
idn't
> >list it.
>
> It's not currently in the SDM but in the Intel=C2=AE Architecture
> Instruction Set Extensions and Future Features (which I mentioned in the
> second paragraph of the cover letter). My version of the ISA pdf was
> from June 2023.
>

I see it now, thanks!

> >> -    cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx, &edx.full);
> >> +    cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.ful=
l);
> >>      hw_res->num_closid =3D edx.split.cos_max + 1;
> >>      r->cache.cbm_len =3D eax.split.cbm_len + 1;
> >>      r->default_ctrl =3D BIT_MASK(eax.split.cbm_len + 1) - 1;
> >>      r->cache.shareable_bits =3D ebx & r->default_ctrl;
> >>      r->data_width =3D (r->cache.cbm_len + 3) / 4;
> >> +    if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
> >> +            r->cache.arch_has_sparse_bitmaps =3D ecx.split.noncont;
> >
> >This seems to be called after the clearing of arch_has_sparse_bitmaps in
> >cache_alloc_hsw_probe(). If we can't make use of the CPUID bit on Haswel=
l,
> >is it safe to use its value here?
>
> I believe the calls go like this for a haswell system:
> resctrl_late_init() -> check_quirks() -> __check_quirks_intel() ->
> -> cache_alloc_hsw_probe()
>
> There this line is executed:
>         rdt_alloc_capable =3D true;
> where rdt_alloc_capable is global in the file scope.
>
> Then later in:
> resctrl_late_init() -> get_rdt_resources() -> get_rdt_alloc_resources()
>
> this is executed at the function beginning:
>         if (rdt_alloc_capable)
>                 return true;
>
> So the rest of the get_rdt_alloc_resources() is skipped and calls to
> rdt_get_cache_alloc_cfg() never get executed.

Yuck. But it works I guess.

The series looks fine to me.

Reviewed-by: Peter Newman <peternewman@google.com>

I applied the series and was able to confirm the behavior was still
correct for contiguous-bitmap Intel hardware and that sprase_bitmaps
is true on AMD and continues to work as expected.

Tested-by: Peter Newman <peternewman@google.com>

I'm not sure if I have access to any Intel hardware with
non-contiguous bitmaps right now. Are you able to say where that would
be implemented?

Thanks!
-Peter
