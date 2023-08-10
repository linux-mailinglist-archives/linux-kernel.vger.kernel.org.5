Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9585B77727E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjHJINc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjHJINb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCF5ED;
        Thu, 10 Aug 2023 01:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE570652FB;
        Thu, 10 Aug 2023 08:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83019C433D9;
        Thu, 10 Aug 2023 08:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691655210;
        bh=gXVZ68cdpgp0Oc06O+iDMDHFl7uPsJSDhRHvYoDqwWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bSQJ3MDGIPvJ0HMdmJojPNOITtyTnIaObs3s8neo3b0T4ZqDx67kFFQVnWaIlvSq0
         XbT2KMjZ4kRCPECjY9wzhAZIaEpnY8sOrR6YoMMkBhomarPH2yUscPuKDgMwVXygvL
         931+QUJn8LtveKV+Uc+R4qqJYghlHkz7D5jRSTwBFNp5MlKKPGF92rAFNid/YCWjt5
         wdoO/S0kBgRa9gvVkt8X79r5m0kQBttlpf/RvPowbcQWJMqkxTWaUIF7ln+O7O75gx
         +/Z3QFtPJJd7fJuxGaoYpZUxAebuqPOXjPYpPpP2zE6JtAnsUtzsJNw2q7VYEwiMAs
         Rw5p2OsG22CmA==
Date:   Thu, 10 Aug 2023 10:13:26 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Emma Anholt <emma@anholt.net>, Helge Deller <deller@gmx.de>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] video/hdmi: convert *_infoframe_init() functions to void
Message-ID: <ibwl2bpz5bs72co4ivkvjcc35lv5mqyuvj2hbr3p54hliujklm@uje662ldqfdw>
References: <20230808180245.7474-1-n.zhandarovich@fintech.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="syn7hsjtm3zubtz2"
Content-Disposition: inline
In-Reply-To: <20230808180245.7474-1-n.zhandarovich@fintech.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--syn7hsjtm3zubtz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 08, 2023 at 11:02:45AM -0700, Nikita Zhandarovich wrote:
> Four hdmi_*_infoframe_init() functions that initialize different
> types of hdmi infoframes only return the default 0 value, contrary to
> their descriptions. Yet these functions are still unnecessarily checked
> against possible errors in case of failure.
>=20
> Remove redundant error checks in calls to following functions:
> - hdmi_spd_infoframe_init
> - hdmi_audio_infoframe_init
> - hdmi_vendor_infoframe_init
> - hdmi_drm_infoframe_init
> Also, convert these functions to 'void' and fix their descriptions.

I'm not sure what value it actually adds. None of them return any
errors, but very well might if we started to be a bit serious about it.

Since the error handling is already there, then I'd rather leave it
there.

> Fixes: 2c676f378edb ("[media] hdmi: added unpack and logging functions fo=
r InfoFrames")

I'm confused about that part. What does it fix exactly?

Maxime

--syn7hsjtm3zubtz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZNScJgAKCRDj7w1vZxhR
xSWxAPkBKpcYa8fvgV9S3h2fxehetHD5UXS8LuBJb/F6EtKr5QEA1tv3DgElGqJD
Vd+9ES535Sb39MjXfvkcbNMyPRxsjQU=
=6V+A
-----END PGP SIGNATURE-----

--syn7hsjtm3zubtz2--
