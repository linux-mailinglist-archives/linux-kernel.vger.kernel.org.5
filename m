Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CE97C5E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjJKUox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjJKUou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:44:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADF0114;
        Wed, 11 Oct 2023 13:44:29 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50336768615so410492e87.0;
        Wed, 11 Oct 2023 13:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697057064; x=1697661864; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6aX66cBRnDCOi0/Gtt5IiwJFoyeUsRSX/ZtkBcBa+s=;
        b=ku64DbrlUCrG29LABoAajW2tR7AKdYXJGvtCTiThJkgcZIqfFmJ9zxaUO/mAjZRoz1
         M9kKqVfoLvy1hit77AJX9OLCH7RbxNq5K/pgsGHc5CEcSYTHfCaJB59EJesFvDMMM8rI
         ysOAD5Kwqzv2zBGJcTkKq1S67wgBWYjkTYRrNAV8EvHMj+RUjs752Ggbxh9sChlL6U5u
         +uJmKjlBwKlG9+xih3puwGz1denMeHkPi4ypGfL12BKwOcW1cTHqAdU3CVsefQhFzx1o
         p88Jyf7tjnNlyNBX+QfcNTGE4reHs+5zWWB0flyCw1CGuNkDBnyrmHFqmZU72q7Fsj+T
         ufPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697057064; x=1697661864;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6aX66cBRnDCOi0/Gtt5IiwJFoyeUsRSX/ZtkBcBa+s=;
        b=GK6xBFZWWQ14XG+tXHOApwQ6M+nRxMuCTpcWD4/eitxhTQ37mjUB1ilq0NscmTFbou
         SSULkuws0UBK18T4o9Vz6fwtJ5I5XPFS510+iAPF1VNk08h7tQGI9BAhN5gMdMzLAWHu
         UpNOgOENILBCJBwTi2W6wgHBoRSgWadJ9I5L9xkIpklAPuRrP2qIf1xjR+LVcwutjij4
         Onaz7Bahmz2lU8Z2WHQ3BXsyCOP8eA2aC9eL9aNEsrRLPF12A+yhv/3/CQ10ykeysnRf
         p+58HiDINto21xT3kpLdeJTbIJBQbh3h3KmvHNSvV7IXcakZkQ7v97ZNDLzwiriikyQr
         tzKw==
X-Gm-Message-State: AOJu0YzK0f7MKwurWSM1lNPRnZ77aPCMyet+Hf5GfzO8sOEioUBXWciN
        Mf+RHJHjhSj7P6RTMscLARc=
X-Google-Smtp-Source: AGHT+IE7sKq4jPXrCAsC/5GytMCkM078l9PvAPXBt3mMese9W1ktImwgukCNXyq+AIq5dY9A6mIVNA==
X-Received: by 2002:ac2:5a5a:0:b0:500:9ab8:b790 with SMTP id r26-20020ac25a5a000000b005009ab8b790mr17215603lfn.60.1697057064140;
        Wed, 11 Oct 2023 13:44:24 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k16-20020aa7d8d0000000b0053112d6a40esm9275903eds.82.2023.10.11.13.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 13:44:23 -0700 (PDT)
Date:   Wed, 11 Oct 2023 22:44:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: host1x: Syncpoint interrupt sharding
Message-ID: <ZScJJprT7_OENKCF@orome.fritz.box>
References: <20230901114008.672433-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FC6eHs6d84hP5f0G"
Content-Disposition: inline
In-Reply-To: <20230901114008.672433-1-cyndis@kapsi.fi>
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


--FC6eHs6d84hP5f0G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 02:40:07PM +0300, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
>=20
> Support sharded syncpoint interrupts on Tegra234+. This feature
> allows specifying one of eight interrupt lines for each syncpoint
> to lower processing latency of syncpoint threshold
> interrupts.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/gpu/host1x/dev.c        | 28 +++++++++++++++++---
>  drivers/gpu/host1x/dev.h        |  3 ++-
>  drivers/gpu/host1x/hw/intr_hw.c | 46 ++++++++++++++++++++++++---------
>  3 files changed, 60 insertions(+), 17 deletions(-)

Applied, thanks.

Thierry

--FC6eHs6d84hP5f0G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUnCSYACgkQ3SOs138+
s6Ew/BAArOBHH6vqDRGiO/kZL3ugUGYqKa+95TNhWu4EJWYU8TgAka59tiQgccxB
j4E2kaomdW0JZnrUbZQ1lcyolQbx3lvAlvAU9LuwiqoBrnFbLD6ioKELWm8yzz4d
wX2uRHIOORzfK9PbUK841e8E8IGbt03SQWCRXuKlTJcfZgnkmkl+PICKwpvCYiv5
Z/afeOfyIGHmgVxNrmAzk4DZ7irMZMahGepCO/Cd3Z4WpUD0SINHrFvJYWqO4g/k
KPDMFgmdubjWGTSADIyiblneFVZT9Md8DcfwDUqJSyUwLQx0gfunBf4Sy79lCmxI
U49Q9/hBcOhGEbCCz4xr2nqE00rxwNxAau+7zbzjF4g8LDFiYOcLjoOxBBCk4hB9
4gmY7p87+82ZmTg4BFvlIM5XQnOsxnRj5EoAqF7/TSKlNrrmgUZrzy62GALYpjs5
+93hxN2bLge8h9r+B0dTxpwBEIqvZ60wPzlGHQBUKOROZQCnbIA+HTVmY0d+LScF
MGs+fHAm2nJI9778aGde3aBHooPB+rFgq0jctldbBHnRQdtWfvCmiYmkFM+sM/Sf
efxhaO9ymb+Mzc3vkzK610aBssHBjO+54kubkAWsGZ4bkg6T4tW3mBvMjjwQJNiJ
aZ5N6JRGLJAovX0QgdmOWnu9Vbb59DcN48vP+OglK7Iska1mdTY=
=1sQv
-----END PGP SIGNATURE-----

--FC6eHs6d84hP5f0G--
