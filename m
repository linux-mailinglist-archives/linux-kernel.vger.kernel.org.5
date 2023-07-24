Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100E675FCA0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjGXQya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGXQy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:54:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1B883;
        Mon, 24 Jul 2023 09:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59BF56113A;
        Mon, 24 Jul 2023 16:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDD1C433C7;
        Mon, 24 Jul 2023 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690217666;
        bh=nZLu6vwqapKhQe/GN3qXvFgQwLGxgBCoWllQtcidduE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0Y90PnWh32L82pwmMy5a8pWNvn+UPE6scfeaeRK/teyxdS+ubENOxD3kJXpzaJDo
         S1XpRNMZWL3BER8O/TkhAleES1bJwXQIx7c2bgxhI2oBAAfzDAAngj4SHhzvOPSzuu
         tRq65JDfQEFBz7aF4tfYLyNxaOTA7m3wmHkBCfdEux0lZ3YHNGHFtT8Jp0SRo6sZpz
         eiy58NIkCZM5NsPpZSznC5gpSxwOKIFRYabQH0kfjNw2fzlhIyxCrk5AWIQL4ZY7bF
         DrZpV0UpKv1/+fCTbgFRQ8pfwtIISYoOUQimaXIIF6iRmQsWoE5mhV7fS402XeYh6j
         odpgRpbL8u1ww==
Date:   Mon, 24 Jul 2023 17:54:22 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support
Message-ID: <20230724-paternity-labrador-e8f4046b3398@spud>
References: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
 <20230724-shabby-schnapps-e7254584400c@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AVdePY38nlqBEkwe"
Content-Disposition: inline
In-Reply-To: <20230724-shabby-schnapps-e7254584400c@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AVdePY38nlqBEkwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 05:53:36PM +0100, Conor Dooley wrote:
> On Mon, Jul 24, 2023 at 02:08:47PM +0530, Komal Bajaj wrote:
> > Changes in v5 -
> >  - Separating this from original series [1].
> >  - Added description of driver to secure qfprom binding.
> >  - Replaced pm_runtime_enable() withh devm_pm_runtime_enable().
> >  - Changed module license to GPL instead of GPL v2.
> >=20
> > This series introduces a new driver for reading secure fuse region and =
adding
> > dt-bindings for same.
> >=20
> > [1] https://lore.kernel.org/linux-arm-msm/20230623141806.13388-1-quic_k=
bajaj@quicinc.com/
>=20
> Why does this series have two v5s?

Never mind, I missed the reply Komal. Apologies!

--AVdePY38nlqBEkwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL6svgAKCRB4tDGHoIJi
0iCBAQD2wIUuiq8k4E4sYi53yY2Y99TwRE6p14Z3ZX+cUIyt6gD+OLt9LpGtqgUu
MduxBhp+p1IdFhQuYAghedlTxRJNEQs=
=Tw7b
-----END PGP SIGNATURE-----

--AVdePY38nlqBEkwe--
