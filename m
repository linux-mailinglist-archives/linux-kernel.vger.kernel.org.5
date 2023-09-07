Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426A5797EB3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbjIGWan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjIGWam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:30:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050651BC7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:30:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-273ca7ab3f5so940217a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 15:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694125838; x=1694730638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpnNQ7+4PceUsY4CtP2mHT/YIXxo04Er8QChUdbexmQ=;
        b=lfivh/DGHMjZ5PRWxW8AcabejEgJ9KStLa3R1ZOAD+x7q0HWSQCX3UaWFS3W0EqDPi
         aCjR1sctIFZ+Gk7mIVGnl/d8GBmdpextmmu0eNxXfWfq7GANGL2mi73uFrx9ovMHmK0Y
         05bTpRaAWML4no6sihFB5X+2WXVNMCLHaB9/J47kjjlZuWH4IBwwKYkhxfC9xpv2F5o2
         it8ja2a1U49TC9EYsQKlBjup5vDgNSGknZCVR0M2KcLIatnm0XSgyjh9UKkN3QTbDkcB
         mz0iDSgmKdIXpjnpqUczJ5qiOLS2UDKtQH1VQ7/gLqdUY2b+ESmz+pxkJa/8dXWJYz1A
         kp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694125838; x=1694730638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpnNQ7+4PceUsY4CtP2mHT/YIXxo04Er8QChUdbexmQ=;
        b=tU8pTKDXaBbVLs0uvAf7CqzDphJFmsdzJktUk/F1JZxtsGoreCEzEw+s0Wn6YikFNh
         jIc3mmi2sbhSalkIgyO6zBGUbE2xCsgoS6A3uZRjTe/3J/+LTuBhr2wLUvC5H2URYPJ6
         pWIslAh1Mer2KKqiRmpAf2xKshMHTtf5dYn0a1Ol17d4HCFZEl9W5A5DMFoINJYMcg7k
         oIJGW46EmaEadFQcoTdapnd9yFkOuDBwECj1y4HS9kiuokIiIz85qol4ffnKHl2rtoqL
         4GesJJvKkaFAkuNiepMZ8q73+UnkbbTadhOlQwcYwiS51fAlp/ZC+kl+ZT9fvsnuTzYr
         6N2w==
X-Gm-Message-State: AOJu0YyYZWHiAg5CWwyw0EjdA/XgPZDwV3LE82G/0wYsetw+a8DABRFZ
        /6lDKgmraD/p6uJlf9vgHf2ba/r3hdlcTFFaJS657Q==
X-Google-Smtp-Source: AGHT+IFQDkIymU8DIYuUoJZIZpM5MpNayC97vMwc8ENQeTCQc6xVL/E3VGFg9theyuRLqcjsd+RpkrjfcvgR5fTOMto=
X-Received: by 2002:a17:90b:8c5:b0:26b:3f10:820f with SMTP id
 ds5-20020a17090b08c500b0026b3f10820fmr910764pjb.36.1694125838332; Thu, 07 Sep
 2023 15:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230906224541.2778523-1-acdunlap@google.com> <e037f1c0-aaf6-7951-04ea-6d27e557b61b@intel.com>
 <CAMBK9=b9V6WxYZNrVPNV5vzBZ-mT_noBAxod=ijqrV3bUXAUyA@mail.gmail.com>
 <cb958f57-6a3a-d626-da51-53ad0e61870c@intel.com> <CAMBK9=bk715TjXhzwss+wFqpafKganGhZ=WKWPvEuJyM5M2MCQ@mail.gmail.com>
 <ac2f3bfc-9177-abc9-d4d7-69b1fba943a6@intel.com>
In-Reply-To: <ac2f3bfc-9177-abc9-d4d7-69b1fba943a6@intel.com>
From:   Adam Dunlap <acdunlap@google.com>
Date:   Thu, 7 Sep 2023 15:30:26 -0700
Message-ID: <CAMBK9=ZY7UapTq3YxbjD5vhynBou_s9m4tK=oL-wfv-BoAXQ+g@mail.gmail.com>
Subject: Re: [PATCH] x86/sev-es: Do not use copy_from_kernel_nofault in early
 #VC handler
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, Jacob Xu <jacobhxu@google.com>
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

On Thu, Sep 7, 2023 at 12:12=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:

> What happens before this?  This isn't the first CPUID
> invocation.  Does this one just happen to #VC and all the others before
> don't?

I hadn't noticed this before, but there is an even earlier interrupt
handler vc_no_ghcb
which only supports cpuid. Potentially this version could work until
boot_cpu_data is
set up, but wasn't able to get it working myself.

> In any case, the most straightforward way out of this mess is to just
> move boot_cpu_data out of .bss and explicitly initialize it along with
> some documentation explaining the situation.

That seems totally reasonable. I tried applying the two patches that
you sent plus
boot_cpu_data.x86_virt_bits =3D 0; in early_setup_idt(), and that fixes
the problems
that we can see. Do you want me to send out a new patch with these changes
together?
