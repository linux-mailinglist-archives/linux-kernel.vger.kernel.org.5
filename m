Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C2480F65C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjLLTRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjLLTRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:17:17 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3333A109
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:17:23 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-db53f8cf4afso4990925276.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702408642; x=1703013442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXh6bur6LRnADXulivu2P72dN6ifPaK1xY/cKiFFTNI=;
        b=nKavvAYidvQ9w393bc3O1a4mlDsiGhjQJ/4lYL/qcziFXkDI45Yejvmo1XOc1GA/aq
         DmL6kVj+2k2MsnBVsfBXQ2fCbHHJn/UbwVYJk6a2+Vd1Zghoq287v3/sT6wVS0aRUznN
         rkEc5Vw8Ru+y58FfFbfO6ZNoJ6Uom8oeVUe+hqlQgugJjT2ERC+JJ5pXeGo7jaGJtg1K
         bT2xufqFBgQed3Z5szo7rZzQT81g1p1UpVvbocJXyTE7JgI/AOAFO/lG1nPQAU8HRmP+
         hxHpFwQuMvFUZvyD2kxPIHDopIZjXN+rBWqw0B6oypvOfoyLo/yXFo/6DnKBHL49SBVE
         P/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702408642; x=1703013442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXh6bur6LRnADXulivu2P72dN6ifPaK1xY/cKiFFTNI=;
        b=EwSlJGUTz56fUyJLsaqPUYt7OS2P42qbsmHlQVxe8ls5S+vbJqzz+exHyWIokTnRyt
         wf8qa2zkOccGOSQB4D8foT9wGPp6wZgNVR2fbCYcbEGTJYaAeC4kL/VHDFn/5Sruy3la
         bueMKNtAHVbaS61t8/7tvIigvEWO9MZgK+4f6ZFW8B58xtsAPN1SoKlXy7fMVGCrY49f
         zBbMjM/dgYryDhjws76qyqx0Z8zeSZ6PCF2MiDJ76FvkUDFI2kbC5kopWzu0vJFz8bTC
         goBx9l6R0dZfm5wmYvc1AGRDWRH9Y6rjj1l0a9aPzJgywJnAwzUQp912rskZ38G2V1FK
         eMOg==
X-Gm-Message-State: AOJu0YwJtW10L/cxj5YZjjuV457K2zsXKPsgI+ckaxUInZeyttXoDXp6
        8pa4jYTmkFoXL6MLpBl9YTBicCXwwTTX3+IbH/tCWg==
X-Google-Smtp-Source: AGHT+IEg7PrE51WetYNV2TXBUh16oGjCgjaHBUbmLH/Y9ejNibFsuQg1ft+g8k/hUJRIzvj4zJlXYzVe6GRAoz3cE6E=
X-Received: by 2002:a25:244b:0:b0:dbc:c4f2:612f with SMTP id
 k72-20020a25244b000000b00dbcc4f2612fmr698912ybk.34.1702408642045; Tue, 12 Dec
 2023 11:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org> <20231122-arm64-gcs-v7-2-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-2-201c483bd775@kernel.org>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Tue, 12 Dec 2023 11:17:11 -0800
Message-ID: <CAKC1njSC5cC_fXnyNAPt=WU6cD-OjLKFxo90oVPmsLJbuWf4nw@mail.gmail.com>
Subject: Re: [PATCH v7 02/39] prctl: arch-agnostic prctl for shadow stack
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 1:43=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> Three architectures (x86, aarch64, riscv) have announced support for
> shadow stacks with fairly similar functionality.  While x86 is using
> arch_prctl() to control the functionality neither arm64 nor riscv uses
> that interface so this patch adds arch-agnostic prctl() support to
> get and set status of shadow stacks and lock the current configuation to
> prevent further changes, with support for turning on and off individual
> subfeatures so applications can limit their exposure to features that
> they do not need.  The features are:
>
>   - PR_SHADOW_STACK_ENABLE: Tracking and enforcement of shadow stacks,
>     including allocation of a shadow stack if one is not already
>     allocated.
>   - PR_SHADOW_STACK_WRITE: Writes to specific addresses in the shadow
>     stack.
>   - PR_SHADOW_STACK_PUSH: Push additional values onto the shadow stack.
>
> These features are expected to be inherited by new threads and cleared
> on exec(), unknown features should be rejected for enable but accepted
> for locking (in order to allow for future proofing).
>
> This is based on a patch originally written by Deepak Gupta but modified
> fairly heavily, support for indirect landing pads is removed, additional
> modes added and the locking interface reworked.  The set status prctl()
> is also reworked to just set flags, if setting/reading the shadow stack
> pointer is required this could be a separate prctl.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  include/linux/mm.h         |  4 ++++
>  include/uapi/linux/prctl.h | 22 ++++++++++++++++++++++
>  kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 10462f354614..8b28483b4afa 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4143,4 +4143,8 @@ static inline bool pfn_is_unaccepted_memory(unsigne=
d long pfn)
>         return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE)=
;
>  }
>
> +int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __=
user *status);
> +int arch_set_shadow_stack_status(struct task_struct *t, unsigned long st=
atus);
> +int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long s=
tatus);
> +
>  #endif /* _LINUX_MM_H */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 370ed14b1ae0..3c66ed8f46d8 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -306,4 +306,26 @@ struct prctl_mm_map {
>  # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK      0xc
>  # define PR_RISCV_V_VSTATE_CTRL_MASK           0x1f
>
> +/*
> + * Get the current shadow stack configuration for the current thread,
> + * this will be the value configured via PR_SET_SHADOW_STACK_STATUS.
> + */
> +#define PR_GET_SHADOW_STACK_STATUS      71
> +
> +/*
> + * Set the current shadow stack configuration.  Enabling the shadow
> + * stack will cause a shadow stack to be allocated for the thread.
> + */
> +#define PR_SET_SHADOW_STACK_STATUS      72
> +# define PR_SHADOW_STACK_ENABLE         (1UL << 0)

Other architecture may require disabling shadow stack if glibc
tunables is set to permissive mode.
In permissive mode, if glibc encounters `dlopen` on an object which
doesn't support shadow stack,
glibc should be able to issue PR_SHADOW_STACK_DISABLE.

Architectures can choose to implement or not but I think arch agnostic
code should enumerate this.

> +# define PR_SHADOW_STACK_WRITE         (1UL << 1)
> +# define PR_SHADOW_STACK_PUSH          (1UL << 2)
> +
> +/*
> + * Prevent further changes to the specified shadow stack
> + * configuration.  All bits may be locked via this call, including
> + * undefined bits.
> + */
