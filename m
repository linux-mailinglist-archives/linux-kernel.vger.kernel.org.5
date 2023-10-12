Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2547C6FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378991AbjJLOEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbjJLOEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:04:41 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95401B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:04:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fb85afef4so846489b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1697119479; x=1697724279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3ropCljelAQ4xMLZKutsQltAGHtknBuH4fIH4/voyA=;
        b=CgvDTUxgRcPBjvvF2097VDXV5sKlAs5zL8jKsivI/j+YQ+cl2UaJdgrkQTAbZpzZcq
         rLHv7TjDQnMa9mWvk9dqsTTWKYNVYcooAGR9cNYYI38hRIwDM4ABa3ilj0e2G5VIf7rl
         DK6Zg5ZhuQg696sEBw1s7xgzyWFQKLoY1xqq/lDjl3ZM035WZUDNMPjyTAsiZMViqz9X
         qcUQQ+p/WcjZW+4LHAPM7XQD2IG9BfMImqHvVMK9bn7rL7OzhAfELd3052v8ue1VghJI
         jvEzKm4kGaimY4UiQzkZAvlAT4XH5UqCYuefNqOSBM2T4sHiaHYUump6qVnX+tPHcVfL
         VYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697119479; x=1697724279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3ropCljelAQ4xMLZKutsQltAGHtknBuH4fIH4/voyA=;
        b=cOSjwxk6XjtDJ4T850iEtV2kJumIb/xnc319k5KDJVrlF/Dul3rkLTO0JIZGGKat17
         nElMst2GSZPnXBBG2AVp2UuqyUzGSkP9GNkqyzAerA+O2C8p7uqIIRrOQM8wYQkEIWXM
         1xJKjvZgsz/lVpbDGaT5ozNQwDKFwEmHMsO5hhzydP4i/14EG+c7t0JKYN+MimKF7XzU
         reMP6p8+ouUj4pacEFQL7kQPvqHGiLv0LSYTplEguRJY2NOe1oCe1TSp3XHtI4sr1DBc
         o7bPLpT226cc6+QbuaC+p87/TZGi4cBjuuSfaMBfMnJ2EETDqY3MY9pcEqYpcSUQ85oT
         Q0uw==
X-Gm-Message-State: AOJu0Yzl7TnIBgZbkOtZIeTrOvXL0IoFx8nhs12AK07SlAXpHbsjO4sk
        gX92ls/zLh4ulmhpznk3goLM7ur/EZetbv/rMG8NV1D//Mq4bHk0AMI=
X-Google-Smtp-Source: AGHT+IFYzz1udWcTeV4meGkJeMqGjEeSeMlU+XeqwQooukBcx18KN/ZD2OzwwabFVNJ4dm5BRlOrQ5y5vfkWL1S6KVI=
X-Received: by 2002:a05:6a20:c518:b0:14b:7d8b:cbaf with SMTP id
 gm24-20020a056a20c51800b0014b7d8bcbafmr18395717pzb.57.1697119478939; Thu, 12
 Oct 2023 07:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231003035226.1945725-1-apatel@ventanamicro.com> <CAAhSdy0P=5WiFfFyMHjkd63JKCcjsTsvhLTNgUB+LOCd8A9iOQ@mail.gmail.com>
In-Reply-To: <CAAhSdy0P=5WiFfFyMHjkd63JKCcjsTsvhLTNgUB+LOCd8A9iOQ@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 12 Oct 2023 19:34:27 +0530
Message-ID: <CAAhSdy2XLqB-NPVfqYdO07bPxkc2VXBpethHppiKkBms2ysvZA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] KVM RISC-V Conditional Operations
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
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

Hi Palmer,

On Thu, Oct 5, 2023 at 11:35=E2=80=AFAM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Tue, Oct 3, 2023 at 9:22=E2=80=AFAM Anup Patel <apatel@ventanamicro.co=
m> wrote:
> >
> > This series extends KVM RISC-V to allow Guest/VM discover and use
> > conditional operations related ISA extensions (namely XVentanaCondOps
> > and Zicond).
> >
> > To try these patches, use KVMTOOL from riscv_zbx_zicntr_smstateen_condo=
ps_v1
> > branch at: https://github.com/avpatel/kvmtool.git
> >
> > These patches are based upon the latest riscv_kvm_queue and can also be
> > found in the riscv_kvm_condops_v3 branch at:
> > https://github.com/avpatel/linux.git
> >
> > Changes since v2:
> >  - Dropped patch1, patch2, and patch5 since these patches don't meet
> >    the requirements of patch acceptance policy.
> >
> > Changes since v1:
> >  - Rebased the series on riscv_kvm_queue
> >  - Split PATCH1 and PATCH2 of v1 series into two patches
> >  - Added separate test configs for XVentanaCondOps and Zicond in PATCH7
> >    of v1 series.
> >
> > Anup Patel (6):
> >   dt-bindings: riscv: Add Zicond extension entry
> >   RISC-V: Detect Zicond from ISA string
> >   RISC-V: KVM: Allow Zicond extension for Guest/VM
> >   KVM: riscv: selftests: Add senvcfg register to get-reg-list test
> >   KVM: riscv: selftests: Add smstateen registers to get-reg-list test
> >   KVM: riscv: selftests: Add condops extensions to get-reg-list test
>
> Queued this series for Linux-6.7

I have created shared tag kvm-riscv-shared-tag-6.7 in the
KVM RISC-V repo at:
https://github.com/kvm-riscv/linux.git

This shared tag is based on 6.6-rc5 and contains following 4 patches:
dt-bindings: riscv: Add Zicond extension entry
RISC-V: Detect Zicond from ISA string
dt-bindings: riscv: Add smstateen entry
RISC-V: Detect Smstateen extension

Thanks,
Anup



>
> Thanks,
> Anup
>
> >
> >  .../devicetree/bindings/riscv/extensions.yaml |  6 +++
> >  arch/riscv/include/asm/hwcap.h                |  1 +
> >  arch/riscv/include/uapi/asm/kvm.h             |  1 +
> >  arch/riscv/kernel/cpufeature.c                |  1 +
> >  arch/riscv/kvm/vcpu_onereg.c                  |  2 +
> >  .../selftests/kvm/riscv/get-reg-list.c        | 54 +++++++++++++++++++
> >  6 files changed, 65 insertions(+)
> >
> > --
> > 2.34.1
> >
