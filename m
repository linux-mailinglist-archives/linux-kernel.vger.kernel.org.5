Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4307C0157
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjJJQNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbjJJQN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:13:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC3DD7;
        Tue, 10 Oct 2023 09:13:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso54331145e9.3;
        Tue, 10 Oct 2023 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696954403; x=1697559203; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap+ERWrbz8gWnQjcESvO2qjRnXglMjuwKN0/PSGnFg0=;
        b=FvYq9FOIBqu/MLZGCdXQK/MANbg7nEmQSNq8nSGmdm9M0ta0zHi5OfO3K0Jsx28vbO
         PY/qi3o6+6/O9i6mKH30cMM9e/dcfyH8VgRGaE53+8K2VDnO9DQa01ZM77tpWrCLPn3S
         B9407kf+bg9xDUkCLoLoZ3aBldNcKkSCvLKkoxc86TeWiiSMvTtH3dDxdDrCmQNnCD10
         LlbfpZewDXIIfYdQAQBCyr0dRr50C98n409EXurJ5DZU5MehLS9/PIWmmfQptl3WwbPW
         yXLQmqWeaFboZHpffDMqAV2OeJGvApixXzOr0uhe3BOyNuwQyvG2iA9bSgonygFPeN7O
         03pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696954403; x=1697559203;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ap+ERWrbz8gWnQjcESvO2qjRnXglMjuwKN0/PSGnFg0=;
        b=honRKDmiNEMymhCTsOLg7NpZLyWuUCCvc0Af5SLSDFGUpDJoNouAqey5lCNWWG4db9
         rAT5y6PlOty+x59rd/Pd2knePTmx+rM+nu9T1iRrG4rpBXFJ9aV7D8/HMcT4fUYWSHg6
         j0u8CYPdni5QFX1NtUJ1MC4A460yyvEWQlm+vu8FE+7SPBarA8lTl8p7Izc6OwKuE/gi
         tv8njhOQ8X3PJKwuRHI0zXdlKpzIz6AnMVrrc9oHexZL7JT5oFAzYlh8xd8pInLKf2ch
         cOmJD0eQMDBiusNgISV3QJw3ZAIgBaDMNxy2PO0+zlMUFW07qWcAE7e8f0m+tdW2ex7T
         62KQ==
X-Gm-Message-State: AOJu0YxQb6Hrb5+OqqUjeNC4QIi9rTDfBfA1vflo0PJmmm+B0ngKehH7
        vKzP9Qcg2xR0/xDOvfCENOs=
X-Google-Smtp-Source: AGHT+IEypkUu60r/7M4MteaQGqYfpQ2I976+ro3MbRwmSKjVUz1bIssOulFjRMi9z/oK/sOWSHAQtg==
X-Received: by 2002:a05:600c:21d1:b0:405:3ae6:2413 with SMTP id x17-20020a05600c21d100b004053ae62413mr16441550wmj.25.1696954402610;
        Tue, 10 Oct 2023 09:13:22 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003feea62440bsm14455869wmi.43.2023.10.10.09.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 09:13:22 -0700 (PDT)
Date:   Tue, 10 Oct 2023 18:13:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, ac100@lists.launchpad.net,
        gregkh@linuxfoundation.org, marvin24@gmx.de, alex@shruggie.ro
Subject: Re: [PATCH] staging: nvec: paz00: remove unneeded call to
 platform_set_drvdata()
Message-ID: <ZSV4ICULpZ0jSGGW@orome.fritz.box>
References: <20230809154211.15741-1-aboutphysycs@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xXFtpkf/V8blOu7n"
Content-Disposition: inline
In-Reply-To: <20230809154211.15741-1-aboutphysycs@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xXFtpkf/V8blOu7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2023 at 06:42:11PM +0300, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>=20
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/staging/nvec/nvec_paz00.c | 2 --
>  1 file changed, 2 deletions(-)

Seems fine, and if Marc has tested it, that's good enough for me:

Acked-by: Thierry Reding <treding@nvidia.com>

--xXFtpkf/V8blOu7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUleCAACgkQ3SOs138+
s6Fwcg//dbOT+ITHbevm6Ruz8/p44G6Loe2ygmnkQ9V0VXcuLpF1u5+IlXy5Kiqu
8eRdplUrng9qkDBKLl7OtsPgbM4hF3pOZmyQf8wep+f7f/8/dP1ERtPE8gFpMlfN
RUZorVq5Ds8r8HMycIzUf7iNOLYM7gzVLjkWdzChjmC7pjsvcjFZ7kJuEwtNq7X/
FNDgfedUA0J1bx+QzNzW4hP9IgukUzipPxMc9P6DE+bRhFTIVOHjsYaIRDs7xHg2
+KCUBNo2ok6hz7Z3k5JGgQc3i5fceRjVCYjKI8QXSUXg81pXJXmW8YI15wP22lKg
eDKnvY20EgIDfLSYKKn+L4EsuX1qruyWn30rmY3gIJMaZR4wrXnaPsnht08AUuSh
pSOihARTyhOA6GuwJPtF5yUGKnsgT+wpKPBQHYSpaB2MtLFM6PqQ45+nh1WMw2CE
PURvns5vlfT2YnmOw32NR8QZf5MiAXS/K1aFfE51x6OvkNQyqZICO6m31UUZgYB+
loZLWXS7IlV0PI0PBsR+lPVdDyTdIXYoFO6iWHTL5fi+qsZn5cYAZ2ZzcJjxyEm4
2ZhdcAro3zpKa9Qb03RoVJwslzoo9uQiDEv1dUSytemeQGex9+YoWhpeODVikhaQ
3n0fliQGSr35dPgJqUmza/f+0KeMQMnch5tw/Qeg4c/iBtqJ9k4=
=rvpO
-----END PGP SIGNATURE-----

--xXFtpkf/V8blOu7n--
