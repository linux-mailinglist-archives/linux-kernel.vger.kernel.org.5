Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBCE754D54
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 06:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGPEf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 00:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGPEfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 00:35:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C7A194;
        Sat, 15 Jul 2023 21:35:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so33717265e9.2;
        Sat, 15 Jul 2023 21:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689482122; x=1692074122;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s3jhynkIkZ/R+qQ9ccgb7cwbFAaFE+KWXgNiWgMBNQY=;
        b=nOk2TFY+kbalJ/2POSzzHW8JXxJCgPL1j1IcojrnX6yrft8z1HqINsymRFNaVhgQ4W
         jdQ6amvc9CSIzqU824BUc/PaqE3SQuKLNyu58km/qCJBYBilbvHz0qyOXDIoPJ4Itw98
         WWCJaVOK9f3vMU/fOyxBGH0KUb1E8SZw/UiDWD5wNyK5l4Si5DWOyqy+j+8ZLUj3lXXw
         UBMciRSnZWmqI198x9YYeG9N1E4iOXFF4Nn571j3v3z1wpQOgnXR+asVpb+/j89LDBiF
         lALZ6dbqJxR1y1LIMiTlnK77J1HyAt1PAUzE43V9bapHRqwU/J6vpT97aVMZvSy3/ElC
         lGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689482122; x=1692074122;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3jhynkIkZ/R+qQ9ccgb7cwbFAaFE+KWXgNiWgMBNQY=;
        b=cTQQuKd3JXc3TPlgofdEk0CpvblElOBOSi/T+wL3oQDerLkHvRaCbZHNeiZsP3Iw7G
         gaF8xDLqwMMIikuWhkLzW+N9iIqj2MOiw0UrQDUPqBOZb2E7uw70VXGOVm4W5t0LSe9k
         7/WZiG83C5qnZ2CXh44QPsUuvm0Kv0uH1K9Km7MMOlNxEGAW8q1v01UkpbpPg+KuMzaf
         NVC8+z72xVso0vxqqNV9VT36JuETM+/URLzT8CJ/ZTWTb3h6G6Y9gUxVN3ZAgfRjTPco
         NYGP7VJ8suP1MoYpyD/kvnjdl04BiCSEwxDnvZCI0qJqGTV/M5qaNfNp8vRSaRIFt6Nk
         XpYw==
X-Gm-Message-State: ABy/qLZPb9LUmQm/oNW8u393L8cZ9V9tzRNdajUrByUN+OPQitMUCRpe
        SrFoVNecznYBXMBJXB59KDGxFIzyCH2vdSbK
X-Google-Smtp-Source: APBJJlHbV77h1cKA+TPlQwums4kjKJbzg5j0wKxqf6hmxcAwYnnU791cVylMszznI4WEoObjnWYtcg==
X-Received: by 2002:a5d:664b:0:b0:314:3344:326b with SMTP id f11-20020a5d664b000000b003143344326bmr7730152wrw.71.1689482121824;
        Sat, 15 Jul 2023 21:35:21 -0700 (PDT)
Received: from hermes.prahal.homelinux.net (91-175-163-178.subs.proxad.net. [91.175.163.178])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d4492000000b00315a1c160casm15359983wrq.99.2023.07.15.21.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 21:35:20 -0700 (PDT)
Message-ID: <d50ba126af53da17fbf55ab0ed3a0058c66055ef.camel@gmail.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: rockchip: Disable HS400 for eMMC on
 ROCK Pi 4
From:   Alban Browaeys <alban.browaeys@gmail.com>
To:     Christopher Obbard <chris.obbard@collabora.com>,
        linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com, Akash Gajjar <Akash_Gajjar@mentor.com>,
        Conor Dooley <conor+dt@kernel.org>,
        FUKAUMI Naoki <naoki@radxa.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        FolkerSchwesinger <dev@folker-schwesinger.de>
Date:   Sun, 16 Jul 2023 06:35:19 +0200
In-Reply-To: <20230705144255.115299-2-chris.obbard@collabora.com>
References: <20230705144255.115299-1-chris.obbard@collabora.com>
         <20230705144255.115299-2-chris.obbard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 05 juillet 2023 =C3=A0 15:42 +0100, Christopher Obbard a =C3=A9=
crit=C2=A0:
> > > > There is some instablity with some eMMC modules on ROCK Pi 4
> > > > SBCs
> > > > running
> > > > in HS400 mode. This ends up resulting in some block errors
> > > > after a
> > > > while
> > > > or after a "heavy" operation utilising the eMMC (e.g. resizing
> > > > a
> > > > filesystem). An example of these errors is as follows:

