Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A32E766BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjG1Lbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjG1Lbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:31:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D45F2D5B;
        Fri, 28 Jul 2023 04:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CE5B62101;
        Fri, 28 Jul 2023 11:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C216C433C8;
        Fri, 28 Jul 2023 11:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690543899;
        bh=mQamHmOgyjxhff4tf13gl/WJXm01xBH8XpNyYc9u4CU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEq86SlctDT6n2xRRfUW6BXg07k0GOYkhjEmq11FHtLbCgAdef74cw05oPdwlJMxM
         nMFKaz3L5nKPQEiU/c9j4ostFrLN6rWdsaFn+Tg3bcNhTzdRyFcDzEzmeXulEYunm8
         GZxgykpDgWSNe+PLNwW8xOiTCxWwSoyBE9/aq9OSJj9/cN5dI5yKh35KUDbqp9nCSp
         FzD7ww99o97k5yFbC619m7SskfC2XbDCZTgPthSqUSdVLHsGGeU5z3WFzvqKDea9iO
         tYBWjY4vjuS0WJO0oninAReyBrrpmped45vPoIZgt+kFoOBDqZ+vIQcKAb6xbCaxE0
         tPf0W4jFPJCmA==
Date:   Fri, 28 Jul 2023 13:31:36 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        corbet@lwn.net, christian.koenig@amd.com, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, matthew.brost@intel.com,
        boris.brezillon@collabora.com, alexdeucher@gmail.com,
        ogabbay@kernel.org, bagasdotme@gmail.com, willy@infradead.org,
        jason@jlekstrand.net, donald.robson@imgtec.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas =?utf-8?Q?Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH drm-misc-next v8 01/12] drm: manager to keep track of
 GPUs VA mappings
Message-ID: <hi5magp4icayy5dxmylfyxws52cu63jvlhu4yj5xem3acoaylk@msf7zthcr3lg>
References: <20230720001443.2380-1-dakr@redhat.com>
 <20230720001443.2380-2-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3n5o5ss2bit7ecey"
Content-Disposition: inline
In-Reply-To: <20230720001443.2380-2-dakr@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3n5o5ss2bit7ecey
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Danilo,

On Thu, Jul 20, 2023 at 02:14:22AM +0200, Danilo Krummrich wrote:
> Add infrastructure to keep track of GPU virtual address (VA) mappings
> with a decicated VA space manager implementation.
>=20
> New UAPIs, motivated by Vulkan sparse memory bindings graphics drivers
> start implementing, allow userspace applications to request multiple and
> arbitrary GPU VA mappings of buffer objects. The DRM GPU VA manager is
> intended to serve the following purposes in this context.
>=20
> 1) Provide infrastructure to track GPU VA allocations and mappings,
>    making using an interval tree (RB-tree).
>=20
> 2) Generically connect GPU VA mappings to their backing buffers, in
>    particular DRM GEM objects.
>=20
> 3) Provide a common implementation to perform more complex mapping
>    operations on the GPU VA space. In particular splitting and merging
>    of GPU VA mappings, e.g. for intersecting mapping requests or partial
>    unmap requests.
>=20
> Acked-by: Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> Acked-by: Matthew Brost <matthew.brost@intel.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Tested-by: Matthew Brost <matthew.brost@intel.com>
> Tested-by: Donald Robson <donald.robson@imgtec.com>
> Suggested-by: Dave Airlie <airlied@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

For some reason this breaks the drm_exec kunit patches:


$ ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/gpu/drm/tests =
  --cross_compile aarch64-linux-gnu- --arch arm64 --raw_output drm_exec.tes=
t_lock
[13:31:14] Configuring KUnit Kernel ...
[13:31:14] Building KUnit Kernel ...
Populating config with:
$ make ARCH=3Darm64 O=3D.kunit olddefconfig CROSS_COMPILE=3Daarch64-linux-g=
nu-
Building with:
$ make ARCH=3Darm64 O=3D.kunit --jobs=3D32 CROSS_COMPILE=3Daarch64-linux-gn=
u-
[13:31:16] Starting KUnit Kernel (1/1)...
Running tests with:
$ qemu-system-aarch64 -nodefaults -m 1024 -kernel .kunit/arch/arm64/boot/Im=
age.gz -append 'kunit.filter_glob=3Ddrm_exec.test_lock kunit.enable=3D1 con=
sole=3DttyAMA0 kunit_shutdown=3Dreboot' -no-reboot -nographic -serial stdio=
 -machine virt -cpu cortex-a57
KTAP version 1
1..1
    KTAP version 1
    # Subtest: drm_exec
    1..1
Unable to handle kernel NULL pointer dereference at virtual address 0000000=
0000000b0
Mem abort info:
  ESR =3D 0x0000000096000005
  EC =3D 0x25: DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
  FSC =3D 0x05: level 1 translation fault
Data abort info:
  ISV =3D 0, ISS =3D 0x00000005
  CM =3D 0, WnR =3D 0
[00000000000000b0] user address but active_mm is swapper
Internal error: Oops: 0000000096000005 [#1] SMP
CPU: 0 PID: 21 Comm: kunit_try_catch Tainted: G                 N 6.4.0-rc7=
-02032-ge6303f323b1a #17
Hardware name: linux,dummy-virt (DT)
pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
pc : drm_gem_private_object_init+0x54/0xa8
lr : drm_gem_private_object_init+0x44/0xa8
sp : ffffffc008763c10
x29: ffffffc008763c10 x28: 0000000000000000 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: ffffffc00800bb90
x23: ffffffc00820d3e4 x22: ffffff8000fb8880 x21: ffffffc008763db8
x20: ffffffc0086171d8 x19: ffffffc008763cb8 x18: ffffffffffffffff
x17: ffffffc0085b0da8 x16: 000000005a832b7d x15: 0000000000000000
x14: 0000000000000001 x13: 0000000000000000 x12: ffffff8000cbe380
x11: ffffff8000ca0000 x10: 00000000000007b0 x9 : 0000000000000000
x8 : ffffffc008763cb8 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000008 x3 : 0000000000000030
x2 : ffffffc0085b9118 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drm_gem_private_object_init+0x54/0xa8
 test_lock+0x58/0xf4
 kunit_try_run_case+0x48/0xa8
 kunit_generic_run_threadfn_adapter+0x20/0x2c
 kthread+0xd4/0xd8
 ret_from_fork+0x10/0x20
Code: f9407e60 b40002a0 f9401a80 b9406a81 (b940b000)
---[ end trace 0000000000000000 ]---
^CERROR:root:Build interruption occurred. Cleaning console.
qemu-system-aarch64: terminating on signal 2
[13:31:17] Elapsed time: 3.396s total, 0.001s configuring, 1.978s building,=
 1.417s running

Maxime

--3n5o5ss2bit7ecey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZMOnGAAKCRDj7w1vZxhR
xSR2AP9tE8/f72q5jHIMHjhhir0PsVypUMPCWXU4fR+59oPfOgD/ZE9aH6tsf2Vd
FouLH8frZRDzfA2nPV3qd89JLuV60wM=
=Gn76
-----END PGP SIGNATURE-----

--3n5o5ss2bit7ecey--
