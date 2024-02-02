Return-Path: <linux-kernel+bounces-49805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39415846F9A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61A429B368
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7559513E214;
	Fri,  2 Feb 2024 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnZw4JfQ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25591101CA;
	Fri,  2 Feb 2024 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875007; cv=none; b=p7ZhpyJJFYufX8VerWv5nTBfuhhmnXT0GEhbfrvuy7qh3WwlfqbcwWR2X37TRgQ5/LUA5Wr/cdiCCQUYCdyf16jFOxbaV4n1Lzap9/UK18vTfbmpS7A0MK7ZvcGJqWQqu/OnnNmeVnnkF6/oqgYfeJMbh2Lo8b5bK4mQ5Qzmp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875007; c=relaxed/simple;
	bh=HPpXztDKtPpvbFK4baO9rz9dfeoqWBJWdIhwAkDd88c=;
	h=Content-Type:Mime-Version:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=iFdrFxQfWbNFwtd5oScnzy+Bw+wgaCM7gTxaiUP7BIk/l+mLvVrinjOs96X8TCulyTnC5xCf00gdtRAWV8OiDOTj8agG/YGJaSGwR00GZaPAYwgsiC5YHzxF5/JNIsX6Y0FsjLmxvkBcK7jCIe6oSeIMXTEy8MOs3ccDeetaQt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnZw4JfQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55fbbfbc0f5so2796913a12.0;
        Fri, 02 Feb 2024 03:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706875004; x=1707479804; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GG+S5GHLjupx6ER5keZYLTe4IHoqCrNyuoTCVzg0jo0=;
        b=MnZw4JfQWV7R3btwobtAUZmJL1huPWqDHRrinoLjL5qxn4HAgX7rvQtR2il4HfiFyH
         +fkSxzKZT+Fx8cmrksT493Jk73L8JD4mN3zQDEAH7HSG0oVi31hGOkqDM97eR9Vjs5Wy
         ki9xo36PDhEK9uQYnKyG+0zYvOuHyV+WXOVM4x7dxrTASZxmTFjBkaHpaPSmuXzDusI/
         zCsZiXc8iAYPPJEPoAhxkzeCPRN2AuGI6sTSOx5rrJdgO0EFjN8FQpnsZntcnqFUkx26
         MptqPsoelNiy1l4LSg4k1KD5qKhVyZJ3pS450NOKFiDVW2/HREwueFsgKl5OcGPS4NmI
         s+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875004; x=1707479804;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GG+S5GHLjupx6ER5keZYLTe4IHoqCrNyuoTCVzg0jo0=;
        b=QGz8c19k9+Q0DYCRXYtxGQ7JL3yes1lAop8vRnWec84JrDAJrY8bgv00QINqEYgVub
         VSjVeuvWsl3yZSGLXMffzqfZwzGWIAALDwn4hG0FfVVEO00zQP52AWiXWj9rqdu9Wjlc
         Mkj5hMfjR4Z5W5DbtI5uC4EjZxF4KPctOlp4vOIIyLwpRZB2w/3lRSVByfTnfY1zRL9M
         aZLw2kyIhTge62TmaSgi/WsiHsTxcpU4vlgsOFygGVY14xLX4rqKLjnL8qj9CXM0vxx6
         wOmgKe4MbcKM9RqbTPMKd//UKD+WYsQ3YEN9tc1h1o5V0zNdLdvx3d4gF53Wqkek1Vw6
         1QMQ==
X-Gm-Message-State: AOJu0YybQkHhTkW/M0nchEtOBfRqSuhmB3Khp/RT0SGC9tksuC5oksqS
	59d36w4nUgpwXNehKX/zAKsVu4I3K3X3NuMIli6t2/9JB7ScxLoH1L1a3cYh
