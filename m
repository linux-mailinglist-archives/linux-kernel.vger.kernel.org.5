Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CD07B36CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjI2P0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjI2P0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:26:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827BD193
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:26:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919EBC433C8;
        Fri, 29 Sep 2023 15:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696001192;
        bh=lDhaMhZT4eROF80/UUA/0Uxbim5qKJVk0kbddzbxy5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EAVdYtcdU7LbMT5mB0H40Y++kEoixqMQmO92aqFWb5/089IhYoVt2GYxEYF3uh9vL
         Q9eK8bRTs1e1NiTLWTG+ElyrswOnyjU9F5Ck2f4CnSli2X6fh4T9AFbxeahccx800M
         bWIl9mPuhQYBX2ad5MhCLLVvucA4vuPs7AN4FaMpLPPA3bo+e4ehpCyYQAcC/mWfoj
         MyKVBpZPwQBdFF1Wvien2+ycV6tzuwTNBRwyePjUVpD9s8RgjJt9suptarx0pKUGpn
         93MaPdMngBav8czmpcmZGkV+pDB3TCxPkidVBf4wi8IbZC9B+s49qZuvSl3JI7cX3Y
         JtCxKw3W4tHGA==
Date:   Fri, 29 Sep 2023 17:26:30 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v5 03/12] ASoC: SOF: Intel: hda: start splitting the probe
Message-ID: <ZRbspls+UDl1g9Kw@finisterre.sirena.org.uk>
References: <20230929145123.233838-1-maarten.lankhorst@linux.intel.com>
 <20230929145123.233838-4-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nNJvjSCekUlNJmUN"
Content-Disposition: inline
In-Reply-To: <20230929145123.233838-4-maarten.lankhorst@linux.intel.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nNJvjSCekUlNJmUN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 04:51:17PM +0200, Maarten Lankhorst wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> This patch moves the initial parts of the probe to the probe_early()
> callback, which provides a much faster decision on whether the SOF
> driver shall deal with a specific platform or yield to other Intel
> drivers.

Acked-by: Mark Brown <broonie@kernel.org>

--nNJvjSCekUlNJmUN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUW7KUACgkQJNaLcl1U
h9Auawf7BMxLdqOC4O+3unPmYXu0UREWcv1GvxY15x+dxyY7G/UbwROjXwNBbQon
eU5Na3quTlz4vosPRD+tl/0JWKxgs1DN0sE2YSCd+wSDD3D6fQ18RP+g5bnBllFr
4FVEZoKmvnC//vVsGVU1odH3iD66vmLVT7RiMkthuAyH0cZ8QGMEk3LVjV4EffCo
G5aAZ0DwOjQ0V3GOMBOE0JIu4kHR4rsYdqiTiUV7S67kYcuWocpq0XaXOQBTcz5v
6kqZlEbmYr+FAw//sd527ZEee1OrkaiATXfmk1QMwAiKolqim9MkVUuipcOwL0Zr
xr52aSvKJ3JWyqVG+9R2yvI4tzzUtQ==
=0WSI
-----END PGP SIGNATURE-----

--nNJvjSCekUlNJmUN--
