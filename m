Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15AE765944
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjG0Qx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjG0QxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:53:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44F530ED;
        Thu, 27 Jul 2023 09:53:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-522382c4840so1558745a12.2;
        Thu, 27 Jul 2023 09:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690476799; x=1691081599;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTwQIB4IHOiPoYJY4vojAM9a3MV+iKb7V2dGlSdgHxw=;
        b=lI+AusB1AaWv/rUwEtomngUgmeaCNMA23w3lJGt8P3qhWbe7l1112+dgzS1rVShHAN
         dIVSqBy5yiOwE8epqwToLeKP9uW81zQy+SpTxxYFVoHryXvPU8+RbAAHiTiLHQlfpNN4
         gbPwI/wwnZl0Lh15vioPDJ/9ZLQ1Xw8Uz1MZTcHJZQCm/YGMVoBF6M+bzSkntaAtcTRa
         sPJVTtORWsiwJv0os6HFzQiCEnomn5cYhoCIesiy0F1hyC6Dx38VrNLYWgSfgZLKAtgh
         I6cd8wRd9NCwh9ysBMJveHWAYgeU9yczgnvF1Hzk8RShl5zZB3qgCS2EHzJHkdNgg8kO
         RZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690476799; x=1691081599;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTwQIB4IHOiPoYJY4vojAM9a3MV+iKb7V2dGlSdgHxw=;
        b=Sw2JEdMHiQB2shMu3NWrw5pIhHA5NvYn2I0FyZg3YbEOXO2jNi/8FO7YSUnWDQi+FV
         6JepH5BgnewvByfnEEFFXPCrlz08am2e+F4/Sen3tnf3Yl7c2ylM0yHkyjz94yGIMkW9
         b2LSAjDmlqAHgDoaOCfT0FhsDviOWzchuyePHaOVEpH5W20JYgRSPwWE4s/e5uwp/Gsw
         RWO1xsj3x/PJiwgm4QzXgXBz5rz+itdo0QrXEoR+jqlkKH46YHxlsdw2KmPSEyyT25w8
         9fm1oLPKPNB/MWvLhZ8RWNcNNO7brAdOjfxW3U/sno3nxe5VWfdR3IemfVP78OxO3c0e
         iWqw==
X-Gm-Message-State: ABy/qLb1uXM+bRHcWAiSRGXVbM20Y9eA7h4OTBEU2jKEH8s1sfBA8Y3x
        YwOFqET8eIrkKjPWrwstMRo=
X-Google-Smtp-Source: APBJJlHZlSD//sZi4Yqmub9w5kwyDbnGQTGIeGaiZDIEWz7z51ZYCOPYl43sQuHnSGiYfY//1+v0lw==
X-Received: by 2002:aa7:d4d0:0:b0:522:79e8:e530 with SMTP id t16-20020aa7d4d0000000b0052279e8e530mr2321644edr.16.1690476799063;
        Thu, 27 Jul 2023 09:53:19 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640206cd00b005223fb6d511sm832093edy.28.2023.07.27.09.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 09:53:18 -0700 (PDT)
Date:   Thu, 27 Jul 2023 18:53:16 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Jerome Neanne <jneanne@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH 3/6] soc/tegra: pmc: Specify restart mode
Message-ID: <ZMKg_ONgb8GokxgU@orome>
References: <20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com>
 <20230727-pca9450-reboot-v1-3-c8edb27bf404@skidata.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T57b0I5ES1wJOef9"
Content-Disposition: inline
In-Reply-To: <20230727-pca9450-reboot-v1-3-c8edb27bf404@skidata.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T57b0I5ES1wJOef9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 05:26:38PM +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
>=20
> Specify the implemented restart handler as a warm one.
>=20
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>  drivers/soc/tegra/pmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--T57b0I5ES1wJOef9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTCoPwACgkQ3SOs138+
s6Glsw//e8DvHgzuym/bjCuZStCD5jcg6Guk1u18gsSrJ+lOk0jCn7/RIffJmNzW
2C6ITO9D6jmW/XqWXo+VUgk/g/CZ3KygGh/Rz1BSptw0VTYUNIwMQgmqkmU8mxsu
xUmU0F2nA6NUqEXvJgrzYpW5mlsqRG9Mh7XqoL2CIzUQKnMafcHYpOvIEzDZ4V+5
2PWSzkkESMIb2MtwnLmQUNy+6XftwkrINrCh0b93cSEJ7OkiWZ7m1J67oYUXVFwU
6+156zr/CrG86g/mAHi1IOCn9j2oZ2BtcTQT53gARyVHHrnODrNTR7VxR6S3cTPl
J2TsWMxeaNpecJ/2v+kEvqcMlpEVKsTGrrA2UzGinZAbzP2SrH8cy0Vi8MYOiWda
iTXbUwvrznjg4Fj5vkpCqUosS2oEgbXEvbadqV77WWxbwENbHzDAMZZ88F88+vk5
b8fE1kmP1qvsvPQ+pJSZajtvxWqZRfOD7cVL5UCjmPas6m3XE4iZBNRYJYYRdpFL
mvttd3rC4iQOXFYeq6c2BvggP5Sy2I776hTI69nBf9EWBhP43MxW6B+KGzYcNivq
9YqbNGpZU8Y+qr9fmxtFhc4i4f0hC9HkTWxwgEUddf3ssmCSh9ysTXuGi62yLWEM
BsJNMaZkO2LDn/NFEULpGhXd3zmFF60L2CfoYJoxF46gME54TDE=
=Zaii
-----END PGP SIGNATURE-----

--T57b0I5ES1wJOef9--
