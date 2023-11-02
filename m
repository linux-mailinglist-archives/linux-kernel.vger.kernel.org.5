Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B2A7DF490
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376717AbjKBOFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjKBOFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:05:30 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDCD83
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:05:25 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1f03fdfcfacso504389fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698933924; x=1699538724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uAKa3xYdSVkg6JDI0JPbNLKKKKg1VuHVMApjjYwsti8=;
        b=hi1ptla2T9bEzrJtCDvssvwItlNpavMUyGrAsm00DZXh1CPjyIWCHZW7NVMo35GXwE
         GvAGlFiNF0fs62rGqtML2p78rq8RapWDR+qpbIyya2uaGZqWsltnEuBw2q3juElTojnt
         Fj/n6ojeO2MUplvOGEHE3kEEBlH73TlGyYP3ms4KloPK6Joh1gLOjezX5pIJ0G6fDRfj
         KCDL03uyYR0cjYww3IgBB130raUNTFT8QB8muJV6ElmVRSp/hTRt++dLGh1k1jID6CYl
         wILcPk067OrJmPd+evzlJ3BYSm1xJyeibGDRjJflEg50QNmYTPwONnOIDknZnTFz88QA
         ql+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933924; x=1699538724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAKa3xYdSVkg6JDI0JPbNLKKKKg1VuHVMApjjYwsti8=;
        b=h8OJvejZfVhBpNkdnaU9QBfmdshwGXSw0Ci8ZNtJlB7e0HrU2s0e9sI12de7EcG8I/
         CQ3tYpySd4I1tkha0wuwpAgD/xoMwv8hiCgRh/SItw20z7tMrrSjLmW21dHHtOPoPGyc
         qNGXUyr1ljqpdg1Z9Z78QwTRfsKNDV1Iy6Bg6/r/wQbL10AR9PHPZzO+DRxuBEMoEFsB
         uIiSH5lwGi1xT9Z9JS5koxopTO7rbfABowo31TmC4gEyg6c/h3jkSWaeqTISR41AQytX
         6ydVzQUVak4UYu2PeUOQCSnGtVnGunx9tWqe0gC7y4hUVMbgPW5ZISkFPEnL0oYDMfui
         12Pg==
X-Gm-Message-State: AOJu0YwjMJJ68PAvJeIbTOEp9quybtbxgj5PJorxL5X5AYUAOnNCyxkM
        /hdulfEs5jHk5vobaWF9CSUZDxIwWsmBrsm1/sO/fA==
X-Google-Smtp-Source: AGHT+IGVTwuY2StKKB1isW3oqO0iZfyZX72G2otIOFE2vSNvrF3ahBHazdfSh1TejMmuOHqbySMqzr1STCrUbzvNLl4=
X-Received: by 2002:a05:6870:b50d:b0:1ea:8b10:247a with SMTP id
 v13-20020a056870b50d00b001ea8b10247amr21802910oap.42.1698933924425; Thu, 02
 Nov 2023 07:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231026080409.4149616-1-jens.wiklander@linaro.org>
 <CAFA6WYOYRQ4BgyUE90EwAVULsa=qDkZ4C=0rX49e-E3LOvyz6Q@mail.gmail.com>
 <20231102115925.GA1233092@rayden> <CAFA6WYPh-hfzcuLOHToby_vuQcqHh64kF0WQ4AdoaRwjeyyFFg@mail.gmail.com>
 <20231102131624.GB1233092@rayden>
