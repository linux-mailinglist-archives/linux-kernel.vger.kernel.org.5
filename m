Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C6F7D50F7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjJXNGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjJXNGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:06:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499FF4EDB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:04:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so12502a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698152659; x=1698757459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoQb6YlfPBjYIy3Wpkmla/gijk8pUtPjEu2M/l2EG1U=;
        b=umo0shyXRoOFhkvA5hTFCzgDIWSdxyXl3iBy9BEtCi3THojvIG9saT1n3NW9W8Lhws
         C3y6SlVPsCXjNJqRN141eOJ4HSyQ1J6pjpsemSkucM4IWK5axUPiEHDnpx+1/bxK1B9W
         e/u15OlTzkqqW+ZMQdVd6FMWGniW/hSH4q/39UIvDR2gH0CoCM7lq2UfQ5LVs/msYugX
         NNQyR2vMtfmmJyOOO4f+t5f3UZ7zDJJJdbS+bGO56H2v5fRCr+of4lZkCDHmlQkM1iNx
         /A16e4BlUJZP4+09slt0uzyt4593kInw0/sxfe+QV6ik9qoWdcIZk9TeKqALAtK3IJwa
         k6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698152659; x=1698757459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoQb6YlfPBjYIy3Wpkmla/gijk8pUtPjEu2M/l2EG1U=;
        b=BxkP9QkQOp/Zjgth4Aj6HKd6PDfAQ5+CHGPpyqx1+mwMlF2oUKSZFa1vmfDdNODTH8
         vst/GJauaDQtXADe6HHj6QoxRuGujHgOS5eZGGXuEIrVsvbZykrTY5YdhIjO6Ur89USY
         +yw0/Fv3D1yqGukGLXrXXxm+sUt5CDn6zQ9wDxLSa3eUqj7L/eXYLAqbQXnvaSwKZpYC
         COhpmCDxc7VVlHhLqKyc1H/j/gIk6F6aCwQKN3hfpSNETlKkyCLAiAn2EtULzgQ9z3PQ
         lQICPtWPGPQ69+gpi4RFd0Yyu7RD82tphvqDHaHxVKgg5lG2SOcG7ZMMhaL/K2yTjRuw
         V90Q==
X-Gm-Message-State: AOJu0YzHGmjWQcL4y+rtU1uQS8xVFV2O5uthoUUy8LRNcpBcrd/gDUu0
        QMuEJAIRPJKwZ/1HNgEB9/5s73zlIjngwix5eAKc/CS+wbh2RyiOdFY=
X-Google-Smtp-Source: AGHT+IHHUEvBTRSqV64tSry+JE3ETQZUZKSAZ5x1xZ0zTNVhwA1XBFSWYOQzscm+T9fYeQZTqKRt9vNdTuLdje5x01o=
X-Received: by 2002:aa7:c417:0:b0:540:9f5c:9a0d with SMTP id
 j23-20020aa7c417000000b005409f5c9a0dmr69803edq.1.1698152659489; Tue, 24 Oct
 2023 06:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231024075748.1675382-1-dapeng1.mi@linux.intel.com> <20231024075748.1675382-3-dapeng1.mi@linux.intel.com>
In-Reply-To: <20231024075748.1675382-3-dapeng1.mi@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 24 Oct 2023 06:03:58 -0700
Message-ID: <CALMp9eRqGr+5+C1OLhxv1i8Q=YVRmFxkZQJoh7HzWkPg2z=WoA@mail.gmail.com>
Subject: Re: [kvm-unit-tests Patch 2/5] x86: pmu: Change the minimum value of
 llc_misses event to 0
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 12:51=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.=
com> wrote:
>
> Along with the CPU HW's upgrade and optimization, the count of LLC
> misses event for running loop() helper could be 0 just like seen on
> Sapphire Rapids.
>
> So modify the lower limit of possible count range for LLC misses
> events to 0 to avoid LLC misses event test failure on Sapphire Rapids.

I'm not convinced that these tests are really indicative of whether or
not the PMU is working properly. If 0 is allowed for llc misses, for
instance, doesn't this sub-test pass even when the PMU is disabled?

Surely, we can do better.

> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  x86/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/x86/pmu.c b/x86/pmu.c
> index 0def28695c70..7443fdab5c8a 100644
> --- a/x86/pmu.c
> +++ b/x86/pmu.c
> @@ -35,7 +35,7 @@ struct pmu_event {
>         {"instructions", 0x00c0, 10*N, 10.2*N},
>         {"ref cycles", 0x013c, 1*N, 30*N},
>         {"llc references", 0x4f2e, 1, 2*N},
> -       {"llc misses", 0x412e, 1, 1*N},
> +       {"llc misses", 0x412e, 0, 1*N},
>         {"branches", 0x00c4, 1*N, 1.1*N},
>         {"branch misses", 0x00c5, 0, 0.1*N},
>  }, amd_gp_events[] =3D {
> --
> 2.34.1
>
