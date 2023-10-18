Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925767CDBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjJRMiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjJRMiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:38:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0395811C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:38:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso10723406a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632692; x=1698237492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLUXL/iPx3v+XR7Yu/Dv2RbgN18FZCB4Gf9I+UdPwaE=;
        b=VSTb6ge9s2A35PiDVCCBY0AE9gquhe8TZHMcvo0aFS0y+NGjgD0xfLMt/lPqaiQe4g
         DT9aZ2V9VPuwDo4B1tUYRsgjp5xJPC8UHCujzuJ9y00cPqOEzpis/uhWXzbhoPFqfPir
         SIGRpjH8T24MVeyhI+7nnm9YPLUvRgWqkAbV5IDWhXxkDl3cIyQ5rKQ/ZHEl1uH6PK69
         nBYmfgUjFROjHEeYtYFh63kGr6ZLNblQYGkLq/FS6o7BHUVnut9BWGksCOB3FupAZlKo
         JR4nQ4rh3/OnAfUgThVplxn9rcgIJJh1XPFvM825RZh3GAfuTtHMvMt6D4gOgESqWgUy
         AkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632692; x=1698237492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLUXL/iPx3v+XR7Yu/Dv2RbgN18FZCB4Gf9I+UdPwaE=;
        b=tDr6w4Zl0zBZ48FleZuKtWb6hnXX3w9P+QOqZruLdIuUbLhXRVZ7APD+6aZHRux1Uq
         T10hvt7zuizVmBVEpCSuWNkoR9B9ePgfBs8tVqYw8hRRz5Y1ZEtHxfqjzmagHIAjztcT
         eSgo/AuVY6j7rtKZqvyH7NG/wvJnZf2qctr7X/Uz/vWGtATLXeF7SCLUMD+AP2pIUJNI
         ASZdiI1TNmr7aEpG0+ey6a1oN436Yow0a8fPonX+9woIpzhfOTjRJzPsWOrNpICAT7kK
         bECcs6nFEGDYBZErzDo7tdIdI+S91VVZ6MVqLMyYgtk6fRopAp3fLY0rg5qsJBeySGv8
         viqA==
X-Gm-Message-State: AOJu0Yzky2N2DpZpZFC6oHf6UsT1JB2NOIfBTW+eoA+70YgZmBwCx4cX
        L0HbvZrg3K1lQmI/CWrqkLc=
X-Google-Smtp-Source: AGHT+IHqVtWl9quPNuyGYaPKOwaB9R4TUOVnLydGasfjeOI3hnAHOekW9hgbN5HbNqHQfnMba9Jc4g==
X-Received: by 2002:a50:a6db:0:b0:53e:7ef9:a8cc with SMTP id f27-20020a50a6db000000b0053e7ef9a8ccmr4156087edc.0.1697632692254;
        Wed, 18 Oct 2023 05:38:12 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id z96-20020a509e69000000b0053b67aba57bsm2797420ede.17.2023.10.18.05.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:38:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Oct 2023 14:38:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Kalra, Ashish" <ashish.kalra@amd.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH] x86/mm: fix pg_level_to_pfn for 5-level paging mode.
Message-ID: <ZS/RsVFDFImuHDJC@gmail.com>
References: <20231013191703.422085-1-Ashish.Kalra@amd.com>
 <ZSpVtZhks7Wm5Upc@gmail.com>
 <f7aa58e0-7fcd-35a9-d04c-1369a8cb0701@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7aa58e0-7fcd-35a9-d04c-1369a8cb0701@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kalra, Ashish <ashish.kalra@amd.com> wrote:

> 
> On 10/14/2023 3:47 AM, Ingo Molnar wrote:
> > 
> > * Ashish Kalra <Ashish.Kalra@amd.com> wrote:
> > 
> > > From: Ashish Kalra <ashish.kalra@amd.com>
> > > 
> > > Add support for 5-level paging in pg_level_to_pfn().
> > > 
> > > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > > ---
> > >   arch/x86/mm/mem_encrypt_amd.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
> > > index 6faea41e99b6..45914568596a 100644
> > > --- a/arch/x86/mm/mem_encrypt_amd.c
> > > +++ b/arch/x86/mm/mem_encrypt_amd.c
> > > @@ -267,6 +267,10 @@ static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
> > >   		pfn = pud_pfn(*(pud_t *)kpte);
> > >   		prot = pud_pgprot(*(pud_t *)kpte);
> > >   		break;
> > > +	case PG_LEVEL_512G:
> > > +		pfn = p4d_pfn(*(p4d_t *)kpte);
> > > +		prot = p4d_pgprot(*(p4d_t *)kpte);
> > > +		break;
> > 
> > Mind explaining what happens if we don't have this fix, how you found it,
> > which users are expected to be affected by it, whether that's the full
> > known extent of 5-level paging support deficiencies in
> > mem_encrypt_amd.c,foud etc?
> > 
> 
> It was found during working on SNP guest kexec support, this helper function
> is used during early boot stage for setting of C-bit on the PTEs and
> additionally need this same helper for switching shared pages to private
> during guest kexec, so i believe this patch is needed.

Please integrate the information I suggested into the changelog and submit 
a v2 patch.

Thanks,

	Ingo
