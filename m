Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FE97678F8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 01:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjG1X2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 19:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjG1X2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 19:28:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB293AB1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 16:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31A8862211
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 23:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE25C433C7;
        Fri, 28 Jul 2023 23:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690586892;
        bh=N20Vk1GZBKbVhd/c7KSr0gihKQDzhVZnKCVob6v+czU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUZsSBiFbCZZaJwrhaBuhM1808/CLZm+760rfWaKfE51P6dJK5wuE/XiPCfKpkrVe
         Qb1q5/8xLSNDLBHalbX5FjqtoA5zg4idQMUek4DT6vZPNlKOIAsitxt7Qvk65UcSYE
         s6RWO/vecfnWTPVhvFyBNNXjkAyqQSgmqIxZuZMqv98VEQv+/jLF4IRuy1OCShcFej
         tMLxOKsrsJcRVlZ6B5wsaoovJcuWQ2t8UbhTYfdaeWS+VgyHnMfHrzvDskt4o+bNoB
         vCJLZ2cOJnCeA+s+SJ1rLxkYwzugIBe7HOJ2tEb8daIEVOcIuR1YNVwyC/wbuIX0i1
         rhsNYQD7NkljQ==
Date:   Sat, 29 Jul 2023 00:28:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
Message-ID: <ZMRPCA9FqzIXFQe6@finisterre.sirena.org.uk>
References: <20230728-synquacer-net-v2-1-aea4d4f32b26@kernel.org>
 <0a208142-1c71-f997-4d77-961d3bc91343@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UtDpsnXQ6n8IQycD"
Content-Disposition: inline
In-Reply-To: <0a208142-1c71-f997-4d77-961d3bc91343@gmail.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UtDpsnXQ6n8IQycD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 28, 2023 at 03:54:08PM -0700, Florian Fainelli wrote:
> On 7/28/23 15:51, Mark Brown wrote:
> > As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
> > property on ACPI systems") the SocioNext SynQuacer platform ships with
> > firmware defining the PHY mode as RGMII even though the physical
> > configuration of the PHY is for TX and RX commits.

> Did you mean to write "delays" instead of "commits" here?

Yes.

--UtDpsnXQ6n8IQycD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTETwQACgkQJNaLcl1U
h9C/Ogf+MbQ7lE8cIU7YhtnQ52ZRDq9f99ZpfPN6FMQYNt/Hz7s0DTbyZk/U0ReF
mxo+EpFHJB3ck2wycqM0z1S0LoH6VxRdOc/OOel+EJ9sHKM4nOkrVP7kF9fObiNu
3b8sfA5crWTTecPuLMWf/4cD/WatD3gi3g6vKvmJ+OWe/iP8Um6AXxuQhX9M2MB4
3wgsYxE6ZoVUSaDArbnIbDYJuOXaean3Th7kORwEy2ehu3aSoJqEBfAPz1sh5Ax2
KH/PURBbodgXkumPpYoz82uNgV2n6oQ3HVAV7gr3z7rNDKEvqZ+mQY/MEvoyK3aS
FhZ/6abugxn46XrQYFTT+32Rp7l1hQ==
=ZiOC
-----END PGP SIGNATURE-----

--UtDpsnXQ6n8IQycD--
