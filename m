Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C6579244D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 17:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjIEP6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 11:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353481AbjIEGVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:21:33 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADE8191;
        Mon,  4 Sep 2023 23:21:23 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.96)
        (envelope-from <m@bues.ch>)
        id 1qdPQv-001L3y-1u;
        Tue, 05 Sep 2023 08:21:04 +0200
Date:   Tue, 5 Sep 2023 08:20:19 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Rand Deeb <rand.sec96@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        deeb.rand@confident.ru, lvc-project@linuxtesting.org,
        voskresenski.stanislav@confident.ru
Subject: Re: [PATCH v2] ssb: Fix division by zero issue in
 ssb_calc_clock_rate
Message-ID: <20230905082019.3e111dc2@barney>
In-Reply-To: <20230904232346.34991-1-rand.sec96@gmail.com>
References: <20230904232346.34991-1-rand.sec96@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1jNiMFQddYjpJbUFMGo9Qgn";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1jNiMFQddYjpJbUFMGo9Qgn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue,  5 Sep 2023 02:23:46 +0300
Rand Deeb <rand.sec96@gmail.com> wrote:
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -835,7 +835,7 @@ static u32 clkfactor_f6_resolve(u32 v)
>  	case SSB_CHIPCO_CLK_F6_7:
>  		return 7;
>  	}
> -	return 0;
> +	return 1;
>  }

Acked-by: Michael B=C3=BCsch <m@bues.ch>


--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/1jNiMFQddYjpJbUFMGo9Qgn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmT2yKMACgkQ9TK+HZCN
iw7OjRAAkPVJcvb2YsUwfSDQ/Nuc2KYIE9+DpWP+/MllD+bsM1K5wa1gRaohtiVY
ztmHKQlba2XvcxGUkPlW8B4FTfiBlho6dAy/0Qu8zlyr1/7Tc81RYAavLDSLxhmj
omF+DHBXPCyeVRfskOLLSOKtUXQ0rWINmKpEBDBQP2cG64M2ximpP927xkgalBwp
zx3P3ndfTXb2+oNQqEquAEl6NfGGXEWBN2enNLYs3NOddCsDSj6oXpmEfEIouCQ7
QB4vKKzKS7z8MoM0wFXBpvdrfW8WK7cqu1g4JGwlnHLXfZhXuNVbgmS+ncsLQXO3
gkFii/Fa32/9Bm+Hrt1bkMtN2Pt2nBg+S0zOe7ddKdSC3AYCJi3aJCfUz+3PV/2t
DEHAeRsUjnIgOyBR0Ff83ACdVci2bp3LNi1tLeQs5gnLSeLpgA1YuFNrMksob0CF
N5/jxiNYUgsW5ejAaQcpKaG5czZgscPiglDLaXYX6gKY6TL2QsNkaZZ77m9pV9r2
81JNL2UaXEsJW8ztYqgql1P/F1+BVRAULo5cxl8lI9f4Mdxee0RqlE3dW3+2APzn
IMS3V72eDh147bit5r9QPtrYybhJXTcdD9yEvn2VPigPhEPPYt7RDhTpQnHqugNK
NwG7aWGNuh3JxqD2cFiBUqCHE6hq/k20vsRhlrLxzs3y9uVzQKg=
=B5Ak
-----END PGP SIGNATURE-----

--Sig_/1jNiMFQddYjpJbUFMGo9Qgn--
