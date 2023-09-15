Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF0B7A19CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjIOI5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjIOI5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:57:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F2030DE;
        Fri, 15 Sep 2023 01:55:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F198966072BB;
        Fri, 15 Sep 2023 09:55:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694768143;
        bh=+lTKM1jeejz9rZU9eT5TrluIuSbG1Vh8fDRF3LgkNnI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SI3i9Zhj0Qsd/nfH6idkojingBexc2muS7LOU6kgO+YvSTWmnAZgZITNki40fV4tY
         LUwABop1vgFEjK7f4d8nof45yOERdeRyD0Do6IB5GXgrbCOxCsP9NhKDujWUm0AqHH
         vtBuDgFWnODvdO8SLMNUcu7PPOzC/2HAFzJLoaVqEPjdixXHZEJntaZU+2siPos/tJ
         6CQ+/CYsn5qFcCayqgvAKbAB9nlYHs4TeCIhVx2j0XEh6J9dBAKA2Maodu1+bUc+9V
         1bhU1pNw1NlQGeiOUclOX3QC+yqie0qDlbLj4g4AUMEih0R/aVyDeqpG15e1ZL0tZ9
         X7mSLmf2cdmMA==
Date:   Fri, 15 Sep 2023 10:55:39 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, healych@amazon.com,
        kernel@collabora.com
Subject: Re: [PATCH v5 6/6] drm/drm-file: Show finer-grained BO sizes in
 drm_show_memory_stats
Message-ID: <20230915105539.23724780@collabora.com>
In-Reply-To: <20230914223928.2374933-7-adrian.larumbe@collabora.com>
References: <20230914223928.2374933-1-adrian.larumbe@collabora.com>
        <20230914223928.2374933-7-adrian.larumbe@collabora.com>
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

On Thu, 14 Sep 2023 23:38:44 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> The current implementation will try to pick the highest available size
> display unit as soon as the BO size exceeds that of the previous
> multiplier. That can lead to loss of precision in contexts of low memory
> usage.
>=20
> The new selection criteria try to preserve precision, whilst also
> increasing the display unit selection threshold to render more accurate
> values.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 762965e3d503..34cfa128ffe5 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -872,6 +872,8 @@ void drm_send_event(struct drm_device *dev, struct dr=
m_pending_event *e)
>  }
>  EXPORT_SYMBOL(drm_send_event);
> =20
> +#define UPPER_UNIT_THRESHOLD 100
> +
>  static void print_size(struct drm_printer *p, const char *stat,
>  		       const char *region, u64 sz)
>  {
> @@ -879,7 +881,8 @@ static void print_size(struct drm_printer *p, const c=
har *stat,
>  	unsigned u;
> =20
>  	for (u =3D 0; u < ARRAY_SIZE(units) - 1; u++) {
> -		if (sz < SZ_1K)
> +		if ((sz & (SZ_1K - 1)) &&
> +		    sz < UPPER_UNIT_THRESHOLD * SZ_1K)
>  			break;
>  		sz =3D div_u64(sz, SZ_1K);
>  	}

