Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F422A7C94BF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 15:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjJNNZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 09:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJNNZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 09:25:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E3BC2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 06:25:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9506EC433C7;
        Sat, 14 Oct 2023 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697289955;
        bh=xyAHBtwF6qf+q9F9kmfhHuJJAP88d/S1vOjvN3+mXHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OlLa0Ulc0DKDp2Ct10MC5Zsba52hUu+14ZbgGrlmTFVOb+MSAqT6NFF3knJbmDzqZ
         xXOuQvyOL/5JfqzX7hgYx3FHfjHw4KFxg3NaJpm3SH4+pnAxmNmWndifO5AapuoMuC
         W2aQSHZEA+Ut5u4ayVY3NM4r+7zfLMYrU89VOuRA74QbdcnNEYtofU6mAJPNUcx8xE
         ZrA3QUmfdCmFRLCcmGf3FotFK+dyRS6iYvapj4jIaX7Heh5xxjbT9zlMOuLcY/2/go
         V6iA8DtVFoHP14QMrfr27cj1Shnb8as0vDk2qKu/PONC/9R4WFQ3dFZ5YIM53l2DlT
         T9MYJd/YjQlQg==
Date:   Sat, 14 Oct 2023 14:25:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Linu Cherian <lcherian@marvell.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>
Subject: Re: [EXT] Re: [PATCH 1/7] dt-bindings: arm: coresight-tmc: Add
 "memory-region" property
Message-ID: <20231014-carbon-slept-9464499a4156@spud>
References: <20230929133754.857678-1-lcherian@marvell.com>
 <20230929133754.857678-2-lcherian@marvell.com>
 <CAJ9a7VhzARGmywQFPNCZ27D5UKEEPSR9_hmL5fo3daFWpB26Vg@mail.gmail.com>
 <PH0PR18MB500266F8C82877450DC9DDD2CED1A@PH0PR18MB5002.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xODWgUT9EMkdmFwT"
Content-Disposition: inline
In-Reply-To: <PH0PR18MB500266F8C82877450DC9DDD2CED1A@PH0PR18MB5002.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xODWgUT9EMkdmFwT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 14, 2023 at 11:36:37AM +0000, Linu Cherian wrote:
> > > +      - description: Reserved meta data memory. Used for ETR and ETF=
 sinks.
> > > +
> > > +  memory-region-names:
> > > +    items:
> > > +      - const: trace-mem
> > > +      - const: metadata-mem
> > > +
> >=20
> > Is there a constraint required here? If we are using the memory area for
> > trace in a panic situation, then we must have the meta data memory area
> > defined?
> > Perhaps a set of names such as "etr-trace-mem", "panic-trace-mem" ,
> > "panic-metadata-mem", were the first is for general ETR trace in non-pa=
nic
> > situation and then constrain the "panic-" areas to appear together.
> > The "etr-trace-mem", "panic-trace-mem" could easily point to the same
> > area.
> >=20
> As noted above, we do not have other generic use case for these reserved =
regions now.
> Hence two regions/names, panic-trace-mem and panic-metadata-mem with cons=
traints kept as
>  minItems: 2 and maxItems: 2 would suffice ?

Whatever you do, please delete the -mem suffix.

--xODWgUT9EMkdmFwT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSqWzgAKCRB4tDGHoIJi
0qX6AP9zu1/zSvIKb+Or0bUn+DYlqMtR8PQFTUOPeVyvcHN8SwEA1kUb5kBtLo7/
/tHTuGBcFv3oHZR+As70GVeHsRHGtwA=
=JnQT
-----END PGP SIGNATURE-----

--xODWgUT9EMkdmFwT--
