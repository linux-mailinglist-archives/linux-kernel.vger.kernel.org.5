Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95B7805C3F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345387AbjLERQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLERQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:16:34 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AC51A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:16:40 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso13313a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 09:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701796599; x=1702401399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSBKKU83hDN118eQdXRp7uqCLcQ4IWw8MqbWslBNiH0=;
        b=vqX8g0skmYIIMpe+vxKIJjnV09zf5j6xgts60pHKJzbEIDojzzCJ7+5/Pt0s9wPV8M
         XYrtAcQIgAaIZKU/iB0khFu+vCE7OEhYs/Y0dzn8/C1gCqlEC21Me6/W/djupAcnt1Bl
         soTWXluHcpY5uC5w3qcMEBwREed/gn069YJpWm1/+rAXnOB+96Cb5+kVK7DMwnQjhS/5
         RzoYs/giSOG4FMzsNBlnFwSW2GnHgg8zUd/v8XKGrxXlDfqVv6kHTkyxkuHcLARUZPgf
         rDB3FTpY5wcjXjHkw52L8A0gMItDKq0yNLWUzBbGzvpxK8+DeH0D4kPqoc2ci0CXgLDB
         /Ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701796599; x=1702401399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSBKKU83hDN118eQdXRp7uqCLcQ4IWw8MqbWslBNiH0=;
        b=V5FkYuLZDnUMRNXWgfm/gYyAK1t0tmTaU1B2ERMAOtoWw+XS0XxnWXajssYssHIaTi
         ORA+S2bR7VAjydN01FleG/otbDY2gSW9lf95BaZfL87kxN/XSCD4fyChEHyVi1vDiuT4
         h89JsOsUKp4QG5+nLKNKttqKUL/koSyF2+3Vs0cOglDZ9nI0lXPrXpUqeshHNHlQ82eD
         XZ8nm0q+BA0oA3KnWEBPd8EhUBZ6nJ9mWs9UKxCJz6Nin/MX4UhMrPGBWBctqgltj1yA
         orRf5uSU7gtIsE5B+yo0g6lpAtwtxswuORayeuSYc5IJBLrs7IfjQ5Gk/kqPlvPj2vuV
         k+QA==
X-Gm-Message-State: AOJu0YyOYpns3Dt8nJX94R/3891Qd9CyP8K+ADqYn6pAzc1E9a6Rx5sU
        Lft/EeQJJZ0nqRo+HV/kImHBQSlSiRvgVnW5p+LxFw==
X-Google-Smtp-Source: AGHT+IHhWfDjtX7QFgsVonw1utkXmkzqOjxQMR+jQXUD8x+BlFDqv25hTYs1PkiYjEeN5YUy2Ak3VErs9f0y4Tgh9ok=
X-Received: by 2002:a50:99de:0:b0:54a:ee8b:7a99 with SMTP id
 n30-20020a5099de000000b0054aee8b7a99mr478462edb.0.1701796598345; Tue, 05 Dec
 2023 09:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20231128125959.1810039-1-nikunj@amd.com> <20231128125959.1810039-13-nikunj@amd.com>
In-Reply-To: <20231128125959.1810039-13-nikunj@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 5 Dec 2023 09:16:27 -0800
Message-ID: <CAAH4kHYL9A4+F0cN1VT1EbaHACFjB6Crbsdzp3hwjz+GuK_CSg@mail.gmail.com>
Subject: Re: [PATCH v6 12/16] x86/sev: Prevent RDTSC/RDTSCP interception for
 Secure TSC enabled guests
To:     Nikunj A Dadhania <nikunj@amd.com>
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, bp@alien8.de,
        mingo@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
        pgonda@google.com, seanjc@google.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 5:02=E2=80=AFAM Nikunj A Dadhania <nikunj@amd.com> =
wrote:
>
> The hypervisor should not be intercepting RDTSC/RDTSCP when Secure TSC
> is enabled. A #VC exception will be generated if the RDTSC/RDTSCP
> instructions are being intercepted. If this should occur and Secure
> TSC is enabled, terminate guest execution.
>
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
>  arch/x86/kernel/sev-shared.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index ccb0915e84e1..6d9ef5897421 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -991,6 +991,16 @@ static enum es_result vc_handle_rdtsc(struct ghcb *g=
hcb,
>         bool rdtscp =3D (exit_code =3D=3D SVM_EXIT_RDTSCP);
>         enum es_result ret;
>
> +       /*
> +        * RDTSC and RDTSCP should not be intercepted when Secure TSC is
> +        * enabled. Terminate the SNP guest when the interception is enab=
led.
> +        * This file is included from kernel/sev.c and boot/compressed/se=
v.c,
> +        * use sev_status here as cc_platform_has() is not available when
> +        * compiling boot/compressed/sev.c.
> +        */
> +       if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
> +               return ES_VMM_ERROR;

Is this not a cc_platform_has situation? I don't recall how the
conversation shook out for TDX's forcing X86_FEATURE_TSC_RELIABLE
versus having a cc_attr_secure_tsc

> +
>         ret =3D sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
>         if (ret !=3D ES_OK)
>                 return ret;
> --
> 2.34.1
>


--=20
-Dionna Glaze, PhD (she/her)
