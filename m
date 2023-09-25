Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8757AD9B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjIYOG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYOG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:06:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A418BC0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:06:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87208C433C8;
        Mon, 25 Sep 2023 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695650781;
        bh=z+beOv8eP8i270vZ1KGKwTfsMp2RfL6DAYL5zKJa3/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MG32E4D4v6lLAVuXEpIB0vGfmaXdid2BgKg/yfGteT0SAlvD/+tl/NWbfdW2wbqq6
         eO8lAvso0JbMOjcKr3Z4ZKmomaScWlzWun6AWg9kIK/BMlEj6vYruZwA41b/cqbX9R
         lls3NzvHM1USHU/uhE1FszvWEz5ZGOAiEUp5tQhXZJ/0nBr2ygi3bpMiYk53uHqUnF
         0XnAVdpzLOGgC9nKlOV5agNM3wcH59ka2pivMJLD/H5aBJbuNau5NkASuklgK77834
         klvPEiJbjd8Kg+h7egHmthYazXTXyfnr/DLaF6J76m+d1lENd4oaHHa8bYV/jvQqln
         N0+6fybY3WkEw==
Date:   Mon, 25 Sep 2023 16:06:18 +0200
From:   Mark Brown <broonie@kernel.org>
To:     wangweidong.a@awinic.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        herve.codina@bootlin.com, shumingf@realtek.com,
        ryans.lee@analog.com, 13916275206@139.com,
        linus.walleij@linaro.org, ckeepax@opensource.cirrus.com,
        povik+lin@cutebit.org, harshit.m.mogalapalli@oracle.com,
        arnd@arndb.de, yijiangtao@awinic.com, yang.lee@linux.alibaba.com,
        liweilei@awinic.com, u.kleine-koenig@pengutronix.de,
        colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 4/7] ASoC: codecs: Add code for bin parsing compatible
 with aw87390
Message-ID: <ZRGT2oLQaJBVVYFH@finisterre.sirena.org.uk>
References: <20230919105724.105624-1-wangweidong.a@awinic.com>
 <20230919105724.105624-5-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QFIK27TUvqKWMvSN"
Content-Disposition: inline
In-Reply-To: <20230919105724.105624-5-wangweidong.a@awinic.com>
X-Cookie: HELLO, everybody, I'm a HUMAN!!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QFIK27TUvqKWMvSN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 06:57:21PM +0800, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
>=20
> Add aw87390 compatible code to the aw88395_lib.c file
> so that it can parse aw87390's bin file
> Modify the function return value

This breaks an x86 allmodconfig build:

/build/stage/linux/sound/soc/codecs/aw88395/aw88395.c: In function =E2=80=
=98aw88395_prof
ile_info=E2=80=99:
/build/stage/linux/sound/soc/codecs/aw88395/aw88395.c:199:21: error: too fe=
w arg
uments to function =E2=80=98aw88395_dev_get_prof_name=E2=80=99
  199 |         prof_name =3D aw88395_dev_get_prof_name(aw88395->aw_pa, cou=
nt);
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /build/stage/linux/sound/soc/codecs/aw88395/aw88395.c=
:17:
/build/stage/linux/sound/soc/codecs/aw88395/aw88395_device.h:184:5: note: d=
eclar
ed here
  184 | int aw88395_dev_get_prof_name(struct aw_device *aw_dev, int index, =
char=20
**prof_name);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~

--QFIK27TUvqKWMvSN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmURk8wACgkQJNaLcl1U
h9AbHAf9GUfsbOtVMPrTo9cIihIM3OVqHie4TXTSEVdAf9Lg9U2Z9NDs92Cbjc9N
7uisNTtQA6NMvc1UAYTYm7R2yRyHiaJRkW8gYmh2opw7WZgO7nbMAchxGMGvZjH8
huc1lVOvgxbdcRnaZYG4RA8l4htTrMQTD2P+8fMmWQNW16d/xn+1/q0baZ/v8KWJ
lAHGTem14Ry7ocS3WxxCJRrCYIp98a7SbyL3t0EbFHFFZM4JQ019PwaI7poDXRTx
CeQmqsUQwnBwqSDCF+pFl15TEmlXEC7QFPm9B+zGjRN+TLD2ilsT3XgJfDfs9tn5
u7FBcRLo6DeHIqOKu41HCAOkMVenfw==
=xBek
-----END PGP SIGNATURE-----

--QFIK27TUvqKWMvSN--
