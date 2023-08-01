Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F0976B2F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjHALU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjHALT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:19:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE434EFA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:16:56 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686ea67195dso3928899b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 04:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690888615; x=1691493415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/d9qVu/YgKMVuhjhU0hWbA0JqMw1Dt0pNaA2X8wmek=;
        b=cLEpu1fpZif6atTb1LkbVf4G1i4TPB+OFiE4RXQUZPg+A6ZhoAg10LUcbLPsvJYl3l
         7SBxpqYOzAt7LORxMkUuizMhJkXLNFsCm8w4nQemSEWYL9YeZkWOxVu/zuotfsSBWINF
         EuufoRgkUgF99WWvDddKTyIp8pAVcWkOnUWpb5yY48mHMc++5MIuw7yr23XxGuyMhFc+
         yhrRP8+PUv8GKmqwR51imhJ7Vgx9THntr+BrInKefmeXLMrrKUfqvaZMXnQjIICmonlS
         OO+bzooj95qi9tGLIRykfm8RMBvIplz+Kt4R8xVY3hBxz7/iu7pIYAg06Mt290ewUDmR
         wH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690888615; x=1691493415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/d9qVu/YgKMVuhjhU0hWbA0JqMw1Dt0pNaA2X8wmek=;
        b=crHeB14irSKQqkWP+Co5OEN3UYKMtMikDKMhmPBfqESlL5xnyg7Q4t13RJstSQ7yY2
         Mm/Vy4OVSwLZsIOHbBLh3mgQhAmkutxZldYSrnpxgiqC7rnIdizR/EDR67y6iGTm62Ve
         oipXPcHmMZF7H7bNl/TJeDqXKcLG2W/UYDnQ6dCJUyZbVLq4JbZr0Y6w08y8Dlq/P+1e
         38VxstBKNya93gJpNG74kvOGpu/UIa8lIL7H+3DB96Uhbq+0dcQqlB289R4melwTq35v
         Yw0KBvOdplHIohs+P3k1i9o2YGxaxgqLyAB0CMWObCsGGBTXqlORiS/i2KolVwVz6h5c
         Kr6g==
X-Gm-Message-State: ABy/qLYHlFdXIt1baWStLA3c9Ejo9WRk/xLrEQAG21b1u3E+xGzOXZRM
        L87oFEksyV1FBb8MKHo6kJGI3I24bgIlnQ==
X-Google-Smtp-Source: APBJJlEQT4wLJEIOI4URIWAZ3XaBcZXevHviTbAHc+v8I5MziVFXsXSF6IISkcsOmV4HCiEhGp9bEg==
X-Received: by 2002:a05:6a00:16c4:b0:668:99aa:3f17 with SMTP id l4-20020a056a0016c400b0066899aa3f17mr16050243pfc.16.1690888615498;
        Tue, 01 Aug 2023 04:16:55 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id d9-20020aa78689000000b0064fa2fdfa9esm9084667pfo.81.2023.08.01.04.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:16:54 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C9A89801D541; Tue,  1 Aug 2023 18:16:50 +0700 (WIB)
Date:   Tue, 1 Aug 2023 18:16:50 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ran Sun <sunran001@208suo.com>, alexander.deucher@amd.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu73_discrete.h
Message-ID: <ZMjposYeMFxU5nE9@debian.me>
References: <20230801100024.8215-1-sunran001@208suo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Oz9nExZewyCtXaET"
Content-Disposition: inline
In-Reply-To: <20230801100024.8215-1-sunran001@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Oz9nExZewyCtXaET
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 10:00:24AM +0000, Ran Sun wrote:
> Fix the following errors reported by checkpatch:
>=20
> ERROR: open brace '{' following struct go on the same line
> ERROR: trailing whitespace
> ERROR: space prohibited before open square bracket '['
>=20

Thanks for fixing up your tooling to use git-send-email(1). However, it'd
been great to send a patch series touching whole drm/amd subsystem, with ea=
ch
patch fixes one error (assuming the subsystem permits checkpatch fixup
like this) instead of spamming maintainers with >=3D 70 single patches like
this.

And it is unfortunate that you and @208suo.com people doesn't reply to
review comments (try searching lore.kernel.org), which makes me wonder:
what does prevent you from replying to the mailing lists like LKML? Your
mail infrastructure?

Thanks anyway.

--=20
An old man doll... just what I always wanted! - Clara

--Oz9nExZewyCtXaET
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZMjpnAAKCRD2uYlJVVFO
o8eVAQC8i8w0oMagTUhlWHqTriRwuWmnzpcrsbkdtwpX3Jlw9wEAtX2Mn1Ie6sWq
Fjq3EI7u1q5SRe7QS9q9ZY3WCOoWRAY=
=mCUh
-----END PGP SIGNATURE-----

--Oz9nExZewyCtXaET--
