Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA49813880
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjLNR1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjLNR1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:27:36 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4421EB7;
        Thu, 14 Dec 2023 09:27:43 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c580ba223so29611195e9.3;
        Thu, 14 Dec 2023 09:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702574862; x=1703179662; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhNXYxyAPYzPWe6n1/YVvZ3TcijeuBnRICz1efGH75o=;
        b=cQKdi02F5sAauJLM9oqT9m2bNn9h8tz51M/z2AShDCnxFukeEW6lPcJVydqHLiq73M
         lR6Re8GTIx1QzqZgLwJ5t2l+5lkoYx+ARl+WVnBaBRqd8HmdCiXUDiC3wd+Y8wizFTt7
         WnM8fOv43r4gc6B/qwrDOoOtzH18F79Rs9Oedo1rZQQSbXdqU8v1NFjUCdp395Jna/Pb
         fNdJEkbJQVbDfQM4VQ8y3bgldZ5ktZW4enk/YXyGTaEcg75sGOKEw6wnLJK6q3yGWiSr
         SLaJObVRUatRsUZWjj6jvmmzF01CyHAH9OAohZkzFtAyZoY2Qk5Cg31gGxqMJjoeoxu7
         pAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702574862; x=1703179662;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhNXYxyAPYzPWe6n1/YVvZ3TcijeuBnRICz1efGH75o=;
        b=DQoG+9E/fdQ2avjZCGH7OUESH2EQ1f5WDyO/tfPnaKDJCfPzNNeDIVULynDVF9VV8j
         RChfreDHnmewHMZAER1SdRtIIsNVHeRU3VIzWKc5TwnN24JYSJx+NDhn85RG5bGDSW6m
         54XrEnN4YLiF8nYNE725o+jjgSOD0cdYJ/bIDD5nKEzl7na4iPsTxEkxhpM6Gxk4gsPK
         EFDEmd6a14e38++lRLc3btnpAEBI3Xehz3RZuM3pb2cQCJ+Udgsoo94hBbPQYCSgyPWe
         Q/+ciEqLkcI4BF37jVzPUdsdA6hx4C9eRCpW6ohnuFviHisZKEOK35BwhmnSY+fS5sY1
         9mjQ==
X-Gm-Message-State: AOJu0YxMd5MLj6N865rkLysTVPVVxmKnmdKAzd2EeBefo4UVbT0vFCYq
        9Mi7nrjSdIirSpHiwy//veMIUfmNHMc=
X-Google-Smtp-Source: AGHT+IH6Yd3h0/uGmjXlcw9M/CRAc2BZ/TlpTItAVqacJkRFU0Q0k2bvne3xpqFXQ6P2hTW1lBP24w==
X-Received: by 2002:a05:600c:501e:b0:40b:5e1d:83a8 with SMTP id n30-20020a05600c501e00b0040b5e1d83a8mr5741736wmr.60.1702574861554;
        Thu, 14 Dec 2023 09:27:41 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h2-20020a05600c350200b0040c44b4a282sm17521133wmq.43.2023.12.14.09.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:27:41 -0800 (PST)
Date:   Thu, 14 Dec 2023 18:27:39 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     mperttunen@nvidia.com, airlied@gmail.com, daniel@ffwll.ch,
        jonathanh@nvidia.com, p.zabel@pengutronix.de, lgirdwood@gmail.com,
        broonie@kernel.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: dpaux: Fix PM disable depth imbalance in
 tegra_dpaux_probe
Message-ID: <ZXs7C6Yp77UoMCYV@orome.fritz.box>
References: <tencent_B13DB7F6C0023C46157250A524966F326A09@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2ga4bhpKz+XbSCEL"
Content-Disposition: inline
In-Reply-To: <tencent_B13DB7F6C0023C46157250A524966F326A09@qq.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2ga4bhpKz+XbSCEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 10:10:55PM +0800, Zhang Shurong wrote:
> The pm_runtime_enable function increases the power disable depth,
> which means that we must perform a matching decrement on the error
> handling path to maintain balance within the given context.
> Additionally, we need to address the same issue for pm_runtime_get_sync.
> We fix this by invoking pm_runtime_disable and pm_runtime_put_sync
> when error returns.
>=20
> Fixes: 82b81b3ec1a7 ("drm/tegra: dpaux: Implement runtime PM")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>  drivers/gpu/drm/tegra/dpaux.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry

--2ga4bhpKz+XbSCEL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmV7OwsACgkQ3SOs138+
s6GKVg//eVk62JGZsNwcomhQ8UjV7GIdFwOYPfRJbaYoFtmZ2jZqMOdYE/NDYYMt
BkvN6UEK87BP4lslecYI7ooR2ORjKjtyX2/8NLqhQSsDxUCbrBjU1VhRO0eyiQvm
0wwFvEF8nWMLnKtmmklnpO9i9T5EuKGOSshRYaRxgN6gJYJGrZLOt+snSMuGx1Pi
BKsyukdE2vHVQ68oiyvMyoFkkEKjQljc8/mkOAhsKxFqObbOwWUJUVZusvE0AoPh
+NuzFBtkCubHntRUaUdMmomqWBufK+xzFPxSuGu3IhJFOfed6y+ENu+shaF0vP98
vHz11q1n5UX6DRgfUhTp2yZLc3HDC/qWzUj44dvccd6HUOUW8he9o2yjle49ZOEG
pwFpmJUICX805jFGhgsL0FenugXkacrQM+VHAnWrfQJfsXR7U5HW9H52So+V/mC/
+e3Vg2Bo7OuDwYR0z2qpxwptT1tH3igfX4t+YZOQxpHPhswPrqwtNW+4ZHWj/bD2
J/A56TIedeoEaL2NdiwhXEV+rqEgh6kTT+OQxkUC+9r36954a2oNi7dUaA69waLk
l+NCMB/lCA8GgFyDTQNWMTNirz0/vficWJx/lE1YArchkglCtlfIIDtiYF3udAzb
4JeZocrkxuxwUxIZltPCyz+rMoS7FUds237S8hXO68sON4uIxRk=
=EYX6
-----END PGP SIGNATURE-----

--2ga4bhpKz+XbSCEL--
