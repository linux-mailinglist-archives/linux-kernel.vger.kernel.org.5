Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E257A4CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjIRPkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjIRPka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:40:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED44A10D0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:37:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA87BC433CD;
        Mon, 18 Sep 2023 13:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695042419;
        bh=hsho6zwJgdGzMVL4844nsBVJLIQBFgjfSPu5NS4R7o8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mYtySxGMysdHsCIovmnvfHlg2AaCRdxOSMVbY5d92dapcymNtg/kl2qtiuus9BWWP
         O5xRQVUXhyPqGfR3NU5kIxPupa2m0Hpp1SeCCC1aK3hnqJqUYS/p6IFu2lT2qGFGBz
         YW0d9AwawXYSSHY61bLTtA4GMOT+UThCQ7b3Vz5AtA15rH7ZpPmGv91UF0UAvH8V19
         HFKDgIVwF4TB+7Qw79Q22nieQnypZNGrTjB+gEDcVTZiLNNQl5C+jEHIpGcFdJGjwg
         o4QQU9vPvO2j6M82ZFhGAaJUAmaWXXglLUVf0IzSeHB/1AJZM3ezI5cbQuHY8bPBsh
         wcTWASdhyv78A==
Date:   Mon, 18 Sep 2023 14:06:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     wangweidong.a@awinic.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        herve.codina@bootlin.com, shumingf@realtek.com,
        13916275206@139.com, ryans.lee@analog.com,
        linus.walleij@linaro.org, ckeepax@opensource.cirrus.com,
        povik+lin@cutebit.org, arnd@arndb.de,
        harshit.m.mogalapalli@oracle.com, u.kleine-koenig@pengutronix.de,
        yang.lee@linux.alibaba.com, liweilei@awinic.com,
        yijiangtao@awinic.com, trix@redhat.com, colin.i.king@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/5] ASoC: codecs: Add code for bin parsing compatible
 with aw87390
Message-ID: <b695fab0-1f0e-468c-a6c7-aa1003473c32@sirena.org.uk>
References: <20230918115255.33171-1-wangweidong.a@awinic.com>
 <20230918115255.33171-4-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5z+Fx5DotXtZSz3Z"
Content-Disposition: inline
In-Reply-To: <20230918115255.33171-4-wangweidong.a@awinic.com>
X-Cookie: Never kick a man, unless he's down.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5z+Fx5DotXtZSz3Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 18, 2023 at 07:52:53PM +0800, wangweidong.a@awinic.com wrote:

> Add aw87390 compatible code to the aw88395_lib.c file
> so that it can parse aw87390's bin file
> Modify function return value
> Remove the fade-enable property because other properties
> already implement thi functionality.
> Modify the transmission method of parameters.

This would be easier to review if it were split up so that the
refactorings are separate commits, removing fade enable is a separate
commit and then finally just the changes to add the new CODEC are done.
That way each individual commit is both smaller and simpler.

--5z+Fx5DotXtZSz3Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUIS2kACgkQJNaLcl1U
h9Aj0wf/VncxZlHRbBN0E5dNaMspwCt53RF7zzRX8acE4xwwNEi9RATZwZnamY1B
QHozPKBCqDrLv0QTnW2g/ZsForhKwa/q826C7X3ROhrp3O2aKrt25Nypbtn0Lup/
4lRZ5r33uo4FOoh6t+Uj7+eCVaRnTENvmoMwn+8pfIWzmNpX8SrjKuB84kY3Ouh7
8M5qt2/G9TwArVShx8v+ovZUf99Vbm/zQP3PueyLJfH/hJxm1j51zNBHhESEoThT
tUdelqK0GXX3F3JKSc/o2B/WDmk5unSx/uE7N65Y/hcgn1qZ7FBjuur/jR8uy424
Et6u5OOpx0tplM8EO5FVl1hZG+pUgA==
=12+n
-----END PGP SIGNATURE-----

--5z+Fx5DotXtZSz3Z--
