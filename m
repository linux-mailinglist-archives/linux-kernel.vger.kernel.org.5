Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED67C8219
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjJMJbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjJMJbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:31:44 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88E4BE;
        Fri, 13 Oct 2023 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697189502; x=1728725502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=njmefSqG9ONV48MJlnC5TzeJNM5ymdvYqkhrV4QEMXQ=;
  b=Tvz8AX0T+fnZjLMO7auzz5eY7JeKSCIES+DYJdGfuUYYZ17khIuB0Vsm
   E3uIQhj88M5tjZ2jT2fe4xaOsxkD+yRd7UynVcDYQx6ELeMV3nyG4n/Uf
   wAkel0UHsdNThyvmeas2ZEvIusz2KswRgwZo3cHaZHO0i4JUjWNaHd73a
   q2sLDckN/IaPgrf13EMuaAjFeiRtJRl5uhVz6FCFLx4GDcdViJN8DTOsU
   a2WSA97Ycufs+hHCYAA1lnWOda1TBbma7mcOjfF+WoXyIJceh5NJITEkm
   6i9tuSp/4qTcmnyNPZSnaPLFckKQ3acaOyZAQp27lX4e0Ahxu7sL/CXRS
   g==;
X-IronPort-AV: E=Sophos;i="6.03,221,1694728800"; 
   d="scan'208";a="33449897"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Oct 2023 11:31:39 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 75BC4280082;
        Fri, 13 Oct 2023 11:31:39 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mp: add reserve-memory nodes for DSP
Date:   Fri, 13 Oct 2023 11:31:39 +0200
Message-ID: <7769811.31r3eYUQgx@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <80a6a56b-4a12-99bb-acb3-94a5753b2de4@nxp.com>
References: <20231010090929.4371-1-iuliana.prodan@oss.nxp.com> <2301291.ElGaqSPkdT@steina-w> <80a6a56b-4a12-99bb-acb3-94a5753b2de4@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iuliana,

Am Freitag, 13. Oktober 2023, 10:35:17 CEST schrieb Iuliana Prodan:
> Hi Alexander,
>=20
> On 10/11/2023 8:37 AM, Alexander Stein wrote:
> > Hi Iuliana,
> >=20
> > Am Dienstag, 10. Oktober 2023, 11:09:29 CEST schrieb Iuliana Prodan (OS=
S):
> >> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> >>=20
> >> Add the reserve-memory nodes used by DSP when the rpmsg
> >> feature is enabled.
> >>=20
> >> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> >> ---
> >>=20
> >>   arch/arm64/boot/dts/freescale/imx8mp.dtsi | 16 ++++++++++++++++
> >>   1 file changed, 16 insertions(+)
> >>=20
> >> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi index
> >> cc406bb338fe..22815b3ea890 100644
> >> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >> @@ -211,6 +211,22 @@
> >>=20
> >>   			reg =3D <0 0x92400000 0 0x2000000>;
> >>   			no-map;
> >>   	=09
> >>   		};
> >>=20
> >> +
> >> +		dsp_vdev0vring0: vdev0vring0@942f0000 {
> >> +			reg =3D <0 0x942f0000 0 0x8000>;
> >> +			no-map;
> >> +		};
> >> +
> >> +		dsp_vdev0vring1: vdev0vring1@942f8000 {
> >> +			reg =3D <0 0x942f8000 0 0x8000>;
> >> +			no-map;
> >> +		};
> >> +
> >> +		dsp_vdev0buffer: vdev0buffer@94300000 {
> >> +			compatible =3D "shared-dma-pool";
> >> +			reg =3D <0 0x94300000 0 0x100000>;
> >> +			no-map;
> >> +		};
> >=20
> > Please configure these reserved memories on board level. Not every i.MX=
8MP
> > based board uses this DSP or has these memory addresses available.
>=20
> Will it be ok in imx8mp-evk.dts?

If that is the board using the DSP and the reserved memory, then yes.

Best regards,
Alexander

> Thanks,
> Iulia
>=20
> > Best regards,
> > Alexander
> >=20
> >>   	};
> >>   =09
> >>   	pmu {


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


