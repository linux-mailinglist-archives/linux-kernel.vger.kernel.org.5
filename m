Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC377AA3C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjIUV6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjIUVt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:49:27 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C484663DA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=B3IM
        ao2Q2IxNVAWNCXVLHyU4C/DuZeL0FIlKs8Fvzcg=; b=Q/mAwEGNru0HsS7pDT8Q
        F11FmHFXzVXe/KEzNG/f/4wMqv3GFdZX4372wzmjhI+KRLxnpX1/sj/ZptLsA9vw
        toy2h4l68nsrVlGZ7hUhT1N87DNvUOFp+bQoBA1jcZlgud7mxb8s5xxsHOhcO42q
        kq9GTHykmZ1c4pEBEruz8k/B5dj7mfpcRuRFc80j5WRmqFS51TEZyIt+CiRib+xH
        G1pnFWIvm2OXd6ss/rHghzWcLb5nTjAqcjdJHqxYzaYRJTUDQ1IDe5SxvotOzLta
        wBVh3mWyBFvh11j7GlubP9jw8rKe4KQybn0xy6lgYTkJTSL7g9JlJFfLcY/IENCV
        fQ==
Received: (qmail 941082 invoked from network); 21 Sep 2023 14:06:26 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Sep 2023 14:06:26 +0200
X-UD-Smtp-Session: l3s3148p1@K784Ut0Fw3wuciJ+
Date:   Thu, 21 Sep 2023 14:06:25 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc:     linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] vlynq: remove bus driver
Message-ID: <ZQwxwUm3HbqqwEzb@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-4-wsa+renesas@sang-engineering.com>
 <30279c62-c80b-330f-260f-0c64a7893555@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uTWIX+buPLkNnnAP"
Content-Disposition: inline
In-Reply-To: <30279c62-c80b-330f-260f-0c64a7893555@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uTWIX+buPLkNnnAP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 12:37:54PM +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> On 20/9/23 22:10, Wolfram Sang wrote:
> > There are no users with a vlynq_driver in the Kernel tree. Also, only
> > the AR7 platform ever initialized a VLYNQ bus, but AR7 is going to be
> > removed from the Kernel. OpenWRT had some out-of-tree drivers which they
> > probably intended to upport, but AR7 devices are even there not
>=20
> Typo "support".

"support" would also fit, but we use the term "upporting" frequently to
express that we want to bring some code from downstream to upstream.


--uTWIX+buPLkNnnAP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUMMcEACgkQFA3kzBSg
KbaZEQ//WmAKG0+HLioziXTOXss/qa1sW4PU8KSM+nOjF8OU+986UDQ0BoqBOAA5
4bvrJWzAz0m2o2Vx6HKqKp/msgYp0OnRSnXU/kkYjxlPtOEm6K7PoLHA0zjlx2WP
jXYLH3yhjQ10IF9qKyCfX7/SSaNhpiu4QuGJR1byKzNVDcMbsDdXHnUQm0hfY9Ui
Q6akxg+WzQjI8bUaHV/lQbkU9yuXII2eXfyesLIB5RdpKn1TnaMwIa7EHVt2CE9z
NoanTLJWsylhnFLFWg3ZTT6bOpsWkawXNWzmkbpsXsDmpeKrxduwRwSrpBeBsOqK
8CCGoVHytYnkBR82kSwrnx6jXY7rNnvHQZ4Va06VFdYqlRWymwhitkiC0AXew0tu
/iF92A6ZDel7Zd7wcJYA1mF8m3tY7F0UVfo3N2jeTXiCexV+5yNeGtpVZutGSZ6T
7xvGci3EIbTHZxTR20l/tzn0bLqS/2cNVoK7QmmiEFaHvU4YHnS37OtvchsuVo2q
UozYyZex5I/hi8QaY2+a3E4tW3PQ1KpuKkfi8j/k+Lt9EBSLINfmZsvUwD3e+lU/
8XcxVNX1I0KsLrRwP8Upx7LXdlbVaNw9jesBgrx8sUsfdsPPA6hSCGMXZOaXSH52
YV1rDq+eqaKlE88sW9cOBnPYul5z51rdBZTZYhkJd14X1tY9vfE=
=UpnR
-----END PGP SIGNATURE-----

--uTWIX+buPLkNnnAP--
