Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB27718D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 05:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjHGDsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 23:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjHGDss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:48:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A866A10FD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 20:48:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bcfe28909so552929366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 20:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1691380125; x=1691984925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bns5NuOnFHjf4+AhxK6OdiLKU/uYDW/dYLyqP2UAOt4=;
        b=5LEnuLe6+rBNX3zvpPKPIdTqqnxWUz738hsVOkmEBZH2bi40Ti+h6hJSvGjAVK7k+t
         dHk25/OASOQPlDXjFWyNqGEqFz98nybJEnn4a8eiZ9+so87/6fNBzBq+1+UGOPOFuESW
         zAGuk1oq4XTKNeSdOrWID5h2t2Bbm9qH8ECfTAYsya9MP9jF3oRSFnqymLvshliQupLU
         aVBtHihjRnYkd0HekrClm6sQL02NknOm832ejQQIYLXrNtyGUdFoo3K1Sqy1bpjMVR4k
         KQh2jUGOBKILi2W/cvrlXAfAEASLdhBNpmKZF7ceGWfp50NovnwspgLkg75Rn7fGcYu/
         ljeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691380125; x=1691984925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bns5NuOnFHjf4+AhxK6OdiLKU/uYDW/dYLyqP2UAOt4=;
        b=Fqzq9XZzwUQq+3jS9YZEgkx71RRoSqyJHU3bVCS8V7xu6T6ZdR0BRV0YkdwyBsvWfC
         qu6npXydyrgedlREK7AkyFhxouo36/tcZ+yD79nabQUKHXQd8BeaA2bhcoPAk88MxgdD
         fMkpQvFZIloKYImVWsxJpyPg7rKkn01IGR+TPAUhzo8cariJs6OAu3E+VL0mm6liagUI
         2l6KBOX5GX11mnoB8YO3vyQI4ox9RGZWwjWHpwK25LtrabknhbKvY0XUr6dqHTtx3n7P
         7i+Ck5CWYGXkixBFmpaGtSjS012aa4S43Qr0dhXwbyPEiKVlqXakgvKcu/FQQTo4zfsr
         buLQ==
X-Gm-Message-State: AOJu0YwP2FVjFkNgAjEWQNvrShe6tLPco+bUDtnvIMdow4iCcExvFAka
        u1+o3MkSn66Gn7RmZSDtGL2cnUZV6WVaB3eMcMjMDg==
X-Google-Smtp-Source: AGHT+IFA4Pcl20GhvvrZF32CrVlsSTz8804Kwavv3GghPlUogdRMps2PmuTBdGKwOlui5rGci5M5f/LYq0TGzIIAZN4=
X-Received: by 2002:a17:906:2250:b0:993:eddd:6df9 with SMTP id
 16-20020a170906225000b00993eddd6df9mr7298478ejr.2.1691380124601; Sun, 06 Aug
 2023 20:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690273969.git.haibo1.xu@intel.com>
In-Reply-To: <cover.1690273969.git.haibo1.xu@intel.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 7 Aug 2023 09:18:33 +0530
Message-ID: <CAAhSdy0yug=J0nxnnPoLYL=0MiT0w6qgPYOcv0QwMRe+fsQn8Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] RISCV: Add KVM_GET_REG_LIST API
To:     maz@kernel.org, oliver.upton@linux.dev
Cc:     xiaobo55x@gmail.com, ajones@ventanamicro.com, seanjc@google.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Like Xu <likexu@tencent.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        Haibo Xu <haibo1.xu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Hi Oliver,

On Tue, Jul 25, 2023 at 2:05=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> wrot=
e:
>
> KVM_GET_REG_LIST will dump all register IDs that are available to
> KVM_GET/SET_ONE_REG and It's very useful to identify some platform
> regression issue during VM migration.
>
> Patch 1-7 re-structured the get-reg-list test in aarch64 to make some
> of the code as common test framework that can be shared by riscv.
>
> Patch 8 move reject_set check logic to a function so as to check for
> different errno for different registers.
> Patch 9 move finalize_vcpu back to run_test so that riscv can implement
> its specific operation.
> Patch 10 change to do the get/set operation only on present-blessed list.
> Patch 11 add the skip_set facilities so that riscv can skip set operation
> on some registers.
> Patch 12 enabled the KVM_GET_REG_LIST API in riscv.
> patch 13 added the corresponding kselftest for checking possible
> register regressions.
>
> The get-reg-list kvm selftest was ported from aarch64 and tested with
> Linux v6.5-rc3 on a Qemu riscv64 virt machine.
>
> ---
> Changed since v5:
>   * Rebase to v6.5-rc3
>   * Minor fix for Andrew's comments
>
> Andrew Jones (7):
>   KVM: arm64: selftests: Replace str_with_index with strdup_printf
>   KVM: arm64: selftests: Drop SVE cap check in print_reg
>   KVM: arm64: selftests: Remove print_reg's dependency on vcpu_config
>   KVM: arm64: selftests: Rename vcpu_config and add to kvm_util.h
>   KVM: arm64: selftests: Delete core_reg_fixup
>   KVM: arm64: selftests: Split get-reg-list test code
>   KVM: arm64: selftests: Finish generalizing get-reg-list
>
> Haibo Xu (6):
>   KVM: arm64: selftests: Move reject_set check logic to a function
>   KVM: arm64: selftests: Move finalize_vcpu back to run_test
>   KVM: selftests: Only do get/set tests on present blessed list
>   KVM: selftests: Add skip_set facility to get_reg_list test
>   KVM: riscv: Add KVM_GET_REG_LIST API support
>   KVM: riscv: selftests: Add get-reg-list test

Are you okay for this series to go through the KVM RISC-V tree ?

Regards,
Anup

>
>  Documentation/virt/kvm/api.rst                |   2 +-
>  arch/riscv/kvm/vcpu.c                         | 375 +++++++++
>  tools/testing/selftests/kvm/Makefile          |  13 +-
>  .../selftests/kvm/aarch64/get-reg-list.c      | 554 ++-----------
>  tools/testing/selftests/kvm/get-reg-list.c    | 401 +++++++++
>  .../selftests/kvm/include/kvm_util_base.h     |  21 +
>  .../selftests/kvm/include/riscv/processor.h   |   3 +
>  .../testing/selftests/kvm/include/test_util.h |   2 +
>  tools/testing/selftests/kvm/lib/test_util.c   |  15 +
>  .../selftests/kvm/riscv/get-reg-list.c        | 780 ++++++++++++++++++
>  10 files changed, 1670 insertions(+), 496 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/get-reg-list.c
>  create mode 100644 tools/testing/selftests/kvm/riscv/get-reg-list.c
>
> --
> 2.34.1
>
