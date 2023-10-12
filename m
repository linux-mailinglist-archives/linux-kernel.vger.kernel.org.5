Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2387C6BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377747AbjJLLAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347133AbjJLLAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:00:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E39890;
        Thu, 12 Oct 2023 04:00:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so1518852a12.0;
        Thu, 12 Oct 2023 04:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697108441; x=1697713241; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+n0rDebU7jwVFK5ki1gAR/HtMEdxOBbeUN20t9TKm6E=;
        b=Vr1j6tqGc5pygRemjB2ER7H/ACaxhfyKAQD1kW8a8CU2BSbN7KL+yOarzh9kye933c
         ++mGvu9+YBDLdcLfY9MyW+bO0RUll+k4TS2tvkk/Lr7af3Hl7KJ+BReHsPxAfLcw7/7g
         wlws4vUFjIh9sgNyOBHumcVgUNly/4BP2dKHJ9p7o6f7BPu8WHvH8UgjpoGd92gJ9c6r
         B78iAMYiiuAMD5jqDhZACCaEMxbCu483s2QNyr+H/6SRHYKwXipxKn3Pcy/dFbhP3IGu
         iOHixnRKvPrJn5EQnK1ksPR9EWIyqXy8jq1BBn4aZaRCBxOWiiON87U1K/3P//T5mqGe
         8+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697108441; x=1697713241;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+n0rDebU7jwVFK5ki1gAR/HtMEdxOBbeUN20t9TKm6E=;
        b=fonC7zE4NsnKDYXDSOZ5hHw2Zz2naR1sGTGHmTIPqvP3LhIuk60xoMuCaPHWMKcuVD
         Zu5iVcvd+ORcfIhfK8NSgDTSULGVFjCW9KOM75CxQFzC3Kj4Pl30KRYYb5kCW/gNkj5M
         EBTcFLPbNAhi+96SpIDTritYRrCz3/D5aKwbmCrwKjtHccqULNj83aMDeCibjc4S1x1k
         pRtKxg5rnX6vKS0N+mOk+VsFNT+nEidie4ixOJ6xeEHuFYIrnxGrTwm7Lpq8eWwS2o4r
         GrmKozgKBjTEVF7nO3FZmFB/Ew498lqaze2OOdfcQpQcWxjvGsxwZIrH3/M9J60ppemS
         w8yA==
X-Gm-Message-State: AOJu0YwX03ONs+ThTVqkyOuIdRqef/tqwzrUOiJqwoh1GYyftJCzz039
        E3itVgGZvFde3095b0DuGdw=
X-Google-Smtp-Source: AGHT+IFNgdQuwLRLte7wITCWAxB6YO3wXSsPCORafCEsv1MGDCfcHENZmH7CQZGsWHlgI28pTWC3yA==
X-Received: by 2002:a17:906:2921:b0:9b9:faee:4228 with SMTP id v1-20020a170906292100b009b9faee4228mr15291259ejd.56.1697108440390;
        Thu, 12 Oct 2023 04:00:40 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q15-20020a170906360f00b0099d804da2e9sm11045142ejb.225.2023.10.12.04.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 04:00:39 -0700 (PDT)
Date:   Thu, 12 Oct 2023 13:00:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>, krzysztof.kozlowski@linaro.org
Cc:     treding@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com
Subject: Re: [Patch v2 2/2] memory: tegra: set BPMP msg flags to reset IPC
 channels
Message-ID: <ZSfR1l3lHMScTyL9@orome.fritz.box>
References: <20231009100557.18224-1-sumitg@nvidia.com>
 <20231009100557.18224-3-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r7Jhz+PyVOcqXRlM"
Content-Disposition: inline
In-Reply-To: <20231009100557.18224-3-sumitg@nvidia.com>
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


--r7Jhz+PyVOcqXRlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 03:35:57PM +0530, Sumit Gupta wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Set the 'TEGRA_BPMP_MESSAGE_RESET' bit in newly added 'flags' field
> of 'struct tegra_bpmp_message' to request for the reset of BPMP IPC
> channels. This is used along with the 'suspended' check in BPMP driver
> for handling early bandwidth requests due to the hotplug of CPU's
> during system resume before the driver gets resumed.
>=20
> Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidt=
h")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/memory/tegra/tegra234.c | 4 ++++
>  1 file changed, 4 insertions(+)

Krzysztof,

this one has a build-time dependency on patch 1/2, so it'd make sense
for me to pick this up into the Tegra tree along with patch 1/2. That
is slightly easier because I already have a BPMP patch in the tree.

There should be no conflict between this and the Tegra tree, though,
so if you feel strongly about it, you could also pick up both patches,
in which case:

Acked-by: Thierry Reding <treding@nvidia.com>

>=20
> diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra=
234.c
> index 9e5b5dbd9c8d..2845041f32d6 100644
> --- a/drivers/memory/tegra/tegra234.c
> +++ b/drivers/memory/tegra/tegra234.c
> @@ -986,6 +986,10 @@ static int tegra234_mc_icc_set(struct icc_node *src,=
 struct icc_node *dst)
>  	msg.rx.data =3D &bwmgr_resp;
>  	msg.rx.size =3D sizeof(bwmgr_resp);
> =20
> +	if (pclient->bpmp_id >=3D TEGRA_ICC_BPMP_CPU_CLUSTER0 &&
> +	    pclient->bpmp_id <=3D TEGRA_ICC_BPMP_CPU_CLUSTER2)
> +		msg.flags =3D TEGRA_BPMP_MESSAGE_RESET;
> +
>  	ret =3D tegra_bpmp_transfer(mc->bpmp, &msg);
>  	if (ret < 0) {
>  		dev_err(mc->dev, "BPMP transfer failed: %d\n", ret);
> --=20
> 2.17.1
>=20

--r7Jhz+PyVOcqXRlM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUn0dMACgkQ3SOs138+
s6HkqQ/+OpWQXncgqcn9vEN7Qu10eafaP//XzRWKSSbQOj0+b7uO3EMELiJYhmSR
3ZJfb+7rJ+MKEXmJf76dIbjT8U1FvcG1RmgjMMDQLIKgQ69pYLyVGHSfnMbJkkkA
FVrxe0lL6BUDQytS7UnNQhAw+VeM08RZr2yySo1/VXNF6JAeXsc3lSbFC7T5pw3G
8SU7Lt/XAzYFRyMflJga+IkPeZXAoEMGUE614Wt8hMd5VkYrwFBO7x5RE1EOPDtj
Yk1N6Kb8pp40ODfZn/cFFpEiXHv8klgxtwiZjCdhU6ZBbMqaa2nDdghRkcM/ShJv
DD4RkDdjp2PmruwmgBbQGfTxL09HAyEM6Qlbhaewq5LCdYHRtY9J3Au//NyeRKLW
aSP50/ZCgOrOKxyU+uWhMwESKM1xMbKHoaKBCAXvJLvby1lBIx4Exu7kPmMqc9Ol
2slA689tUJGukxOY7A8ApS0ynlxHhOchQR6gkumOnM5qWKr9CgEPCTXOdex7aaDZ
CtXrEoV2CY2/UabFCtHhWPQ1SCGWAhyetUeKasZM8pPW3eGIZhrjj7Vz3e7kirmu
97h39JjE0ZcdAKIJXfGOvnfGJ60Q1d1WXmMahZxhrau+JUb6mSevuiC7gPyCC6/e
JbMxn8gW5lhXhh4ICEoxWuvOomAMG6hxyTIxQYHeOhwoL1f1ML4=
=nVs5
-----END PGP SIGNATURE-----

--r7Jhz+PyVOcqXRlM--
