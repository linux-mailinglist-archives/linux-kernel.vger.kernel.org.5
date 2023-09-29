Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287207B34C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjI2OWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjI2OWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:22:07 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C716D1B1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:22:05 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c6185cafb3so155895ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695997325; x=1696602125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYEFurrEEC58Pi6MuErcWJ3A1NxFP/ysymFeMwH4+H0=;
        b=mMBB6A5LeNbzcZjewRwcSRWyKv/Ix9npFPNe56/IChsDgxIIKy9kUAZllIkUsFPfkX
         HYFgGux5rx6NgVB1JLOhCi+MXERMWtvL8ImhPfO/viR0jCcwr6bEPnFAVfbK/5YPS0w4
         6zsfu/U1Z6Fa3IYYmrzLfNmRXCSdjkFKYXsy/KzbY2LtklW/nI8J8VH7U3DOZQlbZAXa
         4JJKFWug8DEn944qxSYVI/x585o1tEaw8+IAmTyhYx6e2em0ZIKVEDQnB66ef0u8/tCw
         CTpLkvqIJWHtqO3zkKwaOMvr0FFrYgS8GOIg5B6NO9aW56R2iYbF7r+nnNZ4Rfix0nmW
         E34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997325; x=1696602125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYEFurrEEC58Pi6MuErcWJ3A1NxFP/ysymFeMwH4+H0=;
        b=DpxMC6wkD4l9rbqgEyaXxVj/AYLiU5zuzB2n343IAUiJqId8rARs2r4aqfALUCXFHU
         7HcYj/gw9GhmWD7BsSA1JT92u6R0mC+jG0jcBzX9nXRN0bopqXbOlIK3vJOz4fLEgtts
         wSIrYGgrD2uG2NSCneMo+OWMFxzpw48mN573YQBFoX7ApsFsfEMtdY8tKjzj0x9phDiL
         MuWrpMadUwCAc23VJAYN/f8HoUssGSGBXqgvKDnyZhS+qbwDesFgeJLSwrs+63vQAKJK
         uq2kd0k3VCTP+b8Rt17F7E5QQq53CXRe3I7qPFlsj8ieeo7aftX8/slM+nRBtiKEO1L9
         IG8g==
X-Gm-Message-State: AOJu0YwCmQxz9U2ebQ2sPO8q5hxv/9sGSXOw9YF11UIH3/OjDEAZ1R9r
        dEH7GY4K0HHYnlUImd2sMTZTeS2FRmIuu+xr5dT+ww==
X-Google-Smtp-Source: AGHT+IHONXaoBfwbXAGD+xhM6NPRFrExlJFSRqqfsw7iuwEyKFEv1rwMEELo7No+ciZsiAeOEkmQIOfvUjDaN2Qc5nA=
X-Received: by 2002:a17:902:ab18:b0:1c4:21fe:2823 with SMTP id
 ik24-20020a170902ab1800b001c421fe2823mr930677plb.13.1695997324947; Fri, 29
 Sep 2023 07:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230829234426.64421-1-tony.luck@intel.com> <20230928191350.205703-1-tony.luck@intel.com>
 <20230928191350.205703-7-tony.luck@intel.com>
In-Reply-To: <20230928191350.205703-7-tony.luck@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 29 Sep 2023 16:21:54 +0200
Message-ID: <CALPaoCh0dzx2T8-u5ZQXXM0XqaZgJbUAGnRVBmbzHmQiHjvWTA@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] x86/resctrl: Introduce snc_nodes_per_l3_cache
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
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

Hi Tony,

On Thu, Sep 28, 2023 at 9:14=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
>
> Intel Sub-NUMA Cluster (SNC) is a feature that subdivides the CPU cores
> and memory controllers on a socket into two or more groups. These are
> presented to the operating system as NUMA nodes.
>
> This may enable some workloads to have slightly lower latency to memory
> as the memory controller(s) in an SNC node are electrically closer to the
> CPU cores on that SNC node. This cost may be offset by lower bandwidth
> since the memory accesses for each core can only be interleaved between
> the memory controllers on the same SNC node.
>
> Resctrl monitoring on Intel system depends upon attaching RMIDs to tasks
> to track L3 cache occupancy and memory bandwidth. There is an MSR that
> controls how the RMIDs are shared between SNC nodes.
>
> The default mode divides them numerically. E.g. when there are two SNC
> nodes on a socket the lower number half of the RMIDs are given to the
> first node, the remainder to the second node. This would be difficult
> to use with the Linux resctrl interface as specific RMID values assigned
> to resctrl groups are not visible to users.
>
> The other mode divides the RMIDs and renumbers the ones on the second
> SNC node to start from zero.
>
> Even with this redumbering SNC mode requires several changes in resctrl
> behavior for correct operation.

redumbering? Harsh.


> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu=
/resctrl/rdtgroup.c
> index b0901fb95aa9..a5404c412f53 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1357,7 +1357,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resour=
ce *r,
>                 }
>         }
>
> -       return size;
> +       return size / snc_nodes_per_l3_cache;

To confirm, the size represented by a bit goes down rather than the
CBM mask shrinking in each sub-NUMA domain?

I would maybe have expected the CBM mask to already be allocating at
the smallest granularity the hardware supports.

>  }
>
>  /**
> @@ -2590,7 +2590,7 @@ static int rdt_parse_param(struct fs_context *fc, s=
truct fs_parameter *param)
>                 ctx->enable_cdpl2 =3D true;
>                 return 0;
>         case Opt_mba_mbps:
> -               if (!supports_mba_mbps())
> +               if (!supports_mba_mbps() || snc_nodes_per_l3_cache > 1)

Factor into supports_mba_mbps()?

>                         return -EINVAL;
>                 ctx->enable_mba_mbps =3D true;
>                 return 0;
> --
> 2.41.0
>

Reviewed-by: Peter Newman <peternewman@google.com>
