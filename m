Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981DF7E1C6E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjKFIj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjKFIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:39:25 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F624134
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:39:22 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66cfd874520so27183066d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699259961; x=1699864761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekM2xd9y+bSacCYNAL46JwG0PKe1oiGDrHb1EaKbOfE=;
        b=dGBtmdTNaZd0CZ9Z9n3NOi25/jaV5s7TV5Cz9z5B3DKrZc1YkBbrctWH22X8TLqif7
         bfWY5Vj9e+mVQXrkmnJMM3QxsSBz396CSX6Chaw26fwKs3Kec6IS71RKCPpdZqE4U48g
         2MZ7T/0fy9FSqxHnsAjBpwfMNSuv0lJLJLa9ArvNy2sSJuWs8QMYRJaWMKAq+FWuFMQJ
         e/0Weq44MUsee+9fQ+sigqFkvVAq66gYThVHfAHJBCS+5AGfDI7D8mlDKRjdClwmBk5y
         DcdPFFjdAwou9wresVAfp382yJhhw8qGw8/Fflt2GenBg7JTViEwWPL/H0K+gdCdSqqy
         lcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259961; x=1699864761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekM2xd9y+bSacCYNAL46JwG0PKe1oiGDrHb1EaKbOfE=;
        b=o8ljsYtMjYnJN9kTuoXUIUEkFAaKQyYMXP5ZDaLooh4szPR+4ozWwYKjfM66m5MGQb
         uV6slj8zQsOA33sacaULYgbRqgIeiK+wGCjDlQsVfI/uw3v/2gtKD6iTjwR6xg9AB0wt
         QSKiRXDlJpeWSBzEe7qXX8/NzQ5hqhHakJZgkZ+drRnbVdeFjZdc/EZ/nDIHJhxYVUm2
         6PK2iiMSgJgC19xKt2+0ZvYm1lusJTnp/4TOaD1TgS2GCFH3RwfwSVCvA3n7Mq3xe6fC
         bq2b1VbYHXnp+CAWF8iRdQ35nNUk9qgr2ug333cUOTdO79UUCwRJ0/rmBhA8BlFM8HMN
         mrHA==
X-Gm-Message-State: AOJu0YxTWK/igZQuX5Y9a+axfzbTBkoqG+1fcHO9JZiDWii+nHbrs/9w
        i1X7mAe7nwDo0MkGcfFbxTfiGKmH3+oqJhmYwIOk3g==
X-Google-Smtp-Source: AGHT+IHsYMjzemGRxCE5dazD9heKIxsEnTbnmlxTXTQUw72SHgzjaFgaSW0UMsuDfMU7rhl4glF4+FSQ3X37TtU512I=
X-Received: by 2002:a05:6214:c81:b0:66d:a1d3:fd94 with SMTP id
 r1-20020a0562140c8100b0066da1d3fd94mr35036679qvr.19.1699259961423; Mon, 06
 Nov 2023 00:39:21 -0800 (PST)
MIME-Version: 1.0
References: <20231026080409.4149616-1-jens.wiklander@linaro.org>
 <CAFA6WYOYRQ4BgyUE90EwAVULsa=qDkZ4C=0rX49e-E3LOvyz6Q@mail.gmail.com>
 <20231102115925.GA1233092@rayden> <CAFA6WYPh-hfzcuLOHToby_vuQcqHh64kF0WQ4AdoaRwjeyyFFg@mail.gmail.com>
 <20231102131624.GB1233092@rayden> <CAFA6WYMX4UdAYF3BQum0fBXhyUshJv0Hkuwt0UnppDYpR70Rkg@mail.gmail.com>
 <CAHUa44EN4iAdTPf=n1d6AYxfdWWsN3L+dZLtoN3UyzWKydyNYg@mail.gmail.com> <CAFA6WYP2php3gKjOeD93fGAZgndOGtKhViMrf25zVyp66dCm6A@mail.gmail.com>
In-Reply-To: <CAFA6WYP2php3gKjOeD93fGAZgndOGtKhViMrf25zVyp66dCm6A@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 6 Nov 2023 09:39:09 +0100
Message-ID: <CAHUa44E3ju=jp2d8wFu57Gv3ayoQuvAW+WQKD_iTby9t77CBeQ@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 9:53=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> On Fri, 3 Nov 2023 at 13:32, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> >
> > On Thu, Nov 2, 2023 at 3:05=E2=80=AFPM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> > >
> > > On Thu, 2 Nov 2023 at 18:46, Jens Wiklander <jens.wiklander@linaro.or=
g> wrote:
> > > >
> > > > On Thu, Nov 02, 2023 at 05:46:55PM +0530, Sumit Garg wrote:
> > > > > On Thu, 2 Nov 2023 at 17:29, Jens Wiklander <jens.wiklander@linar=
o.org> wrote:
> > > > > >
> > > > > > Hi Sumit,
> > > > > >
> > > > > > On Mon, Oct 30, 2023 at 11:32:47AM +0530, Sumit Garg wrote:
> > > > > > > Hi Jens,
> > > > > > >
> > > > > > > On Thu, 26 Oct 2023 at 13:34, Jens Wiklander <jens.wiklander@=
linaro.org> wrote:
> > > > > > > >
> > > > > > > > Hi all,
> > > > > > > >
> > > > > > > > This patchset adds support for using FF-A notifications as =
a delivery
> > > > > > > > mechanism of asynchronous notifications from OP-TEE running=
 in the secure
