Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A024B7AE719
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjIZHrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjIZHrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:47:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B74FF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:47:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91C3C433C7;
        Tue, 26 Sep 2023 07:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695714455;
        bh=vl35SqT6As6GYRAB1JyOE9/QeFzf9D4iT44T99JNDlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjUhAaaoMDko8sv9+IFAdtVK2RNanulH1ZWFUiB1DPHQE7cHVcsGafcs8JEz0Vsaw
         mS9dPobqyU+cvTEo1zmOaQ/21D5jUVnWXrgkQkd3M+qYg/8kfRi7p6lHnMEgPMrk+h
         D8lCCVtAczUF7D03AL5w34mfyQd0S5MSrI/6FefEn5G5o+JBHOQCqlVMc7BE67xyQg
         BqUksUX/eKNggweBScJtbTmo0lKvSq25NB/NLy70aSszQAox93L8xic42RY01Nj4LE
         152ryVriErwTu1sUfFrFk6XPN+sIY2Ez54b1ppXxdguEyE7bxlzVgLE5724i75oLKp
         lsXcr6Pq1b6JA==
Date:   Tue, 26 Sep 2023 09:47:32 +0200
From:   Mark Brown <broonie@kernel.org>
To:     wangweidong.a@awinic.com
Cc:     13916275206@139.com, alsa-devel@alsa-project.org, arnd@arndb.de,
        ckeepax@opensource.cirrus.com, colin.i.king@gmail.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        harshit.m.mogalapalli@oracle.com, herve.codina@bootlin.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        liweilei@awinic.com, perex@perex.cz, povik+lin@cutebit.org,
        rf@opensource.cirrus.com, robh+dt@kernel.org, ryans.lee@analog.com,
        shumingf@realtek.com, tiwai@suse.com, trix@redhat.com,
        u.kleine-koenig@pengutronix.de, yang.lee@linux.alibaba.com,
        yijiangtao@awinic.com
Subject: Re: [PATCH V4 4/7] ASoC: codecs: Add code for bin parsing compatible
 with aw87390
Message-ID: <ZRKMlCd+Ys5kGXVw@finisterre.sirena.org.uk>
References: <ZRGT2oLQaJBVVYFH@finisterre.sirena.org.uk>
 <20230926070436.486530-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tZVZOycL8pVKc0vY"
Content-Disposition: inline
In-Reply-To: <20230926070436.486530-1-wangweidong.a@awinic.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tZVZOycL8pVKc0vY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 03:04:30PM +0800, wangweidong.a@awinic.com wrote:
> On Mon, Sep 25, 2023 at 16:06:18 +0200, broonie@kernel.org wrote:

> > /build/stage/linux/sound/soc/codecs/aw88395/aw88395.c:199:21: error: to=
o few arg
> > uments to function =E2=80=98aw88395_dev_get_prof_name=E2=80=99
> >  199 |         prof_name =3D aw88395_dev_get_prof_name(aw88395->aw_pa, =
count);
> >      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from /build/stage/linux/sound/soc/codecs/aw88395/aw883=
95.c:17:
> > /build/stage/linux/sound/soc/codecs/aw88395/aw88395_device.h:184:5: not=
e: declar
> > ed here
> >  184 | int aw88395_dev_get_prof_name(struct aw_device *aw_dev, int inde=
x, char=20
> > **prof_name);
> >      |     ^~~~~~~~~~~~~~~~~~~~~~~~~

> I did not get this error when compiling base on "2cf0f715623872823a72e451=
243bbf555d10d032"
> and the changes to this function are already in [patch V4 3/7]
> Can you tell me how to modify it?

Apply every patch in sequence and check that it builds individually,
including for configs like the x86 allmodconfig.  I don't specifically
know what the context was here, I'm just reporting the failure my CI
found.  If you're confident things are fixed then resend.

--tZVZOycL8pVKc0vY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUSjJQACgkQJNaLcl1U
h9AhNQf+PgXK+9hFtAV8TDEBHilOTUoirrT7GLRXtflsuD4DNlW9QYMd+UEt6YT5
lfNWJhq9hhwcgdAfc2L8n22a+WN+tt5iEv1r4V0lRXxhvoxuWiWoPcM4z+Udr5KG
Oj49aBdhZ0XMtu8z4YzhDJtra5cO19kvv+1t8zI+9XKYUSuUc4PrVDDWdCU1LSMm
8jnd/Q5ViOky26oktO/JMDD9rpIIE023Zwvyrz1/gadhZsodwUP0UUwXs+dR1KVF
3sLPU61KC9TVfPrtRESiFUn+rj6FW4qk6m6H/vFq83UksIBF3V2H1M5Nk9m/meyV
JY+hC93fqWPdqhpqPJSTC5loPpwfNw==
=5Afg
-----END PGP SIGNATURE-----

--tZVZOycL8pVKc0vY--
