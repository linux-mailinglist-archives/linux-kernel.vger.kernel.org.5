Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64EA7F50A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344432AbjKVTee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343554AbjKVTec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:34:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04591109
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 11:34:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B28C433C8;
        Wed, 22 Nov 2023 19:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700681668;
        bh=OEAiAa4+BwBMz9R5kgZq2H6MuqYGiQaaeYPalWgnvGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g5/McEbnVAr0rRTefhGKIsY8JT9nkZgdJKBOeirfuosID8rlZbfrRwtNTSKQGWGIW
         7wvgi0iZN/JtmI3iI1IH1/cfAcUbnbcGWS187Q5XMhaKgpW57iH9nFL34H7vogqgOV
         WMh2pFzG0Ud11YWYUPk8NAC/eN7Jf5JxoSqWkwXySDcrXP6aGVmC/WQNLgRlM0nVbC
         v6V9u4nUuv85UeI8R61ga7ytnAvRry7knVpZ1hkevE6NxoAchdOwvpQ5ir3GS71pZZ
         nUykG7UD8hdH8PxDxX4lgNo7csx7DhNGWk+XWVrUANv9dHrcH+fR0LLRasjhiEK2LL
         5T6vS5xtb1u2Q==
Date:   Wed, 22 Nov 2023 20:34:25 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Donald Robson <donald.robson@imgtec.com>
Cc:     dri-devel@lists.freedesktop.org, frank.binns@imgtec.com,
        matt.coster@imgtec.com, boris.brezillon@collabora.com,
        faith.ekstrand@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, afd@ti.com,
        hns@goldelico.com, matthew.brost@intel.com,
        christian.koenig@amd.com, luben.tuikov@amd.com, dakr@redhat.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 00/20] Imagination Technologies PowerVR DRM driver
Message-ID: <jl4igixnszibpq5hindyjvrh6eten7mjr6hj32fst4irjbg2t6@gdks4ydvhshw>
References: <cover.1700668843.git.donald.robson@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yhpbdcvhvn7tgvwg"
Content-Disposition: inline
In-Reply-To: <cover.1700668843.git.donald.robson@imgtec.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yhpbdcvhvn7tgvwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 22, 2023 at 04:34:21PM +0000, Donald Robson wrote:
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
> work on the BeaglePlay board. Firmware for the AXE-1-16M can be found her=
e:
> https://gitlab.freedesktop.org/frankbinns/linux-firmware/-/tree/powervr
>=20
> A Vulkan driver that works with our downstream kernel driver has already =
been
> merged into Mesa [1][2]. Support for this new DRM driver is being maintai=
ned in
> a merge request [3], with the branch located here:
> https://gitlab.freedesktop.org/frankbinns/mesa/-/tree/powervr-winsys
>=20
> Vulkan driver links referred to above:
> [1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/15243
> [2] https://gitlab.freedesktop.org/mesa/mesa/-/tree/main/src/imagination/=
vulkan
> [3] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/15507
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
> https://gitlab.freedesktop.org/frankbinns/powervr/-/tree/dev/v9_dts
> The full development history can be found here:
> https://gitlab.freedesktop.org/frankbinns/powervr/-/tree/powervr-next

I just merged all the patches to drm-misc-next.

Congrats :)

Maxime

--yhpbdcvhvn7tgvwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZV5XwQAKCRDj7w1vZxhR
xQRDAPwJJyRpMcbHjTq7UnC2OyBaXf8KMwPzhe509wvPJWD7vwD/VaDJvd9wF7Pb
syxg6XJXQ0MCnmWfXybmQk07JbFNKws=
=qJrP
-----END PGP SIGNATURE-----

--yhpbdcvhvn7tgvwg--
