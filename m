Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0587E005B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346429AbjKCIC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346280AbjKCICy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:02:54 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F5A1A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 01:02:47 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1f084cb8b54so16195fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698998567; x=1699603367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhTbWIZQKLMqapeg0J5J4RGppJL24GqNW8OU5VCHdOU=;
        b=gWBUmY8doYgZLyOn+uMI8BeQmfRrdCur2WDTttn5V8whgRupYzQR0kwiE801mej735
         QGoVfwLkQ15nNUIXcoTmiia0TZrUKGF2I8Oo6+2RrGM9eDCU/Yk7mjZ5ORav6ikT7unL
         UdG0I1QretycXvGfLqVuHqgUPoQ351Zl6Wm5C+liSIbgkiE8Ul+bXdzCk6e0O+HxwdtL
         02/D3A1D+MgLDDk4xY7N87UfTYH+2Rogxsn80y4G7x5QtCp5w2tShh7c+wt86kKdCHwN
         qbRC8ZU1+nyZgM60hsg+zwTvctB0QvRN5xkemCO+9bXSMbU8GKwiH+WkD8wG2/KuVaKH
         kIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698998567; x=1699603367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhTbWIZQKLMqapeg0J5J4RGppJL24GqNW8OU5VCHdOU=;
        b=RSKq+YGKcVX7P80h1WBBWE0eSUGkCTZvu2qUAg5Bjldz7jWYxUyYpU61z0VnkjllFJ
         VmTN4BfMOWINB+JyeNTbSEVkvV+zFb3kEGav91cy859FnK8yXJ4+uDzxfcBvX4ujY04g
         92JeaJwZ4HvqTSJ4eNWxcJ82HyOOT9i79nKfEFqo4XUwgM7ZF1gcN6p907aR/XzEAYwo
         wkY+VooGgzkRErcDxN1J4uoz1egi2zNFzOIYE9JrS3dRBa7XNCw0YS6of/UZGUdPdMEj
         3bs+Hbe0tKfjqh/K3rZVuu28gmr819yagCx9EC5vvtWByhKHS8ElE3hC+6fHYbAKfY8r
         3sCw==
X-Gm-Message-State: AOJu0YyZz7tAc5kIODiNvQ4v4CmFcryfpDg/y0Pm37x3XRM56WU3PmlP
        E9iwPJ81bD7rNqbkjhej9l7Ot0b8pQD/bujvYQfAYA==
X-Google-Smtp-Source: AGHT+IGVWdmp1Esj4+2ZW80nPUv6lPfWBPEaKQGoVZUjFTk98TonfUHjmK+KLX8gOhep39BpvoWYzyK50INuL+YNViQ=
X-Received: by 2002:a05:6870:c797:b0:1ef:b0d5:de4f with SMTP id
 dy23-20020a056870c79700b001efb0d5de4fmr13624663oab.23.1698998567121; Fri, 03
 Nov 2023 01:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231026080409.4149616-1-jens.wiklander@linaro.org>
 <CAFA6WYOYRQ4BgyUE90EwAVULsa=qDkZ4C=0rX49e-E3LOvyz6Q@mail.gmail.com>
 <20231102115925.GA1233092@rayden> <CAFA6WYPh-hfzcuLOHToby_vuQcqHh64kF0WQ4AdoaRwjeyyFFg@mail.gmail.com>
 <20231102131624.GB1233092@rayden> <CAFA6WYMX4UdAYF3BQum0fBXhyUshJv0Hkuwt0UnppDYpR70Rkg@mail.gmail.com>
In-Reply-To: <CAFA6WYMX4UdAYF3BQum0fBXhyUshJv0Hkuwt0UnppDYpR70Rkg@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 3 Nov 2023 09:02:35 +0100
Message-ID: <CAHUa44EN4iAdTPf=n1d6AYxfdWWsN3L+dZLtoN3UyzWKydyNYg@mail.gmail.com>
Subject: Re: [PATCH 0/2] OP-TEE FF-A notifications
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Olivier Deprez <Olivier.Deprez@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 3:05=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> On Thu, 2 Nov 2023 at 18:46, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> >
> > On Thu, Nov 02, 2023 at 05:46:55PM +0530, Sumit Garg wrote:
> > > On Thu, 2 Nov 2023 at 17:29, Jens Wiklander <jens.wiklander@linaro.or=
g> wrote:
> > > >
> > > > Hi Sumit,
> > > >
> > > > On Mon, Oct 30, 2023 at 11:32:47AM +0530, Sumit Garg wrote:
> > > > > Hi Jens,
> > > > >
> > > > > On Thu, 26 Oct 2023 at 13:34, Jens Wiklander <jens.wiklander@lina=
ro.org> wrote:
> > > > > >
> > > > > > Hi all,
> > > > > >
> > > > > > This patchset adds support for using FF-A notifications as a de=
livery
> > > > > > mechanism of asynchronous notifications from OP-TEE running in =
the secure
> > > > > > world. Support for asynchronous notifications via the SMC ABI w=
as added in
> > > > > > [1], here we add the counterpart needed when using the the FF-A=
 ABI.
