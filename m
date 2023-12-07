Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FE08088C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjLGNCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjLGNCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:02:22 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE2610D1;
        Thu,  7 Dec 2023 05:02:27 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7c5634d3189so392475241.0;
        Thu, 07 Dec 2023 05:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701954147; x=1702558947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2GLl9ORxjgzbrAPA2o2RMIrdlgomnkHIAs9YLkJmLY=;
        b=HF1kcFsF0a/Xd8sZULLDNTD+AZ5ce46aQuy/1exFE2Ra+axgBQd6L2T4tm6IPqhKwe
         XPbYuez12DT3EBaBm7Y235RqFu5VvMjkjjVFoRtiHIKO04dxicqbWPw+d020brVDWTMK
         8WkX71UyxaJgHEwEppG5+/QsmESrbT9gOeDUesz/VF1ZwvQ0lFM1EKPfh759OZ3FvdfW
         3MjLR4WKq/Q46yHMYYjPjIxSWlKUne+UjUCjKhnGVJkJw5T5fIETjg8k1w8faB90oEML
         SNDnq8sowCE34oojFliHh1yY30FOHnrabXxyez2UtEcrsGNEeUjrI4R1L0h4nGQyEotv
         vv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701954147; x=1702558947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2GLl9ORxjgzbrAPA2o2RMIrdlgomnkHIAs9YLkJmLY=;
        b=fRAzkegh6OXO9zChtzzzsUhw0df6g3OpL0YvewAFkde/gcYj+zhcGCRJl2N89LMQgR
         voQDO11GdUlorinnHodhTtnH1OQahu2tnl8S1FZrkOkNxK3sM4D11bQl0tPMCKA2x9Vx
         klpwvVjmMn+plQgkO9uWRKjTb4QD6wtIYpTcWLBCznlcJHCzRmzT96uvoR9vkdg6hR2e
         /MOB3nOdbBGD5QOvo4XWNKPUXLTH6jy/M1MM0E8pUz/zsE+F2jfuEkrjExsJPbF/hiLM
         NQvIGdm5omMuRFgWxC4TAunFNFelzMmQSj8j6lmNiXpwYrrdbaNRDbs1RkOw8RnlcWhJ
         4B/w==
X-Gm-Message-State: AOJu0YxppjKdsv7AB2TYKpxhnAADf2JeGOEfmwxGXIkwlrAoWeK+i7xh
        WDuVCsdmes1JEg5M8sbaZv2Sn/4P0HX0poikCFU=
X-Google-Smtp-Source: AGHT+IGtRYMhWMwVELysDloo+mmiJ60uQH2EsvvN6YMJOfv0iL7mDl0yDXi4ORiDbM8cv8xM6vKN+5mMQqNLrSX9bTo=
X-Received: by 2002:ac5:c9b5:0:b0:4ab:da7a:c573 with SMTP id
 f21-20020ac5c9b5000000b004abda7ac573mr2440577vkm.8.1701954146656; Thu, 07 Dec
 2023 05:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20230810-crewless-pampers-6f51aafb8cff@wendy> <mhng-550dee8b-a2fb-485b-ad4d-2763e94191b4@palmer-ri-x1c9>
 <20231206-precut-serotonin-2eecee4ab6af@spud>
In-Reply-To: <20231206-precut-serotonin-2eecee4ab6af@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 7 Dec 2023 13:02:00 +0000
Message-ID: <CA+V-a8s3MjvpD8gAE7-mOUc6PEytbPOR6x_PHuw0J0hOLkaz-w@mail.gmail.com>
Subject: Re: [RFT 1/2] RISC-V: handle missing "no-map" properties for
 OpenSBI's PMP protected regions
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        geert+renesas@glider.be, Atish Patra <atishp@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        apatel@ventanamicro.com, alexghiti@rivosinc.com,
        Bjorn Topel <bjorn@rivosinc.com>, suagrfillet@gmail.com,
        jeeheng.sia@starfivetech.com, petrtesarik@huaweicloud.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 2:26=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Wed, Dec 06, 2023 at 04:52:11AM -0800, Palmer Dabbelt wrote:
