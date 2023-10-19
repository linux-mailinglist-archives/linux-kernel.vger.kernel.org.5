Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA2B7CF6C4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345372AbjJSL22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345346AbjJSL20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:28:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602A8112;
        Thu, 19 Oct 2023 04:28:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250FDC433CA;
        Thu, 19 Oct 2023 11:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697714905;
        bh=CC0lIEjmBNKh9ZTUkXID9Xg/UYaPpvLP9VjlpzQIKKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8J0WDTwOMk8s35OVmB7NSTsfGjyRimJNi5chvuN1wISDixtWWtxec6I/Jgkl7RYb
         wPdKLI3UMGcqllLhjGfvA1fPhw3Ss24uv9lOCpTq9KygR+eDdZ6yo6b5UMx0t5qV/A
         HJ8wfdF9AqVuSyXYkrXMMHAg28W2/so1DapBzf2bVBRFXBG3ZFAfxnmdS+xBugvWxw
         cZdMhkr1sXbWWExImGv/N12f5FQqe1aVRlVNDMW7wzQOh1AZx7lxv9T1kqtb5CAWIq
         Sn+yf4mAwebUB9u8U3khpgl0/GAiQoqEOERGebNHxs/y25XgfQW5yXshmQg5YN4jdn
         6B9mKC0kTpD2Q==
Date:   Thu, 19 Oct 2023 12:28:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: light: Squash APDS9300 and APDS9960
 schemas
Message-ID: <20231019-hurry-eagle-0ffa95b1a026@spud>
References: <20231019080437.94849-1-subhajit.ghosh@tweaklogic.com>
 <20231019-rematch-ethically-9d482ca4607e@spud>
 <6b856b0d-4f69-70ac-59a7-237fd21d1a92@tweaklogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iLG2NMHQSB/mbANT"
Content-Disposition: inline
In-Reply-To: <6b856b0d-4f69-70ac-59a7-237fd21d1a92@tweaklogic.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iLG2NMHQSB/mbANT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 09:20:12PM +1030, Subhajit Ghosh wrote:
> On 19/10/23 19:21, Conor Dooley wrote:
> > On Thu, Oct 19, 2023 at 06:34:37PM +1030, Subhajit Ghosh wrote:
> > > Squashing Avago (Broadcom) APDS9300 and APDS9960 schemas into one
> > > file and removing the other.
> >=20
> > > Link: https://lore.kernel.org/all/4e785d2e-d310-4592-a75a-13549938dce=
f@linaro.org/
> >=20
> > "Yes, they look similar. I will combine them all in a single yaml file =
in
> > the next revision. Thank you Krzysztof."
> >=20
> > Yet this is a follow-up patch, not a version 2. The original patches
> > seem to not have been applied, so I am not sure why you didn't send a
> > v2?
> >=20
> > Cheers,
> > Conor.
>=20
> Sorry, I should have put a longer description and a longer commit message.
> That patch series adds a new driver - apds9306 which is separate to this
> patch. As per Krzysztof's comments, first operation is to merge the exist=
ing
> apds9300 and apds9960 schemas. This patch is the first operation.
>=20
> Second operation will be to add apds9306 support on top of that. I will
> explain more on Krzysztof's comments. Thank you for reviewing.

Ahh apologies then. The best course of action would likely be to include
the patch merging the two bindings in your series adding the third user.

--iLG2NMHQSB/mbANT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTES1AAKCRB4tDGHoIJi
0hxoAP9jx8eindF1SaXOSWo2eyme0bm0nsGc8NhDwAugFtQf1QEA4S34dn1S2csN
Xiyj0F1EY71U+VdxYt7jDZkgkwUtlgw=
=tF1b
-----END PGP SIGNATURE-----

--iLG2NMHQSB/mbANT--
