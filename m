Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0F776FFD5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjHDL7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHDL7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8181FB1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 04:59:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F5D061FA0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE30C433C8;
        Fri,  4 Aug 2023 11:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691150352;
        bh=Xb2ACTD4PZsn1ysNMGCo4jBgCEijNCm6praOLhXsK6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDQZm+TRy04HDZ8uNjebJcN2VENMYpkSnX0d+51YqR7w8jz4985UwjoVdV3n6EGIU
         2nOLWjq/RdpFbQ7as+VUE+u7wCMSlVYNk41Q8fr4BIDLlnbQ2qvqzKx8HSUapXHqpO
         nD0wrtG0VhKvJEF/HQJCUipmGZRM1rHcKM+JA979fOz43UjYYh8UWdJSRhsdIT2I5P
         7XYNwf0NA4XGnY73NYPL6JDWCT8Gh54rs6V0+tIUxaRFvE9NRXK/X6Dr0bNJ+YWMGd
         JWT0A73zegG0s8EWe6Nzv3NRaG5pm5c38iKuCTvOrdCGZkP+Ba+4lGIrq0ei29u8Lz
         uFuWQiCrF/BLA==
Date:   Fri, 4 Aug 2023 12:59:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: Move binding to display driver outside
 of deferred probe
Message-ID: <383ebe0e-e333-4b6e-8688-98a20977d03c@sirena.org.uk>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
 <87r0oohyea.wl-tiwai@suse.de>
 <ec653abc-f2f8-8a9d-4b8a-ea9d985d32fe@linux.intel.com>
 <f6efb6f9-11ae-e901-f2a5-a4ef94590290@linux.intel.com>
 <2719a8fc-d2e5-f499-ac4d-cf322941526c@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4UO/14p9t2UJznza"
Content-Disposition: inline
In-Reply-To: <2719a8fc-d2e5-f499-ac4d-cf322941526c@linux.intel.com>
X-Cookie: I'm hungry, time to eat lunch.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4UO/14p9t2UJznza
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 04, 2023 at 12:47:54PM +0200, Maarten Lankhorst wrote:
> On 2023-08-01 18:32, Pierre-Louis Bossart wrote:

> This mail can be applied with git am -c.
> ------8<---------
> Now that we can use -EPROBE_DEFER, it's no longer required to spin off

Don't do this, it breaks my automation and means I very nearly just
skipped the patch entirely since it looked like the middle of some x86
discussion.

--4UO/14p9t2UJznza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTM6AkACgkQJNaLcl1U
h9AqsQf+P7GCoI7e9morAkeZoiDSbe8h47xmQIVwTLiIN3rMew8BRFPZ2jo7lwy1
SV4utapq9mZxzxFZgt+wLIzEYMwgT3u5BSiG6yeSkL0UMsZxdoFYtJLNuzr03zr4
icc85FHHQ1LEb961n6oFYf2JSz3KuoLh+wjJFWSUwLwPoCeRWAY5K4UaASKxdwpi
SSZ+0lT4JGgGRsUVwRk29G9Kgp6gfqpjTb/I3npLyYSPz/u/ZgEwxi3KPLTvGYns
pQvWGRrUUCvWkQx6W4hEyMR7gPP3VJTeFR0gGIhkvS6H181WiJlJ2YCUaDh04SyW
QKVR5armzOrvQiImy2akR2HGaZ1GQQ==
=fpv4
-----END PGP SIGNATURE-----

--4UO/14p9t2UJznza--
