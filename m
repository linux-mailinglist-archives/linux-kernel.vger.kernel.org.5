Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F84D808FDF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443707AbjLGSWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443502AbjLGSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:22:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B7210E3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:22:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24EDC433C7;
        Thu,  7 Dec 2023 18:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701973371;
        bh=71yycJKM75YE1bqFGWW8tRJ+zrRLK/bB6hrE1EEMaSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YfYVJ7HtKN3CT+yZ1ou5EejSsGyaxytgoFz9Uvy/w3bgWZhpeM1m6p3ST0iqcT05b
         NVojFMwGAPymppmUXYtRLUJ4lUVtQbbSp+Ad2xvUckusKVMq8dR4e54iVSAm1GwcOe
         jYcFFI1fCsWaGYRTD6CyYySXzm107k2q8eKRUCFqIe/FLdH48YDfCXZTLmlhQwmWsZ
         Feb7w1i3O17ZlIe0eiNuQ9QaMX/9qqsp0X3kzAbtZ36dBpBEubM7pcMRFe0492ZN6b
         YINf5aDzTV8l+7Jq2zFgOhBt9mGberdyulL31QEFz/dNenO9Il1lBC4j99VXNbAMcR
         iS0KMKFcY9xGw==
Date:   Thu, 7 Dec 2023 18:22:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Gergo Koteles <soyer@irl.hu>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 06/16] ASoC: tas2781: add ptrs to calibration functions
Message-ID: <132426d1-5fb3-429e-918a-d1ef4be8ed01@sirena.org.uk>
References: <cover.1701906455.git.soyer@irl.hu>
 <e069d578aebb8d5aa1c09abae2a0f240b3dedec2.1701906455.git.soyer@irl.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GMlZJ3xZGxdkGdNv"
Content-Disposition: inline
In-Reply-To: <e069d578aebb8d5aa1c09abae2a0f240b3dedec2.1701906455.git.soyer@irl.hu>
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


--GMlZJ3xZGxdkGdNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 12:59:47AM +0100, Gergo Koteles wrote:

> rename save_calibration to load_calibration

The subject line said we were adding pointers, the commit message says
something different and neither explains why we're making these changes.
This should probably be multiple patches, the pointer refactoring split
=66rom the renames and all explained somehow.

--GMlZJ3xZGxdkGdNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVyDXYACgkQJNaLcl1U
h9BZbAf+P8uiL3Rt6a5np0U1FE6lGtiCIZAy0rAvjenAI32eT0G0ratW7Rhw322N
4fDD/kPd02x0VSgUR+1PY9tP02Y1HBq+a+gczmeK9/C5B18Do4o/d2OjE3GLiwIp
6aaEkBSGq8danMg1DVto/L2+mcWose7r65aU5ydXB+JTOZruehwFQ6JpaXLGDf8j
26FhrRaV2yhn/ZgEuTaVNvBecbwTEVYyzZZ23yytgr0IB5IeR8dn+lSxjd1CD/kh
N4Nr/FKJk8UGl+4dO+2zbujF9UeywmeGNc3AGbT2a8MglESfX5Ucfvyu+Iq1MWyf
MjMd1RCcDTWM+aUsxKoqiJBivx8Yzg==
=3s/F
-----END PGP SIGNATURE-----

--GMlZJ3xZGxdkGdNv--
