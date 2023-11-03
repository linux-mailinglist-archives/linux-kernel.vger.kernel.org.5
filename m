Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB5F7E006B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343700AbjKCIx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjKCIxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:53:24 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E48A19D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 01:53:19 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-45d72b3f76dso526171137.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 01:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699001598; x=1699606398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkJo6U1mAb8N98x2KNNB/0dmqsCd5IGyh6ED9aGxytk=;
        b=NTaWsLSMljKrzI19+1/7Qxp06paNm0fuZFbke9UA9J3134wn8eCLsBJGwpCxG6uQay
         AlXQYWgTc/wrVMqpgWCzyKwXX6+5Ids1v9XHli/hM6x6IiiCuyGbvT2jbBTnWw8Oy4dZ
         y5Sxrd9S/h+YVE//RH7zq2ogM3hvMuJekH1rcFek02wnxlZWYVfO+VQKY8Tvqe0/ucER
         396414khyZb+AiE1QbkaHnAhS4Nfwy4PLals0AGgi91/SoGU/JyY7mEO+1Z6qb6kug87
         Kzskh5eVGtkTSORskdGdn3uOCaV5RMh1hIqx2DhnA/uPKj/T/0IVVvCp+9KvceQbbxxZ
         a02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699001598; x=1699606398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkJo6U1mAb8N98x2KNNB/0dmqsCd5IGyh6ED9aGxytk=;
        b=RlE51EhjHbR7DVOujebiOFwfJGCd1MB3fEZefRSKUIyYklPCsbzx4g2MOHxTod8H1m
         EYkCuc/H72/HnyGP5qV7eNi60bTjTQMHhTv1kePTdyEyOQwaHP6eoS7gwj8RuiUDFgqs
         xP35xqiD2F/SxULPz/LfT39CoOu3MBQdtLB/iDswrW4HF9b387lYeRsgUHhZkAD8V3jq
         4+TWDzyUBg45kj/F7f6+FL/9mFfgIs9f7iix8EydsHSgLOhm9subGQO7Mxv5xvC9t4L/
         1oAsuoVlLacZuJmqaT/p3h/kRIkUynDeGLwaML4wopLMNvKpsXsyjaSxCeFyMud1zMmi
         nUcA==
X-Gm-Message-State: AOJu0YySIDmq2fMJaIb2u43CUa0wsjhGJErNqkrI8QazLPoWNk9YlhzO
        r0vaXknre7gJHwpzixNRFCo0Ommyb9c1YlofmII6PfAEp27Jj1ku
X-Google-Smtp-Source: AGHT+IFDpR4tUGz/GnEyvTzny/patFCf7Jzhnxl7YiDyOTbHKZb+Ob/I1B1rWEtWiV/RRmkZha0hhSvKwe+VODqjL6I=
X-Received: by 2002:a67:e1ca:0:b0:45d:a0ad:9502 with SMTP id
 p10-20020a67e1ca000000b0045da0ad9502mr260138vsl.3.1699001597407; Fri, 03 Nov
 2023 01:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231026080409.4149616-1-jens.wiklander@linaro.org>
 <CAFA6WYOYRQ4BgyUE90EwAVULsa=qDkZ4C=0rX49e-E3LOvyz6Q@mail.gmail.com>
 <20231102115925.GA1233092@rayden> <CAFA6WYPh-hfzcuLOHToby_vuQcqHh64kF0WQ4AdoaRwjeyyFFg@mail.gmail.com>
 <20231102131624.GB1233092@rayden> <CAFA6WYMX4UdAYF3BQum0fBXhyUshJv0Hkuwt0UnppDYpR70Rkg@mail.gmail.com>
 <CAHUa44EN4iAdTPf=n1d6AYxfdWWsN3L+dZLtoN3UyzWKydyNYg@mail.gmail.com>
In-Reply-To: <CAHUa44EN4iAdTPf=n1d6AYxfdWWsN3L+dZLtoN3UyzWKydyNYg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 3 Nov 2023 14:23:05 +0530
Message-ID: <CAFA6WYP2php3gKjOeD93fGAZgndOGtKhViMrf25zVyp66dCm6A@mail.gmail.com>
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

On Fri, 3 Nov 2023 at 13:32, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> On Thu, Nov 2, 2023 at 3:05=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
> >
> > On Thu, 2 Nov 2023 at 18:46, Jens Wiklander <jens.wiklander@linaro.org>=
 wrote:
> > >
> > > On Thu, Nov 02, 2023 at 05:46:55PM +0530, Sumit Garg wrote:
> > > > On Thu, 2 Nov 2023 at 17:29, Jens Wiklander <jens.wiklander@linaro.=
org> wrote:
> > > > >
> > > > > Hi Sumit,
> > > > >
> > > > > On Mon, Oct 30, 2023 at 11:32:47AM +0530, Sumit Garg wrote:
> > > > > > Hi Jens,
> > > > > >
> > > > > > On Thu, 26 Oct 2023 at 13:34, Jens Wiklander <jens.wiklander@li=
naro.org> wrote:
> > > > > > >
> > > > > > > Hi all,
> > > > > > >
> > > > > > > This patchset adds support for using FF-A notifications as a =
delivery
> > > > > > > mechanism of asynchronous notifications from OP-TEE running i=
n the secure
> > > > > > > world. Support for asynchronous notifications via the SMC ABI=
 was added in
