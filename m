Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624487E996D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjKMJvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjKMJvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:51:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633DE10D2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 01:51:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7372C433C7;
        Mon, 13 Nov 2023 09:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699869065;
        bh=4MkvGrUVycKC9A5KUDfRgr2hBxqeKe3Fbl93G9r6QU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fMf1fvuidE8Ce+YR3AqKli/uC4lIUpcXFPN8xxfLW3cn3K2MwgVCRB1zE4+ZEfoBN
         Od/ciPeu2XLepeAoYki4mlM1uSiJeXgQ9mjkrMIMFpqmEGMg9MJi4daNwm94acCEab
         IpfAxZacFNDpCX1nQxaIlYrYbKtv2sA99Grct/BTSHJTSSdZCAzVprljXuSH42RxoW
         wFQAS85X0Uy+33UzuuhlqRPI4oWtEES3SG0D1AmHNsAHT72ncWLknU7wuq4J6/E9QB
         Ax7dWdznLEvCo7EHdG3Z1ZOivz9/R/iE0XQCHzsgDkDqzaOXksgvQWyoKUfohgsfNd
         wphqJhnosx7yw==
Date:   Mon, 13 Nov 2023 04:51:00 -0500
From:   Wolfram Sang <wsa@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Jan Bottorff <janb@os.amperecomputing.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] i2c: designware: Fix corrupted memory seen in the ISR
Message-ID: <ZVHxhN+dxJSUkEOg@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Jan Bottorff <janb@os.amperecomputing.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231109031927.1990570-1-janb@os.amperecomputing.com>
 <yuperxjytpcwz25fofjut2edzjc4i6jgymcraxp4q6mfe27taf@b33ym5iuubji>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t8LnJb9u6oVhM1lW"
Content-Disposition: inline
In-Reply-To: <yuperxjytpcwz25fofjut2edzjc4i6jgymcraxp4q6mfe27taf@b33ym5iuubji>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t8LnJb9u6oVhM1lW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The patch has already been merged in, but in anyway:
> Tested-by: Serge Semin <fancer.lancer@gmail.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Thanks to a restrictive hotel network, I haven't pushed out yet, and
could still add your tags. Thanks!


--t8LnJb9u6oVhM1lW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmVR8YAACgkQFA3kzBSg
Kbajpw/+LsHLEOAvcgLU2sJpusYw4cLrC6K8W6W6+LdxH+2DJAeOQYgmpgOKBUAd
rf/I+o9AELntKTLeM47y/iUcXNMBM5/d8+S8JnENGrv+IsHPDM6a7Jd/axnMrpXG
aj2hX3IrRjHbjEnZr4o6/nCXxUp8twFNRCaguJOFjHLPM9noJsAuTWaDklZyW4TS
pDYS2vL8IeF/DLzqQeoF4VuCM50O0KwIjuabRRdpaghFS/nDlAfI1GC+6a3V0rGA
/vNDhT7unaBQLZ6l8QA9lXgtJ8XFJzryyWE1hZmUIo1AaA7hw84eb1qoQ/L/nCY6
P5OVtVhHqbEG2nFH8Tan+s9T1yFux1juL/C5rnJ0R+4WM+jrQVsXhopODV1XhvsZ
yfgYZPMMntwAYwsCkcsc3GkViHWrJysutUsGJBjyS1bdUbpNY7+qa0gz1CL5jCDj
wrgX6FPWrbzj4pOHE4G9ay+vJMXPrHwSzLx0Fwwu1YtnC8k/TzL9vPx+PdoW5LBt
JUVdiA71b7OcI25HLDcQZviA8MSjVU0YwMD1qs+LA8R/uF7sZ8DK/VIO/Qejq+y9
1GqLTcNRQ7bdJcVLAW/LsY4Nfq0cXkRJVCvCvicjRxLQ/K6WYpfHZYNqDVwy7/9P
E2OTA4i3Cr+//bIN08ilELRPOfqmoxJUwx3FSCOyjSfOTLcgm20=
=DqV+
-----END PGP SIGNATURE-----

--t8LnJb9u6oVhM1lW--
