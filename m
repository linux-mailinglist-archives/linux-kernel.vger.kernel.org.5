Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA10A8035A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344816AbjLDNzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjLDNzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:55:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A21F2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:55:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6150DC433C7;
        Mon,  4 Dec 2023 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701698141;
        bh=oZ4b/iYgBreW9QtS2G2hGTtITqzJeRENjPM1x97+Vlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gRvc2Y2qS3N6yjKe7vlP3L5yLr2po7eVpY7e0mGpMce6s3ccULglLpzsbM4ikcX+5
         RhzZMsZ/AtwogdLxGXl6J0t3Bg+vwanoqyi5eX9A9KsG4+HtLlaNabL1JhBrA5eG72
         G4MVPFVTt9p16cX+p7pvu6G+57USSTk/0iHHaDvk7D9Ot0RJ/MLpdBrL8Y47EY7HhW
         gNZFELgRjwPjAkomdLOqwfPTQbC/RaLRQRU2PMvhFERzJeTt2zXCUwuhc7BIQtWCFH
         ms7a8CmF2udTmjb1MjLglzhNgGWxhIG4Ftbbr/IQLazpVzXxfLL+bPxEBLyrBV8R1N
         2/wQvm6+6GsXA==
Date:   Mon, 4 Dec 2023 14:55:39 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Donald Robson <donald.robson@imgtec.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        frank.binns@imgtec.com, matt.coster@imgtec.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] drm/imagination: Removed unused functions in
 pvr_fw_trace
Message-ID: <7rwnnzsh6mlfnp5nqsxlehtc7siznebppixap7lh56kkr274jo@wtilprrqiuw4>
References: <20231204133611.53913-1-donald.robson@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ywz7mwoosg3s7mrw"
Content-Disposition: inline
In-Reply-To: <20231204133611.53913-1-donald.robson@imgtec.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ywz7mwoosg3s7mrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 04, 2023 at 01:36:11PM +0000, Donald Robson wrote:
> Fixing the warning below due to an unused file level vtable. Removing
> only this causes additional warnings for the now unused functions, so
> I've removed those too.
>=20
> >> drivers/gpu/drm/imagination/pvr_fw_trace.c:205:37: warning: 'pvr_fw_tr=
ace_group_mask_fops' defined but not used [-Wunused-const-variable=3D]
>      205 | static const struct file_operations pvr_fw_trace_group_mask_fo=
ps =3D {
>          |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311302054.MVYPxFCE-lkp@i=
ntel.com/
> Fixes: c98cc92ab6ce ("drm/imagination: Add firmware trace to debugfs")

That commit doesn't exist (upstream).

You made that mistake on the 5 patches you sent last week too but I
forgot to tell you about it. Are you working from a private branch?

Maxime

--ywz7mwoosg3s7mrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZW3aVgAKCRDj7w1vZxhR
xSPgAP9erofg/RVkKD6Ziz2dMHCcsc0gXGrd4hdAvP82eS74UwEA373CvQO6UY9S
Ckpcx+NprA48bphjtNrUQ2gzOIhevwI=
=wEwQ
-----END PGP SIGNATURE-----

--ywz7mwoosg3s7mrw--