> > On Thu, 10 Aug 2023 02:07:10 PDT (-0700), Conor Dooley wrote:
> > > On Wed, Aug 09, 2023 at 02:01:07AM -0700, Atish Kumar Patra wrote:
> > > > On Tue, Aug 8, 2023 at 6:39=E2=80=AFAM Conor Dooley <conor@kernel.o=
rg> wrote:
> > > > >
> > > > > On Tue, Aug 08, 2023 at 12:54:11AM -0700, Atish Kumar Patra wrote=
:
> > > > > > On Wed, Aug 2, 2023 at 4:14=E2=80=AFAM Conor Dooley <conor.dool=
ey@microchip.com> wrote:
> > > > > > >
> > > > > > > Add an erratum for versions [v0.8 to v1.3) of OpenSBI which f=
ail to add
> > > > > > > the "no-map" property to the reserved memory nodes for the re=
gions it
> > > > > > > has protected using PMPs.
> > > > > > >
> > > > > > > Our existing fix sweeping hibernation under the carpet by mar=
king it
> > > > > > > NONPORTABLE is insufficient as there are other ways to genera=
te
> > > > > > > accesses to these reserved memory regions, as Petr discovered=
 [1]
> > > > > > > while testing crash kernels & kdump.
> > > > > > >
> > > > > > > Intercede during the boot process when the afflicted versions=
 of OpenSBI
> > > > > > > are present & set the "no-map" property in all "mmode_resv" n=
odes before
> > > > > > > the kernel does its reserved memory region initialisation.
> > > > > > >
> > > > > >
> > > > > > We have different mechanisms of DT being passed to the kernel.
> > > > > >
> > > > > > 1. A prior stage(e.g U-Boot SPL) to M-mode runtime firmware (e.=
g.
> > > > > > OpenSBI, rustSBI) passes the DT to M-mode runtime firmware and =
it
> > > > > > passes to the next stage.
> > > > > > In this case, M-mode runtime firmware gets a chance to update t=
he
> > > > > > no-map property in DT that the kernel can parse.
> > > > > >
> > > > > > 2. User loads the DT from the boot loader (e.g EDK2, U-Boot pro=
per).
> > > > > > Any DT patching done by the M-mode firmware is useless. If thes=
e DTBs
> > > > > > don't have the no-map
> > > > > > property, hibernation or EFI booting will have issues as well.
> > > > > >
> > > > >
> > > > > > We are trying to solve only one part of problem #1 in this patc=
h.
> > > > >
> > > > > Correct.
> > > > >
> > > > > If someone's second stage is also providing an incorrect devicetr=
ee
> > > > > then, yeah, this approach would fall apart - but it's the firmwar=
e
> > > > > provided devicetree being incorrect that I am trying to account f=
or
> > > > > here. If a person incorrectly constructed one, I am not really su=
re what
> > > > > we can do for them, they incorrect described their hardware /shru=
g
> > > > > My patch should of course help in some of the scenarios you menti=
on above
> > > > > if the name of the reserved memory region from OpenSBI is propaga=
ted by
> > > > > the second-stage bootloader, but that is just an extension of cas=
e 1,
> > > > > not case 2.
> > > > >
> > > > > > I
> > > > > > don't think any other M-mode runtime firmware patches DT with n=
o-map
> > > > > > property as well.
> > > > > > Please let me know if I am wrong about that. The problem is not
> > > > > > restricted to [v0.8 to v1.3) of OpenSBI.
> > > > >
> > > > > It comes down to Alex's question - do we want to fix this kind of
> > > > > firmware issue in the kernel? Ultimately this is a policy decisio=
n that
> > > > > "somebody" has to make. Maybe the list of firmwares that need thi=
s
> > > >
> > > > IMO, we shouldn't as this is a slippery slope. Kernel can't fix eve=
ry
> > > > firmware bug by having erratas.
> > > > I agree with your point below about firmware in shipping products. =
I
> > > > am not aware of any official products shipping anything other than
> > > > OpenSBI either.
> > >
> > > > However, I have seen users using other firmwares in their dev
> > > > environment.
> > >
> > > If someone's already changed their boards firmware, I have less sympa=
thy
> > > for them, as they should be able to make further changes. Punters buy=
ing
> > > SBCs to install Fedora or Debian w/o having to consider their firmwar=
e
> > > are who I am more interested in helping.
> > >
> > > > IMHO, this approach sets a bad precedent for the future especially
> > > > when it only solves one part of the problem.
> > >
> > > Yeah, I'm certainly wary of setting an unwise precedent here.
> > > Inevitably we will need to have firmware-related errata and it'd be g=
ood
> > > to have a policy for what is (or more importantly what isn't
> > > acceptable). Certainly we have said that known-broken version of Open=
SBI
> > > that T-Head puts in their SDK is not supported by the mainline kernel=
.
> > > On the latter part, I'm perfectly happy to expand the erratum to cove=
r
> > > all affected firmwares, but I wasn't even sure if my fix worked
> > > properly, hence the request for testing from those who encountered th=
e
> > > problem.
> > >
> > > > We shouldn't hide firmware bugs in the kernel when an upgraded
> > > > firmware is already available.
> > >
> > > Just to note, availability of an updated firmware upstream does not
> > > necessarily mean that corresponding update is possible for affected
> > > hardware.
> >
> > Yep.  I think we're been in a very hobbist-centric world in RISC-V land=
, but
> > in general trying to get people to update firmware is hard.  Part of th=
e
> > whole "kernel updates don't break users" thing is what's underneath the
> > kernel, it's not just a uABI thing.
>
> Yeah, there's certainly an attitude that I think needs to go away, that
> updating firmware etc is something we can expect to be carried out on a
> universal basis. Or that fixing things in the upstream version of
> OpenSBI means it'll actually propagate down to system integrators.
>
> >
> > > > This bug is well documented in various threads and fixed in the lat=
est
> > > > version of OpenSBI.
> > > > I am assuming other firmwares will follow it as well.
> > > >
> > > > Anybody facing hibernation or efi related booting issues should jus=
t
> > > > upgrade to the latest version of firmware (e.g OpenSBI v1.3)
> > > > Latest version of Qemu will support(if not happened already) the
> > > > latest version of OpenSBI.
> > > >
> > > > This issue will only manifest in kernels 6.4 or higher. Any user
> > > > facing these with the latest kernel can also upgrade the firmware.
> > > > Do you see any issue with that ?
> > >
> > > I don't think it is fair to compare the ease of upgrading the kernel
> > > to that required to upgrade a boards firmware, with the latter being
> > > far, far more inconvenient on pretty much all of the boards that I ha=
ve.
> >
> > IMO we're in the same spot as every other port here, and generally they=
 work
