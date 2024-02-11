Return-Path: <linux-kernel+bounces-60645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ADA850800
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E761C214CF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 07:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8E5405DD;
	Sun, 11 Feb 2024 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2XQ/dhi"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F672405D4;
	Sun, 11 Feb 2024 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707635704; cv=none; b=r1OIBrqudrvbkDkNngGD7Yeohc4ZLLFZqVDmi3WDft1iJffrIDG2WJMTx1hznsphHUU/0mA1DU5pwc7IQaexrlGeQGvWk4xg9KyQj/7i8MScrUHMUhm24uiF6L6pTjl/rgaKWn8Z6yISDL/G3giuF84ZURLvm9g2bJydlC44blI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707635704; c=relaxed/simple;
	bh=nQmMD2SptD35nCghndxGZnGfVOxRHsS0gRs8rfSrQnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYNRYJta+aQtPeZYI0sWV7ksDOMKHCQ7wpLvAjT0HM6BYfdVeQG9ZNcxL5oWuuyOaofJtuXp0hzzIuMnbn+ptMOT6Szl9ZywzloV1o3BULS7qSkDaPs49TxO2kiAVKjqkw5ED9P9tMA9wRbkivE3zy8hk/g+aIub5O5fB8gEZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2XQ/dhi; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3916c1f9b0so302225066b.1;
        Sat, 10 Feb 2024 23:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707635701; x=1708240501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s12drHj8rj04+GroOxHXAuF3MnK/ZF0RkJW4T41Khsk=;
        b=V2XQ/dhi734Dn1W9qvg9ZCe1Mi1kBUdPARSO+9vERWs7ysjseE+dAqlWjkcfQ+EU03
         m0uBgu10zW8mMkx7zulCnIR/cvwH09JAbVYYvT0Ga87q4vF2buFlYJlENPBYoCDo8Bzo
         3eIoRdzC7oZNW41PP5AwTdpAGOfRpA9einyhl73ejjCuSgY20uBDtsTbaH/BJwA9XTQk
         Mi2T0yecUTPMWhOI2qg72nFDKLi9bRxTuD97crRNApY1eAz04kXKc5Wu2rRa9kQaAYvR
         g6GSVuoAlfcXM0UQrw2NWK2kVfP43HUCGwx2DC7/xCxfDNvynholOKy/Afj5COgKzc+0
         xTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707635701; x=1708240501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s12drHj8rj04+GroOxHXAuF3MnK/ZF0RkJW4T41Khsk=;
        b=h8HkLJsTN28Jgkx1wwK9/qYwl6ILH8UEYo+47ujaj10SUDkAvCUOj7ExPcUcVZlNNe
         cAmR87x9J4ar0nK2bnXvCiqgNBvnbhRle+3V81PmwlK4348iYDWZwGx5CqGPm6PwwCKi
         Zw9toM0wEBer8hgk245dBDwZ5UjF4Bfp3BqPCN/enMcSMEwDt3z7NxUaHxJZYcdFvWbR
         pUJ4gcVhv9t4zOad0wS7q/YO1Y/9hsucIGn/c4Vl0vaQg2qDkixfCWoFIH2lEe+Mq4oN
         L0w536lgH2Efe0LibPy57HIGwwjQMXsg/QZXyEFjOfpdd7eK02FPlt4K5NubjwaUtDup
         U8KA==
X-Gm-Message-State: AOJu0Yw++VYUD+qmSyJb0j4s7bQkgF6Kezzw/XUV46LzZpPrUAo0SgiM
	TxV1DQKD4QV/00XkqVdki4w/rj4GQIEvU9oJ9SSqleFjRxpmQXBl
X-Google-Smtp-Source: AGHT+IHx17me+VBcKI2SHqbrlalGQZ9cBXxQIeylmjN+xWS0vcuJHRxDc3RzrIhvi6DRAAsbyITBUQ==
X-Received: by 2002:a17:906:11ca:b0:a38:7171:e832 with SMTP id o10-20020a17090611ca00b00a387171e832mr2646883eja.32.1707635701158;
        Sat, 10 Feb 2024 23:15:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1B2BVyGTYjcb+HSx/MArU4UVP4S2nUXOXZnenKTB4bHcPx8NjanSTBKDXV25fHOkRKacTlpJ6tLjnZD1mWV8rkS0TBzb0OhOmiFdf1rvIJTPRI7fnbW5bpbNMaffnXmG9cya9RjmvRUGgZHFVYfiHkPZ2mPtWtVpcoH8ewrcnltV3TLYR/G3x1emOak4hQFLH89XLw0/2aydJFgFF3B26tJs1EGXtTHZV4qdlb+OlPE9lkmgqXuJxYdaEFcN4rdBkZZjKAf+7PJmMuVXTnvvhKrhfeithpord8v9KayFbliXDuwY=
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906338900b00a388e24bd2fsm2585713eja.162.2024.02.10.23.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 23:15:00 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject:
 Re: [PATCH 1/2] arm64: dts: allwinner: use capital "OR" for multiple licenses
 in SPDX
Date: Sun, 11 Feb 2024 08:14:59 +0100
Message-ID: <2720166.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20240208105301.129005-1-krzysztof.kozlowski@linaro.org>
References: <20240208105301.129005-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne =C4=8Detrtek, 08. februar 2024 ob 11:53:00 CET je Krzysztof Kozlowski n=
apisal(a):
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



