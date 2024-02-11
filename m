Return-Path: <linux-kernel+bounces-60646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B466E850802
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711521F23E02
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 07:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E282405FE;
	Sun, 11 Feb 2024 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3mTuSXr"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9CB405FD;
	Sun, 11 Feb 2024 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707635715; cv=none; b=IPDt4Fb3bj1UhbSJDuTczMS3G0bqs/T9BP0daX6Pz9ExR1OIy/Z6sWIWZGiPKmYn62DaBrXsclIPsLXYua76ARzs/snsOcDhJPRASP4OeZD0Tnk89lS8WL6OWBfwVb0XeItMwp/SOgL13EGdE+YxNeZk4tdbz50nj8g+YaeUPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707635715; c=relaxed/simple;
	bh=kql/nHMm6T19x2VYu/8rtjfvbmpEsr9DvyQkFOUrpf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlDWQ8amP0rg4WbIIBf4Mx4JVWmRCt6iwwauVF6vr1KcmgSpZH28zp6jdYeXy0JGp2T5iB0PY6sYx90OavoYq/fd2sZmJvrhGvWV3Oi2XMBwwlXMZRamEEDvR8FQtkzqenxw41vgAE7CD2DsLL9vt8ZSzdd8ly8oNAO9Kx0/V7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3mTuSXr; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a36126ee41eso295821266b.2;
        Sat, 10 Feb 2024 23:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707635712; x=1708240512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kql/nHMm6T19x2VYu/8rtjfvbmpEsr9DvyQkFOUrpf8=;
        b=W3mTuSXrMl0Oe0SFTYteo7L9A2asnQ99b5czPJ137kcRrROc8KbH2Fj77951GfebsR
         YXiDu0hhWEbUjh0nT2YUcMG7JwfcbAydPC4aLCuIbAG4DHbiyiFCtm4+h4GVbSx4ml9h
         eZc7vIofvQ2Xs3gAwp6V/IPl0JN6AvEEG+T2EbBq7C9Kb23kH23mvaQzpILn2M8HzGyX
         tjTTi1WXy0j25V5F89rDvHPufDqQTw4r2ZbqEeov10bkiSrsvSQZ7XYOcucVuUp+QRwF
         9C7fW+syBwrR9wyJHu7roBbEjnfBexFR1+zpSF85jaw9wSUN+5/cdZAGKU7ZydHfWkj4
         PvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707635712; x=1708240512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kql/nHMm6T19x2VYu/8rtjfvbmpEsr9DvyQkFOUrpf8=;
        b=XYqi6NTNGpYx98l0nYfkFNhwhFlm0X/EL3JEiEoVtqfG5QpCsmDBetzbnvADAST3VK
         Kc15d0uJhR1n4mNlEWP/iBIp5KPKQdlh7PYLpK7M/m5ZhaiTRyO6cKvNfHSign3FdlxG
         rNTHwbfufrJnFqMrxcimw8RtgTts2uYwlIq2JjcYex8f2/VI9SLqx1glKt9/IM7P/LZx
         SSXFYbWLqsLutKGaTs3fhJzOxTMbr3YVa4Jssz4gDvknUes2Z9un5OZ6K7RtecuL1FGb
         KyccChUxVPc2uSedyhFJ85gNZCSQirDPwaKslQ/lmHy+ZkBoI4uMi/H/gTE3sjd6Z6Dx
         iHpA==
X-Forwarded-Encrypted: i=1; AJvYcCWpYx+Mb/N9GwSiy0JIK8V6HpwvrwX3GoKyQ0/RBy54xkvWBwj5jcR+2uvvp4ZDkMrxUQmaMzlL0Rbw0c837FRDAZ5CezDtxnQrcf3w9o90G192hT4/xhnZ2dkjg6Mq20/b6P1ozZfimQ==
X-Gm-Message-State: AOJu0Yz9ukNhB69mkSvyFk7VXW/NURdW4f1rkzjdx3FUfOYbSQdm4Juo
	iu7rSJLAkkNesGXGSd2dE+aS6CcFYY4zSXsK345jvKkeGSOaurVbdc73PTk7
X-Google-Smtp-Source: AGHT+IH5Oj/EgxNbkTQ2kneuQsvTJX1fVBO6ran1S24Hyd95M13+8oo64xOe1qpn1iXS9mWLmVDIFg==
X-Received: by 2002:a17:906:f1d1:b0:a37:2ed2:cba1 with SMTP id gx17-20020a170906f1d100b00a372ed2cba1mr2518282ejb.22.1707635711866;
        Sat, 10 Feb 2024 23:15:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNjk/FIZrbBqqnqJKR4K6hq9yUIHExAQz5KmIGl5tvMXfx+qodqQ5mKt7Qz5kl3aJm0zitehkTJ8Az0EIOvNhZ7JlMa6kcCRZgystz53mknmRN1JBXqM3emjMMp02FMbcPC3cqJbqLUErnQJDIXd+JGzpD4In+t439okilx0deAIWkhakzpETB8GR+SEwFugvIXosB4hg8hQ+CU/PuMUlTbUIj/PQFu1Sc/k/aG4NWpB194KpGsdQB47Rma8c4cWF/OZVzJw7oy6ZiVmgnycOWZI2uiH+UOHPCRcLCwhIUuZv7YEM=
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id qf37-20020a1709077f2500b00a381eea0e9csm2586258ejc.197.2024.02.10.23.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 23:15:11 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h616: minor whitespace cleanup
Date: Sun, 11 Feb 2024 08:15:10 +0100
Message-ID: <5754939.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20240208105301.129005-2-krzysztof.kozlowski@linaro.org>
References:
 <20240208105301.129005-1-krzysztof.kozlowski@linaro.org>
 <20240208105301.129005-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne =C4=8Detrtek, 08. februar 2024 ob 11:53:01 CET je Krzysztof Kozlowski n=
apisal(a):
> The DTS code coding style expects exactly one space before '{'
> character.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



