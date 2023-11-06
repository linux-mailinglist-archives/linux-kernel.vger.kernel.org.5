Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF227E1EF1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjKFKwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjKFKwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:52:16 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10818136
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:52:11 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7b9c8706fc1so1196729241.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699267930; x=1699872730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qddZsPv1L0BNBrHiWAo0yUztJcif/xsKDWKIZbJLmaU=;
        b=HLrbsATN/MUKAlX9S7ortA+/0McQsqaBGy7lOtM60PoOL9DrTxNbgFrPK5NunVNlCA
         C401MXqRWspVdjaF/eWjc+K9im2lgG5iT8OU9H1Wjb8Ph7EdJuKzDRXxwL1Se1hga0fM
         FKdNBOaRi7Dpo2Po5zSHaFj9lID6u8UXfumTqfFuexyCfvCCzLUuCKOIqr8latwAmSSn
         dojUGxoYWtfKp6e3N2/EVWA0jbe9OwaDSTb6uiS5HaQPIjkAv2PKBKbKE7lDSlcCydij
         J9x0eK4HNLYtU8XbxoTopFD+Jg0MHFddKvZsPX0YiJjhn5csao408ckj5NKEdMruvCCD
         K5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699267930; x=1699872730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qddZsPv1L0BNBrHiWAo0yUztJcif/xsKDWKIZbJLmaU=;
        b=jWoVLnKC066Q7QDweOAM6SOfnB3zBRnPtdxNkmLOyxM5oWTOPtVIL4J6HsOivAbTOZ
         XEisuwLjiESRsqrYjS1KuHj+lvQBRpJMO1ciBCCb2dbe88pCOWuHJs5cEPqRScaEGd5C
         8aN4bTCrS7hHDsoUpLeP7bLSMK0ubucQte3ZSs2k3A6qg1vNw1g1G/yhHbQl7GX81r2n
         q/DIJo6n1pAj/EdL6LHA6nx2xxmxocwJNg4vaW9pigOimGjC0jMyzlw0dmC9/gi3TnQX
         cVWSbdBLc+88tlNwSjpo/4qDIXLUODayRqfl+ohNR917LSw35S9uK2aKtoh6APsYwzlq
         gBxA==
X-Gm-Message-State: AOJu0YzU0aADcjEnCHxuT9Awsa/tvUTRyx820G1YtwLcyA3pPpqO6Gr9
        gCMfwgMkvpyfdjvNBE9nkJmWa4NQ/KHT7TmHFGAqKQ==
X-Google-Smtp-Source: AGHT+IGmC3RRi4EatKCJe3hwO9OtLplAse6SlutDJIFt75RVfZNvBdwlihvWhA8lo1z+rlYurU95qXhOgirj+SWpnPo=
X-Received: by 2002:a67:c006:0:b0:457:ddde:ba45 with SMTP id
 v6-20020a67c006000000b00457dddeba45mr25033652vsi.14.1699267930134; Mon, 06
 Nov 2023 02:52:10 -0800 (PST)
MIME-Version: 1.0
References: <20231026080409.4149616-1-jens.wiklander@linaro.org>
 <CAFA6WYOYRQ4BgyUE90EwAVULsa=qDkZ4C=0rX49e-E3LOvyz6Q@mail.gmail.com>
 <20231102115925.GA1233092@rayden> <CAFA6WYPh-hfzcuLOHToby_vuQcqHh64kF0WQ4AdoaRwjeyyFFg@mail.gmail.com>
 <20231102131624.GB1233092@rayden> <CAFA6WYMX4UdAYF3BQum0fBXhyUshJv0Hkuwt0UnppDYpR70Rkg@mail.gmail.com>
 <CAHUa44EN4iAdTPf=n1d6AYxfdWWsN3L+dZLtoN3UyzWKydyNYg@mail.gmail.com>
 <CAFA6WYP2php3gKjOeD93fGAZgndOGtKhViMrf25zVyp66dCm6A@mail.gmail.com> <CAHUa44E3ju=jp2d8wFu57Gv3ayoQuvAW+WQKD_iTby9t77CBeQ@mail.gmail.com>
