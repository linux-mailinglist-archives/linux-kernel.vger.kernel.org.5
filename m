Return-Path: <linux-kernel+bounces-156405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156788B0266
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F8F283DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47881157499;
	Wed, 24 Apr 2024 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNfExcaV"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1837615687C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941325; cv=none; b=IWnpVn1OiyUozS5iMcOe/1WgGWCkyoKTwoggOQ8/i9CF9xNPW8kyDud+zv0788TklysSQZ3yGqLhoxIjdakGje0PirXRLDHq99XAZAAbGUeyiyZ8Io+IvXIgFk0cMFLd17Es+9GX/aJFOVtQuQkETfwCLeq0TSHyKaB/Eo0EvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941325; c=relaxed/simple;
	bh=5CU6mL+iQliAjVWbjAM7cnzdrrPIzC97UjspUCLrXDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TS00jppWQzRF69jpJLoT5+orD9c8/anivq5xlmtbBN/F9rdnGkksJ+iuF1Oa7n6GxPo31vv/Of+3oB/YBDCczrSfS4ydQsS2bmf4jfUYUfgNDmYt/d62cJHgrmIVXeCIVeu6tNjlxstTJXjHOFrfuvqsIxFeZtCd6FkGiNLYBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vNfExcaV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-417e327773cso2753765e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941322; x=1714546122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r61Kb7IQFeca73kF1CUdR8Nck6Yrqjf3CouDIb1P98U=;
        b=vNfExcaVYtlcpgdiHeOUgMU6utCfNEbc93oR4bUOnhUCA3WyreMkDNujfzC1SNjrnj
         eLTK/uoVJODb5R/DcYNOW788rcl3TNNxcpZ8WzyyhRzsdhnfeTn0lQnquK87D7lx6Pe9
         bi8TlNXddmq3+lUAJY4+xfWZ54KDbg0uRXsi2CI6I4taEClUqAMhw49vAG//NdC4RyDD
         O9ouiL3GDjxnLpUqxgAw6nrCI1l9AEwK32bZe6NzIY5kOGNCM+f0QAqvTxD/i+KZz4W8
         r2HJ7UIS0mgexa7N5fOwtam6U/1EjuYRQ9iA6GE+mon6C/lylu3ljAk1lkLopZ1rz9dg
         Enbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941322; x=1714546122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r61Kb7IQFeca73kF1CUdR8Nck6Yrqjf3CouDIb1P98U=;
        b=srg+IzZZ/q7gNT4OkJVqm/dMvxw/QF8eZfSMYOEftzsACTpf8IP0NIWf01K6KSemLD
         GYvo0iBPgc/wr9SripBpJjrWutvnsLiKyrb/V+oU6EN1oUg8slgvFXiWLL3wVeKuJnfP
         uVPdamckpWk2FSlB4rS8tU4UF5T+NMPmWFYa7mkoY/cPV3hZ2RlxLktRrNjK6ZevztCh
         MW1XR5DVKZn96iJJ+Uf8/xbCZ2k8PsBq5SmbLeoKwq5MK7vc1+dKo9bLQ2M9UcLxoYVi
         yTgaY7Jgwtx7uyC0ddcVVamWO59ifaA109PRqcJiHRAbzsiZ2HMOCXZ7XJgPlIQEZPLe
         izzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrEqB6+GB36lNaSu/SXmkq71r0USDDhh1wQnfDlaqzX0HTs0SSzvRfp/6zNPSbz51Y2brS7U+OFqcFXiOKgY6+JLzZoWtjeFIndVUi
X-Gm-Message-State: AOJu0YxrQhAEndDaXXb5rK/hrN5kZMhpA9a+PBEskaeymSMCjShWRduJ
	X2h7LGiEtIbB88knAeE4b82v653xmoTQXCjeQuL/BZM1jbs3kNW+Tt3tOcS2s0M=
X-Google-Smtp-Source: AGHT+IHaQADJgMwIajA8lFxEUdw1lpqkdpyaVAJFqWUQcrZ+ZPia4iTy725UEakhayBhM96AyPmpog==
X-Received: by 2002:a05:600c:3b91:b0:417:e316:fbb3 with SMTP id n17-20020a05600c3b9100b00417e316fbb3mr1013641wms.15.1713941322494;
        Tue, 23 Apr 2024 23:48:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b004186c58a9b5sm22433236wmb.44.2024.04.23.23.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 23:48:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	devicetree@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Kousik Sanagavarapu <five231003@gmail.com>
Subject: Re: [PATCH] sh: j2: drop incorrect SPI controller max frequency property
Date: Wed, 24 Apr 2024 08:48:36 +0200
Message-ID: <171394121882.41568.17609347008268237958.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322064221.25776-1-krzysztof.kozlowski@linaro.org>
References: <20240322064221.25776-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 22 Mar 2024 07:42:21 +0100, Krzysztof Kozlowski wrote:
> The J2 SPI controller bindings never allowed spi-max-frequency property
> in the controller node.  Neither old spi-bus.txt bindings, nor new DT
> schema allows it.  Linux driver does not parse that property from
> controller node, thus drop it from DTS as incorrect hardware
> description.  The SPI child device has already the same property with
> the same value, so functionality should not be affected.
> 
> [...]

Month passed, no replies from maintainers about picking it up. Dunno, looks
abandoned, so let me grab this. If anyone else wants to pick it up, let me
know.

Applied, thanks!

[1/1] sh: j2: drop incorrect SPI controller max frequency property
      https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git/commit/?h=next/dt&id=cc92bf017f7c66c8a4050c61a7d11ddfd43f5cee

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

