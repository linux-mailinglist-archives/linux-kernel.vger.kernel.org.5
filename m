Return-Path: <linux-kernel+bounces-63149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10172852B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D021C22AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625A7210FE;
	Tue, 13 Feb 2024 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMiImORu"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280CE20B27
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814087; cv=none; b=RrGnv30t6Q2HCVMSwfVn/gM0WCnQIOgnWOkHdwfi9+3eBZkp2tzTIqipWojqi+Lcn3mfN9favCkqRQf7HSCEmatXsL5oiaZeIpnxhehJg3VcFIF9vmP2/F9/nvdrc/hrAIWF8Po0FHZTx9eHvqqLeayo2V75vKq4ZR/XGxHi/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814087; c=relaxed/simple;
	bh=UmKMhMjwgubZRTDFjXUtlGss/VVLnfAGIvJRLtEAGAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhFJmaLiY8xmwk8Hmoiaost00ESZaM8T7FvD8Iv0rsixO85KoRq2WaAgQTOP84fOE0wfefdLaCGnszzPLINDVJPeeXv/s7Op8yDlsoaOj67bYo55+xwFHTPwqpG8bTQIJbnu/uRLJUhDrtnUQOyCeXCQIgvJweVAVJ0QuBGp7Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HMiImORu; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6078ad593easo2495487b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707814085; x=1708418885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmKMhMjwgubZRTDFjXUtlGss/VVLnfAGIvJRLtEAGAk=;
        b=HMiImORuxUty3jECuwMmqvPkhI3Jmxs1SXsQuNWiazCvM1oGIi1tknz06LKVZoZ5RN
         CIztjQjlYdN4g3bdPhLLeQwjTybxJXiKDQLfU6W9sGcMMyfCQuZDDZQjchXEEaXA93CJ
         COabWTsv6A9es2iS8o/Oa9J9rxkDi8iiwvtjHbBhMAjRfx3wPlCQ5Z+LG+U6WqpYTknl
         E7PXoEupf2ZdhfOtYWSTyDmimZnygbc8PnILkNc/e/VUghcENY9I9BG1gUkdT1BO8OQy
         kvmr19JvGTESH0fWGYOQMFH9BgzQcWAHJMMjBxOEENrZl4/XGpkwWnW80xxNW14ABOKs
         5L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707814085; x=1708418885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmKMhMjwgubZRTDFjXUtlGss/VVLnfAGIvJRLtEAGAk=;
        b=V0MnVp9m3WLYvOmkcX56VGjgZX13Ae61+l4HrLjz4RDHMA+D2lsF2N0aVNkGCJzEUA
         EckRFoZyrlHzj6M1+DsRPbfUTfdje9pAcLtrsVRyuTdXwncBmJWKckDdhGef43Qj72SO
         Uu/UyJO1pHvlxeM0tPipAZ29Z/3ckdTIpdiJKy0CqQ2W5OE5aU5KXOAa/sudeNPQK97A
         8rW8K/MVmrWi4A+jgnHLuikvItxPL5PvI+X5ODKD2Q65/rDHM5PjyjGHxUlu4eg34Geb
         QW1zLbK6CCrVz/yEOkMvUTmU6dTtCptI7fJ2ny7opYa7+YWJutV5QwPQASVUYA9uT9jP
         +Mdg==
X-Forwarded-Encrypted: i=1; AJvYcCXjzmtmYlodlvtT8o1TAtYFD9JAC/7EP1IAI8AaFiHo8ACgaR+qxzkyFt/G2SYvEQnj32EX2lcgMisKE3wc67xsWLKZWgERm9DIbC6H
X-Gm-Message-State: AOJu0Yx1afrCjIibJ/+fqJSPpBXnlBiktoKcL6KS8gUZC7xqLpJ1SBnL
	VFsThEIL1f0Bcigdw7XKfMMZz0KtDPBCH/6XEAICH66lLyWErQKEeyu7Lim875laA9oIsN8zu4Y
	WFtnzLmHoG7suFQ7GXbliVJEO8LhuqRJWFFJhUQ==
X-Google-Smtp-Source: AGHT+IExCdzrpd7++ek/q7qzwdeeM9WLXTrpFYVurkWI4Pg86K7HisMcu72lsW4reyouOzIX+im9ts0aFWyNApvxetE=
X-Received: by 2002:a25:c70e:0:b0:dc6:db64:67a8 with SMTP id
 w14-20020a25c70e000000b00dc6db6467a8mr7128883ybe.43.1707814084929; Tue, 13
 Feb 2024 00:48:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213010347.1075251-1-sre@kernel.org> <20240213010347.1075251-10-sre@kernel.org>
In-Reply-To: <20240213010347.1075251-10-sre@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Feb 2024 09:47:54 +0100
Message-ID: <CACRpkdZqmfiY5B6y0kSSanF6cw1_jU-BZ5dC8YEp0Oz+78yqQw@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] ARM: dts: imx6ull: fix pinctrl node name
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

> pinctrl node name must be either pinctrl or pinmux.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

