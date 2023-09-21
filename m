Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEB77A9AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjIUSvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjIUSvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:51:20 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282404B71D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:49:54 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7740d57e9f3so43706885a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695318593; x=1695923393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9nCvb9CrO2GaZq009DzYQ8CxVOSv0DQu3f44RpIAl4=;
        b=R5LhrGPN56Ucfjoq1FdDkz/L3ylQkoJkyVLbK0683IT6u86XW7JyxCxSRTTkDI3dAs
         dlOEhGlAOa1fYNhcWUwrajDN1aAAdRg0RPmS3MwK0Pjyd3Jur2c/8UKDz+fzuuJLJP88
         EhUGmqAF2JpqvoFAnD2MYOrkeaMQ8mAiJ25SFF0CAcce9IlUVjQBzWFnCRba/61UHzle
         UCJET1GyVxngbcE1i6GYhiqUb1A0doHrqRLXDi1/hG92ayJhi8jrWbHwyTICxSl908Dk
         0YEXTfYEaGyvjwahfVN6PK/OFdleuo3CbnyTgxeEIPke5hCBhM/dpIJbCOaWPJRViEms
         UQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318593; x=1695923393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9nCvb9CrO2GaZq009DzYQ8CxVOSv0DQu3f44RpIAl4=;
        b=CQk/ZCcwzWLFr+fDsM5sDM5ubBFPHXA8Zm3P9q+CQw9hPNPscwZeBPLIpvgk8J26i1
         Oh+1u9KICD+OM0RHahsAxDyIrWsurCtJqq8h3y9fyzYS1ARaehe9La+ft2raayOZhNlU
         uNEAJeJASJMla+MyEv/NOLr1h+f98P37okNnhsqgCpeDoZIndWVjb5Mp3XBmXKH8WOJb
         B3ptJGgsGvMPf+CAg8QzeNwOMTkKsPEEjutgqcSTaGEjNhBY4/eTMlrxQjhjsRqvzGWV
         2kczcLpYVG6Sw9ykT0vIn7t7guaQExcRwPcrPATMv8n2aRYzurPCvPbknEL38xEnHqU9
         3Pfg==
X-Gm-Message-State: AOJu0YyXx1eapKGk7kl3BmkYIot6d41FhcldZjV4rLhIAJGNHSfczHxv
        duV+bOKXEjLVBKQM5G/q8fOnv6AfXheT10PU+/kHs+nJPNXvaMOOJi0=
X-Google-Smtp-Source: AGHT+IHVPuhFW+sGrMGW2iY7pMa14QvaelEddHySWV/HAgZhZpuV4DDEx4xNG/hsPPFcqiqQeUvbDngd1S9ogJ2JCoI=
X-Received: by 2002:a17:90a:c08a:b0:268:553f:1938 with SMTP id
 o10-20020a17090ac08a00b00268553f1938mr4569172pjs.4.1695273761830; Wed, 20 Sep
 2023 22:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230920154608.1447057-1-apatel@ventanamicro.com>
In-Reply-To: <20230920154608.1447057-1-apatel@ventanamicro.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 21 Sep 2023 10:52:29 +0530
Message-ID: <CAK9=C2WXtRLTFA5JeWbkyKt+1qyTat0nw7v3-b6oQ-YO_37tdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] KVM RISC-V fixes for ONE_REG interface
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 9:16=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> This series includes few assorted fixes for KVM RISC-V ONE_REG interface
> and KVM_GET_REG_LIST API.
>
> These patches can also be found in riscv_kvm_onereg_fixes_v2 branch at:
> https://github.com/avpatel/linux.git
>
> Changes since v1:
>  - Addressed Drew's comments in PATCH4
>
> Anup Patel (4):
>   RISC-V: KVM: Fix KVM_GET_REG_LIST API for ISA_EXT registers
>   RISC-V: KVM: Fix riscv_vcpu_get_isa_ext_single() for missing
>     extensions
>   KVM: riscv: selftests: Fix ISA_EXT register handling in get-reg-list
>   KVM: riscv: selftests: Selectively filter-out AIA registers

Queued this series for 6.6-rcX fixes

Thanks,
Anup

>
>  arch/riscv/kvm/vcpu_onereg.c                  |  7 ++-
>  .../selftests/kvm/riscv/get-reg-list.c        | 58 ++++++++++++++-----
>  2 files changed, 47 insertions(+), 18 deletions(-)
>
> --
> 2.34.1
>
