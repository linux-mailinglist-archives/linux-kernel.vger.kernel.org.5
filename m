Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3FB785B80
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbjHWPJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbjHWPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:09:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE5710C6;
        Wed, 23 Aug 2023 08:08:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD8365C76;
        Wed, 23 Aug 2023 15:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F57DC433C8;
        Wed, 23 Aug 2023 15:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692803313;
        bh=JGq8R5xqMtVVPKuMWihL6epOl3sHKR796hDF3Zg8PRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AgUMlqXeSZn9cIBPJHzrYuqoR9CfPf7w1J35N89LVKzerPtWBP161+ACprGAFW5/v
         IL7h3KTkSzk0EdhbVgwyTTtPRZxuvg9UL69qY3BfBa9SdqyecMWashK7SKFw/XPP8p
         j4cO04tenaWxJyLO3cF/RF2r3hblzL3tl7JDDOjVRoBpa2fNmU96W+v9BjORE56XtB
         TsSrQuE8BNkHl5n4qc/0+pMOnIciH0sDukvosZD3wrroQGgywB31TdG+nUJA9Tx1RM
         T2jk2XQV1mr7qOUOqRUOG3HGmpsqIBAi+RhZEerhWUXb2eTNgZ93QKBOgbeKBD7+b2
         dm4etpY/Wz7Mg==
Date:   Wed, 23 Aug 2023 16:08:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v4 1/2] gpio: dt-bindings: add more loongson gpio chip
 support
Message-ID: <20230823-certainty-grimace-a8365c0cfb02@spud>
References: <20230823033427.23072-1-zhuyinbo@loongson.cn>
 <20230823033427.23072-2-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S5CS9eIFPcjBP7ZC"
Content-Disposition: inline
In-Reply-To: <20230823033427.23072-2-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S5CS9eIFPcjBP7ZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 11:34:26AM +0800, Yinbo Zhu wrote:
> This patch was to add loongson 2k0500, 2k2000 and 3a5000 gpio chip
> dt-bindings support in yaml file.
>=20
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../bindings/gpio/loongson,ls-gpio.yaml       | 23 +++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml=
 b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> index fb86e8ce6349..97472f1529a0 100644
> --- a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> @@ -11,9 +11,24 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - loongson,ls2k-gpio
> -      - loongson,ls7a-gpio
> +    oneOf:
> +      - enum:
> +          - loongson,ls2k-gpio
> +          - loongson,ls2k0500-gpio0
> +          - loongson,ls2k0500-gpio1
> +          - loongson,ls2k2000-gpio0
> +          - loongson,ls2k2000-gpio1
> +          - loongson,ls2k2000-gpio2
> +          - loongson,ls3a5000-gpio
> +          - loongson,ls7a-gpio

> +      - items:
> +          - enum:
> +              - loongson,ls2k1000-gpio
> +          - const: loongson,ls2k-gpio
> +      - items:
> +          - enum:
> +              - loongson,ls7a1000-gpio
> +          - const: loongson,ls7a-gpio

Are there going to be more controllers that are compatible with
"ls7a-gpio"? If not, you can simplify both of these to have 2 const:
entries, like:

      - items:
          - const: loongson,ls2k1000-gpio
          - const: loongson,ls2k-gpio

      - items:
          - const: loongson,ls7a1000-gpio
          - const: loongson,ls7a-gpio

Either way,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for sticking at this one :)


--S5CS9eIFPcjBP7ZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOYg7AAKCRB4tDGHoIJi
0ij2AP9ycHxBMjGFNyFLGzGwvUA07stB9ZrZ2pb+C9RmwNpyDQEAtx55RIZwst6D
6NfmIIFXVf90D/AxjXJOvwcllY1Q1gU=
=VESe
-----END PGP SIGNATURE-----

--S5CS9eIFPcjBP7ZC--
