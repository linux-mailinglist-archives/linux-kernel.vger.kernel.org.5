Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82DB7BCEDF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344887AbjJHOLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 10:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJHOLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 10:11:16 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCFE99
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 07:11:15 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57b635e3fd9so1755160eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 07:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696774274; x=1697379074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XyEKxcvwY7znmPwndnO8wEBvpz3VAnMCyGn/RSrU7oc=;
        b=UsFH9XH3PFyvFYiaINm6OOgG0U4m4OMa/0I2x2iTzdLUDhQD6ZSZU646rpweIyxBqE
         q/P5oDOcaYNg4A5L83hLULENXx70lTFXuyemViE5lUT6lAZ/sCjo1AnYq1BpRyx2oeqw
         mQyqpfI6rq7DW2GOmzMRGg9l6YYTG7BbIgu1cAlzUAJaWoVcUC3UPBiad2Kf0p6HyV86
         9C1GD0dU47cVoDNTTxvvSOYoj3oQjKseU8ZIztOmISs7/s2RGPBG0C//nj2PGVWXHD8B
         DLSmNvuKLSPm+hQOvM9QzDYWwjoCHqPGc579OPDXC8jUyUKPIIPyElxkaJTMQI+R7bQq
         OUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696774274; x=1697379074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyEKxcvwY7znmPwndnO8wEBvpz3VAnMCyGn/RSrU7oc=;
        b=BuxA+KlPsOx21ZmNZS4HeV19JT7ZjPbAv+5Q/1ClV+G+BGSBTEh/sfwY0w/FzcoUVM
         AeqWpS+yo04XRW66TQUoUaG7jE69G1boEK3cc8JH2n3OrQXBT5t5dRRoCmw1Y6hlaywk
         Ix/b6saxD6W5fppuOYxgiqG1DDxXHxprAXvQuDUqKAZnbcnRp+a7AfV5qdEJ1518Tnpf
         E0sPYCrIrDd8DU4TTUq0QWw7dJOnXuLTMKt1kLPNyuG1ynq6aMYwKluZaQZ54v8TkSsA
         J3AQQCFKCfgpVPJKeiNJyRAawzTBhVvgyaFKV9eyARilttR5QGybeEo0sD9knKMCzr8a
         KpGg==
X-Gm-Message-State: AOJu0YyVxMTM/SNQhw54j53wI9hFnKl4aBmQFReEbWi4LYYKbM0jGW6I
        WS03K1A2i42vT4XheP3CXMU=
X-Google-Smtp-Source: AGHT+IG+CkVWDZM4qbJZPGKsfqeGKlF2EUxOaaCzInK5BXwAXjPI7BtZrZDAcVJa8xl9T/W6Kr6cOQ==
X-Received: by 2002:a05:6358:918b:b0:14f:3874:2746 with SMTP id j11-20020a056358918b00b0014f38742746mr10423698rwa.23.1696774274421;
        Sun, 08 Oct 2023 07:11:14 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id l19-20020a639853000000b0056b6d1ac949sm6374825pgo.13.2023.10.08.07.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 07:11:13 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3F79F81B12C1; Sun,  8 Oct 2023 21:11:04 +0700 (WIB)
Date:   Sun, 8 Oct 2023 21:11:04 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau: fix kernel-doc warning
Message-ID: <ZSK4eNUPYIqPF3fM@debian.me>
References: <20231008070618.20640-1-bragathemanick0908@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NyY6YWaxLzVX3FT9"
Content-Disposition: inline
In-Reply-To: <20231008070618.20640-1-bragathemanick0908@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NyY6YWaxLzVX3FT9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 08, 2023 at 12:36:18PM +0530, Bragatheswaran Manickavel wrote:
> @@ -458,15 +458,15 @@ struct drm_nouveau_svm_bind {
> =20
>  #define DRM_IOCTL_NOUVEAU_GETPARAM           DRM_IOWR(DRM_COMMAND_BASE +=
 DRM_NOUVEAU_GETPARAM, struct drm_nouveau_getparam)
