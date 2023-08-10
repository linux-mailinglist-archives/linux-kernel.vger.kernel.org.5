Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1FC778176
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbjHJTYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjHJTYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:24:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2374D90
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B46BA66445
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CFEC433C8;
        Thu, 10 Aug 2023 19:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691695486;
        bh=dGlwEVlRQLY6hzisurfToivtweKkIfYIl1RZciNjZeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pS7Le/b+BETgEgjMi5DwVwX9zUha9IA2Ii0pAZZ/8fNp8Obdiwm1iJTC9YArxTd8f
         U6JItPzkD7A8JXV7X0GoCSwEmCPmkfqSxEGl4mZu6tBaY/OqjxSFA7T+frh/o21uEf
         +yP3vgsYTBTxQ/3fi6I+bGB582+wjo8h0KWmYBVozHqF5I0NvA5bIDTckrVjCfLeqv
         2jLuQiG4qbm7ZRbFoDSwuHPjEQOxZ0Abr1enWqBfaQncqH8I69ZCtv2NB2rNGV9VsM
         lWFt4a7P+2JfRAWuY59tN9WDo7Xx3FLbVGwSK1s3+QlvOAJQRh6kjnqh/jLmN0uZMn
         9T8xy0SKvFlEw==
Date:   Thu, 10 Aug 2023 20:24:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Eugen Hristev <eugen.hristev@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH] dt-bindings: arm: mediatek: convert audsys to yaml
Message-ID: <20230810-syrup-matador-f00ec8ad381d@spud>
References: <20230810133602.48024-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zCt4crqknTtCVQPA"
Content-Disposition: inline
In-Reply-To: <20230810133602.48024-1-eugen.hristev@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zCt4crqknTtCVQPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 10, 2023 at 04:36:02PM +0300, Eugen Hristev wrote:
> +  audio-controller:
> +    #  $ref: /schemas/sound/mt2701-afe-pcm.yaml#
> +    type: object

Other than this "informative" reference, which really feels like it
should be a second patch in a series with this one, this looks good to
me. You can add a
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
when the reference is a real one.

--zCt4crqknTtCVQPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNU5eQAKCRB4tDGHoIJi
0hv9AQCC01iB3MpLxF2VvSb3yCD+YUvH4FOmYYci0+sUCQPOBgD+LuVu0B9lwAQf
cljg0lUR7zfuDA7YBdpltZMtFjvr7gk=
=CcPp
-----END PGP SIGNATURE-----

--zCt4crqknTtCVQPA--
