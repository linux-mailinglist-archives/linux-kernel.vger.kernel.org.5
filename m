Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439927A9993
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjIUSQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjIUSPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:15:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED6884F32;
        Thu, 21 Sep 2023 10:37:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B98BC4AF7A;
        Thu, 21 Sep 2023 11:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695296759;
        bh=B5xFlRjZSUa0fGEwETgAARr7jSAUY2bfCZxgYOjYkAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdyOD5QZ6UTXYGX7KA1Tj9gVp/Qwr1N6OPc0v9/f7gTBIi/oJUq1uO1u9GnXQfasv
         rSThNQBU9ikPIcgzLz5GRis/Gb8qmVipZ4QJV0mCKbpOp+KoAYQ6ye8IKvmm5L0mVN
         Y5r4Zy2sdCI8+QWdLtl3D4sMxIM7ho7JtpVId9wgwlaWI90Bu59LBINbbdtvAA+uGE
         w39DocBGiNpFtJeAXtezq5k4cXbvnG5iZfhGHf8dmad33eY2LonBfYexXHwxSzsbTc
         ODcqFVJAsAqf542oSYL0n3rCmdonR++9lTxeu2ACrLyRFJIw7gB+0l75zdJKkqR730
         JlNnhpWZjfmlA==
Date:   Thu, 21 Sep 2023 12:45:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v4 09/11] media: uapi: Add
 V4L2_CID_USER_IMX_ASRC_RATIO_MOD control
Message-ID: <f5743550-89a1-48b4-a8a6-f66fd246a02c@sirena.org.uk>
References: <1695202370-24678-1-git-send-email-shengjiu.wang@nxp.com>
 <1695202370-24678-10-git-send-email-shengjiu.wang@nxp.com>
 <fbedcbf1-d925-47d6-b9fb-c9e15263c117@xs4all.nl>
 <CAA+D8APyNGFSry1GUv6TOW0nKYHKSwQd5bTcRNuT7cu0Xf8eUA@mail.gmail.com>
 <5292ce53-643e-44f0-b2cc-cb66efee9712@xs4all.nl>
 <CAA+D8AMZN59uTRs2sOrSeVb5AGopTzurNVCTNwJOVPahfEXd+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VZPV3UQ+Ok/rD6bG"
Content-Disposition: inline
In-Reply-To: <CAA+D8AMZN59uTRs2sOrSeVb5AGopTzurNVCTNwJOVPahfEXd+w@mail.gmail.com>
X-Cookie: Caution: Keep out of reach of children.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VZPV3UQ+Ok/rD6bG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 21, 2023 at 07:13:14PM +0800, Shengjiu Wang wrote:

> Ratio modification on i.MX is to modify the configured ratio.
> For example, the input rate is 44.1kHz,  output rate is 48kHz,
> configured ratio = 441/480,   the ratio modification is to modify
> the fractional part of (441/480) with small steps.  because the
> input clock or output clock has drift in the real hardware.
> The ratio modification is signed value, it is added to configured
> ratio.

It does sound like something other vendors are likely to have to provide
a mechanism to compensate for clock inaccuracies.

--VZPV3UQ+Ok/rD6bG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUMLO8ACgkQJNaLcl1U
h9BsbAf9FFU/jXmFMuDrv5AHXagBE2ZnPpLBCFyq5o9+5iHStRpg6JjatAWgBYz6
jSQEHHIrxzJXJERSR6ZRV0pZu6xHQJgWxH3wzCBgIv9xwxRVKaBgJ9/qAfHIhq3r
VlDRzT6xqXstBSc0AC8vZPVcimz2QNMQSf81b66DFlAS96pzIYtUvR6Hj7zXYSRg
YcJSBjoPYvhB9vnst4d/+sEB53MTq5+gqAkjsB2nYHkDAcRTBUf6BVTD/NFtGk0K
04YzjgyoI4OW05wj1RcNk5AnFI8C519Qyaf+mLrJTIjZx4Y/v3wvw5N9h1tLc+0r
AjoZOgf+eL5qYEbRF1M4VyBn2rgwOQ==
=3xkU
-----END PGP SIGNATURE-----

--VZPV3UQ+Ok/rD6bG--
