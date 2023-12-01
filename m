Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3660800FB3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378240AbjLAQH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjLAQHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:07:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A97319E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:08:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36824C433C7;
        Fri,  1 Dec 2023 16:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701446881;
        bh=d/08iXOBweGKjvzeBse92aGDvcp1s3i+5SpPnyoDhjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gopnhae7f4ZBBzXjZmJ8RtunpsSQFs9yEjMom25qdT+I6mp9n8Cre0bGN9lRC4RtK
         JF5hmjUnbaPro2a0HXGOkqnMCIsyX1SK1LBfhwbSviErdouy7rBviUHEBLeEFSTijz
         qIQwEhRs3f5lsjSnz98tvgaz/pBxfBd5LcVd4IXdHMSkLOpZhEwQCQmNZAaxOm07XO
         Cj0QB9QdPDXie0P2WM5tyEwsQA2ZPNQG5VdUm8Rmmyin8szu/P46/hhhctgzVwoDU/
         B+g+KUS1qyONU7mEcTk48gGEoyIpXIEpEs1GvuMdABspvxumgAJgi7GZ4h5ZBzSh4K
         Cdz4c6b8vP9Kg==
Date:   Fri, 1 Dec 2023 16:07:56 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Increase max number of io-channels
Message-ID: <20231201-spousal-outage-c8c5ec1fca80@spud>
References: <441d9babc7042892350a58ba4300df4761876ae3.1701334008.git.michal.simek@amd.com>
 <20231130-power-rubbed-fbf64a8c6978@spud>
 <074cb071-2a3d-4c9b-89ba-d215a3624b6b@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="089BzLmiPUjI3fx5"
Content-Disposition: inline
In-Reply-To: <074cb071-2a3d-4c9b-89ba-d215a3624b6b@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--089BzLmiPUjI3fx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 09:35:27AM +0100, Michal Simek wrote:
>=20
>=20
> On 11/30/23 15:58, Conor Dooley wrote:
> > On Thu, Nov 30, 2023 at 09:46:54AM +0100, Michal Simek wrote:
> > > arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts is defining 30 chan=
nels
> > > that's why increase it.
> > > But AMS binding defines 51 channels
> > > Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > > that's why increase number to 51.
> >=20
> > Please write commit messages for bindings in terms of how they relate to
> > some hardware. In this case I think it would be sufficient to say that
> > the Analog Monitoring system has 51 channels, the opening sentence about
> > the dts as justification provides no actionable information.
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> v2 sent.

I wasn't requesting a v2 FWIW. "$file uses 30 channels" rather than
rephrasing it in terms of the hardware actually having 51 channels just
annoyed me, that's all.

--089BzLmiPUjI3fx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWoE3AAKCRB4tDGHoIJi
0htzAP0cOVLgxVE33YuXQA6ip9kEABi2FUj1VukVCiHIHTK77QEAr7zoWm8Mc4YC
DSRCWd6uHwdNq5vULwzOo6IThJj63ws=
=G3fr
-----END PGP SIGNATURE-----

--089BzLmiPUjI3fx5--
