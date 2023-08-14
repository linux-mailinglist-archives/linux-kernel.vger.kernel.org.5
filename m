Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7A077B963
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHNNHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjHNNGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8038FE5F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 174D16225E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02580C433C7;
        Mon, 14 Aug 2023 13:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692018392;
        bh=4DceL9KcHwWQ+Cgmj5RYuHHEBdgdMe9pj2q7texqDIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TITz5O/3gIKn5GUU3om6d4hipptoJo9YS0ebS1rOaIJBI7XZKnxYY3k1d5abuJoRn
         WILPfL9Wka9Ir1ohTb5vgdOsWXzZicfvz84jYLbNurywPIwusswHbkx1BS01rtJXNV
         JITK09jY8uMyjbztdsZlYvuibLfx6QHLLI/FiT+4f6lOvlfPOheLWXR3mGfW4ge3H3
         lwB9qpniN6g2DVzVEsW2TyyUGMrasGy53V535bCDkHprpV1LjFh8nJ2d5IdLQdUJKE
         W5LiGvSuEh9TN8E/9lJtlEZ9bEnEi03oroJLJzUfoS3RH3BI2xO2ycB4w0F5AeXwvz
         nrGiQwoxNwyhg==
Date:   Mon, 14 Aug 2023 14:06:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>
Subject: Re: [PATCH 20/25] ASoC: qcom: Convert to generic PCM copy ops
Message-ID: <c7fbc486-8e3d-46f9-88f2-e15f35e66149@sirena.org.uk>
References: <20230814115523.15279-1-tiwai@suse.de>
 <20230814115523.15279-21-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vxNJttPmjSY0Llhd"
Content-Disposition: inline
In-Reply-To: <20230814115523.15279-21-tiwai@suse.de>
X-Cookie: FACILITY REJECTED 100044200000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vxNJttPmjSY0Llhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 01:55:18PM +0200, Takashi Iwai wrote:
> This patch converts the qcom lpass driver code to use the new unified
> PCM copy callback.  It's a straightforward conversion from *_user() to
> *_iter() variants.
>=20
> Note that copy_from/to_iter() returns the copied bytes, hence the
> error condition is inverted from copy_from/to_user().

Reviewed-by: Mark Brown <broonie@kernel.org>

--vxNJttPmjSY0Llhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTaJtMACgkQJNaLcl1U
h9BaHAf8CmSE+u2aE3htHE9hbFad/tLmWLTNyST1EuzVnzF2gCUsGbMbEFxSUvqn
YmKboT1SXtQRr+tvSAmb+CCHgMN/krVgb57xi6wC8uI8SlVa7Hld99Ki14ugHtGk
PdQ3qSCEUNSSMOSKDzMu6hdUiE3gISeeBn/z4BY28qcGNtGGfXJFig1Zq5HJaXnn
jN9QZAHEVsg/vHof8nYY9p0a7FdxNBlN39l1gM/0lm+rNgY+dqSXbeh4mMv5MLjj
RGocfUX+hD8gO9OcqmpOcs8gk0ImWk+COWd/1Td4+AvZOMd82tptu615whIADpV6
fhQyTz/bYwb+YTSEoR2b316L4Y/n5w==
=Xez9
-----END PGP SIGNATURE-----

--vxNJttPmjSY0Llhd--
