Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD687AA104
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjIUU4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjIUUex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:34:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5349C86112
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B855C4E681;
        Thu, 21 Sep 2023 14:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695305987;
        bh=3omRRAuhKLx3rUlF+M0I38XRTMiyOqLO113BPuaeJPE=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=NarvtlMJI4dC25o33cGWYbiFUCmh6m5wCn6RhAcs1t4sHSKg+gQYLRIib4349DV56
         T2KFKBerigcI6jOyzdS970PrTgy6l9Z79H6RKet7hOkbTP5TK5bHV7hDQGBvpazmC0
         R+8fGTRFcN44d/smo48T/hkRZ8DM+sjKzqBvwHkoMhicoF5YqATOc2rTwuC4kvFdKc
         r6bSlPfgbasVYD291yp21mtRIqmcjbDfICi+Iq+0Mv8SWie85dFlmKpAegqkbkgCk8
         36N4vbfs4TNFq5wpPiygyjqQM7WizXDFgr7tGoyHqiVnWqBBUYwuOwQkdP+Fzuqa/9
         bxEFLDCo148HA==
Message-ID: <f171c049112dfc21f0a1127edcd5717f.mripard@kernel.org>
Date:   Thu, 21 Sep 2023 14:19:44 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Javier Martinez Canillas" <javierm@redhat.com>
Subject: Re: [PATCH] drm/ssd130x: Drop _helper prefix from struct
 drm_*_helper_funcs callbacks
In-Reply-To: <20230914195138.1518065-1-javierm@redhat.com>
References: <20230914195138.1518065-1-javierm@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@gmail.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 21:51:24 +0200, Javier Martinez Canillas wrote:
> The driver uses a naming convention where functions for struct drm_*_funcs
> callbacks are named ssd130x_$object_$operation, while the callbacks for
> struct drm_*_helper_funcs are named ssd130x_$object_helper_$operation.
>=20
> The idea is that this helper_ prefix in the function names denote that are
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
