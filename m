Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5567E2D95
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjKFUGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjKFUGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:06:13 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DC21BF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=vjZF
        qOeaA5LnEvg7LgKIYy3UkKcpigHlSgqw4G26ag8=; b=JLv9rI0rbmHPlQYxKl7T
        ygwR/amMDIBMCRPI7WXXcaouj38UoUWUebE4OXL3n6MmN95nF2nwHe35Ax3Wasf6
        q0gHZ0sXG9QYPcPlR+MgLgaGSXcOVI3VVlNuxNb8GUKqgmct/E6iAPlYoJ22yryp
        NWbvh38Qi1I/dHddmW7qBngSuNTfWHZYbjtx8cOB/eyLKg7+SpZdrf3Rs7l1S1Tl
        +M2kGmJpPLQ3uE6He9enkJWzFHJtL7kNgux+ZxkzdrjdfztM5+1fUR9ZtYnrOvBA
        7qZ2kzhfveKxmQHiHsNmHoklbBC6q3LJzs50UMMT08vtPnqud8jm1j8a+zbNbNge
        9g==
Received: (qmail 2147080 invoked from network); 6 Nov 2023 21:06:06 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Nov 2023 21:06:06 +0100
X-UD-Smtp-Session: l3s3148p1@e2NaYoEJluQujnvL
Date:   Mon, 6 Nov 2023 21:06:05 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] gnss: ubx: add support for the reset gpio
Message-ID: <ZUlHLZ1mm9IpSPal@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Johan Hovold <johan@kernel.org>, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
References: <20231103225601.6499-1-wsa+renesas@sang-engineering.com>
 <20231103225601.6499-4-wsa+renesas@sang-engineering.com>
 <ZUj3fzArgPU4kYYT@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XtrtXT+bQEBVz+kB"
Content-Disposition: inline
In-Reply-To: <ZUj3fzArgPU4kYYT@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XtrtXT+bQEBVz+kB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> 	1.5 I/O pins
> 	RESET_N: Reset input
> 	Driving RESET_N low activates a hardware reset of the system.
> 	Use this pin only to reset the module. Do not use RESET_N to
> 	turn the module on and off, since the reset state increases
> 	power consumption.
>=20
> (and AFAIU you should generally not try to use reset this way unless it
> is explicitly said to be supported).

Oh! That's the opposite of my intention :/ Okay, today I learnt
something. Thank you for pointing this out. I will remember this and
double check reset handling in the future.

That means I only need to de-assert reset in probe() for now, right?


--XtrtXT+bQEBVz+kB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmVJRy0ACgkQFA3kzBSg
Kbblgw/9HkWUa0iBE7Mo2bg3mjgmftVGc9rJBWSmmDiocs9jX9ksuSH6a5AHiqMe
+xpfG6MI4xjUzLGL1+YaITrYQyKE3ZUMSLeKqwJSV+qxhBo+biDtWq/EKExyO+91
PAb553VbrW+QmdK2+bcsHKi+LqZ0kSy18IF9vaCV7fQozNXwRvxocyTBLGZmfrZo
xQ0+Mt1+T5nNkU8dHtyKENHuMlgFYSlGbUiLEdIUPYBNA9TAew+7JDiyx6ZS88hu
Njkso91lBK981JBPS3kmpL+/WsRXsm+tEuc/6snQ4TWu9LlIDv+TsYXZ6rh3Oe7L
B+3L+mMa+fUcRkt0rfCh18hbLASgtQZ67HfT5t5jUqlq5L4aR0wYNHNt1Gu2S3g/
Of/XiEfvD54yjwled7izZEW9U7yQcSrPSi49DSzuibavicjYK+dKTw7P/v21z2Pc
UWlAuFsoyamyGyswY2Z1vIBSnFtIgySFcr6cS5YGwTHomzxWUkH81zjKtZfIHmD8
hafMaegBE40vE+9wBMp0+UpAv5Zt5KgI7W6FCHIiu8offra9dch54SiaARjJlMe4
etaFgu//W+bxGQDUuIfNJER8V8FMsb+3gip1eR7dQq+MnZqIVubaVIRhCOYoxDZf
7Dxkr1o28KP3W4ETDirAAuR8/BtaZimx/9uXm9CEewYtGX7GANU=
=TGul
-----END PGP SIGNATURE-----

--XtrtXT+bQEBVz+kB--
