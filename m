Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0187DD64C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjJaSsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjJaSsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:48:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A620F3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 11:48:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so2442a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698778087; x=1699382887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4SYutzdU2lYd0Ydt06asj331E5VhblLHsx51CrMqmA=;
        b=YJnTQ/WRC2U3bPZjGOWHbLsEkzSghyqbu7bDhyEcSK+kT+HuASVc8f38LejspYCeT3
         jsUo/y26VsoY7Bs9XRINtlGOuneO9zFdR5l9NN4rW0QTdhBmDDkGbjPKoZQP58Quf+R6
         s54wIqKDqqOQw6LKnN0hGsUtUO6onElpwCmrmg9vNBRGSkAyjtHiiu2gvP7TeD+7V5Ry
         rcminDem9Z/4gQ7vWhj07yZNQjnhcGNQ0QiXg7CoPuCVMC0o6t7hDBhGfHPlQ1D+2QHy
         uOXQPD4J+4ToaAaOxsyE5uNCBt07C/Y0By4NejQ82AvcYtiOWXXnt4Zt6QZyt1tc2r1P
         cHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698778087; x=1699382887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4SYutzdU2lYd0Ydt06asj331E5VhblLHsx51CrMqmA=;
        b=Lg5kXGYKO8sR9MUnmTFwb7sW8r0p/9Eb3Ax2sJ8SggbAJ21WuB7nTdTX65GxasumYA
         taALDcupRKykTAd8t+Qac9lDq3nar0+bFkmQECD3qM1ZP5TrCNxyHKlfM7hS37PumjNZ
         /dNfNnbOY7atrevNTGbY0gl+DxD4owqp2ranb9O4bE0NOf5Qx5lbsMCdJyg8dqFbz1Io
         3LT/Sf277Ae+5VZw0ojiOXUdLvt5GOwlSKKvy787Kr8gcTDogj4Hmb9OoKGEA2dsLHTz
         f6bS5MGNR0gh/y/lTqdxXnLmn1t9mjBxJeVZxhl7ccnyubr9D8Ind+2Tm5tocKP/PY67
         8Qjg==
X-Gm-Message-State: AOJu0YxRFW6WcyxOxGFcWp3nujhUwXMXFEAAHrFx6jGkdNTqdkf4oN9J
        OqAa2evlSvBbVOR6drsrzQm/FIL4NsGUhfCRSDRj5A==
X-Google-Smtp-Source: AGHT+IH8aQCcupadQGpdlmBqtD0mL9ohRx/4Q5A0bBK0kcOUvlee6GUiG1dAoGzqxix5jpbUy532ZaZqXpUondFIT1w=
X-Received: by 2002:a50:c04f:0:b0:542:d737:dc7e with SMTP id
 u15-20020a50c04f000000b00542d737dc7emr201265edd.0.1698778086580; Tue, 31 Oct
 2023 11:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231031092921.2885109-1-dapeng1.mi@linux.intel.com> <20231031092921.2885109-5-dapeng1.mi@linux.intel.com>
In-Reply-To: <20231031092921.2885109-5-dapeng1.mi@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 31 Oct 2023 11:47:54 -0700
Message-ID: <CALMp9eQ4Xj5D-kgqVMKUNmdF37rLcMRXyDYdQU339sRCKZ7d9A@mail.gmail.com>
Subject: Re: [kvm-unit-tests Patch v2 4/5] x86: pmu: Support validation for
 Intel PMU fixed counter 3
To:     Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Xiong <xiong.y.zhang@intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 2:22=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> Intel CPUs, like Sapphire Rapids, introduces a new fixed counter
> (fixed counter 3) to counter/sample topdown.slots event, but current
> code still doesn't cover this new fixed counter.
>
> So this patch adds code to validate this new fixed counter can count
> slots event correctly.

I'm not convinced that this actually validates anything.

Suppose, for example, that KVM used fixed counter 1 when the guest
asked for fixed counter 3. Wouldn't this test still pass?

> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  x86/pmu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/x86/pmu.c b/x86/pmu.c
> index 6bd8f6d53f55..404dc7b62ac2 100644
> --- a/x86/pmu.c
> +++ b/x86/pmu.c
> @@ -47,6 +47,7 @@ struct pmu_event {
>         {"fixed 1", MSR_CORE_PERF_FIXED_CTR0, 10*N, 10.2*N},
>         {"fixed 2", MSR_CORE_PERF_FIXED_CTR0 + 1, 1*N, 500*N},
>         {"fixed 3", MSR_CORE_PERF_FIXED_CTR0 + 2, 0.1*N, 300*N},
> +       {"fixed 4", MSR_CORE_PERF_FIXED_CTR0 + 3, 1*N, 5000*N},
>  };
>
>  char *buf;
> --
> 2.34.1
>
