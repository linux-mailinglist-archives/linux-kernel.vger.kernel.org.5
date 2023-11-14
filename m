Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCA27EA8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjKNDHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNDHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:07:45 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9311A1;
        Mon, 13 Nov 2023 19:07:40 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 2adb3069b0e04-50930f126b1so6808608e87.3;
        Mon, 13 Nov 2023 19:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699931259; x=1700536059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiPMNDbylGPmUBZnrDrileXRRyOA8CD9jtZ19oaqKUk=;
        b=k12209q2JzzbHrDfxdFKOnf/+KSskVeafWj3aFtkjwkqigxRbQ0zZHo/b9zoJ2gxOO
         m9eRw9L42oVp4EaLYYUXWTq559fSwE1is/f2uSrGFJFgrP/sApxZh/2TBUXpNuIWXiIT
         w2XTLk8HrEupoi9MzRjK8N9tnE31qRfrjbUjD0qz91Z57XX6VArtKySYKO8hjMdlWpjV
         QekAMkBsiVdLHlxpWdt3Xf3vZU5pnlnrPfbHqOsgdi5KpUYwru6klfS8xcDTBKZBOK3d
         5VuCiEU6aVINAkR8zGNDmRspyJY7bRpiyXvk5HEDyTsITiqS8YmIxmnlm9KsXfUlTWO1
         FtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699931259; x=1700536059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xiPMNDbylGPmUBZnrDrileXRRyOA8CD9jtZ19oaqKUk=;
        b=mrJd9yTSxh/CKaBKcm6bBJV3UxNsTPtgCbo5CaS3Vk81jnuH4t4Yi6O8WP9VI2elOE
         HbHFRovBEr5QL7phIrcl3ienGlqhprSejScWNKRrv9EoEfx34oGplgUPgnYQdG9viBR8
         e/y3QfVk584lrBdT8qhLKglhVHoyDlh9kZqmOsDprnqdTKlqWLZoTKpPVZZe6Zmqnn3t
         E2pmQ8sefHzATv/IB3BDLqcY0W7HvZNoEG/I6da/dxVGWNV9ipWWN3I15h3gmt84v8NZ
         nJdnO8QLK7YaudR1lSdu5aJVkUW2Z48cJoAHFytOMNSgAz+pu3xScDfdZXMIfwqy6ZtU
         CgmA==
X-Gm-Message-State: AOJu0Yx+x67US3H6UAY1jQCEACt44Zij7YP0ea7ax3JkSe16zoHuJcpG
        hZtIt7YxuEkoIrgeIDyX2jnsmjy+CNSkQ7s3Jyg1Qgly0LyLKu7GiyY=
X-Google-Smtp-Source: AGHT+IGPPzPhSC9bhpCbxnlwOIW2bW4CohlCP6NGc4HEqcGXfnZ+KKoNgpSkeN1iqykrl5udWVhgbhP92EtZepzfoOM=
X-Received: by 2002:a05:6512:31c8:b0:4fe:279b:8a02 with SMTP id
 j8-20020a05651231c800b004fe279b8a02mr6190916lfe.67.1699931258504; Mon, 13 Nov
 2023 19:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com> <20231110021306.1269082-27-seanjc@google.com>
 <feb599ea-89e6-1dd9-ba71-3c3d1e027e06@gmail.com> <ZVInZkwjbanQ2rkx@google.com>
In-Reply-To: <ZVInZkwjbanQ2rkx@google.com>
From:   Jinrong Liang <ljr.kernel@gmail.com>
Date:   Tue, 14 Nov 2023 11:07:27 +0800
Message-ID: <CAFg_LQWU1ZZBKLJUZxSkovJAVV90Fm16Tjn2+R2UugV+0wyJpA@mail.gmail.com>
Subject: Re: [PATCH v8 26/26] KVM: selftests: Extend PMU counters test to
 validate RDPMC after WRMSR
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>,
        Jinrong Liang <cloudliang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=8813=
