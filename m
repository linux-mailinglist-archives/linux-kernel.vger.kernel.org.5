Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728CC8023F6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 14:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjLCMbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 07:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCMbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 07:31:34 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33022FF;
        Sun,  3 Dec 2023 04:31:39 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cddb35ef8bso2838817b3a.2;
        Sun, 03 Dec 2023 04:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701606698; x=1702211498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MUy55F2F+wgLbUaq7AQf9HgfhTQk1XTmdlJL+JJNEo=;
        b=csWxtsQJ8fK86xkEg0slWx6LRfFx3RCeURlAO7jzi9IkkIrS6kvUJzS5ebdxgL0O0t
         W7QRC+qqSXlDDME50ZO+qr7U4BiiuAi6sjbvwgBIjqGPrCESPGG9Bqv1Hm3RfaYVud/i
         OPk1vDUweobowDYGK6tqC/sqBkQeAEjgwv0OX1KP25gS6nubzyT32cRgyVo8A+d5QeZu
         FW6pnqAWuDZpbQ1XYpMDdyxo3/mH4aD+RNbLFdA0GqhRNCJJnRl9DktWSgjX6EoEZXgY
         wje/WwyXWIS5nYhsjZSF0fkHIqTHl2eRje/N/FAFxGZkbxRqYJJy87cxwzt6HwyIfGPR
         fPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701606698; x=1702211498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MUy55F2F+wgLbUaq7AQf9HgfhTQk1XTmdlJL+JJNEo=;
        b=Uf1tltgz8IT/iAbZ2tT4vHv4h7zeH4w9zisQpk0Sev4TqSyq/ZmSAxypxjCiw0j1iP
         qmoiuNT8pwpYbWVYK4e3ebYeDA2Gv3jnU/LlyLTnUDiG6F1zoVSbir149OJHw5jSc4Iu
         zpuEVfEvypv9OHkylMetYYm41CWjpMA+HB49hkQHxMSvVal8xeDIkGVllVCMXzEUwttj
         8Sio2c8LWRoa4v1uXsa5lhb8uOBqiJbRIx/Ef2uOdAEgOGs8HfEBl9XkXfh4UKiTOSPi
         XDGty3yUiER+zvPCPRNkM8DmRXBw3itJzh0VFN5BQdhA03hT1XIAo1OlfkfQ20o+YlO9
         Fv7w==
X-Gm-Message-State: AOJu0Ywsz0EQNvBV8NjxpaSWqdQy1HbA1bwjxeNvrndhPICI3uh4Jhlw
        LQPT283/ESf344DEX0wfgiPJwQYm04WhUw==
X-Google-Smtp-Source: AGHT+IHmLadSlZkgkEbu7BCMhHy54Dhejaw4nkpOT9L4Al3PzBof4xcJ8kA+G2XiA2o5lw1MMiqVvg==
X-Received: by 2002:a05:6a21:81a9:b0:18b:cd15:b832 with SMTP id pd41-20020a056a2181a900b0018bcd15b832mr777612pzb.42.1701606698415;
        Sun, 03 Dec 2023 04:31:38 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902b94c00b001c613b4aa33sm6529854pls.287.2023.12.03.04.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 04:31:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 8AE2D1033EDE8; Sun,  3 Dec 2023 19:31:28 +0700 (WIB)
Date:   Sun, 3 Dec 2023 19:31:28 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux IOMMU <iommu@lists.linux.dev>,
        Linux Power Management <linux-pm@vger.kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, kbugreports@proton.me
Subject: Re: Fwd: Kernels v6.5 and v6.6 break resume from standby (s3) on
 some Intel systems if VT-d is enabled
Message-ID: <ZWx1IHBE9KCk6rWj@archie.me>
References: <4b3c624a-f114-4e39-9e1c-0df18f307e8c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dO/hfGGfuReF84Ss"
Content-Disposition: inline
In-Reply-To: <4b3c624a-f114-4e39-9e1c-0df18f307e8c@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dO/hfGGfuReF84Ss
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 08:09:24PM +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]. Quoting from it:
>=20
> > Note:
> >=20
> > I'm just a Linux user, I don't work in IT or even write code, so, I'm p=
robably using terms to describe the issue that are not the ones someone who=
 knows code and what the system does under the hood would use.
