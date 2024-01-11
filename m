Return-Path: <linux-kernel+bounces-23710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA5482B08F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E8D28B714
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06683D973;
	Thu, 11 Jan 2024 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RAt1QzA+"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC13D56C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ebca94cf74so52996227b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704983059; x=1705587859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5H4wGjXC1DdLzQIpv3zBJ0pf8Lkdr1yQJoU8LqpgzM=;
        b=RAt1QzA+S1taMBjYXdWpe3/1i2AICagLHf2jzWf+6LlE2KCpqTDlti9EBUF2COd4rE
         3DWUZZgDh29pubVLbJu8866tDBj4YVyine19pSfXuIt2T0pVKGbU3I4AyNNXawqn8EBZ
         HQBqsvo8py3zoghaVnAukdrWnAsL4tEVq67Ysq1MpV50jvf+4qbeVy95w9U/bJdPV9nA
         3+DwKfupD9ZA43tKLPYdTIONwjOXk/EnmBHoaPy/kGh2tn8CAoaqPrNOGtYulN74Lj+T
         74E9b82LgdX+1hHlxCnmWVzreoWtmSZaIN/GhP6tWCkeRlSaZxHoDypsc5Bw04v2BbVG
         sK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704983060; x=1705587860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5H4wGjXC1DdLzQIpv3zBJ0pf8Lkdr1yQJoU8LqpgzM=;
        b=I42CVURtOsRp0xXnWcut28q8E8ALdIh6exm/QStd+TdCx7MhHL9QY9IH775wLkqgLg
         zfnj1a+Y5YMWRHfw8DB+Ez4DYlCaeJa0jhGHJJZKxt7UwB/FkJWwyQLY2HsCQJyWHvUS
         5pQJsUk5xsDnOU179yPcpJUI+ywhyHS8eiRnrnC1HnvDa8Avy/Iapc+NM4R2tcV4Q+2Y
         NdJj1MC57e07294+wze1gS2bbJQwD1yjdRn8BnY3Jh0dnjz7L/nbayeacTXHLiYEtzNm
         FHTo2C6oLy7BI1Z690RwRXSFJZ0f+Qs/eJdTvdtgSt77Gxzo6t6lhmVV4C0dNcu1vuSz
         BedQ==
X-Gm-Message-State: AOJu0YyVNCdTL1MuxE+K3Ne/NCOJBWiSwJyREn6f6iZhYbpIVBQt3EA7
	c1hTDF+jx1AdJdxEEQVcY+DyM/C42x59BhHJ/ecczadUaoGIEA==
X-Google-Smtp-Source: AGHT+IFaYmLOxFxDAbrD29zJ5P+ZteNYH0C8/fah2rkfr0pwnrnR+2kJeW7gA7vd5Qa94LgZL5/dHpczsnOz/Isabo8=
X-Received: by 2002:a81:d845:0:b0:5f8:ddb6:f38 with SMTP id
 n5-20020a81d845000000b005f8ddb60f38mr564900ywl.0.1704983059775; Thu, 11 Jan
 2024 06:24:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111113146.16011-1-dario.binacchi@amarulasolutions.com> <20240111113146.16011-6-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240111113146.16011-6-dario.binacchi@amarulasolutions.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 11 Jan 2024 15:24:08 +0100
Message-ID: <CACRpkdbvwmvdv1oH6A2a+BHJ7y0gqAU1O5ZM5grAMnrrMRMdQg@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] ARM: dts: add stm32f769-disco-mb1225-revb03-mb1166-reva09
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-amarula@amarulasolutions.com, 
	Lee Jones <lee@kernel.org>, Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
	Andre Przywara <andre.przywara@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	=?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michal Simek <michal.simek@amd.com>, 
	Rob Herring <robh+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 12:31=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:

> As reported in the section 8.3 (i. e. Board revision history) of document
> UM2033 (i. e. Discovery kit with STM32F769NI MCU) these are the changes
> related to the board revisions addressed by the patch:
> - Board MB1225 revision B-03:
>   - Memory MICRON MT48LC4M32B2B5-6A replaced by ISSI IS42S32400F-6BL
> - Board MB1166 revision A-09:
>   - LCD FRIDA FRD397B25009-D-CTK replaced by FRIDA FRD400B25025-A-CTK
>
> The patch only adds the DTS support for the new display which belongs to
> to the Novatek NT35510-based panel family.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

