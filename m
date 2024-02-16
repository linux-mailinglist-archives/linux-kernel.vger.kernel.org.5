Return-Path: <linux-kernel+bounces-68530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC84D857BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4779FB20BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BCD77F1C;
	Fri, 16 Feb 2024 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZJ+TYrs"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF859169;
	Fri, 16 Feb 2024 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083408; cv=none; b=BBs/OsxE3ZBrF7XHOYBo51HljETf7ad0F/FNV+swlm7BpB2Mq6W5Uq+ibZoiL+TjRNI811Qk5hcKFQDEn3SH2j5qz6Y4CKIoGVQTx6qIf/jeY42wqLt9aL1iuKieFYjZ+NJTy97kZd3Dj3WkhEVEXtPV6A0objP2bHT5M51ab00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083408; c=relaxed/simple;
	bh=/aYZiCQV3Ziq90vP84iGl4qvR520PN8iVoyhRcLNOsQ=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=kYq94lJNW44DmpQrL93eJ9MfYfDUEa+wNEafkI8/XBh4tqt636dAv0OfrIvIFv7NV4J7JUMoQkiMNAQqm8y/a3VNJmwIc+p8pHdYz2X3huNMLoxjGJYEk6BBxGTJ30fKiCkgQYO4VMrjQ7Sdz4wULediT9dKR3ZiWbbvofIddNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZJ+TYrs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26f73732c5so100403166b.3;
        Fri, 16 Feb 2024 03:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708083405; x=1708688205; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krj5k8+V71cWpO8vb8ZHzT1+fsI8D5xdWWG998LplEM=;
        b=JZJ+TYrscPjEDthiB1xtbIAkow6eUU82Ul0kiC7avjztDs0pWd2pCkRnM8z9xyARVa
         9hIDnFupCYQEYFlEuoX/RyLMM8Mp2wQhCDBQOq4gUC7bA5h4CG/RV2df0w3/QO4pWFI9
         HxP66ydn+SK2ZdXWU1NvNHFvKLFfR+ETLkMOA2oFdSfMKyRfdD1lyMt7cvfq6auo9KOv
         ISD3FOlkcjp8dKv3384j41aahGzeNOG1uBqR1LziMJc151yMIT+pmbBtC9C+sCayC0jo
         Lkqo0HdunR+QiuYULjrdHtZ+AsBOzdwvNo7GI3ZAYsMyDso0QHAuEBVx/BArXuzPbZDf
         q/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708083405; x=1708688205;
        h=in-reply-to:references:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krj5k8+V71cWpO8vb8ZHzT1+fsI8D5xdWWG998LplEM=;
        b=T7Gcp+Tb1VR3uB2ZRKwTLNvqmWMRy1tPXelHnnS3L5ZDk38YT3OpaYIhifiYeC/PBA
         2WvG4fVoK5JqYodDXpuj94rSs/U+Rh+KrTgEMIbidYXyA9Z1P+6LNQnQaDtsk4MCbIVf
         UO/Wmr/KZAXKoXQiz5KoQTLtLMVHoeR4OwoSs3vBy1Fe0MMFLtT1NP5hQgz7a9//C1KH
         Psia1LehY8ehvLEyBTcwqkH5PqITefNgHwOU6tIFXWvgCrc7IbDU31apRMMc7TVan1Nj
         MlJ6++HCzHN4l9kg4oaxUK+K8Aotuedhg9QYpUNytq61ddzjL+jzakfUvYl/zNM76p2q
         qmSw==
X-Forwarded-Encrypted: i=1; AJvYcCXk/WUPkFX96IRvomHBl53lN4L+FQNsLzPsIxiq78wmfES5BHbZh3XGQ8ehAkZrzbe8O9fAp/3+U/4nh+67JrYZVnfMFu3eO6XIS8Zw8wSn7K8viiherq30f6dOtWtijxS9SeDQ0CS/hGQ=
X-Gm-Message-State: AOJu0YygYTtBwR2a36/p3NBvOy87Yjv1Zdyt1z2gk5bkNTbw8Aoe5Aw/
	pS0ljS+BOxpJKsxqdA/wZ/klvA4DIvkeqH9NCs9uMsqeorQeFcO1Jir6JZBT
X-Google-Smtp-Source: AGHT+IGLbge1rHEsBBQQH35yemiF7YoxH2kRUo/mHs5+Vjmaxfi5yxh+gbpQUNnLgJDkcMQIEf55Nw==
X-Received: by 2002:a17:906:b847:b0:a3c:b36d:dffb with SMTP id ga7-20020a170906b84700b00a3cb36ddffbmr3003663ejb.16.1708083405146;
        Fri, 16 Feb 2024 03:36:45 -0800 (PST)
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id vk4-20020a170907cbc400b00a3cf243de37sm1467694ejc.111.2024.02.16.03.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 03:36:44 -0800 (PST)
Content-Type: multipart/signed;
 boundary=7dfaaa8787f0119adde6de01fee310d24161838f59b74c6b8992af9b9481;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 16 Feb 2024 12:36:44 +0100
