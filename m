Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A3777B1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjHNHAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbjHNHAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:00:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06574E63;
        Mon, 14 Aug 2023 00:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691996436; x=1723532436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HyMtUxxgw2gVLDNuMwD4mMzvJ49O4kx94ybiRXJDRfw=;
  b=tDJP5sHrCe+RGRVMyWvpkWiFG65k87LOfQ/miYxMfUwjUjtiVEJkZEYK
   ydhkmn89pTz0CMoI7/QwQpSJOWLfawtpCMiA/2PSBPNkbrSDDLUIyfKbr
   V59WlkUWpR+HgGjsUaTOevupmzwXMERccR+oVQ6x5tU4fhJEn6xFEwZEL
   1k8LneHnGDc5dgxOi71sll+T1o5rR7u8tZsIooRrFbWcZquV9g7yofOMl
   qJhHbr6lYACUbhR7uVMp1+yR7Jy9R33l5BDj1dkGaen0L92ofMGTZdt0x
   JZy3kE0SnICIYNJsRAayVRiTWm/70hEnYuuVAKUN79DYNeyxnANdpSisx
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="asc'?scan'208";a="166290856"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Aug 2023 00:00:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 14 Aug 2023 00:00:33 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 14 Aug 2023 00:00:30 -0700
Date:   Mon, 14 Aug 2023 07:59:51 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Md Danish Anwar <a0501179@ti.com>
CC:     Conor Dooley <conor@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Suman Anna <s-anna@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <srk@ti.com>, <nm@ti.com>
Subject: Re: [PATCH] dt-bindings: remoteproc: pru: Add Interrupt property
Message-ID: <20230814-circus-preachy-b5b9f6ad07d0@wendy>
References: <20230807110836.2612730-1-danishanwar@ti.com>
 <20230807-euphemism-trailing-ef4130dc7437@spud>
 <910a4a98-712a-5517-5a5b-ffb962f83463@ti.com>
 <20230808-unwomanly-generic-67d20f0e51cd@spud>
 <cd74e31f-8bc6-445b-9c33-51e53a439cd2@ti.com>
 <20230808-bazooka-uncoated-a3401d94b063@spud>
 <e49fb304-bd5d-5013-815f-5933a2a170c4@ti.com>
 <20230811-ladylike-snore-abba84731921@spud>
 <ce22155c-31b9-3dd1-8336-275fa92c234d@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QVaRVnEiOl5Q3z9C"
Content-Disposition: inline
In-Reply-To: <ce22155c-31b9-3dd1-8336-275fa92c234d@ti.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--QVaRVnEiOl5Q3z9C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 10:43:58AM +0530, Md Danish Anwar wrote:
> On 11/08/23 8:51 pm, Conor Dooley wrote:
> > On Fri, Aug 11, 2023 at 04:48:28PM +0530, Md Danish Anwar wrote:
> >=20
> >>>> There are no standard defines for these interrupt types. However I c=
an create a
> >>>> new .h file defining all the three interrupt cells and their values =
for both
> >>>> PRU and RTU cores if you think that is required. Otherwise we can go=
 with
> >>>> hardcoded values.
> >>>>
> >>>> Please let me know what you think should be done here.
> >>>
> >>> It'd be good to reference to the documentation for the cells, I don't
> >>> think adding a header is necessary here.
> >>>
> >>
> >> How should I reference to the documentation for the cells?
> >>
> >> Should I just add the details of cells in description of interrupt pro=
perty here.
> >>
> >>   interrupts:
> >>     maxItems: 1
> >>     description:
> >>       Interrupt specifiers enable the virtio/rpmsg communication betwe=
en MPU
> >>       and the PRU/RTU cores. The value of the interrupts should be the=
 PRU
> >>       System event number [cell 1], PRU channel [cell 2] and PRU host_=
event
> >>       (target) [cell 3].
> >>
> >> Please let me know if this looks OK to you.
> >=20
> > I was thinking there'd be an binding for the interrupt controller that
> > you could mentioned.
>=20
> There is a binding for interrupt-controller [1] that I can mention. I tri=
ed using
>=20
> - $ref: /schemas/interrupt-controller/ti,pruss-intc.yaml#
>=20
> But it was throwing dt binding errors so I didn't add the ref.

Yeah, you're not a pruss-itc so that makes sense.

>=20
> I will mention this file name in the description of the property like bel=
ow,
>=20
>      description:
>        Interrupt specifiers enable the virtio/rpmsg communication between=
 MPU
>        and the PRU/RTU cores. For the values of the interrupt cells please
>        refer to interrupt-controller/ti,pruss-intc.yaml schema.
>=20
> Please let me know if this looks OK to you.

This is what I would've expected, yea

--QVaRVnEiOl5Q3z9C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNnQ5wAKCRB4tDGHoIJi
0sOoAP493J6fgOaLp+xT4qZeoRYxhj410prJLo6DeSre5PkDgQD7BBF3IDKbwsZs
ZER6gpf5G77oetGXKenPhwnAhW6RwwU=
=a2k2
-----END PGP SIGNATURE-----

--QVaRVnEiOl5Q3z9C--
