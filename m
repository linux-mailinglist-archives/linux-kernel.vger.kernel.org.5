Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEFC767FFA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjG2OMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjG2OMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:12:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6441BDC
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:12:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbff6b2679so1761455ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690639932; x=1691244732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+C6jJRc0LdW2x/2DP37k+SaBYlDtw6zn+yIijsr+W6Q=;
        b=SgAAUN7IvS6GoQAolVEmt8DQxByP2zKnQlfP7HlegvgMjDiBllWXagumXqz3/9FUP2
         vRC99IgQr7JNLUJuHgwkv0OfAT2uKam4GSSJ8tU568Y6qzLvPoyylGKTNddQVa3TFavK
         8Maindl9XQ34rJXNUU62YmirYjJWIaA9y5gYp5fmTiTjTHHSEWMRq0bMRvs4V3UiSiNK
         V609ozvSKraa47aY2tA7HN/iHNPk1OhLxnyo4o/D3TP4VdhREM1lJ3BtQnEXa6zn8bJf
         yvrWAWbbYlEofjxWO/14Az53VxzeItAnnHRdKGC++tNraJEB5tW5pZNdCmrJrfCjCH7n
         MIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690639932; x=1691244732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+C6jJRc0LdW2x/2DP37k+SaBYlDtw6zn+yIijsr+W6Q=;
        b=DDOkJlanA4b17BHq/WfqsTwZxcr+usb4XSlw1Eih3eR/Mnb/e9resfK/HGaNxjoKGW
         yVuDHwwcEdt2113R36VNR/o8EN0iKGstL3h7Lk7bI6qHbTP0mS1BcMc/o8yaXS1605D6
         D/uCgVUNKxD5iDb8daGbniinVUmnNyJ+ff9RovJCLcu6dYbfNj4sTW1mKlCx6l9hZ5FA
         1t/imjhXxl5/dFDumo97P83EWkxLtu8cpGIyk6LGYVvOT9+J5kjllrK8XEyEUj9lLWyh
         BKDkqYaYC96+dYIlrYO4jXT47r8NXORvT80ucB255vPfh8gA7Zg+mY/ixa5g8CRi+RWa
         FX+Q==
X-Gm-Message-State: ABy/qLay/fCCuHm9oPnjTL6+LJCB5QRo4ojcJZbjwB45vGQRosOdoIxq
        1O/WWQXbUR5C9Op8WuMiHVI=
X-Google-Smtp-Source: APBJJlE662Atmiw9uVK/6bA4umUfd5xUgkEOpmu5PWhPABkU0JdjBkBHFOZbngWO40y2M+4W2DCpkQ==
X-Received: by 2002:a17:903:22d2:b0:1b9:c207:1802 with SMTP id y18-20020a17090322d200b001b9c2071802mr5225754plg.0.1690639931771;
        Sat, 29 Jul 2023 07:12:11 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b001b1a2c14a4asm5347654plo.38.2023.07.29.07.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 07:12:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id AC0498AEC1A0; Sat, 29 Jul 2023 21:12:05 +0700 (WIB)
Date:   Sat, 29 Jul 2023 21:12:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     =?utf-8?B?5a2Z5YaJ?= <sunran001@208suo.com>,
        airlied <airlied@gmail.com>, daniel <daniel@ffwll.ch>,
        "alexander.deucher" <alexander.deucher@amd.com>
Cc:     amd-gfx <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/radeon: Prefer 'unsigned int' to bare use of
 'unsigned'
Message-ID: <ZMUeNehNb52Qu/Cp@debian.me>
References: <3a4bebc5-79fb-4799-8743-14a0dde97a4f.sunran001@208suo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="01f/lLxb6k6fTJWx"
Content-Disposition: inline
In-Reply-To: <3a4bebc5-79fb-4799-8743-14a0dde97a4f.sunran001@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--01f/lLxb6k6fTJWx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 10:35:19PM +0800, =E5=AD=99=E5=86=89 wrote:
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>=20
> Signed-off-by: Ran Sun <sunran001@208suo.com>

Your From: address !=3D SoB identity

> ---
>  drivers/gpu/drm/radeon/radeon_object.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/radeon/radeon_object.h b/drivers/gpu/drm/rad=
eon/radeon_object.h
> index 39cc87a59a9a..9b55a7103cfd 100644
> --- a/drivers/gpu/drm/radeon/radeon_object.h
> +++ b/drivers/gpu/drm/radeon/radeon_object.h
> @@ -37,7 +37,7 @@
>   *
>   * Returns corresponding domain of the ttm mem_type
>   */
> -static inline unsigned radeon_mem_type_to_domain(u32 mem_type)
> +static inline unsigned int radeon_mem_type_to_domain(u32 mem_type)
>  {
>   switch (mem_type) {
>   case TTM_PL_VRAM:
> @@ -112,12 +112,12 @@ static inline unsigned long radeon_bo_size(struct r=
adeon_bo *bo)
>   return bo->tbo.base.size;
>  }
> =20
> -static inline unsigned radeon_bo_ngpu_pages(struct radeon_bo *bo)
> +static inline unsigned int radeon_bo_ngpu_pages(struct radeon_bo *bo)
>  {
>   return bo->tbo.base.size / RADEON_GPU_PAGE_SIZE;
>  }
> =20
> -static inline unsigned radeon_bo_gpu_page_alignment(struct radeon_bo *bo)
> +static inline unsigned int radeon_bo_gpu_page_alignment(struct radeon_bo=
 *bo)
>  {
>   return (bo->tbo.page_alignment << PAGE_SHIFT) / RADEON_GPU_PAGE_SIZE;
>  }
> @@ -189,7 +189,7 @@ static inline void *radeon_sa_bo_cpu_addr(struct drm_=
suballoc *sa_bo)
> =20
>  extern int radeon_sa_bo_manager_init(struct radeon_device *rdev,
>           struct radeon_sa_manager *sa_manager,
> -         unsigned size, u32 align, u32 domain,
> +         unsigned int size, u32 align, u32 domain,
>           u32 flags);
>  extern void radeon_sa_bo_manager_fini(struct radeon_device *rdev,
>            struct radeon_sa_manager *sa_manager);

The patch is whitespace-corrupted. Use git-send-email(1) to submit patches.
Also, your patch is also MIME-encoded, hence the corruption.

To Alex: Please don't apply this patch due to reasons above.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--01f/lLxb6k6fTJWx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZMUeMAAKCRD2uYlJVVFO
o58+AQDBnu90P/KFMkRmE5l99Ib4Tj5NqIUMx+sXAV1aN7lIBgEAqWSXDZxC87Ry
rWvbVbgDxvYYyf8JS2Ln6A60zFCshwg=
=ibKj
-----END PGP SIGNATURE-----

--01f/lLxb6k6fTJWx--
