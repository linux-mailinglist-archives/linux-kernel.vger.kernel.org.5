Return-Path: <linux-kernel+bounces-156421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00C08B02A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0FB2856BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD2E158D79;
	Wed, 24 Apr 2024 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bTqdKgvD"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B771586C5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941669; cv=none; b=g7kpCww9KbfvbLWnDCkV5VQXAQp5dv8B6nr34lQyczuWr8M1r1SAeIg0Sp1eWaNLcUJ+Mc6BzECIPd9Ot/GQaloDinvGJXFIG8+rc7Ut37tamtDG4q9sbh5/0vSuwr2lzD/vSiRmQHNTWu341CMFrYMwrruzQrQ98H//m2eQ4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941669; c=relaxed/simple;
	bh=xX17T8WMKkxIp4UDB4scfeAA2Am2xF6rrCVM05QAZRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAhahPH8o2W1JVPmRvJvzxLJte5mMqvlwDPylx242zrVzbEYl5XyYg9APDWD4wQI+Q5RtdGsl+6168b27VuhG6yrSBlq4RxtzczTcbc1l3XyGnpttk7NQck2EkCzWJB6YfOf4CNGTG+7NfJkA8cjxHmtm3VMuMZdfo6ciYlVsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bTqdKgvD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34a3e0b31e6so4741379f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941667; x=1714546467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRXZ/tLCapg/sR9UuiD3mh5QxR0Ko/bOntfG3Dm/Y24=;
        b=bTqdKgvD54IurVg9s6sukYfUKnxzoUBko8J+YNShmOKR2wMccKhZCL3f83X2CU2uhL
         YbDE+1vUvJU9Z3TqgvSz7pPdc9isRudhvRO7aXPeBlF0tOn4Fl9RmtnPI4rFIaW6WOFg
         xw9dSNXMZynCEDlxMqTP2x1kffw7Gpp5YtbEyDmrwMV2CDRyKLbP7gQ1Y4YmnE/74vN4
         r+2JO01PdIcccgauhWkSSLjHpBygE9J2Ftmg+6F+cB9XrU2LlkfaEIkuPhq5zNWD9Fgj
         VDYinAXPVzVgxVk6gZbmaZ8VUqGW+mQIZV77lRMtMLY8aM0K+vdBVoSdS0n5T6VQgiPp
         6UrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941667; x=1714546467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRXZ/tLCapg/sR9UuiD3mh5QxR0Ko/bOntfG3Dm/Y24=;
        b=e0SlberNhxLLBkxGt7oVmFtKyS2O5JBvcsg2jWKRc4El3XyZVosoE2MxbwsSVxzcqW
         +HypcHxYls6X4IQFEFxH1rS959dP0BotnjN3afi17y6sWZDR3Jj1L8eOQHzK5+EURQ3r
         0AnxVWkX4+iI3H+T8SK6+/j1Bjnxyr/khDVjMmJj0CNE7AuqIZxqY8DMqryfM05zK6DU
         BiJdBqs2Qjb/3FdPwS6Z2TgysZOddtgYAtEf+EjwF5bH6Dy2AwAOOP+xDvSzyB2Mijxd
         8pL6/UIGAXq9APF3dN+JXo6fwHyCkrYTHF82kgqs0NCCwF8HlgyU6FGbOGAXrYSatPyF
         rDqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwYHuAz1dA4GVme/qBcFSQAPU8njhWA3Q4Ywxudcg2q2EtWgHOVsIWzIEvvMrc153UEOsUWPcGibJh/JlgCQlXXy2IptYDpSAt+mpH
X-Gm-Message-State: AOJu0Yw7aYLBmcDcX2MS2079EKQcV0J5JyY1ZvOxbxZtrCXwMnqdNLlL
	9oZtxQAIfG6u2zy5+LoAVDNj2Ic8+p+3oFMJXRAZpweRN5lUBUYGiujUf3gOrtw=
X-Google-Smtp-Source: AGHT+IEHetyDhUiUzHcfe7q16iCTDEirIvHNmMB9O5sQej3xjlHhonwKDPihO71zRrjNQU88qGbN8w==
X-Received: by 2002:a5d:568a:0:b0:343:9b68:d9a3 with SMTP id f10-20020a5d568a000000b003439b68d9a3mr871983wrv.64.1713941666708;
        Tue, 23 Apr 2024 23:54:26 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d6912000000b0034997769ae4sm16338534wru.15.2024.04.23.23.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 23:54:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] arm64: dts: cavium: move non-MMIO node out of soc
Date: Wed, 24 Apr 2024 08:54:13 +0200
Message-ID: <171394159880.43787.17031752611016260486.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402194129.69481-1-krzk@kernel.org>
References: <20240402194129.69481-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Apr 2024 21:41:28 +0200, Krzysztof Kozlowski wrote:
> Non-MMIO devices, which are BTW not really part of the SoC, should not
> be within simple-bus, as reported by dtc W=1 warning:
> 
>   thunder-88xx.dtsi:374.28-379.5: Warning (simple_bus_reg): /soc/refclk50mhz: missing or empty reg/ranges property
> 
> 

Almost a month passed, no replies from maintainers about picking it up. Dunno,
looks abandoned, so let me grab this. If anyone else wants to pick it up, let
me know.

Applied, thanks!

[1/2] arm64: dts: cavium: move non-MMIO node out of soc
      https://git.kernel.org/krzk/linux-dt/c/e0806688f15cc448e6d8ab0f2fa5e8040a7ab6d5
[2/2] arm64: dts: cavium: correct unit addresses
      https://git.kernel.org/krzk/linux-dt/c/02e361a6f6c72c16f89ca2e07b731025292b5662

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

