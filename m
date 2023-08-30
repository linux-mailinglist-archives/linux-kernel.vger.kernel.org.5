Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D320E78DDCE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245661AbjH3Sx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243267AbjH3KfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:35:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A3C19A;
        Wed, 30 Aug 2023 03:35:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D5A4F6607236;
        Wed, 30 Aug 2023 11:35:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693391717;
        bh=KZarq9IFVHe9P2TumUzb/mQlXyao/cCu6/Rbx6Q3Nyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YfVsk8X7VNMGYXNgW/cDHU4E153/CP3CtOk45NFNGR65Vp6P/f9KXRLLj+nZmEFBc
         nBGdE7ACLkrM8cE+XKXAn0ek6I+GBHYMH+Ua0u5aVyC09rbxMBTPw9AM8b9rkOZMYc
         p6u1CLmYyj5kku4TXSNU5M+RkOAVh/HYcXmDieg7U8QRi6UX1lE2li+Sy0N9JQqE9r
         jkzu79p+Lc8F+jNomNnX8LhNACanNZ2RVbFFkOEipWzXKXK1phr8xmcbRYZ5NzWkra
         9xd2KqLzpK6AUY/vfv6UY0i5pcL3XjzAXPrl+OgTHKNnCCebBtbz2EKgdW8zqov7F1
         QiFeHv1OnQgjg==
Date:   Wed, 30 Aug 2023 12:35:14 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        healych@amazon.com, kernel@collabora.com,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 1/6] drm/panfrost: Add cycle count GPU register
 definitions
Message-ID: <20230830123514.28c0180f@collabora.com>
In-Reply-To: <20230824013604.466224-2-adrian.larumbe@collabora.com>
References: <20230824013604.466224-1-adrian.larumbe@collabora.com>
        <20230824013604.466224-2-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 02:34:44 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> These GPU registers will be used when programming the cycle counter, which
> we need for providing accurate fdinfo drm-cycles values to user space.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_regs.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/p=
anfrost/panfrost_regs.h
> index 919f44ac853d..55ec807550b3 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_regs.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
> @@ -46,6 +46,8 @@
>  #define   GPU_CMD_SOFT_RESET		0x01
>  #define   GPU_CMD_PERFCNT_CLEAR		0x03
>  #define   GPU_CMD_PERFCNT_SAMPLE	0x04
> +#define   GPU_CMD_CYCLE_COUNT_START	0x05
> +#define   GPU_CMD_CYCLE_COUNT_STOP	0x06
>  #define   GPU_CMD_CLEAN_CACHES		0x07
>  #define   GPU_CMD_CLEAN_INV_CACHES	0x08
>  #define GPU_STATUS			0x34
> @@ -73,6 +75,9 @@
>  #define GPU_PRFCNT_TILER_EN		0x74
>  #define GPU_PRFCNT_MMU_L2_EN		0x7c
> =20
> +#define GPU_CYCLE_COUNT_LO		0x90
> +#define GPU_CYCLE_COUNT_HI		0x94
> +
>  #define GPU_THREAD_MAX_THREADS		0x0A0	/* (RO) Maximum number of threads =
per core */
>  #define GPU_THREAD_MAX_WORKGROUP_SIZE	0x0A4	/* (RO) Maximum workgroup si=
ze */
>  #define GPU_THREAD_MAX_BARRIER_SIZE	0x0A8	/* (RO) Maximum threads waitin=
g at a barrier */

