Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B947FBB92
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345378AbjK1N3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344875AbjK1N3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:29:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785EBA0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:29:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68D8C433C9;
        Tue, 28 Nov 2023 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701178183;
        bh=eegc62CSFJSGMpwmfbQ9cieR8ro9QUfxI2Hecr1t0d0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jq7O6PHR6YExx9eupodBnBU26Udoi6FMtcX3bU0B51+pFSeHpJij8cLvwfre2NU9r
         hlU8qmy3P9IKCI32NGfGoni/pILrS/N0Cck3Tw7ijrhJCX1Sf7O7oU2BFFkwWdJZNR
         iiQeyGhKbsamyvQTl7kyEyLKkq+N2PPHIolJ5kOfAAHS1dm/aR6mTJirWaZ/FWN7tf
         0D1yIWE/TUPh7NQQ1aZp2qlVgarhL3nEIZNzaQVa5OpJCI47SJqKml4TEp3yPS9Ti8
         JMc/ozLQGq95jIAU9G6MmFGXMRLW2Otb9xTDH8Yas6bpLF9Wg1eT7bbYXmlO/TiwG2
         JdNpUHuh7JNOg==
Date:   Tue, 28 Nov 2023 14:29:40 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 05/45] drm/connector: Check drm_connector_init
 pointers arguments
Message-ID: <v3hplco5fdedv6bnc6mwx2zhhw4xxdiekha26ykhc5cmy7ol77@2irk3w4hmabw>
References: <20231128-kms-hdmi-connector-state-v4-0-c7602158306e@kernel.org>
 <20231128-kms-hdmi-connector-state-v4-5-c7602158306e@kernel.org>
 <87h6l66nth.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ncmpulkgjsh2p7e6"
Content-Disposition: inline
In-Reply-To: <87h6l66nth.fsf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ncmpulkgjsh2p7e6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jani,

On Tue, Nov 28, 2023 at 02:54:02PM +0200, Jani Nikula wrote:
> On Tue, 28 Nov 2023, Maxime Ripard <mripard@kernel.org> wrote:
> > All the drm_connector_init variants take at least a pointer to the
> > device, connector and hooks implementation.
> >
> > However, none of them check their value before dereferencing those
> > pointers which can lead to a NULL-pointer dereference if the author
> > isn't careful.
>=20
> Arguably oopsing on the spot is preferrable when this can't be caused by
> user input. It's always a mistake that should be caught early during
> development.
>=20
> Not everyone checks the return value of drm_connector_init and friends,
> so those cases will lead to more mysterious bugs later. And probably
> oopses as well.

So maybe we can do both then, with something like

if (WARN_ON(!dev))
   return -EINVAL

if (drm_WARN_ON(dev, !connector || !funcs))
   return -EINVAL;

I'd still like to check for this, so we can have proper testing, and we
already check for those pointers in some places (like funcs in
drm_connector_init), so if we don't cover everything we're inconsistent.

Maxime

--ncmpulkgjsh2p7e6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWXrRAAKCRDj7w1vZxhR
xTyXAP0W+h2/0xLXXBJVtoNPSJ+MdMt1B3qXNmsRScATV36j3QD+JmPDNBt3syJA
33NzAAvtBetz/KSX6B52Yckf1U8lwwU=
=KHiZ
-----END PGP SIGNATURE-----

--ncmpulkgjsh2p7e6--
