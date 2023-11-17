Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0BF7EED9D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbjKQIiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjKQIiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:38:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A22F8E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:38:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8D4C433C8;
        Fri, 17 Nov 2023 08:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700210296;
        bh=Zltwp4GsFJ8WfP3ZhXGXiAa9/m0rbEf851izwH8yjO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kMZGno5qrvLEpX6AN9zmd71utBBkwSFFzxkvEDGD5nD1hI/FzwtZeU1edNY9tbH93
         0VSY5MuZpTE4HYrai69U+Ept2rPIUjCpfa2GJ+Up25xQAPmbB+2iTK1Ltr7vwPZE4D
         IP44dPdtg9GBu/FEFbqA/R5ukGAEE7Gi+jiifEGeZF1RADYKNqc8u2hRU9zbPfrubG
         y7MBvOAm6ccBAyMhzeCTzFhhjquV3uKaqe1D0YePTNqo/8Foxydk0IysortH79cBei
         1Lr3MzK79PRPa9EX7/e7G4v4j0MNyXTbgmDd26kLAxveZrzXoJx6wcvAJvIAFTYyHS
         3nJhk4iggSnMA==
Date:   Fri, 17 Nov 2023 09:38:13 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Sahaj Sarup <sahaj.sarup@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/ssd130x: Change "solomon,page-offset" property
 default value
Message-ID: <yqneztpzmhhqenommpvhw2pksjspq7srpeba7ckfia5z3c5aap@wmnxhbgcflnd>
References: <20231116180743.2763021-1-javierm@redhat.com>
 <20231116180743.2763021-3-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ugqcnc4hp5qdpf6v"
Content-Disposition: inline
In-Reply-To: <20231116180743.2763021-3-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ugqcnc4hp5qdpf6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 07:07:39PM +0100, Javier Martinez Canillas wrote:
> This is used to specify the page start address offset of the display RAM.
>=20
> The value is used as offset when setting the page start address with the
> SSD130X_SET_PAGE_RANGE command, and the driver currently sets its value to
> 1 if the property is not present in the Device Tree.
>=20
> But the datasheet mentions that the value on reset for the page start is a
> 0, so it makes more sense to also have 0 as the default value for the page
> offset if the property is not present.

I can see the argument, but that's a DT ABI breaking change.

> In fact, using a default value of 1 leads to the display not working when
> the emulated fbdev is attached to the framebuffer console.

Could we fix that one instead? What is the issue about, exactly

Maxime

--ugqcnc4hp5qdpf6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZVcmawAKCRDj7w1vZxhR
xT0mAQCE0xcyl9bZKj0rvFdl4wB/NEpUf6ubP/8QlEW1O0uNogEA3sQFl+W/EfEi
L21HM4MkPBXDc8MHyzB/8wbCsrnHQQ0=
=T+Yj
-----END PGP SIGNATURE-----

--ugqcnc4hp5qdpf6v--
