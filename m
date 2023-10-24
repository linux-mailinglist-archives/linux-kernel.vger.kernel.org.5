Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAAC7D46F6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 07:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjJXFhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 01:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjJXFhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 01:37:51 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9668F125;
        Mon, 23 Oct 2023 22:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1698125867; x=1729661867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GKCui9cJyGKr7oruPX4GBfO58GfHK6CS9FhEdXSU9BA=;
  b=JNECnJUaCOWv/ygdgCyp8g5KUCLXm1aAFZJPq53rZ1NL0gYtlr/ruafv
   nnhxlVDLqCQoIKN+1IVKC00Cige/bObcoNpamHZZbyo6D/Mp04qY6Y1pc
   Z8PHwAXB2NY/NYg5XEIxi4j5Z/0zMI1yYOQP+3ROhIJ4A+1XQ/GOnt6Hy
   yaLI9b9kdPdSll+vR8YU8jA8vxPHH6DPYS2NCtI1p5G+z2mrXTj9vm8gl
   /RBEx7vp+g0O3s3Z8EGogmHBzsdXJpX1XKEE/MdOphr8kXU+LlqDU11ab
   sx6jAm9E8PPtMMfyUXmzTgmTz4QtDOG7lwJeYVJ48bhlVL+0BBEEixJOM
   Q==;
X-IronPort-AV: E=Sophos;i="6.03,246,1694728800"; 
   d="scan'208";a="33612995"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Oct 2023 07:37:44 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 7A71728007F;
        Tue, 24 Oct 2023 07:37:44 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: imx8mp: add reserve-memory nodes for DSP
Date:   Tue, 24 Oct 2023 07:37:47 +0200
Message-ID: <5883038.MhkbZ0Pkbq@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <ZTasTEvw4//SEMlW@p14s>
References: <20231013152731.23471-1-iuliana.prodan@oss.nxp.com> <20231013152731.23471-3-iuliana.prodan@oss.nxp.com> <ZTasTEvw4//SEMlW@p14s>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Am Montag, 23. Oktober 2023, 19:24:28 CEST schrieb Mathieu Poirier:
> Hey guys,
>=20
> On Fri, Oct 13, 2023 at 06:27:31PM +0300, Iuliana Prodan (OSS) wrote:
> > From: Iuliana Prodan <iuliana.prodan@nxp.com>
> >=20
> > Add the reserve-memory nodes used by DSP when the rpmsg
> > feature is enabled.
> >=20
> > Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> > ---
> >=20
> >  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 22 ++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts index
> > fa37ce89f8d3..b677ad8ef042 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > @@ -125,6 +125,28 @@
> >=20
> >  		};
> >  =09
> >  	};
> >=20
> > +
> > +	reserved-memory {
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
> > +		ranges;
> > +
> > +		dsp_vdev0vring0: vdev0vring0@942f0000 {
> > +			reg =3D <0 0x942f0000 0 0x8000>;
> > +			no-map;
> > +		};
> > +
> > +		dsp_vdev0vring1: vdev0vring1@942f8000 {
> > +			reg =3D <0 0x942f8000 0 0x8000>;
> > +			no-map;
> > +		};
> > +
> > +		dsp_vdev0buffer: vdev0buffer@94300000 {
> > +			compatible =3D "shared-dma-pool";
> > +			reg =3D <0 0x94300000 0 0x100000>;
> > +			no-map;
> > +		};
> > +	};
>=20
> Alexander: Are you good with the refactoring?

Yes, adding this to EVK is good for me.
Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> Rob and Krzysztof: I'm not sure if you want to ack this patch but giving =
you
> the benefit of the doubt.
>=20
> Shawn and Sascha: Did you plan on picking up this patch or shoud I?
>=20
> Thanks,
> Mathieu
>=20
> >  };
> > =20
> >  &flexspi {


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


