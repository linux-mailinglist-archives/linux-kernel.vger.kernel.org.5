Return-Path: <linux-kernel+bounces-74767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E28185D95C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510DF1C22EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD2969E08;
	Wed, 21 Feb 2024 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqyGWigy"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F396E29AB;
	Wed, 21 Feb 2024 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521447; cv=none; b=CYXMPEC6xF7gKYqjkQKYZyGn8ymhF5qrvHI+rS7feEwT0FeynW/A9Psz35QAdLk+xoDc24khdGGC5W9BAAmCzNViYkIZpWbRUgBVx2+VmHRly2tr1a/YA1CHh7UEHrlTGDk+vrvvPC6SJI+2oLyopOGqYc1LB5E1nBGAcnvzD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521447; c=relaxed/simple;
	bh=8weXbsTiZXDl7Df+7SFv5Hv/18BWCIk0oX6HwXJCWWA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eJD9/dowASPwT2FdixbDjjEWOdeZok3PJG+hSA7yAfZlT0Mc5d6aBwj5bpFbjDgainY0JEt0P9ZuQfMXlnipycz3YuqulW34zsG0ODS09FkbHd02Rbd4YmLkmoPobgVLwq4mKgYa2Ntei/N05AFxoeF34fodMJCqY7Sd1L1Ls/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqyGWigy; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512bc0e8ce1so3675257e87.0;
        Wed, 21 Feb 2024 05:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708521443; x=1709126243; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/VbOc4RnNw4E7FyceOF8PbK4TjGH9qC/rWBexDcUoYM=;
        b=OqyGWigy0iM8de93b+aCzktsZ97KcDcGYOSmCBaEoZmd/zZ/Pw9aqd6HsP3Y47XiuB
         EYz/2EIlOw4YsQrTgGQC8z9jMHNTS0BZZ0czF4LRhNw3sc3Zn4UeUXAmnfAiMy3bHL6f
         mqNzwCuEz7xgiXqEq4BSRi4kL5qYvn2lrETTeon+n8w97D3ryVoXlP3ivEPxaKxzb6hE
         lXREzit+iOHbird+JxzZjCutVygX0DdOUgSemLUTZ+e0kXJRS9yCuHTTPPmbPiSmi2dL
         7qEyX1Q5bcAfAMy7HFf6iSvTkDMHMhjeRe5yeMQcDXas89AKnjvetukFutPVPCeBJoEj
         1Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521443; x=1709126243;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VbOc4RnNw4E7FyceOF8PbK4TjGH9qC/rWBexDcUoYM=;
        b=PKSOA+3Tey2ye5rCyAQI4ks4S0XhIA7C8H/aSeWUDSQGeJUykFy14i9Vjh8kVxUzq/
         D+z2mSpfOdN9nXWseeae74LKJl8eJK56wywmdv1xmPKCeBxbyNF4pLwlBy6e2+updWNA
         trohehGaJGkzEuQrWjXb3jAfEG7FnPlenEJKawmlJRN/u3fRSsAa8deeQdEuTsWaEMkO
         RZRexF24ykcGNMqrfH8mDyeNWc2IEzFJCcnkbwsbNx6ELdGpHUJlY3mZc9zBnT/Ob88W
         YAEtBN5kX75Vkhi/CYQ5cWKwfREtHjjKLK8C5QghQtUpf+mgTe4uGOkoHK7UKyUFHAST
         d62w==
X-Forwarded-Encrypted: i=1; AJvYcCVi+wNxkghKBCwaBc4oHHcPiD1lazVSHAY8EUeS6k1Knm7mSrISD4apYB68/Bfec3jJw7fsHaSEogDdGT8wLh9WIhEieqKxboz9ElRCB4zxh4E11thQhQBny6A0IOSG8qdVZNf+QhV0N0BNywoF1ybjs4a9cY+y7hw/VYn24YVBKu3VBg==
X-Gm-Message-State: AOJu0YxLCHvPHjvnNaT3Zsid7AZNtzLGy4ErjcuJ5p0zMcu+iMP5ZWqs
	KN3tToRuhtiwjMCWeTONqkN/lC7KCkyRwGOL62sx4VJNCpxoeltTrPDgS3ZDkimd8w==
X-Google-Smtp-Source: AGHT+IEY6xWfntBRZepcpRiVs4IGWFN0HX34/r/c6/QHCM2YoFA/Ni3yp0hUiC+5hl9fpYTIvPRqgQ==
X-Received: by 2002:a05:6512:3c9d:b0:511:9d36:18a8 with SMTP id h29-20020a0565123c9d00b005119d3618a8mr14661653lfv.2.1708521442728;
        Wed, 21 Feb 2024 05:17:22 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id p15-20020a170906140f00b00a3d2f55bc2esm4978855ejc.161.2024.02.21.05.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:17:22 -0800 (PST)
Message-ID: <94f7e7f2568d0d70055954f628b2bd56cbe78d9b.camel@gmail.com>
Subject: Re: [PATCH v5 4/5] iio: amplifiers: hmc425a: use pointers in match
 table
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
 <jic23@kernel.org>,  Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ceclan Dumitru <dumitru.ceclan@analog.com>
Date: Wed, 21 Feb 2024 14:17:22 +0100
In-Reply-To: <20240220153553.2432-4-mitrutzceclan@gmail.com>
References: <20240220153553.2432-1-mitrutzceclan@gmail.com>
	 <20240220153553.2432-4-mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-20 at 17:34 +0200, Dumitru Ceclan wrote:
> Change the match table to use pointers instead of device ids.
> Remove type from state as it is not used anymore.
>=20
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---

One comment (Jonathan might be able to address that while applying)... With=
 that:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/amplifiers/hmc425a.c | 29 +++++++++++++++--------------
> =C2=A01 file changed, 15 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hm=
c425a.c
> index 13e018a59637..77872e2dfdfe 100644
> --- a/drivers/iio/amplifiers/hmc425a.c
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -41,15 +41,14 @@ struct hmc425a_chip_info {
> =C2=A0
> =C2=A0struct hmc425a_state {
> =C2=A0	struct	mutex lock; /* protect sensor state */
> -	struct	hmc425a_chip_info *chip_info;
> +	const struct	hmc425a_chip_info *chip_info;

Since you're doing this, I believe you should also constify hmc425a_chip_in=
fo_tbl[]
and mention it in the commit message.

- Nuno S=C3=A1


