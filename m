Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EC17D0571
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346735AbjJSXiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjJSXiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:38:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003BD119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:38:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7fb3f311bso2308787b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697758684; x=1698363484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I2j7Yik+YMnC6aoXUwQPLVmjtMCU4QZmyK+G7ptrz2o=;
        b=Ndhe4/17LqjbxLKvfEL/deGW3JZbXkip+ASFK5zz13jciVr9b41vKxrG0Bn+WloX57
         GqlhG0jIuv4RfNshWab/CLHIzLjvm9TeUahPzhYB3iSrsdIspGTSTpAV84DugnzVscHo
         B6CfpktSIZHDt0lbGwcuD1ry7jKmDm9LKM1/PknyTX5WstZhTYmE2sioJhHcDfD30Zt4
         Wg55yy3UQUlw45ZiyDVKKMAqVoCCiNdEGuOwZT+tCQr0Wm8PsVwt8H0B5OofdwYdsith
         eBP822DI7JmUFt6SiuK9W7WWuybvHAY5cCBOJROCVLVF1rMPVxDy6QqmUInfvf4p2JpH
         gJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697758684; x=1698363484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2j7Yik+YMnC6aoXUwQPLVmjtMCU4QZmyK+G7ptrz2o=;
        b=PTr3kmAdu7rLdgC6Ft55ISjwYESG9OrkUjEU74aAK5svxdvVobTtDql6PiRNLEt1Hd
         LPc3SYUuGYLzaNsmgKZyNp3lP+uQo3ic/6WMK8WJITowOQcKTU2c940GNVujj21yGPlT
         xAy1EBlGxkgu0eMYxcS/M0Yn7eujIBS/CkzYvBXF3AhtuPDMuXYWjE/S0yv1NDrAHRKt
         VT3KD2F2RJ44EoVPBcUNOh2DUX+inJZoMj/3JT4CgqiC5kPGcge/EuvigyWtXRjEBU6e
         GlOie8qNLGzyuQ4mG9nXZzwPJvplsR8kQW4uwMkS8qiUMmS3ZdYCft7u8LkR+t0aeVx/
         1m/A==
X-Gm-Message-State: AOJu0Ywe77t32Y5ePUCPpD1wOtxtW5gCtFTEKZeh3QJbFpRB7UvyrTKz
        DZXTShBS3vT+BL4YTJts2XKD2RM/X7Y=
X-Google-Smtp-Source: AGHT+IEeuZ0b1JLc+AMvcAMKU7edL/eRstuDinRvzcXhzvpXL/aWjymFHDX99YcRicSv3/gfMvOlXaAClmc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d806:0:b0:59b:ea2e:23e5 with SMTP id
 a6-20020a0dd806000000b0059bea2e23e5mr9284ywe.7.1697758684176; Thu, 19 Oct
 2023 16:38:04 -0700 (PDT)
Date:   Thu, 19 Oct 2023 16:38:02 -0700
In-Reply-To: <20230911114347.85882-4-cloudliang@tencent.com>
Mime-Version: 1.0
References: <20230911114347.85882-1-cloudliang@tencent.com> <20230911114347.85882-4-cloudliang@tencent.com>
Message-ID: <ZTG92uzYFEAAyAPK@google.com>
Subject: Re: [PATCH v4 3/9] KVM: selftests: Add pmu.h for PMU events and
 common masks
From:   Sean Christopherson <seanjc@google.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Like Xu <likexu@tencent.com>,
        David Matlack <dmatlack@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jinrong Liang <cloudliang@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shortlog should call out lib/pmu.c (or just say "a library", but naming files is
fine).

On Mon, Sep 11, 2023, Jinrong Liang wrote:
> +#define PMU_CAP_FW_WRITES				BIT_ULL(13)
> +#define PMU_CAP_LBR_FMT				0x3f
> +
> +enum intel_pmu_architectural_events {
> +	/*
> +	 * The order of the architectural events matters as support for each
> +	 * event is enumerated via CPUID using the index of the event.
> +	 */
> +	INTEL_ARCH_CPU_CYCLES,
> +	INTEL_ARCH_INSTRUCTIONS_RETIRED,
> +	INTEL_ARCH_REFERENCE_CYCLES,
> +	INTEL_ARCH_LLC_REFERENCES,
> +	INTEL_ARCH_LLC_MISSES,
> +	INTEL_ARCH_BRANCHES_RETIRED,
> +	INTEL_ARCH_BRANCHES_MISPREDICTED,
> +
> +	NR_REAL_INTEL_ARCH_EVENTS,
> +
> +	/*
> +	 * Pseudo-architectural event used to implement IA32_FIXED_CTR2, a.k.a.
> +	 * TSC reference cycles. The architectural reference cycles event may
> +	 * or may not actually use the TSC as the reference, e.g. might use the
> +	 * core crystal clock or the bus clock (yeah, "architectural").
> +	 */
> +	PSEUDO_ARCH_REFERENCE_CYCLES = NR_REAL_INTEL_ARCH_EVENTS,
> +	NR_INTEL_ARCH_EVENTS,
> +};

...

> +/* Definitions for Architectural Performance Events */
> +#define ARCH_EVENT(select, umask) (((select) & 0xff) | ((umask) & 0xff) << 8)
> +
> +const uint64_t intel_pmu_arch_events[] = {
> +	[INTEL_ARCH_CPU_CYCLES]			= ARCH_EVENT(0x3c, 0x0),
> +	[INTEL_ARCH_INSTRUCTIONS_RETIRED]	= ARCH_EVENT(0xc0, 0x0),
> +	[INTEL_ARCH_REFERENCE_CYCLES]		= ARCH_EVENT(0x3c, 0x1),
> +	[INTEL_ARCH_LLC_REFERENCES]		= ARCH_EVENT(0x2e, 0x4f),
> +	[INTEL_ARCH_LLC_MISSES]			= ARCH_EVENT(0x2e, 0x41),
> +	[INTEL_ARCH_BRANCHES_RETIRED]		= ARCH_EVENT(0xc4, 0x0),
> +	[INTEL_ARCH_BRANCHES_MISPREDICTED]	= ARCH_EVENT(0xc5, 0x0),
> +	[PSEUDO_ARCH_REFERENCE_CYCLES]		= ARCH_EVENT(0xa4, 0x1),

Argh, seriously, why!?!?!  0xa4, 0x1 is Topdown Slots, not TSC reference cycles.
There is _zero_ reason to carry over KVM's godawful pseudo-architectural event
crud that exists purely because KVM uses perf events to virtualized PMCs.

And peeking forward at the usage, the whole thing is completely nonsensical, as
the selftest will set expectations on the TSC reference cycles behavior based
on whether or not the Topdown Slots event is supported.

Grr.
