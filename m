Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8A2774357
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjHHSCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjHHSBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:01:37 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99C2D1ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:28:19 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63cffc0f95eso29269286d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691512050; x=1692116850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoWzrCMANPjnlj2cvgK7d043Ga9JDouQ0JU9bziv+Vs=;
        b=aoX21WBggS/4XosYG0HYLIKnJ7c7QmjOo9JOVS5jS9Qk8gIoraTfS8Lb4jlP3ng4/S
         nctO0uW56++SiRwWIDxn2eqcf67alPUNwPhsVpCQQ3TTyccURL0mUptq2wWAUFptt1GL
         hlj8Q50IjofgrBXgbY9XAQgzJuvg8mjfos48sd3VRUSPz9IHKk3XE/2y/zQMdLFFbHU2
         cjJXk0bdZIO/QTUJvDiTUZNMGazUTawXnhvtWaqSWI+idWPmzPVMXpZ6zO5mVfh7TDmf
         o+2EFmlEPQkzUioTfn9saJw+QvTfEUkoVRdA6mYqAyVyJmZsTRmt/WPFWkzLZBD+ByzQ
         bHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512050; x=1692116850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoWzrCMANPjnlj2cvgK7d043Ga9JDouQ0JU9bziv+Vs=;
        b=BR7LKo0i+GVd2rdoeU5pKciY5x1HO/tmtb5mPVMU2gPULDDYT1hGUugeC9AULMfm96
         I2hcNM/DWt8SbMktjsiLvVmiYA6Uo7Ehczr6jq57caGFY1lJqAu0hLVf/GXHdcTsvGJo
         Xg7bq9nz9bkGVlvWztRli2kdMJqB5a34gru8uXkEQnyUqvp8P2MTkXI2LkxQ3RYsEDhv
         HRaZzDbk6WEZACz7MEexLOVxSLjM4Yx1RiWcKLrfbKl+QVm6YA5hcvDGs9nSbtZngMNl
         tubdENsL5tew9esVdDK+9st/ABbpoj7dycsjuz2sc1neHgBXu5eAoqMWzlRYRduPAEzC
         l/KQ==
X-Gm-Message-State: AOJu0YwIauTL7wxZeewesb+Ik+hGyg7UrCqPMAOww9AzrcvafMi7kvyW
        F8k7dGpS3B3+F3wqRz6n3NQ89pz9d+oXLhYenR2/yuDC6V5MVrabiT8=
X-Google-Smtp-Source: AGHT+IFE1mPg+bhXgiG77u3yQqApnKpoE4FunmLDF9Q9WwsTSf+Qi6ptI0RPfwZ4AzBJM8DZgQeG+mmHAo9n23G6KkM=
X-Received: by 2002:a0c:dd13:0:b0:63c:fb87:625d with SMTP id
 u19-20020a0cdd13000000b0063cfb87625dmr10181036qvk.3.1691512050315; Tue, 08
 Aug 2023 09:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230808-riscv_static-v1-1-9f3dc99dafe8@google.com> <20230808162412.GA2172017@dev-arch.thelio-3990X>
In-Reply-To: <20230808162412.GA2172017@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Aug 2023 09:27:19 -0700
Message-ID: <CAKwvOd=93QE6d1Runn9EO9A4KBAKvhx4RwZTpWNNFcf2eW1kWQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: fix 2 instances of -Wmissing-variable-declarations
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Tom Rix <trix@redhat.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 9:24=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Tue, Aug 08, 2023 at 09:15:41AM -0700, Nick Desaulniers wrote:
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index 75970ee2bda2..4c8c0f83a974 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -188,6 +188,7 @@ extern struct pt_alloc_ops pt_ops __initdata;
> >  #define PAGE_KERNEL_IO               __pgprot(_PAGE_IOREMAP)
> >
> >  extern pgd_t swapper_pg_dir[];
> > +extern pgd_t trampoline_pg_dir[];
>
> Missing early_pg_dir too? It looks like there is already a declaration
> in arch/riscv/mm/kasan_init.c that could be hoisted here?

Yep, will respin. Good catch!

--=20
Thanks,
~Nick Desaulniers
