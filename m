Return-Path: <linux-kernel+bounces-64510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74975853FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74C51C27BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C2B63116;
	Tue, 13 Feb 2024 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYFvfwwv"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2B062811
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865697; cv=none; b=pnkmszZXB6cLrMQ7Ca4ssTmS9aTSxWKq/06ZAk7SqxswFGrQMmEb0Qffn/3EDW4J4y3kwid7+MQ8gBh5DZFZ/hdVpXmPc7A+hsCOaRiKirbwKtAZAIuPUEUdeNs62dBhCaNwiLKWFbDih33IusivKc4Dtc085KKBvTlfcG1N1Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865697; c=relaxed/simple;
	bh=UPKxpUZmpewL2oiDjDYBorf4uyD8cQRyNRxn1Fc4a+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaydtBOSmI7Vr+X5qIGUxLwtx7kfjEu3/BQkBcZZ8ovIX0BVXV3HYSLWR0r7CUPlT19l4c/TZYWj8QlTly3X5472nsVenzVgEOOCEoK/0sCZojlOGPMNoAdthCp1liUZF8xla+FJZ+m9S7hbfa89DrnzFzmteH5/LDYu/LStJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYFvfwwv; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso4403730276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707865695; x=1708470495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPKxpUZmpewL2oiDjDYBorf4uyD8cQRyNRxn1Fc4a+8=;
        b=pYFvfwwvTNfuiAFviMHRdrQIH42+S6oSdoE+uEH8ZET+sRVwrnJBbmOfPTXWW86DiT
         vLBi2x6E6gy5kM8J/1RelO4lKJRXibwxOFuTaQqdQsp7vl1pz89aJgcGzzg5c5BasHlT
         LdyaR1s0Ujjfr3s8UpOZAgIwiRObuumNzVUxNZvCfw3TS712oBxNIYApbW1YTB2bSEf3
         gX2YwVaiipfjmtzUfWNE5CwOp0L0GuOue2uViw8Z0P5ll9mK9o8CUngWk4uEGt6IA3RW
         Q1LU9jaktXOLAftO+M+B4LhQfWUCImlP/qOrROKoP8wEUQZRg+/idWt2YnoEOog50cxh
         PysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865695; x=1708470495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPKxpUZmpewL2oiDjDYBorf4uyD8cQRyNRxn1Fc4a+8=;
        b=Q52qjbS5kIuRmr5bndiUJjtIcXp4nB3iq0Z0QjDUnZcFKiPDU7FOgCakcg8nhx+QZp
         osXwqMxyOqzBzdsbF5in7E0Ks8FZ5EABIv7RaixxqMDmnlXErC7EyAIsGePeHiwvzg7q
         0lBxlIXNu44nCAg4oLWO2kUr88fJd2dmwH0Or9vciFqS4ftS5FN+uvzXg8JEv/U01n+C
         VzO05BH2Zs2gSTRCiHEqhRaRgSM1xuqRlD7BFhv6Cw7AXoLMxQ8IW6eNhdZckcuXTEVi
         niHiWzG533szcPLL1rgDcWxfeDxVCbspK2GgOSY/PpdWx6aocRK/mfce6JOJO4CyDL+K
         oHeA==
X-Forwarded-Encrypted: i=1; AJvYcCXv1jHkjF4zra+CF0Ud0zS2jUdz5haIJf9yiVT9wxp/9UGWfq+q9tFCBUSE+hGSB2PngouMlJOjiprywnmb+ESkIlmxXOsJywOMtNpw
X-Gm-Message-State: AOJu0Yw0S0GPIG78slOMIensNvCevrwXXYJWJ0zPU20reVdw0sKi43q7
	FVIvIB5127kzv2rP2C5xA5/OHKX8rJaRVtGdKhvBF8q9V1rpE9Kezh1xB0PCMfBEFcdz2VUpXka
	nfAVF7d/GRziZj7yVOsN/OdVoWqqMc/LPg1RNsg==
X-Google-Smtp-Source: AGHT+IF+elx+hBn7SrCXxhMrRvIzsV8yx9LlnGhlnBcMFGcNffUiWOWuLtYWOP2QLloedfePv65ibJK4V2I/D2Ty+lQ=
X-Received: by 2002:a25:8c86:0:b0:dcc:140a:a71f with SMTP id
 m6-20020a258c86000000b00dcc140aa71fmr626531ybl.60.1707865694274; Tue, 13 Feb
 2024 15:08:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220331.239031-1-paweldembicki@gmail.com> <20240213220331.239031-5-paweldembicki@gmail.com>
In-Reply-To: <20240213220331.239031-5-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Feb 2024 00:08:03 +0100
Message-ID: <CACRpkdZCbnDQ+JYaSyv2OKYC4zCb0iboAN1ma6DMuxyioVBvYg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 04/15] net: dsa: vsc73xx: Add define for max
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

On Tue, Feb 13, 2024 at 11:05=E2=80=AFPM Pawel Dembicki <paweldembicki@gmai=
l.com> wrote:

> This patch introduces a new define: VSC73XX_MAX_NUM_PORTS, which can be
> used in the future instead of a hardcoded value.
>
> Currently, the only hardcoded value is vsc->ds->num_ports. It is being
> replaced with the new define.
>
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