> > > > > > > [1], here we add the counterpart needed when using the the FF=
-A ABI.
> > > > > > >
> > > > > > > Support for FF-A notifications is added with [2] and this pat=
ch set is based
> > > > > > > on Sudeeps tree at [3].
> > > > > >
> > > > > > It's good to see FF-A notifications support coming through. The=
 good
> > > > > > aspect here is that FF-A uses a common secure world SGI for
> > > > > > notifications and doesn't have to deal with platform specific r=
eserved
> > > > > > SPI for notifications.
> > > > > >
> > > > > > From OP-TEE point of view I think most of the secure SGI donati=
on base
> > > > > > would be common, so can we switch the SMC ABI to use this donat=
ed
> > > > > > secure world SGI for notifications too?
> > > > >
> > > > > The SMC ABI driver picks up the interrupt used for notification f=
rom
> > > > > device-tree, so there's a chance that it just works if a donated =
SGI is
> > > > > supplied instead. We'll need some changes in the secure world sid=
e of
> > > > > OP-TEE, but they wouldn't affect the ABI.
> > > >
> > > > AFAIK, a secure world donated SGIs doesn't support IRQ mapping via =
DT.
> > > > The FF-A driver explicitly creates that mapping here [1].
> > >
> > > That looks a lot like what platform_get_irq() does via of_irq_get().
> > >
> >
> > There is GIC_SPI or GIC_PPI but nothing like GIC_SGI in DT bindings [1]=
.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/include/dt-bindings/interrupt-controller/arm-gic.h
> >
> > > > Moreover
> > > > it's better to detect it via an SMC call rather than hard coded via=
 DT
> > > > as FF-A driver does.
> > >
> > > Typo? I guess you mean that you prefer that way the FF-A driver does =
it
> > > rather than having it set in the DT.
> >
> > Yeah sorry about that. We shouldn't use DT if OP-TEE features are disco=
verable.
> >
> > >
> > > Assuming that you only care about "arm,gic-v3". The SGI will likely
> > > always be the same so it shouldn't be too hard to keep the correct
> > > configuration in DT.
> >
> > See above, DT looks like it does not support SGI.
>
> You're right.
>
> >
> > >
> > > >
> > > > So the ABI should dynamically detect if there is a donated SGI then
> > > > use it otherwise fallback to SPI/PPI detection via DT. This would m=
ake
> > > > the notifications feature platform agnostic and we can drop legacy =
DT
> > > > methods from optee-os entirely but still need to maintain them in t=
he
> > > > kernel for backwards compatibility.
> > >
> > > We care about compatibility in both directions so we'd need to keep i=
t
> > > in OP-TEE too, but perhaps under a config flag.
> >
> > Isn't it just supported on Qemu right now in OP-TEE? I hope dropping a
> > feature won't be a problem there compared with the maintenance burden.
>
> I'd rather not remove this since I believe it can support more
> configurations (different interrupt controllers), but feel free to
> propose a patch with the new ABI.

Having a second thought here, I think adding further ABIs (redundant
ABIs become maintenance burden overtime) don't make sense until we see
real users of notifications. Have you been able to discover real users
of this asynchronous notifications feature in OP-TEE?

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > >
> > > Thanks,
> > > Jens
> > >
> > > >
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/li=
nux.git/tree/drivers/firmware/arm_ffa/driver.c?h=3Dffa-updates-6.7#n1283
> > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/li=
nux.git/tree/drivers/firmware/arm_ffa/driver.c?h=3Dffa-updates-6.7#n1275
> > > >
> > > > -Sumit
> > > >
> > > > >
> > > > > Cheers,
> > > > > Jens
> > > > >
> > > > > >
> > > > > > -Sumit
> > > > > >
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens=
.wiklander@linaro.org/
> > > > > > > [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-=
1_notif-v4-0-cddd3237809c@arm.com/
> > > > > > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.ho=
lla/linux.git/tag/?h=3Dffa-updates-6.7
> > > > > > >     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driv=
er version to v1.1")
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Jens
> > > > > > >
> > > > > > > Jens Wiklander (2):
> > > > > > >   optee: provide optee_do_bottom_half() as a common function
> > > > > > >   optee: ffa_abi: add asynchronous notifications
> > > > > > >
> > > > > > >  drivers/tee/optee/call.c          | 31 ++++++++++-
> > > > > > >  drivers/tee/optee/ffa_abi.c       | 91 +++++++++++++++++++++=
+++++++++-
> > > > > > >  drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
> > > > > > >  drivers/tee/optee/optee_private.h |  9 ++-
> > > > > > >  drivers/tee/optee/smc_abi.c       | 36 ++----------
> > > > > > >  5 files changed, 153 insertions(+), 42 deletions(-)
> > > > > > >
> > > > > > >
> > > > > > > base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