In-Reply-To: <20231102131624.GB1233092@rayden>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 2 Nov 2023 19:35:13 +0530
Message-ID: <CAFA6WYMX4UdAYF3BQum0fBXhyUshJv0Hkuwt0UnppDYpR70Rkg@mail.gmail.com>
Subject: Re: [PATCH 0/2] OP-TEE FF-A notifications
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Olivier Deprez <Olivier.Deprez@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 at 18:46, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Thu, Nov 02, 2023 at 05:46:55PM +0530, Sumit Garg wrote:
> > On Thu, 2 Nov 2023 at 17:29, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Mon, Oct 30, 2023 at 11:32:47AM +0530, Sumit Garg wrote:
> > > > Hi Jens,
> > > >
> > > > On Thu, 26 Oct 2023 at 13:34, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > This patchset adds support for using FF-A notifications as a delivery
> > > > > mechanism of asynchronous notifications from OP-TEE running in the secure
> > > > > world. Support for asynchronous notifications via the SMC ABI was added in
> > > > > [1], here we add the counterpart needed when using the the FF-A ABI.
> > > > >
> > > > > Support for FF-A notifications is added with [2] and this patch set is based
> > > > > on Sudeeps tree at [3].
> > > >
> > > > It's good to see FF-A notifications support coming through. The good
> > > > aspect here is that FF-A uses a common secure world SGI for
> > > > notifications and doesn't have to deal with platform specific reserved
> > > > SPI for notifications.
> > > >
> > > > From OP-TEE point of view I think most of the secure SGI donation base
> > > > would be common, so can we switch the SMC ABI to use this donated
> > > > secure world SGI for notifications too?
> > >
> > > The SMC ABI driver picks up the interrupt used for notification from
> > > device-tree, so there's a chance that it just works if a donated SGI is
> > > supplied instead. We'll need some changes in the secure world side of
> > > OP-TEE, but they wouldn't affect the ABI.
> >
> > AFAIK, a secure world donated SGIs doesn't support IRQ mapping via DT.
> > The FF-A driver explicitly creates that mapping here [1].
>
> That looks a lot like what platform_get_irq() does via of_irq_get().
>

There is GIC_SPI or GIC_PPI but nothing like GIC_SGI in DT bindings [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/dt-bindings/interrupt-controller/arm-gic.h

> > Moreover
> > it's better to detect it via an SMC call rather than hard coded via DT
> > as FF-A driver does.
>
> Typo? I guess you mean that you prefer that way the FF-A driver does it
> rather than having it set in the DT.

Yeah sorry about that. We shouldn't use DT if OP-TEE features are discoverable.

>
> Assuming that you only care about "arm,gic-v3". The SGI will likely
> always be the same so it shouldn't be too hard to keep the correct
> configuration in DT.

See above, DT looks like it does not support SGI.

>
> >
> > So the ABI should dynamically detect if there is a donated SGI then
> > use it otherwise fallback to SPI/PPI detection via DT. This would make
> > the notifications feature platform agnostic and we can drop legacy DT
> > methods from optee-os entirely but still need to maintain them in the
> > kernel for backwards compatibility.
>
> We care about compatibility in both directions so we'd need to keep it
> in OP-TEE too, but perhaps under a config flag.

Isn't it just supported on Qemu right now in OP-TEE? I hope dropping a
feature won't be a problem there compared with the maintenance burden.

-Sumit

>
> Thanks,
> Jens
>
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tree/drivers/firmware/arm_ffa/driver.c?h=ffa-updates-6.7#n1283
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tree/drivers/firmware/arm_ffa/driver.c?h=ffa-updates-6.7#n1275
> >
> > -Sumit
> >
> > >
> > > Cheers,
> > > Jens
> > >
> > > >
> > > > -Sumit
> > > >
> > > > >
> > > > > [1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens.wiklander@linaro.org/
> > > > > [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com/
> > > > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tag/?h=ffa-updates-6.7
> > > > >     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driver version to v1.1")
> > > > >
> > > > > Thanks,
> > > > > Jens
> > > > >
> > > > > Jens Wiklander (2):
> > > > >   optee: provide optee_do_bottom_half() as a common function
> > > > >   optee: ffa_abi: add asynchronous notifications
> > > > >
> > > > >  drivers/tee/optee/call.c          | 31 ++++++++++-
> > > > >  drivers/tee/optee/ffa_abi.c       | 91 ++++++++++++++++++++++++++++++-
> > > > >  drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
> > > > >  drivers/tee/optee/optee_private.h |  9 ++-
> > > > >  drivers/tee/optee/smc_abi.c       | 36 ++----------
> > > > >  5 files changed, 153 insertions(+), 42 deletions(-)
> > > > >
> > > > >
> > > > > base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> > > > > --
> > > > > 2.34.1
> > > > >
