Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9654F78D2EA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 07:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjH3FJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 01:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjH3FIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 01:08:46 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD94E0;
        Tue, 29 Aug 2023 22:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=AZcsmheJ6eAkCj7UFk1uonPsLptIUrfHn6cPU4i6NqA=; b=YN5o3rdXKY96X4LAUZz6FmJuAH
        wHghN5nazXF8DZ8RjRmuRp7DsDkPYgWDALjcIOpPgw+MkEQR9dCrN4abDttCXf38EwZfS2P/2lf+j
        3D69fxONAp7CdzG4H6/iOzQSMvr+8T5vPzRc7gPGx01e2aMPkkpvtswYuDxYVRDRAESV/r6MdTq41
        OftaDdLByl0sb62Byr4F5zlM+sPsITouMxeWl51IyE+zh2cbi72cjVQelJJ8zEzRpzQtT5VnGwNnO
        +/MmSZtbha2MghtBarmxD0Kf1AptwsTeX1274AufzX0/nb/3E0o2UiYURO1oQGynG8kArHxkPbEd0
        EAFh68DA==;
Received: from [2a01:e34:ec5d:a741:9a7b:5831:531:65c9] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1qbDRU-00FoKi-Qc; Wed, 30 Aug 2023 07:08:36 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1qbDRT-002YG0-37;
        Wed, 30 Aug 2023 07:08:35 +0200
Date:   Wed, 30 Aug 2023 07:08:35 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Zhipeng Wang <zhipeng.wang_1@nxp.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH 2/2] cpufreq: dt-platdev: Support building
 cpufreq platdev driver as module
Message-ID: <ZO7O056MxAnjvGxu@aurel32.net>
Mail-Followup-To: Zhipeng Wang <zhipeng.wang_1@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230524153417.2738448-1-zhipeng.wang_1@nxp.com>
 <20230524153417.2738448-2-zhipeng.wang_1@nxp.com>
 <ZO4yTQAV9EYA4erZ@aurel32.net>
 <PAXPR04MB8304AA1D331B3DA5B548EE3EEBE6A@PAXPR04MB8304.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <PAXPR04MB8304AA1D331B3DA5B548EE3EEBE6A@PAXPR04MB8304.eurprd04.prod.outlook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023-08-30 03:09, Zhipeng Wang wrote:
> Hi Aurelien,
>=20
> I'm not sure why we need to make cpufreq-dt-platdev autoloading, does it =
make sense? As I understand it we need to actively modprobe cpufreq-dt-plat=
dev, why not?

This is needed to recover the old behavior, where if a CPU supports
cpufreq-dt, it get loaded automatically. Now users has to modprobe
cpufreq-dt-platdev explicitly to get cpufreq-dt to work. This seems like
a regression to me.

Of course one can explicitly make CPUFREQ_DT_PLATDEV=3Dy, but the default
is to build cpufreq-dt-platdev as module when cpufreq-dt is built as
module.

Regards
Aurelien

> > -----Original Message-----
> > From: Aurelien Jarno <aurelien@aurel32.net>
> > Sent: 2023=E5=B9=B48=E6=9C=8830=E6=97=A5 2:01
> > To: Zhipeng Wang <zhipeng.wang_1@nxp.com>
> > Cc: rafael@kernel.org; viresh.kumar@linaro.org; linux-pm@vger.kernel.or=
g;
> > linux-kernel@vger.kernel.org
> > Subject: [EXT] Re: [PATCH 2/2] cpufreq: dt-platdev: Support building cp=
ufreq
> > platdev driver as module
> >=20
> > Caution: This is an external email. Please take care when clicking link=
s or opening
> > attachments. When in doubt, report the message using the 'Report this e=
mail'
> > button
> >=20
> >=20
> > Hi,
> >=20
> > On 2023-05-24 15:34, Zhipeng Wang wrote:
> > > Make the cpufreq platdev driver as tristate so that it can be built as
> > > loadable module.
> > >
> > > Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
> > > ---
> > >  drivers/cpufreq/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig index
> > > 2c839bd2b051..dda3a78bfd5c 100644
> > > --- a/drivers/cpufreq/Kconfig
> > > +++ b/drivers/cpufreq/Kconfig
> > > @@ -218,7 +218,7 @@ config CPUFREQ_DT
> > >         If in doubt, say N.
> > >
> > >  config CPUFREQ_DT_PLATDEV
> > > -     bool
> > > +     tristate "Generic DT based cpufreq platdev driver"
> > >       help
> > >         This adds a generic DT based cpufreq platdev driver for frequ=
ency
> > >         management.  This creates a 'cpufreq-dt' platform device, on
> > > the
> >=20
> > It seems that this new module is missing support for autoloading, causi=
ng issues
> > with CPUFREQ_DT=3Dm.
> >=20
> > Before that change, CPUFREQ_DT_PLATDEV ended up selected as =3Dy. Now,
> > CPUFREQ_DT_PLATDEV ends up selected as =3Dm. As it is not autoloaded, i=
t means
> > that cpufreq-dt is not working anymore unless manually running "modprobe
> > cpufreq-dt-platdev".
> >=20
> > Could you therefore please add support for autoloading?
> >=20
> > Thanks,
> > Aurelien
> >=20
> > --
> > Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> > aurelien@aurel32.net
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Faure=
l32.
> > net%2F&data=3D05%7C01%7Czhipeng.wang_1%40nxp.com%7C84e6deca09fb4
> > e86857608dba8b9df5f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > %7C638289288492430681%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> > AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> > 7C%7C&sdata=3D02iXE8HQXHNXRiA7SMtl%2B5ldGiVDF%2F7GtO%2F0DtAP0EQ
> > %3D&reserved=3D0

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