> > > > > >
> > > > > > Support for FF-A notifications is added with [2] and this patch=
 set is based
> > > > > > on Sudeeps tree at [3].
> > > > >
> > > > > It's good to see FF-A notifications support coming through. The g=
ood
> > > > > aspect here is that FF-A uses a common secure world SGI for
> > > > > notifications and doesn't have to deal with platform specific res=
erved
> > > > > SPI for notifications.
> > > > >
> > > > > From OP-TEE point of view I think most of the secure SGI donation=
 base
> > > > > would be common, so can we switch the SMC ABI to use this donated
> > > > > secure world SGI for notifications too?
> > > >
> > > > The SMC ABI driver picks up the interrupt used for notification fro=
m
> > > > device-tree, so there's a chance that it just works if a donated SG=
I is
> > > > supplied instead. We'll need some changes in the secure world side =
of
> > > > OP-TEE, but they wouldn't affect the ABI.
> > >
> > > AFAIK, a secure world donated SGIs doesn't support IRQ mapping via DT=
.
> > > The FF-A driver explicitly creates that mapping here [1].
> >
> > That looks a lot like what platform_get_irq() does via of_irq_get().
> >
>
> There is GIC_SPI or GIC_PPI but nothing like GIC_SGI in DT bindings [1].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/include/dt-bindings/interrupt-controller/arm-gic.h
>
> > > Moreover
> > > it's better to detect it via an SMC call rather than hard coded via D=
T
> > > as FF-A driver does.
> >
> > Typo? I guess you mean that you prefer that way the FF-A driver does it
> > rather than having it set in the DT.
>
> Yeah sorry about that. We shouldn't use DT if OP-TEE features are discove=
rable.
>
> >
> > Assuming that you only care about "arm,gic-v3". The SGI will likely
> > always be the same so it shouldn't be too hard to keep the correct
> > configuration in DT.
>
> See above, DT looks like it does not support SGI.

You're right.

>
> >
> > >
> > > So the ABI should dynamically detect if there is a donated SGI then
> > > use it otherwise fallback to SPI/PPI detection via DT. This would mak=
e
> > > the notifications feature platform agnostic and we can drop legacy DT
> > > methods from optee-os entirely but still need to maintain them in the
> > > kernel for backwards compatibility.
> >
> > We care about compatibility in both directions so we'd need to keep it
> > in OP-TEE too, but perhaps under a config flag.
>
> Isn't it just supported on Qemu right now in OP-TEE? I hope dropping a
> feature won't be a problem there compared with the maintenance burden.

I'd rather not remove this since I believe it can support more
configurations (different interrupt controllers), but feel free to
propose a patch with the new ABI.

Cheers,
Jens

>
> -Sumit
>
> >
> > Thanks,
> > Jens
> >
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linu=
x.git/tree/drivers/firmware/arm_ffa/driver.c?h=3Dffa-updates-6.7#n1283
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linu=
x.git/tree/drivers/firmware/arm_ffa/driver.c?h=3Dffa-updates-6.7#n1275
> > >
> > > -Sumit
> > >
> > > >
> > > > Cheers,
> > > > Jens
> > > >
> > > > >
> > > > > -Sumit
> > > > >
> > > > > >
> > > > > > [1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens.w=
iklander@linaro.org/
> > > > > > [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-1_=
notif-v4-0-cddd3237809c@arm.com/
> > > > > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holl=
a/linux.git/tag/?h=3Dffa-updates-6.7
> > > > > >     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driver=
 version to v1.1")
> > > > > >
> > > > > > Thanks,
> > > > > > Jens
> > > > > >
> > > > > > Jens Wiklander (2):
> > > > > >   optee: provide optee_do_bottom_half() as a common function
> > > > > >   optee: ffa_abi: add asynchronous notifications
> > > > > >
> > > > > >  drivers/tee/optee/call.c          | 31 ++++++++++-
> > > > > >  drivers/tee/optee/ffa_abi.c       | 91 +++++++++++++++++++++++=
+++++++-
> > > > > >  drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
> > > > > >  drivers/tee/optee/optee_private.h |  9 ++-
> > > > > >  drivers/tee/optee/smc_abi.c       | 36 ++----------
> > > > > >  5 files changed, 153 insertions(+), 42 deletions(-)
> > > > > >
> > > > > >
> > > > > > base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> > > > > > --
> > > > > > 2.34.1
> > > > > >