X-Google-Smtp-Source: AGHT+IFVhaTCP6oR6YqmOW2BRG8uTZ9wmXSTxUarlqKneiLmehcQMO5JzmUscfkCox5rMbEmuO50EA==
X-Received: by 2002:a17:906:5789:b0:a36:6c98:a506 with SMTP id k9-20020a170906578900b00a366c98a506mr1625202ejq.18.1706875003912;
        Fri, 02 Feb 2024 03:56:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW5dI5nuJyVEmffMPO+6v4Jj4YjyRyStV61K5coisKkUpFZwVttW+iKe9Vpaqf6dAA3OP3sKD55cFsjMNfame5Bt1LkIO29kFRRRDzowvWVJEQtFBNiCN43aQr4xkLtBSQGH58iei2pLm3Tt28mnhp7PIjLtPfG5oJjyHoME4QuWDCU7y0y6t9bm7jown07s8XNBc7zz0yuCCEbkFY3S23TcPwjIFP0TX0JBanMMkObXjRUqNw5vc0B38HhFyt04RlKtrFBYV8n4B6/VdJq4aZYFE4Vn8fq3D47UtJwUaZlq3Wf/nV3Zw055a7eyNclkKp8uZxOHc8vTVEtO5mzGhs43e6Dli7LdJZMJahSQ742V23J4V5s1rIMphueZTDty+1Y7ytB1S44anJY8ufcvcOGg7JcU2zzogWS9PASM2BcJiPd8DkvCYojLhsJVGZ67w==
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090611c800b00a36efbc8a0csm810284eja.142.2024.02.02.03.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 03:56:43 -0800 (PST)
Content-Type: multipart/signed;
 boundary=e24b41a4f26a8b9a10d9406ab403ef394b90d058a9a15d50ac8b9824a485;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 02 Feb 2024 12:56:42 +0100
Message-Id: <CYUKOVAO5YVL.3TA1O4LH0488B@gmail.com>
To: "Thierry Reding" <thierry.reding@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Jose Abreu" <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Cc: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, "Thierry Reding" <treding@nvidia.com>
Subject: Re: [PATCH net-next 1/3] net: stmmac: Pass resources to DT parsing
 code
From: "Thierry Reding" <thierry.reding@gmail.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240201-stmmac-axi-config-v1-0-822e97b2d26e@nvidia.com>
 <20240201-stmmac-axi-config-v1-1-822e97b2d26e@nvidia.com>
In-Reply-To: <20240201-stmmac-axi-config-v1-1-822e97b2d26e@nvidia.com>

--e24b41a4f26a8b9a10d9406ab403ef394b90d058a9a15d50ac8b9824a485
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Feb 1, 2024 at 7:49 PM CET, Thierry Reding wrote:
[...]
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/driv=
ers/net/ethernet/stmicro/stmmac/stmmac_platform.c
[...]
> @@ -605,7 +606,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, =
u8 *mac)
> =20
>  	of_property_read_u32(np, "snps,ps-speed", &plat->mac_port_sel_speed);
> =20
> -	plat->axi =3D stmmac_axi_setup(pdev);
> +	plat->axi =3D stmmac_axi_setup(pdev, res);

Looks like I messed up splitting these changes, so this will actually
fail to build before patch 2. I've sent out an updated v2 that I've
explicitly tested for bisectability.

Sorry for not catching this earlier.

Thierry

--e24b41a4f26a8b9a10d9406ab403ef394b90d058a9a15d50ac8b9824a485
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmW82HsACgkQ3SOs138+
s6HByA//T7KnD4H8sVbYiDUKxEteI4BxxUWpTFvQCch43SAhItvc5yB+OqDK13y9
ZlxwjJOht8LZZPUHMNP3u0sZSP8A+SzkOdMaFayTTWi0rep+SxwroYkbftIyXc+1
+h7nUVp6YitkAFl7wYWpx4G9aDawDc5+qH0WPgxA+g877bE5iyY8RdssTVqj+2BK
OSomWN5F6tjK7ZzEVPa1d7otssjzmrsRWOq+e0EAkFShWELfPnbFaDpUtwNPfrmM
tRLzbuuvqxVDhUvS+ciFYFEq11mG7fp3FiiNFgFKlr2S4Iup5Tv+fyETk9W+rJ7T
7diy09G2yzxDFYbFdlA+2gUYZONuK+S1G1qbEHefgT5ea2iBUnSxk+xeiEkawQU6
1hetSvJYKgPZcS7H9ulZi1igX9+3gGSg/O6OnIq19Ka02/dOHbu6/XVHMQ4jftmK
f4TSeZJOEQ+X2MWRMyXz2jbdNIrC4l/21A+J/7uetVbEc+PC2LyAbuAzNIvwsmt0
wG+FFS4KyN6vNvsOsIy0si/e7WVgxdEughzkerOgXk83ha0XYC5/J41nN02qGxg6
//P16mJOVi/LBpwFiSEkndRJxw+YsTgl32NRCAdoSv49IB6aWlz3FPHENKBx8fBc
3govTWDRwfkaF14qTuzuCpNZzyRomHDie1T7Uc4g0AsbxYXjLRY=
=pstN
-----END PGP SIGNATURE-----

--e24b41a4f26a8b9a10d9406ab403ef394b90d058a9a15d50ac8b9824a485--

