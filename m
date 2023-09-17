Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533A27A3515
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbjIQKEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbjIQKEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 06:04:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7E718E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 03:04:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52139C433C8;
        Sun, 17 Sep 2023 10:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694945041;
        bh=Gso6S/NadZnbLvgrACDdGV3yKQ0lDXCmgQv0+9JSmeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5bdmq+S8UpnPJnPiePBHbssJs5tcLQYAfJy3MYqUbj4Z1ggrkoekIJNTi+fW/cGS
         SJpPDQ2WOXZQwUrLeAia9CsGSQW1AjPjrb6Q5R6hJ1gujm7EteVVQzaeedetIM3jdx
         3xxQis3riBr6+R2kTADEeXAsBA7lewPP8EAHAEg3g4Ono+D9dbGgpbYGAaR+37VhgR
         ZR6jqzDXReYg3cqVFmpmf6MIsQzUUnFN4wggJeBxJHDo5d3N/disihdWZ/K6ZxnE9g
         ZcpajpyxaZr9kilkPrnNNINqubQMErLDjlYI0RxwgMciiC5e8iYUbcODsg6wPCntRY
         wunFLDNXQSYlA==
Date:   Sun, 17 Sep 2023 11:03:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        fancer.lancer@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 1/2] dt-bindings: net: snps,dwmac: Tx coe
 unsupported
Message-ID: <20230917-figurine-overlying-f5a0935af5ea@spud>
References: <20230916063312.7011-1-rohan.g.thomas@intel.com>
 <20230916063312.7011-2-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sfl5dMioS+61NyiC"
Content-Disposition: inline
In-Reply-To: <20230916063312.7011-2-rohan.g.thomas@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sfl5dMioS+61NyiC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2023 at 02:33:11PM +0800, Rohan G Thomas wrote:
> Add dt-bindings for coe-unsupported property per tx queue. Some DWMAC
> IPs support tx checksum offloading(coe) only for a few tx queues.
>=20
> DW xGMAC IP can be synthesized such that it can support tx coe only
> for a few initial tx queues. Also as Serge pointed out, for the DW
> QoS IP tx coe can be individually configured for each tx queue. This
> property is added to have sw fallback for checksum calculation if a
> tx queue doesn't support tx coe.
>=20
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc2..5c2769dc689a 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -394,6 +394,11 @@ properties:
>                When a PFC frame is received with priorities matching the =
bitmask,
>                the queue is blocked from transmitting for the pause time =
specified
>                in the PFC frame.
> +
> +          snps,coe-unsupported:
> +            type: boolean
> +            description: TX checksum offload is unsupported by the TX qu=
eue.
> +
>          allOf:
>            - if:
>                required:
> --=20
> 2.25.1
>=20

--sfl5dMioS+61NyiC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQbPCwAKCRB4tDGHoIJi
0jpOAP0Rec+DYUN9Tx+3DSmk0L8jcQbqesqX7hzjoxzMCmsBwAD+LoOp6/jRtBiP
ZD5abXvbAPNK63Z3f0NgpMoHlrqdKQY=
=Te+k
-----END PGP SIGNATURE-----

--sfl5dMioS+61NyiC--
