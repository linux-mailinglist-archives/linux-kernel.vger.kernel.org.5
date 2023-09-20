Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DB67A72F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjITGkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjITGkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:40:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9BC6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:40:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C861C433C8;
        Wed, 20 Sep 2023 06:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695192007;
        bh=QdaDxHqtaLe5D46ildkhpzTfwiTKFpwZhONBdF/TK6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5JO5kgUzBwgM05BbJKjzFQR8qujZId9X07ee8gaGO31S94UsnScc4SjSS+A2zxSn
         OTPPxZDf3KfCmO9F11loIBC55dPi0OemVkXWgx0sxa/Qw5mrDGqeoTj7gP4gUi7Nrk
         IX8gPMReKBaijl7zyx6XQBVYVLIzuXPzxi6ty9YQsY7cqoMC9MpM3vgYoki3VFVmW3
         SGzKtNtBZdFP6doszSXPk/oQ+JRvYF4jzE9oFBrQ5VX0BiGXZtkqGRaWS8kPAS4/ii
         08aPlv8oDvsrsGZ89C0yCky2CUi5mHrYQGUVe5LecpI+yHTKYFWzchybVbuhIAnMj+
         M6qN6Pi59fmwg==
Date:   Wed, 20 Sep 2023 08:40:04 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Arthur Grillo <arthurgrillo@riseup.net>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, tales.aparecida@gmail.com,
        andrealmeid@riseup.net, mairacanal@riseup.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH 3/3] drm/tests: Fix a use-after-free bug in
 __drm_kunit_helper_alloc_drm_device()
Message-ID: <66zj2spgswo2adyhh2xbcefimggiyci2whxjhsygdistyyqvob@rot736yxggcw>
References: <20230920-kunit-kasan-fixes-v1-0-1a0fc261832d@riseup.net>
 <20230920-kunit-kasan-fixes-v1-3-1a0fc261832d@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q75l2sqotzpskg3l"
Content-Disposition: inline
In-Reply-To: <20230920-kunit-kasan-fixes-v1-3-1a0fc261832d@riseup.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q75l2sqotzpskg3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Sep 20, 2023 at 03:11:38AM -0300, Arthur Grillo wrote:
> In __drm_kunit_helper_alloc_drm_device_with_driver(), a drm_driver is
> allocated with kunit_kzalloc. If the dev argument was allocated by
> drm_kunit_helper_alloc_device, its deferred actions would access the
> already deallocated drm_driver.

We already have a fix for that in drm-misc-fixes, could you give it a try?

Thanks!
Maxime

--q75l2sqotzpskg3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZQqTxAAKCRDj7w1vZxhR
xTOaAP9pjkE1m1Q7mszoUSKaUx/K3sfFfs5u97hCYtBm58HrcQD9H3YghSvpmnGY
f07dxL9+X4Wf2mIZiAjhgeUtnDa3UQk=
=U1Oy
-----END PGP SIGNATURE-----

--q75l2sqotzpskg3l--
