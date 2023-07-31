Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384AF76958D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjGaMF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjGaMFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:05:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B786C171C;
        Mon, 31 Jul 2023 05:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B3576108B;
        Mon, 31 Jul 2023 12:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA01C433C8;
        Mon, 31 Jul 2023 12:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690805098;
        bh=CxFnYp7q+XxZ7znzGHFxRtOTFd57UjGuXrJBT9Z6jfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNP7+QrCm8e46TuickOROLjjoLk92XRMECcE6QClmuWcLojczZGukm8KMESE1qWL8
         CYxrXkdWiffoaLzos/RLuhWfIAdUqM/Q1pylPvMfbNH8spCCndcH/XDhXCxRQLggiF
         vgBrGQHEXumy5TAx6WhEAHo1gT1LXoPY6m/epkfeeFQumPrdgl5SdK3jQGgrHF5mq7
         pvD/f2EG7lAQIaTUn5JiXPWse/LTC4ro5PhsIEbt/I/IqH0PTMZa/o3xLuLyeDE+Ts
         JhrfTd66S/ROXLq2LHi4ag2u/bghGxZltrDXN2c6wo0BCVdmbyzvetd4DsqUafCH0A
         cW61RjU8PEI9Q==
Date:   Mon, 31 Jul 2023 14:04:55 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, tzimmermann@suse.de, corbet@lwn.net,
        christian.koenig@amd.com, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, matthew.brost@intel.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net,
        donald.robson@imgtec.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas =?utf-8?Q?Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH drm-misc-next v8 01/12] drm: manager to keep track of
 GPUs VA mappings
Message-ID: <r7gbbrkn4hjyjyjgapf7jnyswbuvks4ng7uuy7gibsra2xpvzf@iot4rgafaqjn>
References: <20230720001443.2380-1-dakr@redhat.com>
 <20230720001443.2380-2-dakr@redhat.com>
 <hi5magp4icayy5dxmylfyxws52cu63jvlhu4yj5xem3acoaylk@msf7zthcr3lg>
 <20230728142612.2ecf99ef@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wm7cpxvm7mxqxcv7"
Content-Disposition: inline
In-Reply-To: <20230728142612.2ecf99ef@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wm7cpxvm7mxqxcv7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Boris,

On Fri, Jul 28, 2023 at 02:26:12PM +0200, Boris Brezillon wrote:
> On Fri, 28 Jul 2023 13:31:36 +0200
> Maxime Ripard <mripard@kernel.org> wrote:
>=20
> > Hi Danilo,
> >=20
> > On Thu, Jul 20, 2023 at 02:14:22AM +0200, Danilo Krummrich wrote:
> > > Add infrastructure to keep track of GPU virtual address (VA) mappings
> > > with a decicated VA space manager implementation.
> > >=20
> > > New UAPIs, motivated by Vulkan sparse memory bindings graphics drivers
> > > start implementing, allow userspace applications to request multiple =
and
> > > arbitrary GPU VA mappings of buffer objects. The DRM GPU VA manager is
> > > intended to serve the following purposes in this context.
> > >=20
> > > 1) Provide infrastructure to track GPU VA allocations and mappings,
> > >    making using an interval tree (RB-tree).
> > >=20
> > > 2) Generically connect GPU VA mappings to their backing buffers, in
> > >    particular DRM GEM objects.
> > >=20
> > > 3) Provide a common implementation to perform more complex mapping
> > >    operations on the GPU VA space. In particular splitting and merging
> > >    of GPU VA mappings, e.g. for intersecting mapping requests or part=
ial
> > >    unmap requests.
> > >=20
> > > Acked-by: Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> > > Acked-by: Matthew Brost <matthew.brost@intel.com>
> > > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > Tested-by: Matthew Brost <matthew.brost@intel.com>
> > > Tested-by: Donald Robson <donald.robson@imgtec.com>
> > > Suggested-by: Dave Airlie <airlied@redhat.com>
> > > Signed-off-by: Danilo Krummrich <dakr@redhat.com> =20
> >=20
> > For some reason this breaks the drm_exec kunit patches:
>=20
> Fix available here [1].
>=20
> [1]https://lore.kernel.org/dri-devel/cbf4ccf9-8131-27a0-332c-6942866340d1=
@igalia.com/T/#t

Thanks for pointing it out :)

Maxime

--wm7cpxvm7mxqxcv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZMejZwAKCRDj7w1vZxhR
xaW5AQCv028JEAAnIb/aFhQc1sYoXrIKQLstpLgP6KnY2r99tAD7BvwHotLO3uHq
7wsMukvisTg7tcpMtdYRdRiWIaoh+gs=
=nrso
-----END PGP SIGNATURE-----

--wm7cpxvm7mxqxcv7--
