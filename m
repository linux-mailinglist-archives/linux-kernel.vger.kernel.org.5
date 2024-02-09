Return-Path: <linux-kernel+bounces-59352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D8284F5B9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06BC8B23F83
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FBB381D9;
	Fri,  9 Feb 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRowDtdX"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C226337160
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484870; cv=none; b=p9zwFTvWH6/v++RZhLeix8kUdh6612OVEWLedOGJFVzxR0G74M/P1JpiGGTNloVWj+oMwVCMCyv0X5nmF4kvVJthLkAuDOppLEtbeFSvgw2kAKlmpkw2hpckjm/m+paAJ6yrKJn785FnS6P+6U3CnyewsCs8ZhSXQEDaiK6YkZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484870; c=relaxed/simple;
	bh=zJwquKDcQdXxx95fVyEF0thd2c92Rc/rle9klHqcSno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfBZ38TyToTdcd82EjADnikdgaM38IPl4xS+/3fWFQr6RtNvySKVk1Yotd4N4XD0eVy82uDvORkMI2whbWPW140pjgZTPXpM4+hxmUaFrtF2GfeBOZjTqJGPSKxEjDUlvY/mG8+DPI579y+wrARIkvGuwDVMsoEp4TqvyPbwFDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRowDtdX; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-604a05a36d2so10477717b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707484868; x=1708089668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJwquKDcQdXxx95fVyEF0thd2c92Rc/rle9klHqcSno=;
        b=SRowDtdXAa7zu3PhWtb/UYZTa5S/Mzna9vpIk8MVHL0qc9SWbJaK5ShBhO/c6CW8xy
         7AxbW6A+ML8shjpu0pcyBCxMgEFGGeeioJB8E1Y88KS4TBjfrS/CCGUS2NxFkQTZJXBv
         o9t1vSkNEOFEFtpo+eJi6oIDUR0FiAI9BRTcJI8nxFqW7ZNW26MCKjVkqyi07wCHdm0w
         wbwuJ/RefMiojmDP07HYQdYyCua8xPeJ4LHfGjk3lJhfMqfs499PTTM4NB5OKh7A8Izp
         Y00fiOK2Y7TMcpdqK/GaHJJqJPzdr1+2XuIod4lWpLHhEsfNeZHxA7JnVjwMUMzW2w2C
         mF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484868; x=1708089668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJwquKDcQdXxx95fVyEF0thd2c92Rc/rle9klHqcSno=;
        b=Of/w13PpO+ORuEGIoRczxaIKvCdL79xqHUgGSQGP1gy6FDui1cX1wGlNtmX6o0Pb2w
         VszWIIzgqEhP8SH4AraJfisZXO5jqaL5yYzsdsPIsKfUfj8J1aUPz0VTSKf+djJHwrBr
         98wvyr0A8eskHZxLIezZbNqtnnreAWB/jRc/T1gv1/xfEw20iGqfHLpX+9kodzwfETc9
         rJQErY2c0e0G3D7yPxcYsO9BlSGsVOvAK3IDY6cpxYpatOg9F6/hhWg4GS9+RfaZvbw1
         PSn6Asj0Z3czIAr1wqHvcSSFMqEHvDRNiNJpZUHjLVK0HyVHTa0INwPWjrW9NdkCDmE7
         qjxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrtYjyF/kbhSm3RquBQqBy0/VW433XZ/tvXO0Q7Oav/SLnRlTG0yJu4Hl+JF0tvVR3i19Im47wUMpj08CRHOSEhGRPbTbrteeDBsEM
X-Gm-Message-State: AOJu0YzcRSPDdM/CiXlQA4DC8pwEiaiqS9LMYo63WBXfJOCo9DO5GdET
	uwZl/qR8/K/P6g1OLd49erHpR6HvXDtEGE4FjzbNVlX8wIu0rd8nbbmx3EiRvU60pdo4264vSl9
	1YOP8i8rK0NeOh57UDMoTVn+DmOi80pbCR4CJrQ==
X-Google-Smtp-Source: AGHT+IHcVHa6uuIl/rmttkT9yIiHEaYl+hdN6Go+Qba9nXw18VGXS51FICHCCsz95taf1uoA0LiegixgSjIl886ullE=
X-Received: by 2002:a81:9291:0:b0:604:7bb0:cfb6 with SMTP id
 j139-20020a819291000000b006047bb0cfb6mr1489620ywg.2.1707484867813; Fri, 09
 Feb 2024 05:21:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-6-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-6-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:20:57 +0100
Message-ID: <CACRpkdYgh0joQWfL-rbMfk_p_rso=zMyZAwos2wyjG=-aKY0bA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 06/11] net: dsa: realtek: merge rtl83xx and
 interface modules into realtek_dsa
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:04=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Since rtl83xx and realtek-{smi,mdio} are always loaded together,
> we can optimize resource usage by consolidating them into a single
> module.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