=E6=97=A5=E5=91=A8=E4=B8=80 21:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Nov 13, 2023, Jinrong Liang wrote:
> > =E5=9C=A8 2023/11/10 10:13, Sean Christopherson =E5=86=99=E9=81=93:
> > > Extend the read/write PMU counters subtest to verify that RDPMC also =
reads
> > > back the written value.  Opportunsitically verify that attempting to =
use
> > > the "fast" mode of RDPMC fails, as the "fast" flag is only supported =
by
> > > non-architectural PMUs, which KVM doesn't virtualize.
> > >
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > > +           /* Redo the read tests with RDPMC, and with forced emulat=
ion. */
> > > +           vector =3D rdpmc_safe(rdpmc_idx, &val);
> > > +           GUEST_ASSERT_PMC_MSR_ACCESS(RDPMC, rdpmc_idx, !expect_suc=
cess, vector);
> > > +           if (expect_success)
> > > +                   GUEST_ASSERT_PMC_VALUE(RDPMC, rdpmc_idx, val, exp=
ected_val);
> > > +
> > > +           vector =3D rdpmc_safe_fep(rdpmc_idx, &val);
> > > +           GUEST_ASSERT_PMC_MSR_ACCESS(RDPMC, rdpmc_idx, !expect_suc=
cess, vector);
> > > +           if (expect_success)
> > > +                   GUEST_ASSERT_PMC_VALUE(RDPMC, rdpmc_idx, val, exp=
ected_val);
>
> > This test case failed on my Intel machine.
> >
> > Error message=EF=BC=9A
> > Testing arch events, PMU version 0, perf_caps =3D 0
> > Testing GP counters, PMU version 0, perf_caps =3D 0
> > =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
> >   lib/x86_64/processor.c:1100: Unhandled exception in guest
> >   pid=3D464480 tid=3D464480 errno=3D4 - Interrupted system call
> >      1        0x00000000004120e1: assert_on_unhandled_exception =E4=BA=
=8E processor.c:1146
> >      2        0x00000000004062d9: _vcpu_run =E4=BA=8E kvm_util.c:1634
> >      3        0x00000000004062fa: vcpu_run =E4=BA=8E kvm_util.c:1645
> >      4        0x0000000000403697: run_vcpu =E4=BA=8E pmu_counters_test.=
c:56
> >      5        0x00000000004026fc: test_gp_counters =E4=BA=8E pmu_counte=
rs_test.c:434
> >      6        (=E5=B7=B2=E5=86=85=E8=BF=9E=E5=85=A5)test_intel_counters=
 =E4=BA=8E pmu_counters_test.c:580