> >=20
> > Affected system:
> >=20
> > Thinkpad, Intel Kaby Lake (i7-7600U) chipset / cpu and onboard gpu (Int=
el HD 620), no separate graphics card, current bios firmware; running Void =
Linux, xfce / lightdm
> >=20
> > Symptom / problem:
> >=20
> > Since the upgrade to kernel v6.5.5 (from v6.3.13) my system doesn't wak=
e up from standby, i.e. resume from s3 fails 100% of the time.
> > When pressing a key or the power button nothing happens. The LED that i=
ndicates different states of the system, keeps indicating standby mode.
> > The only way to use the system again is hard reset by pressing the powe=
r button for a few seconds.
> >=20
> > So, there is no crashing on resume or incomplete resume or only sometim=
es failing to resume or failing to go into standby in the first place.
> >=20
> > Granted, this issue was present with kernels before v6.5, but only occa=
sionally and it would not re-appear for many many boot cycles. So, I never =
had any lead as to why it would happen.
> >=20
> > I installed kernel v6.4.16 to test for the bug - it's not in there.
> >=20
> > For further testing I also installed kernel v6.5.2, as this was the fir=
st kernel of the 6.5 series available on void linux, (and because the kerne=
l logs mention VT-d for kernel v6.5.5 and v6.5.3, see below). Result: The b=
ug is already in v6.5.2, too.
> >=20
> > There's only one thing I noticed from comparing logs between kernels v6=
=2E5/6.6 vs v6.1/6.3/6.4. In the moment the system goes into standby, if ru=
nning one of the latter three kernel versions the system would print the fo=
llowing messages:
> >=20
> > [elogind-daemon] Entering sleep state 'suspend'...
> > [kernel] PM: suspend entry (deep)
> >=20
> >=20
> > But with kernels v6.5/6.6, the kernel message is missing, only the elog=
ind-daemon message shows up in the logs. As if the kernel didn't get the me=
mo and thus didn't prepare and didn't listen for the wake-up call to resume.
> >=20
> >=20
> > To see, if this is a bug that might be tight to a certain chipset / cpu=
 generation, I tested kernel v6.5 on my old Thinkpad (Intel Sandy Bridge ch=
ipset / cpu, and also onboard graphics only). Its BIOS also has VT-d enable=
d. Interestingly, on that system, resume from standby with kernel v6.5 is n=
o problem, even though its system is set up the same as the current Thinkpa=
d.
> >=20
> > So, this bug seems to be limited to certain set of chipset / cpu. Which=
 seems feasible, as I couldn't find a bug report on this - not too many see=
m to be affected.
> >=20
> >=20
> >=20
> > There's an older bug report on similar symptoms, but the cure doesn't w=
ork on my system:
> >=20
> > "intel_iommu=3Don breaks resume from suspend on several Thinkpad models"
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D197029
> >=20
> >=20
> > Although it sounds just like what my system is experiencing - apart fro=
m the fact that term suspend being sometimes also used to describe hibernat=
ion and it is not specified which one is meant in the bug report.
> >=20
> > So, I was hopeful on the one hand that the (workaround) fix (adding int=
el_iommu=3Doff to the kernel parameters) would work on my system, too - on =
the other hand, this bug report was for kernel v4.13, so it's probably not =
necessarily relevant to similar symptoms with kernel v6.5 and v6.6, respect=
ively.
> >=20
> > Anyway, adding intel_iommu=3Doff to the kernel parameters didn't change=
 anything on my system. I made, of course, sure once the system was running=
, that intel_iommu=3Doff was in indeed used as one of the kernel parameters.
> >=20
> >=20
> > With this information in mind I did a regular internet search and found=
 some information that in case intel_iommu=3Doff in the kernel parameters d=
oesn't help, disabling VT-d in BIOS might.
> > And in my case it does indeed help avoiding the bug - for both kernel v=
ersions, v6.5 and v6.6.
> >=20
> > Reading some other bug reports and some changelogs, I noticed that iomm=
u and vt-s are connected, to I posted this bug report in drivers/iommu. If =
it is misplaced here, please feel free to move it to the correct category.
> >=20
> >=20
> > I attached a file with the output of some commands I found being used i=
n several other bug reports on here, just in case they might be needed / he=
lpful.
> >=20
> >=20
> > Thank you very much for your help in advance!
>=20
> See Bugzilla for the full thread.
>=20
> Anyway, I'm adding this regression to regzbot:
>=20
> #regzbot introduced: v6.3..v6.5 https://bugzilla.kernel.org/show_bug.cgi?=
id=3D218191
> #regzbot title: resume from standby fails on Thinkpad with Kaby Lake CPU
>=20

The reporter had done bisection (see Bugzilla for details), so telling
regzbot:

#regzbot introduced: 0c7ffa32dbd6b0

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--dO/hfGGfuReF84Ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWx1HAAKCRD2uYlJVVFO
o9tkAQD39PHo7FdONECmYZXrv+d6mV48M232+oW13+R1CiakrgEA1d/iKH+VFtPl
UK+NIN72mc22rpkszIA/Br5ww/0w0gw=
=tabU
-----END PGP SIGNATURE-----

--dO/hfGGfuReF84Ss--