> > around firmware bugs when they've rolled out into production somewhere =
that
> > firmware updates aren't likely to happen quickly.  I'm not sure if ther=
e's
> > any sort of exact rules written down anywhere, but IMO if the bug is go=
ing
> > to impact users then we should deal with it.
> >
> > That applies for hardware bugs, but also firmware bugs (at a certain po=
int
> > we won't be able to tell the difference).  We're sort of doing this wit=
h the
> > misaligned access handling, for example.
> >
> > > I'm perfectly happy to drop this series though, if people generally a=
re
> > > of the opinion that this sort of firmware workaround is ill-advised.
> > > We are unaffected by it, so I certainly have no pressure to have
> > > something working here. It's my desire not to be user-hostile that
> > > motivated this patch.
> >
> > IIUC you guys and Reneas are the only ones who have hardware that might=
 be
> > in a spot where users aren't able to update the firmware (ie, it's out =
in
> > production somewhere).
>
> I dunno if we can really keep thinking like that though. In terms of
> people who have devicetrees in the kernel and stuff available in western
> catalog distribution, sure.
> I don't think we can assume that that covers all users though, certainly
> the syntacore folks pop up every now and then, and I sure hope that
> Andes etc have larger customer bases than the in-kernel users would
> suggest.
>
> > So I'm adding Geert, though he probably saw this
> > months ago...
>
> Prabhakar might be a good call on that front. I'm not sure if the
> Renesas stuff works on affected versions of OpenSBI though, guess it
> depends on the sequencing of the support for the non-coherent stuff and
> when this bug was fixed.
>
ATM, I dont think there are any users who are using the upstream
kernel + OpenSBI (apart from me and Geert!). Currently the customers
are using the BSP releases.

Cheers,
Prabhakar

> > On that note: It's been ~4 months and it look like nobody's tested anyt=
hing
> > (and the comments aren't really things that would preculde testing).
>
> Yeah, nobody seems to really have given a crap. I was hoping the
> StarFive guys that actually added the support for this would be
> interested in it, but alas they were not.
> I don't really care all that much - the platform I support is not
> affected by the problem and I just don't enable the option elsewhere.
>
> > So
> > maybe we just pick that second patch up into for-next and see what happ=
ens?
> > IIUC that will result in broken systems for users who haven't updated t=
heir
> > firmware.
> >
> > I agree that's a user-hostile way to do things, which is generally a ba=
d way
> > to go, but if it's really true that there's no users then we're safe.
> > Probably also worth calling it out on sw-dev just to be safe.
>
> And if there are users, the fix is actually relatively straight-forward,
> just apply patch #1.
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
