Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC289757F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjGROMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjGROMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:12:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5B2186
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2383C615AC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2250C433C8;
        Tue, 18 Jul 2023 14:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689689557;
        bh=ItUq2wJPk7Akcakns/n+ij2jxWHUnqGkiyYIs9KHoLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLNQK+lS1sNg/+kSy5JJGKrcpuI7mTkFj/EihBUQ7Ev/u7ZgrkWv56uFCDoei/reY
         Dyo3YnJ7GTKWqNnF5I7YdF1KxK75qJorR/Ohobbh7aR51hopT8+HzMPUoIyxSESTGD
         CiQV2jxDeIwh+JFUDQ5Cxf1hVc/JnyCZFxO++YuJcdj+Ql/SebnCpERJTf/tPmN9zZ
         jVxODuUp+KJ5XxfbNbjRUb8iL5i8JnHh8rvWj6VdiCHm1TY4GfAE+bLlc8Yvssdhew
         /Pv0XBHaxSdVEu3jcFCtqROLxHgkIak7OeRA8KDpQ54CySdtREBIwuR+HebFdfvQwA
         82ui3K7zMm+5g==
Date:   Tue, 18 Jul 2023 15:12:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 4/7] ASoC: Intel: Skylake: Move snd_hdac_i915_init to
 before probe_work.
Message-ID: <a240adcc-5677-47d1-a2d0-97a6ddf3c274@sirena.org.uk>
References: <20230718084522.116952-1-maarten.lankhorst@linux.intel.com>
 <20230718084522.116952-5-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JHLFpblRHBWMJVrT"
Content-Disposition: inline
In-Reply-To: <20230718084522.116952-5-maarten.lankhorst@linux.intel.com>
X-Cookie: Nothing happens.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JHLFpblRHBWMJVrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2023 at 10:45:19AM +0200, Maarten Lankhorst wrote:
> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
> the snd_hdac_i915_init into a workqueue. It's likely the whole workqueue
> can be destroyed, but I don't have the means to test this.

Acked-by: Mark Brown <broonie@kernel.org>

--JHLFpblRHBWMJVrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS2nc4ACgkQJNaLcl1U
h9DtFQf/Y0/WSyV0O60ASj8M/EcrXlSr1taBqtfT4vGV0rza+nJrvCXa9j5TQeeo
psGjl3xB53ggRY1m6fqAGiuhCxSBg/n3EgKq2Oj2U9NIao+JOJvN89d/1c4eLStR
oAmuFgRat5PX76xi1h7EeWcz73gjLNt3DTuPCMUqPHxsHrvcoCHoLepL9wG1aLRf
GK/tJ+jfVu3RdLOZ2vjFMm6tegsU/26n7o9KtRPQ31XejBRYVIyaLeK5+k/KEUg6
ITfLDlXhYnH1XpllbzTgNjn8zHLuoZYsPeJ8K3ht+V2durjPE6aM6rxUO7G8j+s8
zghKJSYRgJjoEX9nARrf7eiPEAPPYg==
=tUzJ
-----END PGP SIGNATURE-----

--JHLFpblRHBWMJVrT--
