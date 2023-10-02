Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582557B5655
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbjJBPIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbjJBPII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:08:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9784783;
        Mon,  2 Oct 2023 08:08:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED2AC433C7;
        Mon,  2 Oct 2023 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696259284;
        bh=J+OwmH7fnLd3FjX0c5iBU4C0cZpYv0irsXmd/Nc8juo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=atF4iQwivM2vmRHpHXqaQtNheefwRwC5MjGvX2c4mKcZwXwQvKGjY2e6hq8f8EVKj
         0kStVfFoD8spZca0Kuo+IP28Cyj93OQ6KkOBjhTuBY0euutoi+jq2ZuwBhJ1Yye73X
         SKAwqtIKHBgSW30WTST2zMd97Ix1lNTdBTqrUIv5rNMyLMo8Oszwlh3J5mePVyppfU
         oT+gB8D+YpHaPxu+oEoJW/nTGLgR5Noi1z+Lflc0O1EO/zFSU4MKmAB5xP6p46hMh6
         BO1V0QHJbtc3u91m60YTKhfJGBYbwP7ycVh25X3WDUb94drOOkHqa29unh+etrWD47
         +8ktmKV608gCw==
Date:   Mon, 2 Oct 2023 16:07:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v5 01/11] ASoC: fsl_asrc: define functions for memory
 to memory usage
Message-ID: <7af54654-d4d5-498e-bd53-78ad54e6d818@sirena.org.uk>
References: <1695891619-32393-1-git-send-email-shengjiu.wang@nxp.com>
 <1695891619-32393-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KuYuv5Y+mxgMeyVy"
Content-Disposition: inline
In-Reply-To: <1695891619-32393-2-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Postage will be paid by addressee.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KuYuv5Y+mxgMeyVy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 28, 2023 at 05:00:09PM +0800, Shengjiu Wang wrote:

> m2m_start_part_one: first part of the start steps
> m2m_start_part_two: second part of the start steps
> m2m_stop_part_one: first part of stop steps
> m2m_stop_part_two: second part of stop steps, optional

The part_one/two naming isn't amazing here.  Looking at the rest of the
code it looks like this is a prepare/trigger type distinction where the
first part is configuring things prior to DMA setup and the second part
is actually starting the transfer.  Perhaps _config()/_start() instead?

--KuYuv5Y+mxgMeyVy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUa3MwACgkQJNaLcl1U
h9CpqAf+LBBYky8048zO16jau031dm9xveIOz9PkuENbvo2Uh2rQKQMPbnuhWDLH
h27vidoat8VGo5MFaqpCAKpJA+PReOLkzI4sk71WcW3RaNJ5MofIQO3E5ZIXanKo
ZqsjDFWImiT68/LPs/u7jjgl801Z3IgQ1ozVJgM0NyZr7w/mu603A8gnbenRNZyA
JLcybnLQ0CGi9P23UKjCLBJx4dZpvFgm6K31K175IcDnx+cOn5CBEyHe9nyhEI/S
iXFtO85ddjkuxyepQMqlED8ipo5sSZLgrHHGpTB13DmY08jDnFSQQH9czc/mLNty
KoKv69c+UgkKI6BSQ0hue4iiY/oIOg==
=Cq0X
-----END PGP SIGNATURE-----

--KuYuv5Y+mxgMeyVy--
