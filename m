Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B81A7E196D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 05:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjKFEqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 23:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFEqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 23:46:17 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9B4DB;
        Sun,  5 Nov 2023 20:46:14 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so4402954b3a.2;
        Sun, 05 Nov 2023 20:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699245974; x=1699850774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=32YDJ9UCxSqwPmBexBFw6Ms3U4O90iERTciee1S7uFw=;
        b=m4CnkeUTkGzbP0q5uBPryJt6YmKBZ/Ev61svjdIkgxlG9T14neWUixSw33rtcVNObv
         nomZzq7VADIwPPxI7xXJbPkJV8qcWnEP0CT2Qg97xF0aA1ZBdE4xGem1PX6UHo983SXz
         la2XyGvPLdZwLLK0+7eS3cqnRjor3agMEB4opVf6vLcNKTVaZE+zPpiPP0Fi9Ox9vjid
         vAfa2r91pW3GMX3BmGN9lwCqetwsxH99bGNSj34ey9o2hosA9+jGTaeyYegLk/dXvmW4
         prMqWyHDnwXCTgq59aZS6NAlehYzi3bQrib4cfkwIEJeyCECqyWuc7DmLJY6nyGw6JF/
         +lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699245974; x=1699850774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32YDJ9UCxSqwPmBexBFw6Ms3U4O90iERTciee1S7uFw=;
        b=LlXBaCs8CEpeifBZqdvJi6WxV6yhj7Hqw5BmU1wjSklmVjEVR0xpi790STNtXg9eSh
         lLG4Bwu9IuTMslWV83OttW2TVJtIVVQsTFtDe4sa710wOP4oj/Vuy61B/S21IwLn/wl/
         PADYoRnQqtemD/CrXGkTXFlEki/5UmdREesaiMNTU5Jj4bzho0Of+huLEouBum2Pne3K
         7zCisAYY8erdY9k3NMQFMs2CQVZnTnUe1J6IEZMvOHSGTOj3ijnoZqolPd6eNywQbQBt
         VjbV205qZY8T0JZUA/SgMIp7rp6pqTNxGkqbgPqH9awFiZi2FmoePyJGcijfhr+X60zr
         KEtg==
X-Gm-Message-State: AOJu0Yz/cjKOuHr9/hS+kPw+noeYPRJ4Aiw7967PgqMrqcZB4QBV3WbC
        kUD/8h/6VD8cPdHmYZRRlHM=
X-Google-Smtp-Source: AGHT+IFfATC9E2EJdl6t/GNI8B9ZZ98HIGEZfXC9l8qyYKjBLF3c0dva0LIDFn/gFjZSeVYYioBINw==
X-Received: by 2002:a05:6a20:144f:b0:13c:ca8b:7e29 with SMTP id a15-20020a056a20144f00b0013cca8b7e29mr35142833pzi.12.1699245974114;
        Sun, 05 Nov 2023 20:46:14 -0800 (PST)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090330d200b001c627413e87sm4887823plc.290.2023.11.05.20.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 20:46:13 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 3EB5A822370C; Mon,  6 Nov 2023 11:46:07 +0700 (WIB)
Date:   Mon, 6 Nov 2023 11:46:07 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Hunter Chasens <hunter.chasens18@ncf.edu>, corbet@lwn.net,
        Jani Nikula <jani.nikula@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] docs: gpu: rfc: i915_scheduler.rst remove unused
 directives for namespacing
Message-ID: <ZUhvj2uj_PvaDxIM@debian.me>
References: <20231104134708.69432-1-hunter.chasens18@ncf.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6Wwjq5qJEKQkV4NO"
Content-Disposition: inline
In-Reply-To: <20231104134708.69432-1-hunter.chasens18@ncf.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6Wwjq5qJEKQkV4NO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 04, 2023 at 09:47:08AM -0400, Hunter Chasens wrote:
> diff --git a/Documentation/gpu/rfc/i915_scheduler.rst b/Documentation/gpu=
/rfc/i915_scheduler.rst
> index c237ebc024cd..23ba7006929b 100644
> --- a/Documentation/gpu/rfc/i915_scheduler.rst
> +++ b/Documentation/gpu/rfc/i915_scheduler.rst
> @@ -135,13 +135,9 @@ Add I915_CONTEXT_ENGINES_EXT_PARALLEL_SUBMIT and
>  drm_i915_context_engines_parallel_submit to the uAPI to implement this
>  extension.
> =20
> -.. c:namespace-push:: rfc
> -
>  .. kernel-doc:: include/uapi/drm/i915_drm.h
>          :functions: i915_context_engines_parallel_submit
> =20
> -.. c:namespace-pop::
> -
>  Extend execbuf2 IOCTL to support submitting N BBs in a single IOCTL
>  -------------------------------------------------------------------
>  Contexts that have been configured with the 'set_parallel' extension can=
 only

The warnings go away, thanks!

Fixes: f6757dfcfde7 ("drm/doc: fix duplicate declaration warning")
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--6Wwjq5qJEKQkV4NO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUhviAAKCRD2uYlJVVFO
ozwWAP4tUvIkF1gh+MbNCqESi7gLMuWjBdyWuZTEHcgyN3SBywEAkiw5LRZhtw7s
X12IB03vD5Sr1fxvaXjdv9YYpRrjywQ=
=MAkp
-----END PGP SIGNATURE-----

--6Wwjq5qJEKQkV4NO--