In-Reply-To: <CAHUa44E3ju=jp2d8wFu57Gv3ayoQuvAW+WQKD_iTby9t77CBeQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 6 Nov 2023 16:21:58 +0530
Message-ID: <CAFA6WYPNX20+rmDPfPbp-zhjsFeS-i6gCNfB-=S3oTYKOkN5hA@mail.gmail.com>
Subject: Re: [PATCH 0/2] OP-TEE FF-A notifications
To:     Jens Wiklander <jens.wiklander@linaro.org>
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

On Mon, 6 Nov 2023 at 14:09, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> On Fri, Nov 3, 2023 at 9:53=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
> >
> > On Fri, 3 Nov 2023 at 13:32, Jens Wiklander <jens.wiklander@linaro.org>=
 wrote:
> > >
> > > On Thu, Nov 2, 2023 at 3:05=E2=80=AFPM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> > > >
> > > > On Thu, 2 Nov 2023 at 18:46, Jens Wiklander <jens.wiklander@linaro.=
org> wrote:
> > > > >
> > > > > On Thu, Nov 02, 2023 at 05:46:55PM +0530, Sumit Garg wrote:
> > > > > > On Thu, 2 Nov 2023 at 17:29, Jens Wiklander <jens.wiklander@lin=
aro.org> wrote:
> > > > > > >
> > > > > > > Hi Sumit,
> > > > > > >
> > > > > > > On Mon, Oct 30, 2023 at 11:32:47AM +0530, Sumit Garg wrote:
> > > > > > > > Hi Jens,
> > > > > > > >
> > > > > > > > On Thu, 26 Oct 2023 at 13:34, Jens Wiklander <jens.wiklande=
r@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi all,
> > > > > > > > >
> > > > > > > > > This patchset adds support for using FF-A notifications a=
s a delivery
> > > > > > > > > mechanism of asynchronous notifications from OP-TEE runni=
ng in the secure
> > > > > > > > > world. Support for asynchronous notifications via the SMC=
 ABI was added in
> > > > > > > > > [1], here we add the counterpart needed when using the th=
e FF-A ABI.
> > > > > > > > >
> > > > > > > > > Support for FF-A notifications is added with [2] and this=
 patch set is based
> > > > > > > > > on Sudeeps tree at [3].
> > > > > > > >
> > > > > > > > It's good to see FF-A notifications support coming through.=
 The good
> > > > > > > > aspect here is that FF-A uses a common secure world SGI for
> > > > > > > > notifications and doesn't have to deal with platform specif=
ic reserved
> > > > > > > > SPI for notifications.
> > > > > > > >
> > > > > > > > From OP-TEE point of view I think most of the secure SGI do=
nation base
> > > > > > > > would be common, so can we switch the SMC ABI to use this d=
onated
> > > > > > > > secure world SGI for notifications too?
> > > > > > >
> > > > > > > The SMC ABI driver picks up the interrupt used for notificati=
on from
> > > > > > > device-tree, so there's a chance that it just works if a dona=
ted SGI is
> > > > > > > supplied instead. We'll need some changes in the secure world=
 side of
> > > > > > > OP-TEE, but they wouldn't affect the ABI.
> > > > > >
> > > > > > AFAIK, a secure world donated SGIs doesn't support IRQ mapping =
via DT.
> > > > > > The FF-A driver explicitly creates that mapping here [1].
> > > > >
> > > > > That looks a lot like what platform_get_irq() does via of_irq_get=
().
> > > > >
> > > >
> > > > There is GIC_SPI or GIC_PPI but nothing like GIC_SGI in DT bindings=
 [1].
> > > >
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/include/dt-bindings/interrupt-controller/arm-gic.h
> > > >
> > > > > > Moreover
> > > > > > it's better to detect it via an SMC call rather than hard coded=
 via DT
