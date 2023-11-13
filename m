Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369157EA256
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjKMRuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMRt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:49:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D849110E5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:49:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4991AC433C7;
        Mon, 13 Nov 2023 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699897796;
        bh=OlVdpAafS+/TnL2gNZWocfkiT+WXch7O/Gj4jH3CWTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIjkaZQjXatW09ZeXbTIPo+q5RrNWjCsOk0HG3uQ9jZx/Jj/JwWg8masZL8QKT0ZZ
         WQhSyQhVc2mhkpHTByG3kY/lTylyhO+Jz5Xe32ZS4JAfPZ3uZEtnt2UfkpAMfVaYra
         Z3MLkka6LfZyMsAw09xuTPN7X38dJDuZgUxM5ddajimSmVXShqJDnkUemjsy82m6XW
         kfYKsF2y/34lhawChlHd8v7/XDDz13zS5JPzIQ0wGWvUiEcJxhx8/E8P39xxN3f2nj
         yON8dcggobGU7B0jvYDgW8cWNd2lF2xwMBQwNELv/PcH6ryjBoTuxjmxRgM7bnhZrW
         B1cIyTJrNKMmw==
Date:   Mon, 13 Nov 2023 12:49:53 -0500
From:   Wolfram Sang <wsa@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-i2c@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-fbdev@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        linux-sunxi@lists.linux.dev, linux-mediatek@lists.infradead.org,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        John Stultz <jstultz@google.com>
Subject: Re: [PATCH 00/20] remove I2C_CLASS_DDC support
Message-ID: <ZVJhwSS16+/Zzt0f@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-i2c@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-fbdev@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jocelyn Falempe <jfalempe@redhat.com>, linux-sunxi@lists.linux.dev,
        linux-mediatek@lists.infradead.org, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        John Stultz <jstultz@google.com>
References: <20231113112344.719-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zxnb7iIcQAl5ewYC"
Content-Disposition: inline
In-Reply-To: <20231113112344.719-1-hkallweit1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zxnb7iIcQAl5ewYC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Preferably this series should be applied via the i2c tree.

Are we in a hurry here, i.e. does it block further development of the
i801 smbus driver? My gut feeling says the patches should rather go via
drm and fbdev trees, but I may be convinced otherwise.


--Zxnb7iIcQAl5ewYC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmVSYcEACgkQFA3kzBSg
KbZH2w//eUnZg+R48cg2NHPwlDqb/Y0KJdo6xOk9tXkaIu+sNP9+GauuCw1EMTe3
AIDZoh7pkBamF2ZsoBRIOQOkzRpNj4bN+2L9mbd8SrPSpxaRa8jU3E1prJ7+/NS0
FJUPmwO6XA9JCOmTtkNvivsp16QjSQfVE+UjbBT0qH0+lKo6RQ9PDbwtIdkmzVOZ
vGvEqYzOpUB9UkUekEYESgJ/SCbm2lm397qC+d79JXapjDjD8AZliufTjd/jiOCG
MTVbm6mw9CPGThQsyNd9bjUbaNnqyoz3D0SjxKUG3NPlEYy9uigCj853+J56xO27
JjENHBt0RFz/oPHWpKko6kfMaDCS7m/aNnETGRuZ4fHBb6rviz/3EGLWYc0HoRds
6kw7kmMfmh4T0ZMERMDnRsgRiLHzueUujA9Uhh972jiX62CCaWuSjQm/s6lXpAzC
TT+UETbrdSSX6IJN5eP4E9Rg6ouyKxWGT1N+B4/NPMEjPUfzMFQQgna0ph8aHNcd
JEI9d/HAUvjvf8tQwo2+1UajwmmX1Yf/C905CT+IGqOLF21LsX7B0zoXELDRsPMD
ISj6RpuOXI0jhWV6YPlFTA8pFvqvG+lFfpP6kW1VEkYnXMwSbp+K8aN9bcYITWeH
4OB/vXxnxxEtQ8CgH6yC+jwJWW6jd7KllJQjmD5qi+F4xxOCzwY=
=fxbp
-----END PGP SIGNATURE-----

--Zxnb7iIcQAl5ewYC--