I did not report my finding to the Linux upstream back then (due to
using a non vanilla Linux kernel) but with my Armbian install I had
bisected this issue to 06653ebc0ad2e0b7d799cd71a5c2933ed2fb7a66 as the
first bad commit.
I believe it was released in 5.10.60 (the first broken version to reach
armbian was 5.10.63 from a working 5.10.43.
Since then all rk3399 I have checked have disabled hs400 (down to hs200
which is stable even with the above commits).

commit 06653ebc0ad2e0b7d799cd71a5c2933ed2fb7a66
Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu May 20 01:12:23 2021 +0300

    regulator: core: resolve supply for boot-on/always-on regulators
   =20
    commit 98e48cd9283dbac0e1445ee780889f10b3d1db6a upstream.
   =20
    For the boot-on/always-on regulators the set_machine_constrainst() is
    called before resolving rdev->supply. Thus the code would try to enable
    rdev before enabling supplying regulator. Enforce resolving supply
    regulator before enabling rdev.
   =20
    Fixes: aea6cb99703e ("regulator: resolve supply after creating regulato=
r")
    Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    Link: https://lore.kernel.org/r/20210519221224.2868496-1-dmitry.baryshk=
ov@linaro.org
    Signed-off-by: Mark Brown <broonie@kernel.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 drivers/regulator/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f192bf19492ed..e20e77e4c159d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1425,6 +1425,12 @@ static int set_machine_constraints(struct regulator_=
dev *rdev)
 	 * and we have control then make sure it is enabled.
 	 */
 	if (rdev->constraints->always_on || rdev->constraints->boot_on) {
+		/* If we want to enable this regulator, make sure that we know
+		 * the supplying regulator.
+		 */
+		if (rdev->supply_name && !rdev->supply)
+			return -EPROBE_DEFER;
+
 		if (rdev->supply) {
 			ret =3D regulator_enable(rdev->supply);
 			if (ret < 0) {


My findings here:
https://forum.armbian.com/topic/18855-upgrading-to-bullseye-troubleshooting=
-armbian-21081/?do=3DfindComment&comment=3D128793
this on a kobol helios64 rk3399 board.

I told a user to try this fix (revert commits 06653ebc0ad2e0b7d799cd71a5c29=
33ed2fb7a66
 and aea6cb99703e17019e025aa71643b4d3e0a24413) also for an armbian kernel o=
n a  Nanopc-T4
 and it fixes the issue=C2=A0https://forum.armbian.com/topic/20002-nanopc-t=
4-new-kernel-2202-generates-issues-on-mmc2-and-makes-system-not-properly-wo=
rking/?do=3DfindComment&comment=3D138052
This above 5.16.8.





I had high expectations that the commit that fixed double init would fix th=
e issue for good, but sadly not.
I believe this would have been the only required fix for 5.16 kernels but n=
owadays it is not enough a revert.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/regulator/core.c?id=3D8a866d527ac0441c0eb14a991fa11358b476b11d

regulator: core: Resolve supply name earlier to prevent double-init
Previously, an unresolved regulator supply reference upon calling
regulator_register on an always-on or boot-on regulator caused
set_machine_constraints to be called twice.

This in turn may initialize the regulator twice, leading to voltage
glitches that are timing-dependent. A simple, unrelated configuration
change may be enough to hide this problem, only to be surfaced by
chance.

One such example is the SD-Card voltage regulator in a NanoPI R4S that
would not initialize reliably unless the registration flow was just
complex enough to allow the regulator to properly reset between calls.

Fix this by re-arranging regulator_register, trying resolve the
regulator's supply early enough that set_machine_constraints does not
need to be called twice.

Signed-off-by: Christian Kohlschu=CC=88tter <christian@kohlschutter.com>
Link: https://lore.kernel.org/r/20220818124646.6005-1-christian@kohlschutte=
r.com
Signed-off-by: Mark Brown <broonie@kernel.org>
"
story behing this patch https://kohlschuetter.github.io/blog/posts/2022/10/=
28/linux-nanopi-r4s/

It should have worked because basically this patch is a revert of
commit aea6cb99703e17019e025aa71643b4d3e0a24413 "regulator: resolve
supply after creating regulator" except it keep what I believe is now
dead code (ie the second set_machine_constains in "if (ret =3D=3D -
EPROBE_DEFER) " is of no use now that the regulator supply is resolved
before the first set_machine_constraints call in regilator_registers.
The only code left from the 5.10.60 breakage is the EPROBE_DEFER if
regulator supply is not registered in set_machine_constrains.
But even after removing this leftover and the new EPROBE_DEFER that was
added to set_machine_constraints for "regulator that have no direct
control", I cannot get rid of the Filesystem corruption and errors with
hs400 with 6.3.

Still I have no clue why emmc regulators double init is fine on most
SoC but not rk3399.


Cheers,
Alban