> > > > > > as FF-A driver does.
> > > > >
> > > > > Typo? I guess you mean that you prefer that way the FF-A driver d=
oes it
> > > > > rather than having it set in the DT.
> > > >
> > > > Yeah sorry about that. We shouldn't use DT if OP-TEE features are d=
iscoverable.
> > > >
> > > > >
> > > > > Assuming that you only care about "arm,gic-v3". The SGI will like=
ly
> > > > > always be the same so it shouldn't be too hard to keep the correc=
t
> > > > > configuration in DT.
> > > >
> > > > See above, DT looks like it does not support SGI.
> > >
> > > You're right.
> > >
> > > >
> > > > >
> > > > > >
> > > > > > So the ABI should dynamically detect if there is a donated SGI =
then
> > > > > > use it otherwise fallback to SPI/PPI detection via DT. This wou=
ld make
> > > > > > the notifications feature platform agnostic and we can drop leg=
acy DT
> > > > > > methods from optee-os entirely but still need to maintain them =
in the
> > > > > > kernel for backwards compatibility.
> > > > >
> > > > > We care about compatibility in both directions so we'd need to ke=
ep it
> > > > > in OP-TEE too, but perhaps under a config flag.
> > > >
> > > > Isn't it just supported on Qemu right now in OP-TEE? I hope droppin=
g a
> > > > feature won't be a problem there compared with the maintenance burd=
en.
> > >
> > > I'd rather not remove this since I believe it can support more
> > > configurations (different interrupt controllers), but feel free to
> > > propose a patch with the new ABI.
> >
> > Having a second thought here, I think adding further ABIs (redundant
> > ABIs become maintenance burden overtime) don't make sense until we see
> > real users of notifications. Have you been able to discover real users
> > of this asynchronous notifications feature in OP-TEE?
>
> No, not upstream. There have been questions about a feature like this
> from time to time in the past and I guess non-trivial interrupt
> handling will soon need it.

Okay let's keep the way it is today unless we really need support for SGIs =
too.

-Sumit

>
> Cheers,
> Jens
>
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
> > > > > Thanks,
> > > > > Jens
> > > > >
> > > > > >
> > > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holl=
a/linux.git/tree/drivers/firmware/arm_ffa/driver.c?h=3Dffa-updates-6.7#n128=
3
> > > > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holl=
a/linux.git/tree/drivers/firmware/arm_ffa/driver.c?h=3Dffa-updates-6.7#n127=
5
> > > > > >
> > > > > > -Sumit
> > > > > >
> > > > > > >
> > > > > > > Cheers,
> > > > > > > Jens
> > > > > > >
> > > > > > > >
> > > > > > > > -Sumit
> > > > > > > >
> > > > > > > > >
> > > > > > > > > [1] https://lore.kernel.org/lkml/20211103090255.998070-1-=
jens.wiklander@linaro.org/
> > > > > > > > > [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa=
_v1-1_notif-v4-0-cddd3237809c@arm.com/
> > > > > > > > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudee=
p.holla/linux.git/tag/?h=3Dffa-updates-6.7
> > > > > > > > >     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the =
driver version to v1.1")
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Jens
> > > > > > > > >
> > > > > > > > > Jens Wiklander (2):
> > > > > > > > >   optee: provide optee_do_bottom_half() as a common funct=
ion
> > > > > > > > >   optee: ffa_abi: add asynchronous notifications
> > > > > > > > >
> > > > > > > > >  drivers/tee/optee/call.c          | 31 ++++++++++-
> > > > > > > > >  drivers/tee/optee/ffa_abi.c       | 91 +++++++++++++++++=
+++++++++++++-
> > > > > > > > >  drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
> > > > > > > > >  drivers/tee/optee/optee_private.h |  9 ++-
> > > > > > > > >  drivers/tee/optee/smc_abi.c       | 36 ++----------
> > > > > > > > >  5 files changed, 153 insertions(+), 42 deletions(-)
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> > > > > > > > > --
> > > > > > > > > 2.34.1
> > > > > > > > >
