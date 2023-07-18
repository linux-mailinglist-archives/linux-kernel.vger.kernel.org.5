Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC37E758154
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjGRPud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjGRPub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:50:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51909E;
        Tue, 18 Jul 2023 08:50:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BB0C61636;
        Tue, 18 Jul 2023 15:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CAFC433C7;
        Tue, 18 Jul 2023 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689695429;
        bh=KpsXoGNT24bqVK2j4V39yYPHPZAehW1pBCGywyhhsZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCl6VUf09aCm8F9Rfutn6Uxx1jy2IXKPwVbDgKNy1lsByW8D863kBj34wgk2UM72g
         w1xJ/miCw6e0jHG1v+nv0PesQByoe+ygDO+uaGUl+kT4/oEjpu6XOk+GxaC62yj2w2
         qs7NCOmvby5/koQcOlOhHApH2sSLLpn00WWDYn/nDZtrbaBjuLcGQhZmI4lDlx9K53
         X4Fcw0U+zDJziRGp16VQoMWxMlfRhX58qqZOJHenzUSABwl9YUTj8/hKREuQhVvQE+
         rX5T4SeYeY9ajqhE3J91401ueoMDUuNLRkXoDiN9RNmE8cXFbRcdg7MC5DZvuuxLLI
         VoIHsZ564kXNg==
Date:   Tue, 18 Jul 2023 16:50:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        Marek Vasut <marex@denx.de>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        saikrishna12468@gmail.com, git@amd.com
Subject: Re: [PATCH 3/4] dt-bindings: pinctrl-zynqmp: Add output-enable
 configuration
Message-ID: <20230718-jitters-excretion-fe18c820c102@spud>
References: <20230717093347.3869167-1-sai.krishna.potthuri@amd.com>
 <20230717093347.3869167-4-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hrxtH0ql+XfVls6Z"
Content-Disposition: inline
In-Reply-To: <20230717093347.3869167-4-sai.krishna.potthuri@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hrxtH0ql+XfVls6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 03:03:46PM +0530, Sai Krishna Potthuri wrote:
> Add 'output-enable' configuration parameter to the properties list.
>=20
> Using these pinctrl properties observed hang issues with older Xilinx
> ZynqMP Platform Management Firmware, hence reverted the patch previously.
> Commit ff8356060e3a5e126abb ("Revert "dt-bindings: pinctrl-zynqmp: Add
> output-enable configuration"").

And what has changed since then that makes it okay to add?
Is the old firmware not still in the wild?

Thanks,
Conor.

>=20
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>  .../devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
> index 2722dc7bb03d..1e2b9b627b12 100644
> --- a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
> @@ -274,6 +274,10 @@ patternProperties:
>            slew-rate:
>              enum: [0, 1]
> =20
> +          output-enable:
> +            description:
> +              This will internally disable the tri-state for MIO pins.
> +
>            drive-strength:
>              description:
>                Selects the drive strength for MIO pins, in mA.
> --=20
> 2.25.1
>=20

--hrxtH0ql+XfVls6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLa0wAAKCRB4tDGHoIJi
0oQHAPwLbzoQrcII+jPHwQtJ8XLVTtNNrYqRLQBk6RwGQUphugD/Q638arUQoo1g
cyV6Ef/POblzZqSX0Xj0V4XLt9Klswc=
=ANB1
-----END PGP SIGNATURE-----

--hrxtH0ql+XfVls6Z--
