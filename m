Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5810578F0E1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245585AbjHaQGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjHaQGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:06:31 -0400
X-Greylist: delayed 64229 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Aug 2023 09:06:07 PDT
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0A610C7;
        Thu, 31 Aug 2023 09:06:07 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.96)
        (envelope-from <m@bues.ch>)
        id 1qbkB5-000OJU-02;
        Thu, 31 Aug 2023 18:05:49 +0200
Date:   Thu, 31 Aug 2023 18:05:06 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     =?UTF-8?B?0KDQsNC90LQg0JTQtdC10LE=?= <deeb.rand@confident.ru>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        =?UTF-8?B?0JLQvtGB0LrRgNC10YHQtdC90YHQutC4?=
         =?UTF-8?B?0Lkg0KHRgtCw0L3QuNGB0LvQsNCyINCY0LPQvtGA0LXQstC40Yc=?= 
        <voskresenski.stanislav@confident.ru>
Subject: Re: [PATCH] ssb-main: Fix division by zero in ssb_calc_clock_rate()
Message-ID: <20230831180506.30466e8a@barney>
In-Reply-To: <531722477.1139813.1693465653233.JavaMail.zimbra@confident.ru>
References: <20230830082759.23336-1-deeb.rand@confident.ru>
 <4c6d01bf-1a0f-27de-54e1-4afdcf4bc8d5@lwfinger.net>
 <531722477.1139813.1693465653233.JavaMail.zimbra@confident.ru>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Qokcis+UCMMyJEsFdt=sS0U";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Qokcis+UCMMyJEsFdt=sS0U
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 31 Aug 2023 10:07:33 +0300 (MSK)
=D0=A0=D0=B0=D0=BD=D0=B4 =D0=94=D0=B5=D0=B5=D0=B1 <deeb.rand@confident.ru> =
wrote:

> 1- Yes, I agree that your solution is simpler, and I thought about
> it, but I thought that the one who set the value zero put it for some
> reason, so I did not want to change it.


Yes, I understand your reasoning and I had the same thought initially.
But I looked into the code and I am pretty sure that there is no reason
for the default case returning 0.
In fact, I think returning a 1 as default makes much more sense as the
default value for a factor.

Changing this from 0 to 1 will get my ack.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/Qokcis+UCMMyJEsFdt=sS0U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmTwujIACgkQ9TK+HZCN
iw4NlhAAtupYTu8Q6OEnSbcpPgBOAAR8EoCVWY2QwXo3SlYqT8XSnALguogkyIsy
pNpmND8JYmoq62PrEJXdFERAaIi+nTjpjQi7TYiwC+R2Qn4HUeFUsEOmbBfz+vz6
+h3cKJTN8+2BICKjOIuUzTmcCQ0E/Pgj6kh+ZR3nc76hISuAKNGoEArecidAyoTd
6d2n6Hqjg3FP8NPOu/v3NVrAS4NIeQXm5TLPMUBBXmBLQw95yjV7bNuVsoLI98R8
beiEWRTwqCAg7wLSDP/67hZSTH37oRZgvMuuweywdjU3RMIlRgIfiOGhsSX/+Z3J
Z5VgTcxu2TNib4TzgehvpJLahGepBT72TCktW8NnJ5tIwuedvAwXQWmMwxK5HgWs
mQKSWhvSL6OQV799c3qh04uVAXU3wr55lUJ0iEARwDSdm/DP469Qfz0zHaRmvrWX
SS3b5C4EBoBLhoT4VUbCLq9o9TxLIwTo/zidUh4LM2uaxJJRJWiUJaQAE4h6CjZC
6hOb5zLMfruMmiSx1aDvedjIKAQyHN7GBVFZuTRcVyYnVt/f1Kjau90IqFEuHgE+
45Nhh0X2WxcyIlxhPsXHWN8c670ryrNqV5s97YZpXFc45VwtRrhWP9+szNTtlo0X
1XwOv0cZLFud7f+guOliHmImffOxnAvQrpCSiToAoGBOA2oXQf4=
=PTT5
-----END PGP SIGNATURE-----

--Sig_/Qokcis+UCMMyJEsFdt=sS0U--
