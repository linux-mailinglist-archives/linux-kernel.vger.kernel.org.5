Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651D27E28D9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjKFPh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjKFPh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:37:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878D3B8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:37:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB56C433C8;
        Mon,  6 Nov 2023 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699285043;
        bh=PhVYoqkFGDBmHN5xLHueJkfMTMCbvKcxSBfu8WwI8JM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l2IetvyKN1oDLRoz0HwVEHgm8jvWm0ezF3BJYiPp/+QBjj2ntLMAZ096AFg17aTJf
         mQIX9NVE8OerkpCihyfIFcIV6qlOx+uk3UEurxuzcI31bpB1dgx4lpQWZbQ+0Oso6L
         ZGjNPVBJs0PZtkPvjQw7FbMubGzmv+l+hYTv50nwNQYUhpKYUoRBB31yp97Z81Zsc0
         diVdo1B3wj1X/GLk5HP5DEa+OD5zZfUSJeqxN3DUtXMYbnXlIXMK5fQj+VVuCX84x/
         qCuBhEl4SkI75MFJuD/Pv+fEoC6U0HifRS7g2D3Xp8oWPj0t4zYOO26CZD+PM/DoAR
         m0ZlAXp+BAWvQ==
Date:   Mon, 6 Nov 2023 16:37:20 +0100
From:   'Maxime Ripard' <mripard@kernel.org>
To:     oushixiong@kylinos.cn
Cc:     'Maarten Lankhorst' <maarten.lankhorst@linux.intel.com>,
        'Thomas Zimmermann' <tzimmermann@suse.de>,
        'David Airlie' <airlied@gmail.com>,
        'Daniel Vetter' <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGRybS9hdG9taWMtaGVscGVy?=
 =?utf-8?Q?=3A?= Call stall_checks() before allocate drm_crtc_commit
Message-ID: <khqq7vbclfirac2yphxvr3lthnsph3okw4vuv4rmvc2kui7wx5@5spogczrzd6o>
References: <20231106073742.158905-1-oushixiong@kylinos.cn>
 <6yqalig6nvnlpt7loetugjdgp5z4w3qwhpqpzzsygffp5w32d6@guq6v3g2z7tq>
 <000301da10b4$d4e90690$7ebb13b0$@kylinos.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h44eb5yewsfjbvln"
Content-Disposition: inline
In-Reply-To: <000301da10b4$d4e90690$7ebb13b0$@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h44eb5yewsfjbvln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Nov 06, 2023 at 09:26:15PM +0800, oushixiong@kylinos.cn wrote:
> I think it will cause memory leaks if too many nonblock commit works return
> -EBUSY.

Do you *think* or are you sure?

If you are sure, then please write down everything I mentioned earlier
in the commit log and resend the patch.

Maxime

--h44eb5yewsfjbvln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZUkIMAAKCRDj7w1vZxhR
xbu4AQC4X4AXCLB1i6aJtzCDqCh3TGotHlxtKKbT4mkBrEI+bwD/QGr2Ba6VVzjC
2pz/3i33zZW48TE5qeR9gewfVBg+Cws=
=V8FP
-----END PGP SIGNATURE-----

--h44eb5yewsfjbvln--
