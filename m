Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C0C7B36C3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjI2P0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjI2PZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:25:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0F3D6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:25:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77470C433C8;
        Fri, 29 Sep 2023 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696001153;
        bh=1uWI/HKeZ39XlHxXsGDtE/NQKB9oNAo507xTe7RoeW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XFflkkDAZYLohwshQUtjacZij6ttS0tiDi8W1TSZrN1UM6L7Vu5llaD2SEbkyRpwQ
         UjTgfCmhe5c4L4NZQz0GlPNCtL9E4jqBFT2hP/RPxg61jqdUDLEvbexoVyNkiEwgFG
         YrOmvXnFt0S73Xn8v+mI++Cx0ysrPLxJnmzlsgarF/dVKygbq3PlrF0vh4cbimVtGI
         n5aGDoEee1CrgH7iFYpn8biAxEYtCAaK1eZVQ/mMfUX7dw4fAT3aANHejP88H3OJyR
         An+tLLXI8s0O1BCM8/9CWNUwBfx+TbumiXIvQJe2MqfUtNyivI1RtgNFcBnOwktX9i
         34wNiBP0gCy0A==
Date:   Fri, 29 Sep 2023 17:25:51 +0200
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
Subject: Re: [PATCH v5 01/12] ASoC/SOF/core: Ensure sof_ops_free() is still
 called when probe never ran.
Message-ID: <ZRbsf9yD8r11F6DL@finisterre.sirena.org.uk>
References: <20230929145123.233838-1-maarten.lankhorst@linux.intel.com>
 <20230929145123.233838-2-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qd9T3iGoAIV0YcIs"
Content-Disposition: inline
In-Reply-To: <20230929145123.233838-2-maarten.lankhorst@linux.intel.com>
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


--Qd9T3iGoAIV0YcIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 29, 2023 at 04:51:15PM +0200, Maarten Lankhorst wrote:
> In an effort to not call sof_ops_free twice, we stopped running it when
> probe was aborted.

Acked-by: Mark Brown <broonie@kernel.org>

--Qd9T3iGoAIV0YcIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUW7H4ACgkQJNaLcl1U
h9Bp1gf/Z3D4fi2MOszGZL6o2HGo6TgiB/VbRfXvFFZJa+hjx+pvBTId1ioluOpm
LToU1SpkiRTLWRjA8fxxzRwJmGQhBQJyuo4cbAlcm4pwZ6lV0phxm+W1MmZKXKAz
1NrTwefwGj68txXO5JdDW+w7XF1l1ddazN5zWLBl/kiGKLE5RoIEIVMfR8CARFY9
jfyR6igGzW8Ob7zPkJRXPi69xpqJmWZoCwed2KdB4q2OPq5chJ7tMp9iVe2Cd4tl
YdQP3XLtkmtkX4YBzvcwbOC9yqmZ3mdLHQIIe+WO+sBZtWO6bh88YWpgvQtZVZ8m
FFW4k+PPpS/debehX60OETjxneOlqQ==
=S0Jb
-----END PGP SIGNATURE-----

--Qd9T3iGoAIV0YcIs--
