Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB55675BFC6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjGUHdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGUHdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:33:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4079819A1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAE8A612D7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B08C433C8;
        Fri, 21 Jul 2023 07:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689924824;
        bh=fctNF5EyYiJG9Wv//FA24SN2y/tZsF98l7MKQ2I9rpU=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=Xh8wgcw76Z64y6ASZc+6FAUyj+yQAqYG0IbEqVTU3GLq7y5vf/WT5cfJTV7a6Gwx+
         /iHhjaFhZSFwTWpAgvXjFhzGFgtVp9FswYiviUI6y2WgrVr4zMc0tcOOUl2j6VU8kx
         dc3zNWG9fksW4N7QgkfdSzp0GPNKfcJHN1rrskSBELa2NokIEGOEJ53wOS6OPlblfK
         mBgEAxTtWZSE05CaAnPt2ChSBf4rtwlCS17pgx8A8/57jChHhEhNbNXv9bupCH73nM
         hiyTD8HicPwnBYUE7TxynWa3DrorNtPbfQ8U4HF3M+U2pkEBgMNWOijOK18rFw9TpA
         TcaS7OYA+ltDw==
Message-ID: <c3169a54ab922cfefd4372ce897446ba.mripard@kernel.org>
Date:   Fri, 21 Jul 2023 07:33:42 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Javier Martinez Canillas" <javierm@redhat.com>
Subject: Re: [PATCH v4] drm/ssd130x: Allocate buffers in the plane's
 .atomic_check callback
In-Reply-To: <20230721070955.1170974-1-javierm@redhat.com>
References: <20230721070955.1170974-1-javierm@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@gmail.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 09:09:50 +0200, Javier Martinez Canillas wrote:
> Geert reports that the following NULL pointer dereference happens for him
> after commit 49d7d581ceaf ("drm/ssd130x: Don't allocate buffers on each
> plane update"):
>=20
>     [drm] Initialized ssd130x 1.0.0 20220131 for 0-003c on minor 0
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
