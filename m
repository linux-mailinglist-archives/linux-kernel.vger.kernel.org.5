Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CC47EE619
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345357AbjKPRpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKPRpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:45:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E413D182
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:44:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44F3C433C8;
        Thu, 16 Nov 2023 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700156697;
        bh=yn5B25n6M8qrwrNyu0STc5iMLcjtyg6R1Uxl3tbWaqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6u2kK0/IowLCdNLr4C5NK0exZ27pjabRvjz3pfiTGxK2HMJCRecsKkSr+TsGGIYE
         ncaUTB4oC8rxk7lEd/BExTappoBI77nkp20TXsV4w1Y02H1F5z/rs9q78qUAWAQmVx
         YFjQsxTeFfmfg8ElsdiSJ2X56ZztoIlmWzDbwAX41ScHUDdGDm/97X0D1ZB1piTzUY
         ojTQSWB7wCGZsIYeKakOLblWZhS7WPwq71Xk38SG2IHN5hYxkimIZR069qTq5W5qLb
         LTifKK5gF/UyJVUP7EtqTMrOuzotucclcM+zoIvkX5lO7WViCJ39ICD9XJ18Gn3JeH
         OWilj18Cr9Nxw==
Date:   Thu, 16 Nov 2023 17:44:53 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 7/9] firmware_loader: Expand Firmware upload
 error codes
Message-ID: <20231116-t-shirt-supreme-581c8882d5cc@squawk>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-7-be48044bf249@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ypoZjICOlFY8ORK"
Content-Disposition: inline
In-Reply-To: <20231116-feature_poe-v1-7-be48044bf249@bootlin.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ypoZjICOlFY8ORK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 03:01:39PM +0100, Kory Maincent wrote:
> No error code are available to signal an invalid firmware content.
> Drivers that can check the firmware content validity can not return this
> specific failure to the user-space
>=20
> Expand the firmware error code with an additional code:
> - "firmware invalid" code which can be used when the provided firmware
>   is invalid
>=20
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

This would be rather helpful to me for some stuff that I am currently
working on and was hoping to send to Arnd for inclusion in 6.8:
https://lore.kernel.org/all/20231020-series-uncooked-077b107af3ae@spud/

I'm currently returning a "HW_ERROR" for something that this would fit
the bill for (in mpfs_auto_update_write()). What would the ETA for this
stuff landing via the net tree be?
Since I am not a netdev contributor its hard to tell how controversial
these patches are!

Cheers,
Conor.

--6ypoZjICOlFY8ORK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVZVEgAKCRB4tDGHoIJi
0irnAP463rgejD0fRuUPUsFy/SyMR0GqguMUDXaPiQRu3KbdyAD/fQJuV4BKxnmF
n8iXTSD1Six25k/bHw9DH6k1b+et7gU=
=GRGU
-----END PGP SIGNATURE-----

--6ypoZjICOlFY8ORK--
