Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374867D6C46
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjJYMrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjJYMrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:47:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679C490
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:47:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9E5C433C8;
        Wed, 25 Oct 2023 12:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698238063;
        bh=CyqpQORDLu/59HchAbKGaMl6wNYR768sbZQ93p3rYeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YATVW8KqlFBX1JZPFRjcCsvP4x4eJPNtjpD65YAuL8PazS+HeumlBZZokf3o5lwvd
         iVMMaJNXaDKw6Z0oWv1eNeK6MyuMIdu/CpuQkrH5Y0HuaDlfNP/9QL6TWpgVF1eKay
         V+iqAFkoR8sSqzeuv1DLzujhRFm9naJaPVFPzXwud+g4+Ozh7PuwF5p4zRibwCJtjE
         UxQJbT8OQkzdMshisVf+9fHDgVAWtWtum5z6U16KPaDn+OwbfLVnHZH8ifXTOUQ6tP
         7v4/sEW+PqMcgjWqQIRmaS9GIbJ0jGrwZ9QiG/4Q5vOSGVKDxQURd5grtWNBExk5B/
         kw2MQo2ZKgAvw==
Date:   Wed, 25 Oct 2023 13:47:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/7] regulator: Handle system-critical under-voltage
 events
Message-ID: <c91e53ee-2054-49d0-b554-ab96a5f68b19@sirena.org.uk>
References: <20231025084614.3092295-1-o.rempel@pengutronix.de>
 <20231025084614.3092295-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mdxULxN83Uy27oHH"
Content-Disposition: inline
In-Reply-To: <20231025084614.3092295-3-o.rempel@pengutronix.de>
X-Cookie: There's no time like the pleasant.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mdxULxN83Uy27oHH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 25, 2023 at 10:46:09AM +0200, Oleksij Rempel wrote:

> +	if (rdev->constraints->system_critical &&
> +	    event == REGULATOR_EVENT_UNDER_VOLTAGE)
> +		hw_protection_shutdown("System critical voltage drop detected",
> +				       REGULATOR_DEF_EMERG_SHUTDWN_TMO);
> +

This should probably be a switch statement for the event and also handle
REGULATOR_EVENT_FAIL, possibly other errors this would also be
appropriate handling but it's less immediately obvious and we can
always extend later.

--mdxULxN83Uy27oHH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU5DmkACgkQJNaLcl1U
h9AQGwf/TfaVoP11UEL9ECg1F1JcTUxtIKKbV2e5h8+gGyu/nUdTL2RCcBm0xYbi
ngVCbCI0ei6qYIIgd0hfGwjxFk8+hOK9mQR1oUy3zJ2ICa+iQjXoH/6cYrRJ/8Hm
k6sI8toUJNpUsFRNpOcuvcGCd1oCAQPOH1Xd2h67ay133OnFdWPrU+se41uC8Vg7
6eLPt2hMB2MKyaDCon4JYnYl9ZmIsQUHJ2Ik/2xEhxdkAngx27nOrlpAGy9ADyWa
1CyJIkW0bQhXx3qVvaBbI3y/BTybwQdyixxuch+6EmTXSFR/3lnTAUHvlhgLY2ZX
tjH8WxzNCKXEw5I3UbM5/KZZ6t2TBw==
=Sbh1
-----END PGP SIGNATURE-----

--mdxULxN83Uy27oHH--
