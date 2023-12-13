Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B949811470
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441867AbjLMOSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379150AbjLMOSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:18:11 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67420AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:18:17 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3363aa1b7d2so587436f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702477096; x=1703081896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMvhSkMSE/Am1VRqFroHUAOOjs4iyetVHF646YQvvOI=;
        b=KXYuAUC+oqLsgtArLl7kxsnNfiAs/D34549ViQ0T1w5JcR9DNL28cPsX+eWz3UwAEI
         8TGxKAGhiHTDqXwxikPbTDIYsfGc4qz0CXNybP4ZvwhunNjpGqwoEBEStVAiDGKJe8aa
         SqmIsR2JUija7SjRcSPZ7kTQkZSUzWGclN4L4pjxloK+W6jrXw1VyKOZM0EQaBOLyVO5
         5Iw/UZwCuGW+grdag38FnL7ZMSt5IdyTfkQ7R8QTVGva1uVbepKOUXuyeAMqX+CjadKM
         oKynrpFp6eKIBrR1gelKAQhQjwWf/0jHrpmw7ioGp0Z3IeAHN5h/5JWXvrPIeCdR9KyJ
         qWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702477096; x=1703081896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMvhSkMSE/Am1VRqFroHUAOOjs4iyetVHF646YQvvOI=;
        b=nV/p6CiSsLl72dzP15D8v/prjkDkfvaQnPSyyGdZByLCGRWWvc1ao6ln7z+wpOmBnz
         ApCPDfXHu2zJMbdiku3HZngmVFxu6XOul+oaH0a/Br/mRgXZ0/2f5nMTIBCcGmUUbsN8
         yqpirxq1+MAKVaarQhrKKDsacfrDL+zbJlSPXGrEeKPiM4yNKSzUddYjV89nlv/GdHXc
         W/9z+byCzThG2kDIBG0/aTBqwh5q7DGa9zVwcZtIItxkTWV8ob4wjcjnDp1+D1w0Yv7/
         hF95pmKNu/WOsChQDweRz4OfZJiJPMvBREO1od2+08Ru2rbq+yV1clFcUrasj165rEKZ
         6kIg==
X-Gm-Message-State: AOJu0YznCZMUR4w1Nponnji4l6hagt6QfLbCx3Cnj3G/tvs/tzWXCTBF
        7fhxp42MBbOjF6EiyXZMB5zRcA==
X-Google-Smtp-Source: AGHT+IHHAN8IaZVRK1Ps8W71SJhwMq4xLyWFOqoAIKM4rFfgBhljotdkzECz0shi/fy3fHhekB11VQ==
X-Received: by 2002:a5d:6242:0:b0:333:3c06:b433 with SMTP id m2-20020a5d6242000000b003333c06b433mr2848127wrv.0.1702477095654;
        Wed, 13 Dec 2023 06:18:15 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id v16-20020adfa1d0000000b003362e9b75c3sm4056912wrv.88.2023.12.13.06.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:18:15 -0800 (PST)
Date:   Wed, 13 Dec 2023 15:18:14 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        Samuel Holland <samuel@sholland.org>,
        Sean Christopherson <seanjc@google.com>,
        Peter Xu <peterx@redhat.com>, Like Xu <likexu@tencent.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v4 10/11] KVM: riscv: selftests: Add sstc timer test
Message-ID: <20231213-4ba5fcc75b41cd19ec96f08e@orel>
References: <cover.1702371136.git.haibo1.xu@intel.com>
 <3bb7d5ae5a1a016e970faa0759c47214c9391b19.1702371136.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bb7d5ae5a1a016e970faa0759c47214c9391b19.1702371136.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 05:31:19PM +0800, Haibo Xu wrote:
> Add a KVM selftests to validate the Sstc timer functionality.
> The test was ported from arm64 arch timer test.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/aarch64/arch_timer.c        |  12 +-
>  tools/testing/selftests/kvm/arch_timer.c      |  10 +-
>  .../selftests/kvm/include/riscv/arch_timer.h  |  71 ++++++++++++
>  .../selftests/kvm/include/riscv/processor.h   |  10 ++
>  .../selftests/kvm/include/timer_test.h        |   5 +-
>  .../testing/selftests/kvm/riscv/arch_timer.c  | 107 ++++++++++++++++++
>  7 files changed, 206 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/riscv/arch_timer.h
>  create mode 100644 tools/testing/selftests/kvm/riscv/arch_timer.c
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
