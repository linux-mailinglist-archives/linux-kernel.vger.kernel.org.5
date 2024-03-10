Return-Path: <linux-kernel+bounces-98058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DC8877492
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 01:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9197B21453
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 00:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D83134CB;
	Sun, 10 Mar 2024 00:03:15 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C31170B
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710028995; cv=none; b=GApW5f+RodE8pTqvgzVUuSlUCaN8iFWZuju6G38aBmJr+WzX1Zvun6Oy8Cmgj9myjbEvZ2+zYmMF3M3SkTvYWSwbTpAHPmFAN7vFxXQVigsrkiU83MeMmNcdb9EFwM8Y2xoh2hzhEJd7LqOm9KkfPKUMgK2JCNg56DiCrvuBW2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710028995; c=relaxed/simple;
	bh=l2PF8vzrNA7mLZujTcKphxVafwGJwqbU2lm5z38glkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNCCwZ72/PJBVBReKl5V5wvf9Jbx3BX8SiqvpxKx9dG48rteM9Mj0DobGMHe4mu/tpsxKmqGOYm6SY9i8CsYm0RwX1DeJ3xMZ6fbCUNFgIWNi07SCHIIQWZ2F0pUZpku5LnGs+2zwGvsWsX3V7pJZuMvPp9IHe3uBKpBH9UDorU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a461c50deccso8471366b.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 16:03:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710028991; x=1710633791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/kxb+cW6k3M1uLfKoBDLes6OkkBdvyrEAxG34HYODA=;
        b=h6cV0B6thED7ELHcwdS8dLlCkGqSKU0SMEqkvHcG4UkqvrAM7aHfjL7Sf/qQCdC9o9
         8zwyTmCGkuO2lYg96aBnZDLDrhOIzCggu9bb+sK+7fpWTz9IYTJit3Y84tsSJSjO736l
         DOOVDUl1TmLu7EaVa3fQdUfw2+D9PQjRw5y1Id+XCPm2hKOxpdBjLZEzawyDn97n3GMe
         C4N18j6W+d0EtWhvkhF8caQRhoHbKszfpsAYS+fVFtXP85UZZPY/AOdDFiZRx16l3PNs
         9doNRnE8wfe5Cw+eTkXxKnJlmvBGNllQjrp471F9ywcS1Zt/wh9ODSpnQsLsO5DpYvaq
         OaTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaK3cjwW1u+Sn5/Yq09I0LEXfu4x9JjOWX/TP1S7+qR2LZJIYwHsl/zu2Ak/Kfgtgt5vNtD90hW+1Ty6hv9U72ZbT3d8fx2oqDoFjD
X-Gm-Message-State: AOJu0YyrVBP6CR5F+4gVhrWZSfHXUlmltY6cLYxa2UXHtRl1hGI/qzD/
	FzNHHujbEdTQsnX8EvJPGMW7xLlGpKohN3mmTLaaY/haSedHDl+2kWVY+kn7zPw=
X-Google-Smtp-Source: AGHT+IHvZy+CdyRxeSSGGBCDwt3qBvrhXzAWLSbtcqv+2paDQCWZb8GFTyS6ulAFCSbPR9YZiUNHjg==
X-Received: by 2002:a17:906:5947:b0:a45:c931:5703 with SMTP id g7-20020a170906594700b00a45c9315703mr1241402ejr.70.1710028990642;
        Sat, 09 Mar 2024 16:03:10 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id ae1-20020a17090725c100b00a45ffe583acsm1255306ejc.187.2024.03.09.16.03.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 16:03:10 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5682ecd1f81so2305449a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 16:03:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwIOJHTnolWLa0iRKqvvqn136IMp5yKYjlCVj+6Eqm6Vfwl8vNtE2FDulWW96/nq+93F/v5Iu5sqW8BnqPNjjl7ARrRXQeLjK+R3FA
X-Received: by 2002:a50:9305:0:b0:566:4aa9:7143 with SMTP id
 m5-20020a509305000000b005664aa97143mr1855789eda.14.1710028990084; Sat, 09 Mar
 2024 16:03:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309210230.239045-1-kirill.shutemov@linux.intel.com> <20240309210230.239045-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240309210230.239045-2-kirill.shutemov@linux.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Sat, 9 Mar 2024 16:02:58 -0800
X-Gmail-Original-Message-ID: <CAC41dw-ptOjRuOLefeu2-k_K1sigKVNxRxh+-9SHNooMfH660A@mail.gmail.com>
Message-ID: <CAC41dw-ptOjRuOLefeu2-k_K1sigKVNxRxh+-9SHNooMfH660A@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/tdx: Introduce tdg_vm_wr()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com, 
	hpa@zytor.com, seanjc@google.com, ele.reshetova@intel.com, 
	rick.p.edgecombe@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 1:02=E2=80=AFPM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Add a helper to write to a TD-scope metadata field and use it to set
> NOTIFY_ENABLES.
>

Add a note about why you create this helper function. I think the
intention is to reuse it
to update other TD-scope fields.

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/coco/tdx/tdx.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index cc67f7380055..5ffe5ef99536 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -77,6 +77,20 @@ static inline void tdcall(u64 fn, struct tdx_module_ar=
gs *args)
>                 panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
>  }
>
> +static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
> +{
> +       struct tdx_module_args args =3D {
> +               .rdx =3D field,
> +               .r8 =3D value,
> +               .r9 =3D mask,
> +       };
> +
> +       tdcall(TDG_VM_WR, &args);
> +
> +       /* Old value */
> +       return args.r8;

Since the update failure will panic, any use for returning the old value?

> +}
> +
>  /**
>   * tdx_mcall_get_report0() - Wrapper to get TDREPORT0 (a.k.a. TDREPORT
>   *                           subtype 0) using TDG.MR.REPORT TDCALL.
> @@ -902,10 +916,6 @@ static void tdx_kexec_unshare_mem(void)
>
>  void __init tdx_early_init(void)
>  {
> -       struct tdx_module_args args =3D {
> -               .rdx =3D TDCS_NOTIFY_ENABLES,
> -               .r9 =3D -1ULL,
> -       };
>         u64 cc_mask;
>         u32 eax, sig[3];
>
> @@ -924,7 +934,7 @@ void __init tdx_early_init(void)
>         cc_set_mask(cc_mask);
>
>         /* Kernel does not use NOTIFY_ENABLES and does not need random #V=
Es */
> -       tdcall(TDG_VM_WR, &args);
> +       tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
>
>         /*
>          * All bits above GPA width are reserved and kernel treats shared=
 bit
> --
> 2.43.0
>

