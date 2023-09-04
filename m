Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A42A791718
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbjIDMay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIDMax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:30:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936801A7;
        Mon,  4 Sep 2023 05:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 313B2615E2;
        Mon,  4 Sep 2023 12:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEB9C433C8;
        Mon,  4 Sep 2023 12:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693830649;
        bh=RqwxV2g+EMhwDdFUCKxB6yJM/Of18ZC1KHGmZLecgyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rf8Rp8WMghLUrPsZXpPmwO5qAAAmw7r+iOTyexQ3ZrqARtvOP1UwO9Yt/Jso7Z/Re
         icXXJCzdQCIelgTdwT7Nej/MCuJjVNe2EUlyOiffPOH+gv68zj4N6b9YZQS6/kFsAI
         ILjsx5otxrcrKRE94+a4voWYIfjAHID5TmXhQvrQ2nohpr0i0z2Dg6j5YkKgx13jPO
         dkKc+DoXft+NZX05/R8qcfE6Ibcv/ti+FpACkL5fN6FMpAS2lc4K5WewIgRGnx3Az4
         TSY/fJk8UzFgMs0vxmU4N6NJxkvUrxjvTPz8UNXfywRa3hyFVUZZ3pyp0ElXOvyn3/
         dGY1b6/eUViyA==
Date:   Mon, 4 Sep 2023 13:30:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     wangweidong.a@awinic.com, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        herve.codina@bootlin.com, shumingf@realtek.com,
        rdunlap@infradead.org, 13916275206@139.com, ryans.lee@analog.com,
        linus.walleij@linaro.org, ckeepax@opensource.cirrus.com,
        yijiangtao@awinic.com, liweilei@awinic.com, colin.i.king@gmail.com,
        trix@redhat.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangjianming@awinic.com
Subject: Re: [PATCH V1 3/3] ASoC: codecs: Add aw87390 amplifier driver
Message-ID: <598febde-429e-4319-98d4-4306a7f8bfe8@sirena.org.uk>
References: <20230904114621.4457-1-wangweidong.a@awinic.com>
 <20230904114621.4457-4-wangweidong.a@awinic.com>
 <5ea76d3f-c9dd-10f5-4f9a-7b32b535ab5c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+c3Ap+3u5fsANoA"
Content-Disposition: inline
In-Reply-To: <5ea76d3f-c9dd-10f5-4f9a-7b32b535ab5c@linaro.org>
X-Cookie: Immanuel doesn't pun, he Kant.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+c3Ap+3u5fsANoA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 04, 2023 at 02:17:43PM +0200, Krzysztof Kozlowski wrote:
> On 04/09/2023 13:46, wangweidong.a@awinic.com wrote:

> > +	ret = regmap_read(regmap, AW87390_ID_REG, &chip_id);
> > +	if (ret) {
> > +		dev_err(&i2c->dev, "%s read chipid error. ret = %d\n", __func__, ret);
> > +		return ret;
> > +	}

> > +	if (chip_id != AW87390_CHIP_ID) {
> > +		dev_err(&i2c->dev, "unsupported device\n");

> Why? The compatible tells it cannot be anything else.

This is very common good practice, as well as validating communication
with the device it verifies that the device descrbied in the DT is the
one that is actually present in the system.  This might create hassle
down the line if there is a backwards compatible upgrade but that's much
rarer for this class of hardware than cut'n'pasting of device trees.

--x+c3Ap+3u5fsANoA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT1zfEACgkQJNaLcl1U
h9A+8Af9GepgJeENtK4ITVlnoOj/k1G9hqOW1/oZbk1m0bHzN5cGdLzP2fbfXmiJ
sItWYtATMZ6k8Jj3+m+3oN/Zb5LbJFgj2dn545Ta8ErJioNS58furbRG0tkvR4vt
AsJaIUwPRVEQNhPWGVPDp4q6El1mcbsOZgxMvQD5ljIbRugC3OvzVdsin3M/Y/IL
61QrFvP/9bfq5mP3ieLRcg8BkdZZnR4lLWGx6LFjIVedoFZ5aRrritfT/Hw8MLwC
lFpu2yPXej0/WSRc0qcjhoeHm2fxKtYwHJCl61ZfnWUj/iV3ojpFlpeFCfyL92Xk
bdGwVDZjPvpzWApR9AX5FkKvk+vH5w==
=r39d
-----END PGP SIGNATURE-----

--x+c3Ap+3u5fsANoA--
