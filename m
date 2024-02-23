Return-Path: <linux-kernel+bounces-79286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A55886200E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1539D1F24EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE78C14CACA;
	Fri, 23 Feb 2024 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DxidgVnm"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8956422071
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728653; cv=none; b=FCnqe5g78Vdv/C0XwtQ11coN6UpJWFG7e75ZGjEvR7jLrWPzOESeYxVAahQXduEylk+4Ec8xEFuCuD3375djnAreu5dPBKMuwJtrmm8FuT52YiqJkJ+4n60bu8nQkxNAehK7z9Y0jkNMv4M6Mo5wMQa7FvO8DrR9LP3p/Td5/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728653; c=relaxed/simple;
	bh=7MnTsaQms1KvFyh/w0ZQeuJlEeSO2RTHjAhsELHK+yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIrsObZ/+Ss+Q6Ck6VFB+NskBEwRNA1g+Q4K6zN349tp6OJSch9Rcif1qyTU4GZc7ZljiVp9LHCjh33F6XVH12Oj7tvR/YM+Q3Mfn8YDlZpZeMxV2xFL8j37EX0E+vTtfQ5xseoaUvjc0WF8X6CZ8AyA7GKKufZSPmQb7DfNhRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DxidgVnm; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so1508921276.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708728649; x=1709333449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MnTsaQms1KvFyh/w0ZQeuJlEeSO2RTHjAhsELHK+yI=;
        b=DxidgVnmK93+EwBq2GRKMVqAyWHkrT91EVYe3FtSKEnV6M+H5Kux24wd7WA3mlb9v3
         GybMonD5kUaiBrIYqvZu0FYs9dA5fIisreYk6RNKvJxxe6HChuu5SynNOJUI/PqSf5JP
         Ifvr7dUdYAoMbcOpkFA4irA47VRY9eKYEcGdFm3DISvQJD/ZEmOaLqZaoh2kQ8apLELK
         rNhTys6NxiZpiPeFiDdqlUJiphXKQDrcsNUtdBKfXBcrY7ha2GLhdROx+cJUD252Uu3m
         2hfAzbgd+D2h8/MZt+y+TCQ+Zt7wOAHVOiunrJjnxAmNhqdTXZbaUFSoyW37m7LFoh2U
         TB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708728649; x=1709333449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MnTsaQms1KvFyh/w0ZQeuJlEeSO2RTHjAhsELHK+yI=;
        b=iBROjNdAxLPbCPKyKIfgvEfqnLP2pqD5NwjB4q+LGSWXwRy66TEi8puCPU3Ah+CIvM
         jK5hQJKAx7QLpU2RbVhxO6WPB94oDLNDyZAidCvkLSdYsukuiFMhvVum+89eVXv+wQmZ
         7RpS0J9DpQi2FT9ykvMHj4XC7uFFVMvuN2HXW/bNFa0Scv2Ovk5qtxYsaFtK65s0fVCx
         ucQxVrCRlW0cw45mmmSaFuaDQj0r1UXPhW4GV3D/pJwKKXQO8tdoWk8VgmZ5UKyWyi4K
         /L5rkCSQU48ioBmR60tDMwOoua0YqliyCG2aZkcyXuJY8DNyFfbCVT57Iy2RzjR10Nfc
         2o4w==
X-Forwarded-Encrypted: i=1; AJvYcCUPUTTcvRZRuHVbX2DhEx3Geg28cWyx6I2PUZHm67Uo40Wn8JFROVnFDnU9VxLEI44d9/DhnvS6RPR7xm5QKfw2HA8sMeYuNHrBM8DG
X-Gm-Message-State: AOJu0YxWuvi6y/BbldBKgeJnHOTysWdcLbEw/3Inq5vNmn63IUJRRNrg
	j+kXIOBdWZKhb7Nc8SmhdtTKEtksOrqD6joHwhwt6yRH+k22rr70PL+IGZv8KeHCdi9WDUk1blI
	DjXV2q7BoL8TVCQvLtcEiXkhhD6/EJGkEUa05Dw==
X-Google-Smtp-Source: AGHT+IFTs0JlBH1nBVrpRsCUQ7Qs24Jlivb9KAozhT9oChbcK9RqRaCyl+EWEnBjEsScON9SN0G1wSa0+UobEX4abiE=
X-Received: by 2002:a25:ceca:0:b0:dc2:279f:f7e with SMTP id
 x193-20020a25ceca000000b00dc2279f0f7emr1239658ybe.10.1708728649493; Fri, 23
 Feb 2024 14:50:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223210049.3197486-1-paweldembicki@gmail.com> <20240223210049.3197486-5-paweldembicki@gmail.com>
In-Reply-To: <20240223210049.3197486-5-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Feb 2024 23:50:37 +0100
Message-ID: <CACRpkda7=DeUTcCc1_nee7kv8A7UA8DV8sWCOjJH2OSNZRsahg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 04/16] net: dsa: vsc73xx: Add define for max
 num of ports
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:02=E2=80=AFPM Pawel Dembicki <paweldembicki@gmai=
l.com> wrote:

> This patch introduces a new define: VSC73XX_MAX_NUM_PORTS, which can be
> used in the future instead of a hardcoded value.
>
> Currently, the only hardcoded value is vsc->ds->num_ports. It is being
> replaced with the new define.
>
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

