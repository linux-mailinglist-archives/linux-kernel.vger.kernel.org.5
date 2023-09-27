Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334A67AFF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjI0JMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjI0JMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:12:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F8E92;
        Wed, 27 Sep 2023 02:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695805951; x=1727341951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wPhgzEHO2NaRyB1WCgPNeiw3UuWNC+N8/u1LEawKUZY=;
  b=MraGSZxWy2e+uksJlp2eMCNinTBBduOiLUVWUoXZkaq6kQ8GnujT7pSK
   1+WoCPWBB2a6Tde4hgjK5/D7hRvfcMEzxIDA+68ju6bd7xCyANFJnIDa1
   TIvKojVgDP7T9w+wOvCFDDteeFDl55k11EQxP1OhmRuSGZ/6P4FgWaMVz
   nzmn89QBeiyP0maPK/WJ4SV1mSKB8tmi0aZqomefUZGmrq8kPQ6GcgJI6
   NbSPU/L8fmoQ2lt+o6OFFxmcKZVWsJnLeIvDdtL5Wp9Oyp+SHsKJbqGwB
   wkuFaF6fTyjyeiHFz32uPiU2pKnM2pKO7gFKn9bp2b1aoJiuovqO1CnLF
   w==;
X-CSE-ConnectionGUID: QipB8j7QTkSlnvEe88bcxg==
X-CSE-MsgGUID: hEHH/xoXRLmujSkIgqtwVA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="asc'?scan'208";a="6836511"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2023 02:12:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 27 Sep 2023 02:12:04 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 27 Sep 2023 02:12:00 -0700
Date:   Wed, 27 Sep 2023 10:11:42 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Ming Qian <ming.qian@nxp.com>, Conor Dooley <conor@kernel.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Message-ID: <20230927-dismantle-retinal-2f5dc8c6c235@wendy>
References: <20230926101000.13392-1-ming.qian@nxp.com>
 <20230926101000.13392-2-ming.qian@nxp.com>
 <20230926-slackness-target-b74e33ab1031@spud>
 <AM6PR04MB6341B0D9EC8146149CF8ADB0E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <54c87219-de9f-4c5b-9c70-11de22c7c612@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5M0Lyh3zCCR/Z6Y"
Content-Disposition: inline
In-Reply-To: <54c87219-de9f-4c5b-9c70-11de22c7c612@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--r5M0Lyh3zCCR/Z6Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 10:10:40AM +0200, Krzysztof Kozlowski wrote:
> On 27/09/2023 04:10, Ming Qian wrote:
> >> From: Conor Dooley <conor@kernel.org>
> >> Sent: 2023=E5=B9=B49=E6=9C=8826=E6=97=A5 21:26
> >> To: Ming Qian <ming.qian@nxp.com>
> >> Cc: Mirela Rabulea (OSS) <mirela.rabulea@oss.nxp.com>;
> >> robh+dt@kernel.org; shawnguo@kernel.org;
> >> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> >> mchehab@kernel.org; hverkuil-cisco@xs4all.nl; s.hauer@pengutronix.de;
> >> kernel@pengutronix.de; festevam@gmail.com; X.H. Bao
> >> <xiahong.bao@nxp.com>; Eagle Zhou <eagle.zhou@nxp.com>; Tao Jiang
> >> <tao.jiang_2@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> >> devicetree@vger.kernel.org; linux-media@vger.kernel.org; linux-
> >> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> >> Subject: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign=
 slot for
> >> imx jpeg encoder/decoder
> >>
> >> Hi,
> >>
> >> On Tue, Sep 26, 2023 at 06:10:00PM +0800, Ming Qian wrote:
> >>> There are total 4 slots available in the IP, and we only need to use
> >>> one slot in one os, assign a single slot, configure interrupt and
> >>> power domain only for 1 slot, not for the all 4 slots.
> >>>
> >>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> >>> ---
> >>> v4
> >>> - improve commit message
> >>
> >>> - don't make an ABI break
> >>
> >> What does this mean? Can you please try to explain things a bit more c=
learly
> >> in your changelogs?
> >>
> >> Also, where is the code that actually makes use of these properties?
> >=20
> > In v3 patch, I make this property required, make it an ABI break, so in=
 v4, I remove it from required, and default to the previous behavior if it =
is missing.
>=20
> So say that you dropped line making the property required.
>=20
> >=20
> > The code patch is sent before, but the dts change is not applicable, so=
 I send it separately. The code patch link is as below:
> > https://patchwork.linuxtv.org/project/linux-media/patch/cdadb4a23697fdc=
97def958c69b12cd00f547212.1685430841.git.ming.qian@nxp.com/
> >=20
> > But in the patch, the property name is "slot", not "nxp,slot", I will m=
ake another patch to fix the property name after this patch is reviewed.
>=20
> Format your emails properly. It's difficult to read it.
>=20
> I already NAKed it, I will be NAKing still. Don't embed OS specific into
> the bindings nor into the DTS.

Additionally, sending the binding and dts patch split out from the
proposed driver change is very unhelpful, as often (as is the case here)
binding patches are not very well explained and it is required to read
the driver to reverse-engineer the binding patch author's real intent.

Particularly when you mention an ABI break it is important to do so, so
that we can check the code changes to make sure that the ABI is upheld.

Thanks,
Conor.

--r5M0Lyh3zCCR/Z6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRPxzgAKCRB4tDGHoIJi
0h0jAQDcf7pZAIW8G1ToRYnSYO3mxmidd0e/I9L42Z53F8f5JAD/ehUJW2iFLrkg
VgrFdEdyFM0qD6Dh9w2r1cgc8kGm/Q8=
=HsvG
-----END PGP SIGNATURE-----

--r5M0Lyh3zCCR/Z6Y--
