Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE188089A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442669AbjLGNzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442702AbjLGNz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:55:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1D910F7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:55:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8708EC433C9;
        Thu,  7 Dec 2023 13:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701957330;
        bh=0KrrLtNYr2L6iRo6TQxtDmuTIiNc7jPNPVUjnkZZ2OI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLtWGywFZE7qALmYlEMriM5oRyFuYS8oM860kgCVEDSkhPTY9xV0YjSmrn2nW3EmT
         6qEqD7MQ55czhDHomsXZ5Ga1yRbS7fG9oAr53qnEATXHfeUW97H5VJnx6V7CQgk8Cb
         ttYAkd5k7PtT4oX9A9aDiAyE8auX2tnt4WMBkcn+vhreR3swq0ZulGB3yk5xtP03fg
         F2Ix9otfo7ow3oVet5trJOjDxNDrRX6wA7Vh3l5g8qmpp5zW+YmV06VFPRDpZzVoCW
         2ZLtDKkh+Eqb1NHpeSb6ASWPAhA+FiUCFpm6qLuau/pHiO1Vosv1Cs74I60lcN/+4N
         JFcNQkrLCvJYw==
Date:   Thu, 7 Dec 2023 13:55:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Gergo Koteles <soyer@irl.hu>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 00/16] ALSA: hda/tas2781: Add tas2563 support
Message-ID: <85b7456d-7cf3-4885-8e71-111df53e35fe@sirena.org.uk>
References: <cover.1701906455.git.soyer@irl.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x4mx+umngiD/xm1Q"
Content-Disposition: inline
In-Reply-To: <cover.1701906455.git.soyer@irl.hu>
X-Cookie: Two is company, three is an orgy.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x4mx+umngiD/xm1Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2023 at 01:58:22AM +0100, Gergo Koteles wrote:

> Gergo Koteles (16):
>   ASoC: tas2781: add support for fw version 0x0503
>   ALSA: hda/tas2781: leave hda_component in usable state
>   ASoC: tas2781: disable regmap regcache
>   ALSA: hda/tas2781: handle missing calibration data
>   ALSA: hda/tas2781: fix typos in comment
>   ASoC: tas2781: add ptrs to calibration functions
>   ALSA: hda/tas2781: load_calibration just load
>   ASoC: tas2781: add configurable global_addr
>   ALSA: hda/tas2781: add TAS2563 support for 14ARB7
>   ASoC: tas2781: check negative indexes
>   ASoC: tas2781: use 0 as default prog/conf index
>   ASoC: tas2781: move set_drv_data outside tasdevice_init
>   ALSA: hda/tas2781: remove sound controls in unbind
>   ALSA: hda/tas2781: call cleaner functions only once
>   ALSA: hda/tas2781: reset the amp before component_add
>   ALSA: hda/tas2781: configure the amp after firmware load

Please don't randomly interleave ASoC and ALSA patches like this without
some strong need, it just makes everything harder to manage.

--x4mx+umngiD/xm1Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVxzswACgkQJNaLcl1U
h9AAwgf/S1XgZH7WfZcBLXTVYHiD+Hk9bDC9mmz+SWbgVNkJlWHATgTUwzAZof6f
FW7+hz4+FIhFhDLA+lO3dw9hXfozLQtXbx+jq5E4x9+1AOZuqOVCQfHORpknKrmC
DFa4JEmhF8y2NgK+dLZOzV03e24iceKKyLAVndB+zJ7kp6EzqPL+5hnRGKb6jYBD
GKj/uOGg2p++UNL3Z8Q6bP06w5k3wPiA1l5gXS2NOJVQ7WEW6tFQsVmFjzPvnvFi
WINgsBqRF3oBlaRrc7eVsg85p50hMDt7piwY8lxf64mJHOstQ6yVSXWEM76XwFh9
pnuRa0K/vHizRTDQm6LbYBJcbo7jwA==
=qYy/
-----END PGP SIGNATURE-----

--x4mx+umngiD/xm1Q--