> > > > > > > > world. Support for asynchronous notifications via the SMC A=
BI was added in
> > > > > > > > [1], here we add the counterpart needed when using the the =
FF-A ABI.
> > > > > > > >
> > > > > > > > Support for FF-A notifications is added with [2] and this p=
atch set is based
> > > > > > > > on Sudeeps tree at [3].
> > > > > > >
> > > > > > > It's good to see FF-A notifications support coming through. T=
he good
> > > > > > > aspect here is that FF-A uses a common secure world SGI for
> > > > > > > notifications and doesn't have to deal with platform specific=
 reserved
> > > > > > > SPI for notifications.
> > > > > > >
> > > > > > > From OP-TEE point of view I think most of the secure SGI dona=
tion base
> > > > > > > would be common, so can we switch the SMC ABI to use this don=
ated
> > > > > > > secure world SGI for notifications too?
> > > > > >
> > > > > > The SMC ABI driver picks up the interrupt used for notification=
 from
> > > > > > device-tree, so there's a chance that it just works if a donate=
d SGI is
> > > > > > supplied instead. We'll need some changes in the secure world s=
ide of
> > > > > > OP-TEE, but they wouldn't affect the ABI.
> > > > >
> > > > > AFAIK, a secure world donated SGIs doesn't support IRQ mapping vi=
a DT.
> > > > > The FF-A driver explicitly creates that mapping here [1].
> > > >
> > > > That looks a lot like what platform_get_irq() does via of_irq_get()=
.
> > > >
> > >
> > > There is GIC_SPI or GIC_PPI but nothing like GIC_SGI in DT bindings [=
1].
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/include/dt-bindings/interrupt-controller/arm-gic.h
> > >
> > > > > Moreover
> > > > > it's better to detect it via an SMC call rather than hard coded v=
ia DT
> > > > > as FF-A driver does.
> > > >
> > > > Typo? I guess you mean that you prefer that way the FF-A driver doe=
s it
> > > > rather than having it set in the DT.
> > >
> > > Yeah sorry about that. We shouldn't use DT if OP-TEE features are dis=
coverable.
> > >
> > > >
> > > > Assuming that you only care about "arm,gic-v3". The SGI will likely
> > > > always be the same so it shouldn't be too hard to keep the correct
> > > > configuration in DT.
> > >
> > > See above, DT looks like it does not support SGI.
> >
> > You're right.
> >
> > >
> > > >
> > > > >
> > > > > So the ABI should dynamically detect if there is a donated SGI th=
en
> > > > > use it otherwise fallback to SPI/PPI detection via DT. This would=
 make
> > > > > the notifications feature platform agnostic and we can drop legac=
y DT
> > > > > methods from optee-os entirely but still need to maintain them in=
 the
> > > > > kernel for backwards compatibility.
> > > >
> > > > We care about compatibility in both directions so we'd need to keep=
 it
> > > > in OP-TEE too, but perhaps under a config flag.
> > >
> > > Isn't it just supported on Qemu right now in OP-TEE? I hope dropping =
a
> > > feature won't be a problem there compared with the maintenance burden=
.
> >
> > I'd rather not remove this since I believe it can support more
> > configurations (different interrupt controllers), but feel free to
> > propose a patch with the new ABI.
>
> Having a second thought here, I think adding further ABIs (redundant
> ABIs become maintenance burden overtime) don't make sense until we see
> real users of notifications. Have you been able to discover real users
> of this asynchronous notifications feature in OP-TEE?

No, not upstream. There have been questions about a feature like this
from time to time in the past and I guess non-trivial interrupt
handling will soon need it.

Cheers,
Jens

>
> -Sumit
>
> >
> > Cheers,
> > Jens
> >
> > >
> > > -Sumit
> > >
> > > >
> > > > Thanks,
> > > > Jens
> > > >
> > > > >
> > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/=
linux.git/tree/drivers/firmware/arm_ffa/driver.c?h=3Dffa-updates-6.7#n1283
> > > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/=
linux.git/tree/drivers/firmware/arm_ffa/driver.c?h=3Dffa-updates-6.7#n1275
> > > > >
> > > > > -Sumit
> > > > >
> > > > > >
> > > > > > Cheers,
> > > > > > Jens
> > > > > >
> > > > > > >
> > > > > > > -Sumit
> > > > > > >
> > > > > > > >
> > > > > > > > [1] https://lore.kernel.org/lkml/20211103090255.998070-1-je=
ns.wiklander@linaro.org/
> > > > > > > > [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v=
1-1_notif-v4-0-cddd3237809c@arm.com/
> > > > > > > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.=
holla/linux.git/tag/?h=3Dffa-updates-6.7
> > > > > > > >     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the dr=
iver version to v1.1")
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Jens
> > > > > > > >
> > > > > > > > Jens Wiklander (2):
> > > > > > > >   optee: provide optee_do_bottom_half() as a common functio=
n
> > > > > > > >   optee: ffa_abi: add asynchronous notifications
> > > > > > > >
> > > > > > > >  drivers/tee/optee/call.c          | 31 ++++++++++-
> > > > > > > >  drivers/tee/optee/ffa_abi.c       | 91 +++++++++++++++++++=
+++++++++++-
> > > > > > > >  drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
> > > > > > > >  drivers/tee/optee/optee_private.h |  9 ++-
> > > > > > > >  drivers/tee/optee/smc_abi.c       | 36 ++----------
> > > > > > > >  5 files changed, 153 insertions(+), 42 deletions(-)
> > > > > > > >
> > > > > > > >
> > > > > > > > base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> > > > > > > > --
> > > > > > > > 2.34.1
> > > > > > > >
