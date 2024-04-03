Return-Path: <linux-kernel+bounces-128913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31288961CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536941F21840
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D237111A2;
	Wed,  3 Apr 2024 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+EfHFkf"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231F3FC12;
	Wed,  3 Apr 2024 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712106689; cv=none; b=L2LCVLxLXIKUXlQQOusA9fziXgcq43RyZ9Knu61DAH93wSXvBNiGaUZ+bhejHy9iUvXMRFvaOYcZHKo0vKtFCGX0S6vzVsQ7tEz7CebmxMXTW2GOGY1M7At6hNwDFgwH8H7oyez6dy+0DcKqfVrPkzSfeMjGJHc0RmrfvFkpke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712106689; c=relaxed/simple;
	bh=lnTs2cVXM93CsaTLuEe4HYuxRslxisuZ0kDsO5APKs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWzNTQO4WO52+wty+WpUfu/dvv7SbplmGkmDPpNQyVjVGNfGaElD6wVw3VpzimMak25pXZ95LLo96zsa8UnXmZcCPZna9FKZhy7a/XMpPP28FELW6A9XpE3Xa5k9sv+wdMXCSDae3piIScbJ9RALwy/9XsPHTQHqySdL0/NYEW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+EfHFkf; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-614426b016aso8593237b3.0;
        Tue, 02 Apr 2024 18:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712106687; x=1712711487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z73wb+SKG9jSZ/Yydm0AUJwXmsHQ5eHka22JkZx8e+M=;
        b=b+EfHFkfPa2Zng1k/aqfCQEGL4LeFGL7xTQy1O6NqJ07Pk/GPdHPzG0SHXBuXjSxO3
         7vdPGvrpTp+HhKwU+1siz+HLgTOOwvSPFRlLsNEPj4kuZPRnuYTxIqNllMDCPVy77Cxf
         JY/LTQzrWLZNKk5/w5vBTRZ/EmchsHxEemPU90vmocWFQDXSzqeJpxE+npOf9gZ7AGIj
         dYPut4jC725x8raHPreiP3npZP2tde19NpiR3vowxI1xbnyXuJEOgrhrofDgWmA/5Zkc
         t7Vgl7Z5LSq+JLonEDSrBnv1UnKfOflruvghcHOkg3d6CE2EON/oWQyeu61S0WDQHNm1
         PeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712106687; x=1712711487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z73wb+SKG9jSZ/Yydm0AUJwXmsHQ5eHka22JkZx8e+M=;
        b=CRKocypY7qIqTlfY+Sr3FC6sVMs0SBRTbA6DddsmIYyHmRBNT4+sXpBowx4Jnq2htB
         SBLbuJRaZvSUTH34NhiNay4AAn5i3O76Iy6uSQS0io8qm9oByXcztodKAS79Qzmxvxj0
         zE5Yhu/ZP0riZbtG20p+87nnP5Yd9yq8ZiYR05AA773QM8gk59B6WBzVrfox+uQWEAvH
         JbkhmrZHlIJoqWOf71Asb6Q53B/Ai1B3/apCHtZojgrMxMhP25aD6KzPHACrj5wXWSu+
         bSNLcWNwMQyYdlM+QZ4PxcpyiEHU4BNGvIckXsilp9UxamsPafVJWEELIs2B2KY2kJgU
         lzBg==
X-Forwarded-Encrypted: i=1; AJvYcCUiRK7z+mfsAc5KchxmA5s6fvpphCtPZ1G4+mp/LsJ7HpjmRbwMaLjHZytZB8HRzFny0lyrhV9BYHWZXbmmRSlrRBhevsGRhEr7HtatS6bMRev9S8MgeCO5ag/w83wjOXVQ1V/wRgn0Ww==
X-Gm-Message-State: AOJu0YwdQqJaCeSSDPht9UeO8zZo9608+fzYB5THeB7aZdSe3t4wTSEE
	BFYUsDQDtjWtJFogIwSdXlusDC4xrp71cMBu6m4HGbO/2tMM7+ENVOd9Z1DRd/auD/QT+b3z5Xv
	sR0dpZxFkTa/fRJwa9x+W0W5JgmY=
X-Google-Smtp-Source: AGHT+IFquNV7etgb2w5kQlbd8NCb/0m/IZnAutbSyCn47svG6p/9K8iqIcJf4IS+AFN9acf4nFrrk9isPtaGO0YKFFI=
X-Received: by 2002:a25:b910:0:b0:dcc:a446:55b with SMTP id
 x16-20020a25b910000000b00dcca446055bmr8770788ybj.5.1712106687196; Tue, 02 Apr
 2024 18:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402193355.2333597-1-tharvey@gateworks.com>
In-Reply-To: <20240402193355.2333597-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 2 Apr 2024 22:11:14 -0300
Message-ID: <CAOMZO5D7bL0TiPHu4mVsO093Xnp2eYQXm+5gPxojFGoqh_xEJQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8m*-venice-gw7: Fix TPM schema violations
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On Tue, Apr 2, 2024 at 4:34=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> w=
rote:
>
> Since commit 26c9d152ebf3 ("dt-bindings: tpm: Consolidate TCG TIS
> bindings"), several issues are reported by "make dtbs_check" for arm64
> devicetrees:
>
> The compatible property needs to contain the chip's name in addition to
> the generic "tcg,tpm_tis-spi".
>
> tpm@1: compatible: ['tcg,tpm_tis-spi'] is too short
>         from schema $id:
> http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#
>
> Fix these schema violations.
>
> Gateworks Venice uses an Atmel ATTPM20P:
> https://trac.gateworks.com/wiki/tpm

Thanks for the fix.

Reviewed-by: Fabio Estevam <festevam@gmail.com>

