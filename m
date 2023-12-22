Return-Path: <linux-kernel+bounces-9642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA2D81C8DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE62B23595
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398BF171A9;
	Fri, 22 Dec 2023 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4i4j7ZJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CFE1426C;
	Fri, 22 Dec 2023 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e23a4df33so2128486e87.2;
        Fri, 22 Dec 2023 03:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703243676; x=1703848476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ywwb2c8K+kZPbyhXDFCz7U5YWzVC2teLlAt2hSiJc0A=;
        b=j4i4j7ZJEb420d9qFo3pMBUdaXgDy15Yot02E4+0+qfthRfZVJwSLxiGVgBl6y0Abn
         9JPr8M1qFDzrp8+7MkxmNqttEQbUwiynDISlbH3lUkSpfJt8PQ47YNBfsci//2HV3Yde
         OfssNAcJGAsgkFl0LTUDCuET17IQRB6PxkBZGXQCPeP8MtQE6WvXkZFYyHbhE1juDqm0
         MgfezNTLXjrRpbb5rEjXIrUo4KGFglUMrK3dOvdwLb1JKKKrYxdgO3N063oTG4JTrTKu
         Ii86XvJmKSgk8G3m0RSr4zK2bDg9VKN4JeDb6cSHrbbdbjX0sEXE5BvI08Vwv9SfEd2Y
         SSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703243676; x=1703848476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ywwb2c8K+kZPbyhXDFCz7U5YWzVC2teLlAt2hSiJc0A=;
        b=GvRS+yuvVTqRiFvURvzwkG+5ukXwIdKorYeMvIVLf3sWRnEFPE/xK/uaykh9gGH5T1
         fcgMaC8JNeXeTKblzYrPOzDrFnprxCExslhfyDcUQGIBjMkR5Ml/vlTPa/SR5yw3Qj+O
         2cgRILyA7j2/CVHKqWi9Ac5D23W1zFYDjGZGpWz9z/I4B8Qrg5A6jKKI8kYshEYwLZ5u
         ibIz1zOjxw4RIdUuAkOTflZ0gV3oHLnqIPQMa3KqIYbBjU1UYIITCBzYbD/BgufC0HuA
         F8A+sODZ6PaeTYEk7HfQ0vGGsdpX71FJvSHkviIytL/OSfnMD4n11iDHUqIPhdXOvSPT
         Hqag==
X-Gm-Message-State: AOJu0YzzUSRn5SrY7Ju7hoqNnpgu4yg5dBx8/vV31J3WEPhPGLozE5S5
	mtcUHKZN6ZZwMwyw9P1o/Dc=
X-Google-Smtp-Source: AGHT+IEHhoBZ6sLrw8lKHDckHa1uRnHimx5cP137ZR9Lgo9yiD12gvt8LEkOv80eCcFyVhpbiFrZ1g==
X-Received: by 2002:ac2:5dd5:0:b0:50b:ebd1:6e8a with SMTP id x21-20020ac25dd5000000b0050bebd16e8amr572807lfq.133.1703243675755;
        Fri, 22 Dec 2023 03:14:35 -0800 (PST)
Received: from localhost.localdomain ([154.72.162.91])
        by smtp.gmail.com with ESMTPSA id es15-20020a056402380f00b0055267663784sm2420469edb.11.2023.12.22.03.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:14:35 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [RFC PATCH v3 0/3] Add support for reading D1 efuse speed bin
Date: Fri, 22 Dec 2023 12:14:04 +0100
Message-Id: <20231222111407.104270-1-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This series is an attempt to get feedback on decoding D1 efuse speed bins
in the Sun50i H6 cpufreq driver, and turning the result into a meaningful
value that selects voltage ranges in an OPP table.

I want to make sure I get this right before sending in a v3 of the D1
cpufreq support series here

https://lore.kernel.org/linux-sunxi/20231218110543.64044-1-fusibrandon13@gmail.com/T/#t

which is currently stuck at

https://lore.kernel.org/linux-sunxi/aad8302d-a015-44ee-ad11-1a4c6e00074c@sholland.org/

Changes in v3:
- Drop 'len' parameter and pointer in sunxi_cpufreq_data::efuse_xlate()
  prototype

Changes in v2:
- Make speed bin decoding generic in one patch and add D1 support in a
  separate patch
- Fix OPP voltage ranges to avoid stability issues

Brandon Cheo Fusi (3):
  cpufreq: sun50i: Refactor speed bin decoding
  cpufreq: sun50i: Add support for D1's speed bin decoding
  riscv: dts: allwinner: Fill in OPPs

 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 19 +++-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c        | 89 +++++++++++++++----
 2 files changed, 87 insertions(+), 21 deletions(-)

-- 
2.30.2


