Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED41752603
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjGMPDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGMPDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:03:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4176E134;
        Thu, 13 Jul 2023 08:03:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9891c73e0fbso168782866b.1;
        Thu, 13 Jul 2023 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689260608; x=1691852608;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IfV0L+wpIx89KzIN/UWWh5fvAz/1plFfX5CSMy1Gm4=;
        b=HwwljtV0XLVXzPXu0fRSjk9S25Hud5op8zO6F4M4+i9pGxR522ks9mvJg5DGhQbCkS
         ngpLaEJQVuWw5u3u3ueJquXL3leLaQ3JSS9OdsmOig8QwURW300ybyQMliBXEo1UanG8
         2sB57KODXaHGXT2ZQkPVfNyRY+s9y1IsgkhCrjB5GR+qSynTCYGKT7QziLm2CXeaUoGt
         1gkppGp38PD7CoP7iwA/phD4REID242Kt0wF/J6Y5NhdGqgwxjKZYxnZE0aJqfL9+Ihj
         TSpYXefqe6p4IgLy2W/kjXuihKZulMHiNh23jPzNwFmHa45btot1fA2lJ5FG/yLz2iaC
         lXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260608; x=1691852608;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IfV0L+wpIx89KzIN/UWWh5fvAz/1plFfX5CSMy1Gm4=;
        b=QDTFnD2dnrBc+wiZqcLLRGqnPGihaOu5IBo1gpAA/0I0hF6NzoZ3lJhjgHGELn2pYl
         yA73uo+3dXsJGHtu3cyEgRr60/v99ZmM/tLku9gkK2rm1Qq7rdRa8qyzwb2zTsqBB2mv
         I4C+Q358VlltASh38zZwMbbzjs1Yc6umQ0/e5ba27RQLu0WWbRH0yQT3g7kSuIJVbwYx
         g2lP15otIFO1YrUEkWN30kUmhf3UWsEQJ/bOOmRtCsUNDQ7zfqdnkrqtbIFN3HzMMzbN
         0v7ao6d2JZB9UShtHW2Isie/Wej8+82o2wijoDJk6M8SrrYilXe5Uqo/WuIRmM7uCSqr
         aQ4Q==
X-Gm-Message-State: ABy/qLbrGlNa4kRwCoQC8YQOgO9pRVebE9+P9j6U5sd+/LccBNwrvg4H
        2sPuAnbLo9omqUPF94BFvww=
X-Google-Smtp-Source: APBJJlHCkSZYhsgShBliWDXQQ/lfUEvuMWshhaiXmqhhXDiPAIHnn3zvBhcenhgtTGf3uQGPeg+3eQ==
X-Received: by 2002:a17:906:10cf:b0:993:f127:2391 with SMTP id v15-20020a17090610cf00b00993f1272391mr2905599ejv.32.1689260605126;
        Thu, 13 Jul 2023 08:03:25 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id gr19-20020a170906e2d300b0098e2eaec394sm4166400ejb.101.2023.07.13.08.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:03:24 -0700 (PDT)
Date:   Thu, 13 Jul 2023 17:03:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     krzysztof.kozlowski@linaro.org, treding@nvidia.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, bbasu@nvidia.com, talho@nvidia.com
Subject: Re: [Patch RESEND 4/4] memory: tegra: make icc_set_bw return zero if
 BWMGR not supported
Message-ID: <ZLASO85BoEGeB4eH@orome>
References: <20230621134400.23070-1-sumitg@nvidia.com>
 <20230621134400.23070-5-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i9SXkI7k/7AQWfze"
Content-Disposition: inline
In-Reply-To: <20230621134400.23070-5-sumitg@nvidia.com>
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


--i9SXkI7k/7AQWfze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 07:14:00PM +0530, Sumit Gupta wrote:
> Return zero from icc_set_bw() to MC client driver if MRQ_BWMGR_INT
> is not supported by the BPMP-FW. Currently, 'EINVAL' is returned
> which causes error message in client drivers even when the platform
> doesn't support scaling.
>=20
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/memory/tegra/tegra234.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--i9SXkI7k/7AQWfze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSwEjsACgkQ3SOs138+
s6H6/xAAt8PZMR4/mr+Uvo1s0B62g7Le+Jssxl6A1AIemwWglQe7dh3le2h7sp+u
0byOvWga2mq0fcamheZtbQYVDwhfcVNaoejfYvjiUfZUoo6eY+zCnmtdd/Hz1pMy
iQyZ8uQnUpxWkVX8Apx0Ghy67uGicRg2Brm9Lkq3IrgigXrdme/7HOuy39W+4F3h
zoun/AyB8Nlagscdi3d7u+v+6jvFGd1Z5+/2AvAJfEfjgYal91WKDnNlgEUP1Dii
+LK4VosFzYVQhVKTlER59Jx3v7KcKo5iJ03305JTH0WC/5FIWnO3hAm4DsKALTCV
1jZUEww9OXg4qfFdB9ka7KxTINQVuNiUK0p1rnsrfBbqF10v5JTjy6BHza0bhEVO
Ts1vjcU773lsdkWHd7ix0L23KE41u4XMUBylXlJOkcz9CwgJL6ZDUCOGgtNq0xj9
kvhNOLEapsY/0PMdYm+AP4jMFEiyJYxG9tpSOteruxslFCE4wl2e/B5JtmV7VJj+
EY/RAqTVVw8xMKzQwsYLOCRVPugSCctGJTLWY0hwJBvdr93ZBkzns00J7sx96uJa
HI1YrfmZLZd7fYabrV5cNOXTDjPkWdWlwjeZB9kZwADOFyL7Ps0ovvbDHqKYfxLC
f1K/QrFlCE9UwOZxEVXtLJbKODiL6mK0O+mXOg1T0VcTHAs9KP0=
=uOA6
-----END PGP SIGNATURE-----

--i9SXkI7k/7AQWfze--