> >      7        (=E5=B7=B2=E5=86=85=E8=BF=9E=E5=85=A5)main =E4=BA=8E pmu_=
counters_test.c:604
> >      8        0x00007f7a2f03ad84: ?? ??:0
> >      9        0x00000000004028bd: _start =E4=BA=8E ??:?
> >   Unhandled exception '0x6' at guest RIP '0x402bab'
>
> Argh, I didn't add a check to see if forced emulation is actually enabled=
 (forced
> emulation uses a magic "prefix" to trigger a #UD, which KVM intercepts; i=
f forced
> emulation isn't enabled, KVM ignores the magic prefix and reflects the #U=
D back
> into the guest).
>
> This fixes the test for me:
>
> ---
>  .../selftests/kvm/x86_64/pmu_counters_test.c  | 42 ++++++++++++-------
>  1 file changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/too=
ls/testing/selftests/kvm/x86_64/pmu_counters_test.c
> index 248ebe8c0577..ae5f6042f1e8 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> @@ -325,6 +325,26 @@ __GUEST_ASSERT(expect_gp ? vector =3D=3D GP_VECTOR :=
 !vector,                  \
>                        "Expected " #insn "(0x%x) to yield 0x%lx, got 0x%l=
x",    \
>                        msr, expected_val, val);
>
> +static void guest_test_rdpmc(uint32_t rdpmc_idx, bool expect_success,
> +                            uint64_t expected_val)
> +{
> +       uint8_t vector;
> +       uint64_t val;
> +
> +       vector =3D rdpmc_safe(rdpmc_idx, &val);
> +       GUEST_ASSERT_PMC_MSR_ACCESS(RDPMC, rdpmc_idx, !expect_success, ve=
ctor);
> +       if (expect_success)
> +               GUEST_ASSERT_PMC_VALUE(RDPMC, rdpmc_idx, val, expected_va=
l);
> +
> +       if (!is_forced_emulation_enabled)
> +               return;
> +
> +       vector =3D rdpmc_safe_fep(rdpmc_idx, &val);
> +       GUEST_ASSERT_PMC_MSR_ACCESS(RDPMC, rdpmc_idx, !expect_success, ve=
ctor);
> +       if (expect_success)
> +               GUEST_ASSERT_PMC_VALUE(RDPMC, rdpmc_idx, val, expected_va=
l);
> +}
> +
>  static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_=
counters,
>                                  uint8_t nr_counters, uint32_t or_mask)
>  {
> @@ -367,20 +387,15 @@ static void guest_rd_wr_counters(uint32_t base_msr,=
 uint8_t nr_possible_counters
>                 if (!expect_gp)
>                         GUEST_ASSERT_PMC_VALUE(RDMSR, msr, val, expected_=
val);
>
> +               /*
> +                * Redo the read tests with RDPMC, which has different in=
dexing
> +                * semantics and additional capabilities.
> +                */
>                 rdpmc_idx =3D i;
>                 if (base_msr =3D=3D MSR_CORE_PERF_FIXED_CTR0)
>                         rdpmc_idx |=3D INTEL_RDPMC_FIXED;
>
> -               /* Redo the read tests with RDPMC, and with forced emulat=
ion. */
> -               vector =3D rdpmc_safe(rdpmc_idx, &val);
> -               GUEST_ASSERT_PMC_MSR_ACCESS(RDPMC, rdpmc_idx, !expect_suc=
cess, vector);
> -               if (expect_success)
> -                       GUEST_ASSERT_PMC_VALUE(RDPMC, rdpmc_idx, val, exp=
ected_val);
> -
> -               vector =3D rdpmc_safe_fep(rdpmc_idx, &val);
> -               GUEST_ASSERT_PMC_MSR_ACCESS(RDPMC, rdpmc_idx, !expect_suc=
cess, vector);
> -               if (expect_success)
> -                       GUEST_ASSERT_PMC_VALUE(RDPMC, rdpmc_idx, val, exp=
ected_val);
> +               guest_test_rdpmc(rdpmc_idx, expect_success, expected_val)=
;
>
>                 /*
>                  * KVM doesn't support non-architectural PMUs, i.e. it sh=
ould
> @@ -389,12 +404,7 @@ static void guest_rd_wr_counters(uint32_t base_msr, =
uint8_t nr_possible_counters
>                  */
>                 GUEST_ASSERT(!expect_success || !pmu_has_fast_mode);
>                 rdpmc_idx |=3D INTEL_RDPMC_FAST;
> -
> -               vector =3D rdpmc_safe(rdpmc_idx, &val);
> -               GUEST_ASSERT_PMC_MSR_ACCESS(RDPMC, rdpmc_idx, true, vecto=
r);
> -
> -               vector =3D rdpmc_safe_fep(rdpmc_idx, &val);
> -               GUEST_ASSERT_PMC_MSR_ACCESS(RDPMC, rdpmc_idx, true, vecto=
r);
> +               guest_test_rdpmc(rdpmc_idx, false, -1ull);
>
>                 vector =3D wrmsr_safe(msr, 0);
>                 GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, msr, expect_gp, vector=
);
>
> base-commit: 743a1a6d106931691be32e081e929d9b3de5777f
> --

This fix worked perfectly, thanks.

>
