Return-Path: <linux-kernel+bounces-63143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36150852B93
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696F61C227DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2E91B592;
	Tue, 13 Feb 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oaRbXUHU"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C22261F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814024; cv=none; b=dzMIeslRE1w75yHJP0A7Nevef+dU0JamMYIOzrjdb1nkMn7kjvuN8zhSINdAanv1jlRF0IyBr7ePgw2h1mhngtkrtwsFlnJFti4DdsohBCxZfIVeyj/k9vsXP2C6AnBfCWA5hnhv2Rn3ogOUyNux6dNZbtaFFnr80rtcMUkjSWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814024; c=relaxed/simple;
	bh=2cuQrRHVGcWfh39M8jUML+qmGE6F/UQTXYTXU1snfS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OR4vJoF42CariCNIJzMzNQ0nPIlmgRsB+pgm2RrJ3GCBYhiujEVAAoZxm/yRW+axbzRLTbEqiwZrH27I/r40BkthZEST/VSHFE8UA8gKKITMh5Ljf/dNLaaf7sDJured/SmKalDZKKBzLeZY1qiodf+tsj/t+435H9AYWIp/yQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oaRbXUHU; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60777552d72so10635797b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707814022; x=1708418822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cuQrRHVGcWfh39M8jUML+qmGE6F/UQTXYTXU1snfS4=;
        b=oaRbXUHUWbgLTtGnGtj98Wy838xfLDEkPlHLQj45Ba3JaeZHgw/EPk81+J2oKF7mYP
         DCh0mN/PEFHHSsjSe+3R092O7ZK3Ak/ike7Wy00fNm68/BzprChY4G4OL8Ds724/aCkI
         2BMagwv/l2A8nZDuZUpaJWxw7JChLyFrFu98qRCCmBJ5+G9EylvZaRW4N0eDecEU1AXf
         EsN2k6mFHJ5mlXXlyy3RWn9Y5d1hbaWJ78Uxn+7PtiHXZLFEah+00XpNa1y/HMj4xZgJ
         AXnOVQfGfdc0q/+9QVr4xaeLmFTKigPsNojAvMLB8sYgRrK0cWA9oiknpvDeInyQwUwl
         iaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707814022; x=1708418822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cuQrRHVGcWfh39M8jUML+qmGE6F/UQTXYTXU1snfS4=;
        b=TmjheFjxRW9fcSHP4SMjnp0FT31TUJ3NrFbIzYckMCiQM69tLCPDco7zzAQdW2gGwr
         IuWlcLLkhWIqhgbORSZcpgHLoVt/YpR3G0eTzJnyyLXeusQgPe8zAa+jSiDoFkTCcspn
         x2NXMoJnxJafmft4sul1nYKn0VJZ2DBNICLu9ZHNUW0vvLzNG+YniMPYcJUgk4FqOc5e
         lr3Be9WbLTgYVQ85qs11ggOYSBPbkvVTtPK8AipV+E3R2N8gPDGJekylHJbrO5xz19OK
         gjCYgieDfBWS77x6NTb8ON3T6pKVQd5OUsUjn8P29fGRyAoP3ALfdfq45GbgbXXPjNv0
         0obw==
X-Forwarded-Encrypted: i=1; AJvYcCUVDSxO1Ofj8n/Yo1k0wgmMRpCeshItYu3Ssez4CCE22o4QjCWmyEK0kp2wb8MTHdm05NsVGlvsaOF+v2WhC4F/Bt4iIudSj1XSU3+S
X-Gm-Message-State: AOJu0YxgwfkudwrydZ0jkCTgcNS+gPTv8IUA+d6YOIKjh/73XY3PLoWb
	IN8uhnMHMHGChW3dA9G93Q6t4+bXgew/1DxVt136zfcXRt/AMQ1tBRbTOhraeQOQ2VBR0ryg8/f
	NF8KrAgnTQ4m8dQTZ7bo2zTZ/HivT/5rDlm6Z/w==
X-Google-Smtp-Source: AGHT+IFRZG5n++fAlPdmu+eyqxVBk49aoGoRp+I6MM/Om+FCfXmCNP1OwSYuG71bW545yrJ84k7ogl9bJKstYF+w/0E=
X-Received: by 2002:a5b:910:0:b0:dc7:4610:3791 with SMTP id
 a16-20020a5b0910000000b00dc746103791mr8332489ybq.44.1707814022204; Tue, 13
 Feb 2024 00:47:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213010347.1075251-1-sre@kernel.org> <20240213010347.1075251-2-sre@kernel.org>
In-Reply-To: <20240213010347.1075251-2-sre@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Feb 2024 09:46:51 +0100
Message-ID: <CACRpkdZ1VwU1xpf8Fe7qNn-WEfUGsNjWD3jFK0+5LxgxNtu+gA@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] dt-bindings: pinctrl: fsl,imx6ul-pinctrl:
 convert to YAML
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	NXP Linux Team <linux-imx@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 2:03=E2=80=AFAM Sebastian Reichel <sre@kernel.org> =
wrote:

> Convert i.MX6UL pinctrl bindings to YAML.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

