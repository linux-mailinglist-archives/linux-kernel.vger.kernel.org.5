Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441F47525E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjGMPAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjGMPAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:00:33 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1938FB4;
        Thu, 13 Jul 2023 08:00:32 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51feb79d651so948776a12.3;
        Thu, 13 Jul 2023 08:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689260430; x=1691852430;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvKKxeHn/drcDDjJ3o2/Uyh17up8eYUOE0BIRUsML5M=;
        b=UJST5ZM02gGm1GZWZf54Zb7B6e62TsL62Vcbw2oQzvRhP5+Dp1ybnLvRCaXyBB6ysa
         xD1lI8ZIc3mZVWQNrcnUkV+sVs97Ee/t4Jn2GTCogfPzQcfPdHPynGBbpxQqk9TXunqX
         U/FAsxnynZxjTnTjnDPKqOO46hKXsuJdYzdjlrve+LCgv7q/4Ef0L9r/JLvxjIG2b4oo
         M8D+oz7JpA+mHxL2dMQ/01aUIFKbGN5l+WENoocipSQrObvZ4BGG2qclUeBjxFDvrvbP
         ps7sSJpW5yQbmxk95NHMiCllF093961p6yQCA3R+vpkDYG3jpcPmeeH/4BCEg8IfcwBs
         Gu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260430; x=1691852430;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvKKxeHn/drcDDjJ3o2/Uyh17up8eYUOE0BIRUsML5M=;
        b=SQI5jK5YQL2cxDHFs6s/fvBPQrTJ3WSGIREGJCbkMizXe3sUnxd+jtqB223lCwtfbZ
         7E/UtJeNhLp7gFbggBGEDw9OHMQekc9GpVFoInzeV2Suzo7M9eaSWUEACYVX74EwCXvT
         kzCVqqteCLq85pRth5n1CHPJWSteoedmbyCsmK5g6T07VbabZzg305f6fZ+Ic0NlpV04
         Ot2FfhceOI+k0W5FKbrcs2D2Y4psXehoHyYfxltkQRuv4xy+3BxZMYJJrqfKWb8BStNo
         7OU1zCD+QqvE3vgU8BjiUskyy1OvsuhSk1GCZycLh+WWfjrtav+uP97o4COUD3NFM2nl
         I4AA==
X-Gm-Message-State: ABy/qLZQ7cmYcTUsREb53Hsie53/5cC6tnbdUPkszDoZVw2zGjywJop2
        R3Rjy+zLjdRnjTYXxHA6Xp4=
X-Google-Smtp-Source: APBJJlGxt6QajIu6IRzHemQKx41etO9hzbPue7EVjt9e6xe0RHiOzA97YqmyU/gwZgbysY5HT67wWg==
X-Received: by 2002:a05:6402:8d0:b0:51e:1c18:dd99 with SMTP id d16-20020a05640208d000b0051e1c18dd99mr1863474edz.38.1689260430143;
        Thu, 13 Jul 2023 08:00:30 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id m23-20020a056402051700b0051ddf53c623sm4417424edv.2.2023.07.13.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:00:29 -0700 (PDT)
Date:   Thu, 13 Jul 2023 17:00:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     krzysztof.kozlowski@linaro.org, treding@nvidia.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, bbasu@nvidia.com, talho@nvidia.com
Subject: Re: [Patch RESEND 1/4] memory: tegra: sort tegra234_mc_clients table
 as per register offsets
Message-ID: <ZLARjAY7BBJAEoCg@orome>
References: <20230621134400.23070-1-sumitg@nvidia.com>
 <20230621134400.23070-2-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xuKpBDksVzfhVS5q"
Content-Disposition: inline
In-Reply-To: <20230621134400.23070-2-sumitg@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xuKpBDksVzfhVS5q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 07:13:57PM +0530, Sumit Gupta wrote:
> Sort the MC client entries in "tegra234_mc_clients" table as per the
> override and security register offsets. This will help to avoid
> creating duplicate entries.
>=20
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/memory/tegra/tegra234.c | 514 ++++++++++++++++----------------
>  1 file changed, 259 insertions(+), 255 deletions(-)

I'm not sure if there's a good way to check that these are ordered
correctly, so I'll keep an eye on future patches and manually make
sure that they keep the ordering.

Acked-by: Thierry Reding <treding@nvidia.com>

--xuKpBDksVzfhVS5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSwEYsACgkQ3SOs138+
s6HIug//UhNMv/Rw7aDaH1bBdO0iR+dyQS1cVi4aRKbbyZMOL9Yadn8PoZWy4kA7
S9xLLquryIdD7OvLCdeVRmfZeIzLn33aaGZoR2bjEufCZvLY73u3jRprjJIhaipy
oMzmeQ/4AIJyNjwfHN2tB1HhZIYuT6yNm5CN6lBa226CeVJmZujB1dQJa30YoTGH
O14PtJ1WakprwD0skQm1gzgZy04Q8MqB1L0KWDBkiClNj4wweUeM2sg4QIKSsG9t
zffR5TW1ayZibaCSNIHcZXVZasv6jwzSpMmuKj0EDXIW4fJPmAJD0/txDFRwBZQw
DJGRrCCvwXWhoRV9u3FjYalHGZNikbS+L7nT8y0OOIdgLf6iWITEeXFSwR2SGLX9
NHMlUTAIbr7qnhYe5bDEpRU+vzkaAXsDYzitytYSXCKRWOu/g3hsMpu3vO+2lIXs
cxjpVZg99tG9UTNf8kMnzBn9VQtzCy9VUZdL0i2zKj7Ute63qVGnwUkiYnF3H5Za
zNonblIqkh851PTZA65xasxGLJB2Vm7IRiQtaF1J+O5hBpk8mhvGpOGAeTscPJCU
hU/33Rd/+V+kdSN9istOACBbzUu42M8LrpA3dmXN/INhS++9kaG5SMLZy3w2v7ZM
N2VdoAKQaRbkYi/izRvULK6XmkZ4QLnRFtVRHYTrX/A/sU4eQuA=
=KRjb
-----END PGP SIGNATURE-----

--xuKpBDksVzfhVS5q--
