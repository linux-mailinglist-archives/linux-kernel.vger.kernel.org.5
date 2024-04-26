Return-Path: <linux-kernel+bounces-160326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBC58B3BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E3D1C241EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC7B14A4D4;
	Fri, 26 Apr 2024 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkGIqNYL"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB783146D4B;
	Fri, 26 Apr 2024 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146395; cv=none; b=jNNKki/UsFt+8cWfj8gkRppgDnUOPVwiXun+naGKD1yxVmf4a7/YVqcrsWGHpXSmMpHEc5txwRi6+UkrTXpozyg+kEaQGdXw9NeJUNDt+dVgY/K+/YerridKFi+/Ix6CFcgJUH2qAd3EkSq8KvUa18AwprHbUZMn7BzG3LOwxx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146395; c=relaxed/simple;
	bh=2UtRjw7d/gSUbQgwTtdM8Mdk81nwUGAZVscFer9sTJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2+wzP+QcwMYeRJrlbImC/HU9PK7gJ/yfGmG9+T3fMfos56cy8BnNEtDdKzzSK7Pq8BIzoK8dZj7+2mK7eqrzHN0e3xJAgyvNkVu4rdwE1XzXPdlYg6InWm4po52tnlkaF9fxhD52CEf+zD5VbfbYEGGQ9om6+YJXyhYoXEBT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkGIqNYL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4702457ccbso312725066b.3;
        Fri, 26 Apr 2024 08:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714146392; x=1714751192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXbTa+KajuTLrUP4WiAbVHIOdIZw5ZWXUZLSW6mrWPw=;
        b=jkGIqNYLVQ4tu9hw5pl9eUDcglQhprzdCwXUDFIkOVSDAWgR6A6Iu0xlADsS0XDutV
         NBB+emdKR8oTejV1pYtoqpwHfP3DxPpO4KYJfyFVq0g4Dlu2kvRsHJSHofvmmHI2L/mH
         xh0OqLw+jbWbSrSvDw340wQFkqqRZ5vMGQQEpF+qJh8b3jhQRbXUbXL3fPn/yeh4AMrP
         0wzndGi+KpBP9yNcipAAPdhVChTHOFNdBYqgHf1FqRWfLAvCcBv1S/2ewCXY62/wNUjI
         FgeY4+BS3CPsMKsghmh5uNczPL69wVga3Sdvlty/1qlz5A+0HZAEEdaaMSXPvBCeaWDF
         t4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714146392; x=1714751192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXbTa+KajuTLrUP4WiAbVHIOdIZw5ZWXUZLSW6mrWPw=;
        b=OFEJzRWWviyM40YzU24URzLKFTkRrs32Uf8eXblbVr9tDdcO2rmkkgNp/2mv4ez6+s
         70Pd5/f2ey1eRHUKmQvHl3H1f4TSvg07tsiAMVdMXrWDbtIAzwbHycQUb5wDRy3nSQAS
         n9+oi2HujeBmBYLZdPHcg1roygrclWNKiDTO/GQgEs6q2qCOw77F/lTjLOJNDARfP+xB
         V6T6RKU6YE1nWNTQ6OQrbIxGtyIsqZy4fgQ8/TweU7lM8aj3wbjNd2cSXnVDdQ4ajH+B
         gexlWuBHB/c6glxM705N+pvRUrwljA4wIEox66bN/cLDEh2aWUv4oQPUkMzzKLg0mvjJ
         821g==
X-Forwarded-Encrypted: i=1; AJvYcCXsy0AVmZdnvIfcVeII8/Rtmh4o7ZVFaTtKWFwW+V8ugara56uIeU2zkhocK6aGDWOei8PCyK2MGAD16Qmn+0FowAIKbZQKhMs5tbFjBhfD//DziN2D0jwyTFgGuUVGMW43pWU/6YkggE0=
X-Gm-Message-State: AOJu0Yyty04BVMYZIwt1cYfx7InSY46/qSkUPjPWtgPubl86OfaxWPdY
	45I4NXObvGWB0DXzw2wup5Tp9rZN9G1EEPNIfXAAiYdG8T5A/TIxHhpwUg==
X-Google-Smtp-Source: AGHT+IHxfreGP7FO7+xHHu3l4Dz/DEVwOBePXHKsqR2tdwPTL8o49Zw2EMAh/HhvuAgnryGPnU5yEQ==
X-Received: by 2002:a17:906:138d:b0:a58:b5b8:5805 with SMTP id f13-20020a170906138d00b00a58b5b85805mr2297574ejc.39.1714146392001;
        Fri, 26 Apr 2024 08:46:32 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709065a9200b00a58a4ccf970sm2378527ejq.103.2024.04.26.08.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:46:31 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: tegra20-ac97: replace deprecated gpio suffix
Date: Fri, 26 Apr 2024 17:46:29 +0200
Message-ID: <171414637918.2300234.4054459462425570866.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423120630.16974-1-sheharyaar48@gmail.com>
References: <20240423120630.16974-1-sheharyaar48@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Tue, 23 Apr 2024 17:36:29 +0530, Mohammad Shehar Yaar Tausif wrote:
> Replace "gpio" suffix with "gpios" for tegra20-ac97 dts as gpio
> suffix is deprecated.
> 
> 

Applied, thanks!

[1/1] ARM: dts: tegra20-ac97: replace deprecated gpio suffix
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

