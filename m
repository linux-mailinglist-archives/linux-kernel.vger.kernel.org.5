Return-Path: <linux-kernel+bounces-120095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4D88D17B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19E2323855
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3847213E415;
	Tue, 26 Mar 2024 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub+5CvSw"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C101C13E3FB;
	Tue, 26 Mar 2024 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493084; cv=none; b=pQARBSbQhRIp06iXzut74FDX4BlKRveQi+EPtSTIeRc5WZ22nlBnFTzp6/LfUgMEXmHivaiRvAOWDqI+a1nBD8MtY/td64R++CAIO7+AEoAiUMxjGeOUarU5deubQSl+5N0w4vG4ScBZGwyJE+8DlZLWBdcUTGWp1p73k4SwND0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493084; c=relaxed/simple;
	bh=21njRGl940sgZBGKPtxjtRnd5br8akhXs+E2HiOd6+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTK+7BUWgqdyX0O468EDlh4jvGCvRrskQn59duDUCUr8o/vXKgJT8kLyW6zDdrjDJM/SpS7fM/f9TLpC7+IGbmTM5maVS0vHqukzAvgiXf4X0MOx4PdHTfe0jM0To+AWg9TH9hmnbAPM7SpJ0IRHXGIdB3fjZMPQ743i4fIPtrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ub+5CvSw; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d094bc2244so79843491fa.1;
        Tue, 26 Mar 2024 15:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711493081; x=1712097881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHr5651oMEvLdMR3cMJXLfEH9jfz5XxGqogmz27QaOI=;
        b=Ub+5CvSw+hRp2FPAyoyJUmP1CTPm76Hp4Sr+GBWP0SQ9tFHwfWNDecDfMEXsHebVU6
         +6/zWWQDKGBNfgtC9eP0fRkAeAn56QgKhvpJGWcZOD042Odad8LdIjOf7P8wf7JQsUMo
         SHBiwPKkWPcwvmwUGJoHd77Qs9WbYbI1CWikISmJCpS+kAz9qF8s04H1lcy1h2BfL2mw
         7sPoyvVKZ05ljZ1eUo1sAAaDynQ9DGHZ5IMCYMJGKhnKVuwhRpyo4M57EqGTi9QQGs/V
         1xMaDYrsIR6JmLpZpDx0ofJTPpjo/tdS6ks5KzqkGzXtk1taj0Dgx6a+JSBwliB8Goo3
         a0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711493081; x=1712097881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHr5651oMEvLdMR3cMJXLfEH9jfz5XxGqogmz27QaOI=;
        b=pSvpw1oVNC67RmG3vZG6yPwIsSAto34est3d+aO+9MDTzosyuh4/7LYdCx4Q/kYjuR
         /M88dPoTk36Eg+veyAju9BCwcdYMpeG28ixEBq0/k34IFNoX1Arsbz+YyzhElAkUTl0/
         q0jXycDAHJVSy7GPF6P2DIX7x26ZUykZdMub1+9Au3yzG+YyvZhN5B8ABsyLd0RmdOeE
         9FYX6cJDcICVd75L6mKsTTl+JIl0oxnw59UVwUQeInZxyPiKMHmU4GHmZDpRDPYP/LdH
         V0td9Bm1VWZR/ZCx1Ha6J2fc8Yg2bwpFjS+uCHbiaHzZzxgjD+klBFkWnBD5gn/HNqs2
         3WtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO/raPVeMWL6gO6swJ/DxWmF7f8tyvi/218sr/kKsK95j05qPbT1mWRnGSFioUb79Pl78tvU7sj818r9OeO8HFDq2ZwFasCL4D+g==
X-Gm-Message-State: AOJu0YzjwhGY5R1+SL0T+/E7tD1bGSdGwsDep//vYCCIzYU91bAyd6Ui
	t/8XbFeUBSy4MN4lYN+iBK9i+BnG16MhCKSPqfHeCnGd+rm0sd8Zw8/9Cepv
X-Google-Smtp-Source: AGHT+IEnYDcAqXAqYEKDNyTaX59nzs/0/ekFbWyysHmdBYKs4D0+MiAouG3YSCYzVoJ9LfnudhXkEw==
X-Received: by 2002:a2e:7a04:0:b0:2d6:b424:a634 with SMTP id v4-20020a2e7a04000000b002d6b424a634mr6840536ljc.15.1711493080660;
        Tue, 26 Mar 2024 15:44:40 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id o25-20020a509b19000000b0056bcec9c89esm4786463edi.92.2024.03.26.15.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:44:40 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org, Aren Moynihan <aren@peacevolution.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Chen-Yu Tsai <wens@csie.org>, Pavel Machek <pavel@ucw.cz>,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Miles Alan <m@milesalan.com>, Samuel Holland <samuel@sholland.org>,
 linux-arm-kernel@lists.infradead.org, Ondrej Jirman <megi@xff.cz>,
 Aren Moynihan <aren@peacevolution.org>
Subject:
 Re: [PATCH v3 2/2] arm64: dts: allwinner: pinephone: add multicolor LED node
Date: Tue, 26 Mar 2024 23:44:39 +0100
Message-ID: <3796126.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <20240317004116.1473967-2-aren@peacevolution.org>
References:
 <20240317004116.1473967-1-aren@peacevolution.org>
 <20240317004116.1473967-2-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 17. marec 2024 ob 01:39:29 CET je Aren Moynihan napisal(a):
> The red, green, and blue LEDs currently in the device tree represent a
> single RGB LED on the front of the PinePhone.
> 
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