Message-Id: <CZ6H177U2UI5.2451NH03W3643@gmail.com>
Subject: Re: [PATCH] soc/tegra: pmc: Add SD wake event for Tegra234
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Petlozu Pravareshwar" <petlozup@nvidia.com>, <jonathanh@nvidia.com>,
 <pshete@nvidia.com>, <p.zabel@pengutronix.de>,
 <dmitry.osipenko@collabora.com>, <ulf.hansson@linaro.org>,
 <kkartik@nvidia.com>, <cai.huoqing@linux.dev>, <spatra@nvidia.com>,
 <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240216080450.456135-1-petlozup@nvidia.com>
In-Reply-To: <20240216080450.456135-1-petlozup@nvidia.com>

--7dfaaa8787f0119adde6de01fee310d24161838f59b74c6b8992af9b9481
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Feb 16, 2024 at 9:04 AM CET, Petlozu Pravareshwar wrote:
> From: Prathamesh Shete <pshete@nvidia.com>
>
> Add SD wake event for Tegra234 so that system can be woken up from
> suspend when SD card hot-plug/unplug event is detected.
>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 6dfcc7f50ece..dc4eab3191c2 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -3,7 +3,7 @@
>   * drivers/soc/tegra/pmc.c
>   *
>   * Copyright (c) 2010 Google, Inc
> - * Copyright (c) 2018-2023, NVIDIA CORPORATION. All rights reserved.
> + * Copyright (c) 2018-2024, NVIDIA CORPORATION. All rights reserved.
>   *
>   * Author:
>   *	Colin Cross <ccross@google.com>
> @@ -4199,6 +4199,7 @@ static const struct tegra_wake_event tegra234_wake_=
events[] =3D {
>  	TEGRA_WAKE_IRQ("pmu", 24, 209),
>  	TEGRA_WAKE_GPIO("power", 29, 1, TEGRA234_AON_GPIO(EE, 4)),
>  	TEGRA_WAKE_GPIO("mgbe", 56, 0, TEGRA234_MAIN_GPIO(Y, 3)),
> +	TEGRA_WAKE_GPIO("sd_wake", 8, 0, TEGRA234_MAIN_GPIO(G, 7)),

These are also meant to be ordered by wake ID, so I've moved this up to
where it belongs.

Thierry

--7dfaaa8787f0119adde6de01fee310d24161838f59b74c6b8992af9b9481
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXPSMwACgkQ3SOs138+
s6HGcQ//f0JPfFQemTw/AVj0XnDY0Qyq4ffTv5okvdFIaRP3pUav403BUiPGz1N4
85NYWHrawOTY6mjmwORsSNo/2Vjmj0ZUnf9CK8tRgXORsu434TVrQFr519YhDC7V
yngQlDG5E1RpcaJhLTods46uFXugZ5c8u3yjiFjb9nwx7Ntq7HR6mj7+DWhhFx6H
CkVua+IuPQMqREKsZn+cZzyOqj0S5hFNJDuK+a430lAn4z/KYV+zczTJsQrE4AxI
CBJkV/jD9EuMc+Y4sfPFivo6WrwoUBdXtWbLYhl5vPbk4cVojTl4aTDzpoa8Z5sR
/AE3GWptKpbT+fxSbdh4dduQB1YcqRf3KTqB4yHCQlPpmuHLUfSo+DNHRlvp5Cgr
QFw1vySnPx2Oje/mKWrP/S6EXpxAHPQfaMFpDh8Zq1RVUmCCGsnULpM+WXNgO8M1
1H+fGqxzFRffJqg4LnBcZdd9DUi1Gs3bGZM0H6OIAonppJ57fr+IR4RJCQKNbxNl
JU9koXkRThejqqFPTFmoZc3JZmde7jVu1jAfVXZjbCWm8RliW4oHhr247YLU6VFo
7Gff07i7IyInA1OSlkFkc1Nbl9isbSKflzGzpp4k0oCaRhNRTM4TQrwxkhzZSKRM
MNmCPmCQ/1/R3BJhQfEtIkgC+3WZUKAegM96ED2iakcWgPnOk+Y=
=XUQf
-----END PGP SIGNATURE-----

--7dfaaa8787f0119adde6de01fee310d24161838f59b74c6b8992af9b9481--

