Return-Path: <linux-kernel+bounces-155099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9639C8AE546
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B30A1F21D73
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DAC8564A;
	Tue, 23 Apr 2024 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xhZh6A87"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920D685938
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872930; cv=none; b=kUMUZsVFpqeQnM6eDM7qvFtAzvXTkQsoDdCDHXEX09Um8Iw4qh2Lf5hNV1XrdWy/vW3aqTAfUGPtltcPWz7Cey1uIhKHm6ZNt1Z9uSzhew4chPOx0qRr//nYdhLnm/oyYf3w/uDaUJ6BJMLwlIW9ValHO4UkPgBr3p5GwKs01iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872930; c=relaxed/simple;
	bh=4Q8uM74lj69Nvqo3+Z4SD9KGTyZKkfeSzS/k4zb9cjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjvDbfv5stEwjaoaH163D2QW2BxgpO+GjvV/hHroEnrEzw0enWW3B8z3AjbDtzrD3Y2rWgyK1MD1V/1aVqHOm/iM6fbUN9nKzMPxNxWK2JOQKUQV8dbV+LpJP9XwwOLLRDSjaK9d7CIBwK+9Ic/g+BFuMY1s7Z+sngSY1rRZi/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xhZh6A87; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso5839681276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713872927; x=1714477727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Q8uM74lj69Nvqo3+Z4SD9KGTyZKkfeSzS/k4zb9cjM=;
        b=xhZh6A87+X5A27SwpR3gHSVmmes5NwfmOHOgUt4fjBTEm/HZk2EnDWxNU3bRF/hsWP
         eT9xmRAphH2HIR8V4VauQ1j8Oyg5+UhabUjfYcqHlKZRtxKpzi0OZGeGk+GktHrt215C
         rHt+HgWI7sCiCcLZ2M06xMeIDQHOU3SiIA/wpx7HTmsDgrK4CI0eLFmuyzY8Zuv15ItS
         3iyj19+WgZT5dgeEuQGU9CzUIuhiHak8CZcBZZj8GWJSsYUyiOp29D/95FU7JfhLY1yI
         2Rdb8CU+QGck664/rnTvREkRRcxZv72Rt6FOJzTq+kqKUUr20RoWTe4FpEVpgds91kqI
         j6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713872927; x=1714477727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Q8uM74lj69Nvqo3+Z4SD9KGTyZKkfeSzS/k4zb9cjM=;
        b=Mam2z/1Ubvkm4L4TFZTQ6tuweI0s5M6F2V9imiNKeVEXZkVyICKO4NCHx3sSaORRQF
         EnwjW+iH0RMw0GDcv6AKEvTxAnGJgd5rDDguuK2aUtfgupEG8sEBcOXRquo+YMWrUkn8
         wDrzGlhlQic3CvW2kN7Rexg6nioMGK5pCtZBdv6SfRuhpYe/As3K3U+sA/rrrVVhhFtH
         wcpqZEjsU3tY3Xg+k2nP3s4cx2VpMex32Lv4GSJWnxgUKEscjjlbJiZV5Nuzmc94FIUF
         tX3Y3v540PqueWftslCGcAkdOeMh6YTECBYZ6YoQ2JNaEgKtuSTXo4JVrfrxTsM0HkmS
         egdg==
X-Forwarded-Encrypted: i=1; AJvYcCW9b6a8XrfRBXkCw15tu2suh4pSJXBe5V+j8T7Od3lH0a0oQBNbHU7fsZjKKqo12NO/gWQZVGRmEydZIKqjhkfLhan81hmyyS4PZr9n
X-Gm-Message-State: AOJu0YxHDC9sO0I8ro9SASCRbOnf27SKx85/eFkKZrcA7cpreEztmAtY
	+auOmzUjYyourof1dQMOHCr+MuosUALvsLYaMnibPJgR5ZVzjN2fnAb4CJsNPZRLCwG/j2CkeU7
	jrfU82L9sj5e/OEfAm2l/hikmmeKj3SgxcUCrUw==
X-Google-Smtp-Source: AGHT+IHVF+iOlpUMyBf9xvEWIs8qs0LES453eMHrNJSIkEzeUXM7XFo6B+68AjGK0E/qvKsjnKnaGIOvh4ZScuge4wA=
X-Received: by 2002:a25:9a41:0:b0:de5:4c1c:bbf5 with SMTP id
 r1-20020a259a41000000b00de54c1cbbf5mr2096084ybo.22.1713872927582; Tue, 23 Apr
 2024 04:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com>
 <20240423-for-soc-asus-rt-ac3200-ac5300-v3-3-23d33cfafe7a@arinc9.com>
In-Reply-To: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-3-23d33cfafe7a@arinc9.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Apr 2024 13:48:36 +0200
Message-ID: <CACRpkdYfd+1udf1sUptSXTABVvodzGXoj+B11cSKF32RdcVZjQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
To: arinc.unal@arinc9.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 11:51=E2=80=AFAM Ar=C4=B1n=C3=A7 =C3=9CNAL via B4 R=
elay
<devnull+arinc.unal.arinc9.com@kernel.org> wrote:

> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> Add the device tree for ASUS RT-AC3200 which is an AC3200 router featurin=
g
> 5 Ethernet ports over the integrated Broadcom switch.
>
> Hardware info:
> * Processor: Broadcom BCM4709A0 dual-core @ 1.0 GHz
> * Switch: BCM53012 in BCM4709A0
> * DDR3 RAM: 256 MB
> * Flash: 128 MB
> * 2.4GHz: BCM43602 3x3 single chip 802.11b/g/n SoC
> * 5GHz: BCM43602 3x3 two chips 802.11a/n/ac SoC
> * Ports: 4 LAN Ports, 1 WAN Port
>
> Co-developed-by: Tom Brautaset <tbrautaset@gmail.com>
> Signed-off-by: Tom Brautaset <tbrautaset@gmail.com>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>

Looks similar to others I've seen so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

