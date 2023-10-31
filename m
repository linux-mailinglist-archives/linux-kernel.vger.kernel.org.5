Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D607DD19B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345153AbjJaQbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjJaQbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:31:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55A5F1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:31:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F938C433C9;
        Tue, 31 Oct 2023 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698769868;
        bh=Opu3JDYBPCoRNGFn0xHjErSlJeCKvHxFHszXMcL0FHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3BeNkl8nju6P2+MI5e0/95aJuR/VEVyzci11tafyEPpg2vdRXqOVZTp1zN8XbYWW
         OX5ErgTbJr4LJhZP7nYcz9TM3of3N5KvKvmKLchf9KogPccaqADR1yZ4SVgCjzEFIM
         doxWz7ls1xU2vJY0yUYruxxh/2TkmvwayEEiLo9mm0VyTJoIUhT4naxBYY0HxuU7e6
         i0/KQyankK9r5KDTDvq6BEc5bqnIPOYaqWdEGs2DuMbqfYAClh/OAZbe2JPC7wdIVU
         35oOBr2Oh0E07N9GhzYD3bJ/XfVNh143LQIoXFwL9DoNXJUXHQQc8/mJ4eFiokd4gs
         10bq2Oaj+f7sA==
Date:   Tue, 31 Oct 2023 17:31:05 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Sarah Walker <sarah.walker@imgtec.com>, frank.binns@imgtec.com,
        faith.ekstrand@collabora.com
Cc:     boris.brezillon@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, afd@ti.com,
        hns@goldelico.com, matthew.brost@intel.com,
        christian.koenig@amd.com, luben.tuikov@amd.com, dakr@redhat.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 00/20] Imagination Technologies PowerVR DRM driver
Message-ID: <lg7cdw3qlak74zefbx25f5pnazrburteldueoqz7o7cphydqp7@q56er3qa5muf>
References: <20231031151257.90350-1-sarah.walker@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h6eqzan6yg37toag"
Content-Disposition: inline
In-Reply-To: <20231031151257.90350-1-sarah.walker@imgtec.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h6eqzan6yg37toag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sarah, Faith, Frank,

On Tue, Oct 31, 2023 at 03:12:37PM +0000, Sarah Walker wrote:
> This patch series adds the initial DRM driver for Imagination Technologie=
s PowerVR
> GPUs, starting with those based on our Rogue architecture. It's worth poi=
nting
> out that this is a new driver, written from the ground up, rather than a
> refactored version of our existing downstream driver (pvrsrvkm).
>=20
> This new DRM driver supports:
> - GEM shmem allocations
> - dma-buf / PRIME
> - Per-context userspace managed virtual address space
> - DRM sync objects (binary and timeline)
> - Power management suspend / resume
> - GPU job submission (geometry, fragment, compute, transfer)
> - META firmware processor
> - MIPS firmware processor
> - GPU hang detection and recovery
>=20
> Currently our main focus is on the AXE-1-16M GPU. Testing so far has been=
 done
> using a TI SK-AM62 board (AXE-1-16M GPU). The driver has also been confir=
med to
> work on the BeaglePlay board. Firmware for the AXE-1-16M can befound here:
> https://gitlab.freedesktop.org/frankbinns/linux-firmware/-/tree/powervr
>=20
> A Vulkan driver that works with our downstream kernel driver has already =
been
> merged into Mesa [1][2]. Support for this new DRM driver is being maintai=
ned in
> a merge request [3], with the branch located here:
> https://gitlab.freedesktop.org/frankbinns/mesa/-/tree/powervr-winsys
>=20
> Job stream formats are documented at:
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/f8d2b42ae65c2f16f36a43e0a=
e39d288431e4263/src/imagination/csbgen/rogue_kmd_stream.xml
>=20
> The Vulkan driver is progressing towards Vulkan 1.0. The current combinat=
ion of this
> kernel driver with the Mesa Vulkan driver (powervr-mesa-next branch) succ=
essfully
> completes Vulkan CTS 1.3.4.1 in our local runs. The driver is expected to=
 pass the
> Khronos Conformance Process once the submission is made.
>=20
> The code in this patch series, along with the needed dts changes can be f=
ound here:
> https://gitlab.freedesktop.org/sarah-walker-imgtec/powervr/-/tree/dev/v8_=
dts
> The full development history can be found here:
> https://gitlab.freedesktop.org/frankbinns/powervr/-/tree/powervr-next

Awesome, thanks for sending a new version of that series.

At XDC, we all agreed that we would merge this version if the changes
requested by Faith were fixed, and if the Mesa PR was updated to match
that new kernel series.

Are we there yet?

If so, Faith, should we add your Reviewed-by/Acked-by tag to the UAPI patch?

> This patch series has dependencies on a number of patches not yet merged.=
 They
> are listed below :
>=20
> drm/sched: Convert drm scheduler to use a work queue rather than kthread:
>   https://lore.kernel.org/dri-devel/20230404002211.3611376-2-matthew.bros=
t@intel.com/
> drm/sched: Move schedule policy to scheduler / entity:
>   https://lore.kernel.org/dri-devel/20230404002211.3611376-3-matthew.bros=
t@intel.com/
> drm/sched: Add DRM_SCHED_POLICY_SINGLE_ENTITY scheduling policy:
>   https://lore.kernel.org/dri-devel/20230404002211.3611376-4-matthew.bros=
t@intel.com/
> drm/sched: Start run wq before TDR in drm_sched_start:
>   https://lore.kernel.org/dri-devel/20230404002211.3611376-6-matthew.bros=
t@intel.com/
> drm/sched: Submit job before starting TDR:
>   https://lore.kernel.org/dri-devel/20230404002211.3611376-7-matthew.bros=
t@intel.com/
> drm/sched: Add helper to set TDR timeout:
>   https://lore.kernel.org/dri-devel/20230404002211.3611376-8-matthew.bros=
t@intel.com/

What is the state of those patches? Iirc, we were expecting them to be
merged soon at XDC

Thanks,
Maxime

--h6eqzan6yg37toag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZUEryQAKCRDj7w1vZxhR
xTp9AP48QDAKYOfrziKxyJhD0jPjF1kfqNNf6jYxHagxVE+b3gD9HUbcKZsRyVJZ
myv8rg5pwmzcvrMBx9Irutk/GY6w1Aw=
=57Kh
-----END PGP SIGNATURE-----

--h6eqzan6yg37toag--