>  #define DRM_IOCTL_NOUVEAU_CHANNEL_ALLOC      DRM_IOWR(DRM_COMMAND_BASE +=
 DRM_NOUVEAU_CHANNEL_ALLOC, struct drm_nouveau_channel_alloc)
> -#define DRM_IOCTL_NOUVEAU_CHANNEL_FREE       DRM_IOW (DRM_COMMAND_BASE +=
 DRM_NOUVEAU_CHANNEL_FREE, struct drm_nouveau_channel_free)
> +#define DRM_IOCTL_NOUVEAU_CHANNEL_FREE       DRM_IOW(DRM_COMMAND_BASE + =
DRM_NOUVEAU_CHANNEL_FREE, struct drm_nouveau_channel_free)
> =20
>  #define DRM_IOCTL_NOUVEAU_SVM_INIT           DRM_IOWR(DRM_COMMAND_BASE +=
 DRM_NOUVEAU_SVM_INIT, struct drm_nouveau_svm_init)
>  #define DRM_IOCTL_NOUVEAU_SVM_BIND           DRM_IOWR(DRM_COMMAND_BASE +=
 DRM_NOUVEAU_SVM_BIND, struct drm_nouveau_svm_bind)
> =20
>  #define DRM_IOCTL_NOUVEAU_GEM_NEW            DRM_IOWR(DRM_COMMAND_BASE +=
 DRM_NOUVEAU_GEM_NEW, struct drm_nouveau_gem_new)
>  #define DRM_IOCTL_NOUVEAU_GEM_PUSHBUF        DRM_IOWR(DRM_COMMAND_BASE +=
 DRM_NOUVEAU_GEM_PUSHBUF, struct drm_nouveau_gem_pushbuf)
> -#define DRM_IOCTL_NOUVEAU_GEM_CPU_PREP       DRM_IOW (DRM_COMMAND_BASE +=
 DRM_NOUVEAU_GEM_CPU_PREP, struct drm_nouveau_gem_cpu_prep)
> -#define DRM_IOCTL_NOUVEAU_GEM_CPU_FINI       DRM_IOW (DRM_COMMAND_BASE +=
 DRM_NOUVEAU_GEM_CPU_FINI, struct drm_nouveau_gem_cpu_fini)
> +#define DRM_IOCTL_NOUVEAU_GEM_CPU_PREP       DRM_IOW(DRM_COMMAND_BASE + =
DRM_NOUVEAU_GEM_CPU_PREP, struct drm_nouveau_gem_cpu_prep)
> +#define DRM_IOCTL_NOUVEAU_GEM_CPU_FINI       DRM_IOW(DRM_COMMAND_BASE + =
DRM_NOUVEAU_GEM_CPU_FINI, struct drm_nouveau_gem_cpu_fini)
>  #define DRM_IOCTL_NOUVEAU_GEM_INFO           DRM_IOWR(DRM_COMMAND_BASE +=
 DRM_NOUVEAU_GEM_INFO, struct drm_nouveau_gem_info)
> =20
>  #define DRM_IOCTL_NOUVEAU_VM_INIT            DRM_IOWR(DRM_COMMAND_BASE +=
 DRM_NOUVEAU_VM_INIT, struct drm_nouveau_vm_init)

Can you please split checkpatch fix above into separate patch?

--=20
An old man doll... just what I always wanted! - Clara

--NyY6YWaxLzVX3FT9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSK4dwAKCRD2uYlJVVFO
ow1cAQDVcS0V99/qpu73ULyxIv/J+8DZ7JV9q172/0v22KhgWQEA4slaxL7vNv9D
tEdpFPiHgSg5FsYifzU9Rtf8fy38fAs=
=INQ7
-----END PGP SIGNATURE-----

--NyY6YWaxLzVX3FT9--
