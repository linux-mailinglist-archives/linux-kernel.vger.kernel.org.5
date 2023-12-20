Return-Path: <linux-kernel+bounces-6655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A9819BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47BE1F24CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FAC20330;
	Wed, 20 Dec 2023 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP1xU3t7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DEF208A6;
	Wed, 20 Dec 2023 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2343c31c4bso468532766b.1;
        Wed, 20 Dec 2023 01:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703065921; x=1703670721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9qpB4qf3ZId6lZMFowk0z0oliDO3YWtk6BSWDnuZ0o=;
        b=lP1xU3t7Ja8m7hqpkybAxl1+BOI+rPjr4HScLvWBdD5D52SVPmzLgA+P6jycjOzFV9
         rptbAJsfaiC9k2vRb+FBRMBU2NYpfiWdVZgyUOW7CdpnieS7wM8ttViBFqvUcxCRkSqf
         oNgQsxAEo4HaM3TZYR/xDeJalrcfrK0Aq1UhLkG60QyXP+snjpIoT9QHvApRXABHC4+u
         vWsTPb5miP1L9oYrs8Mb/OTulR1L8AIs9zrpC/ZFtnNN/ZJemJRvsITDjiZ+bRPajmIe
         c9MOtwtdlQSRJomw9Sdsaj7JDH6fcN7gBPCdfmVgzydOZ8AFw8kN4LFG+YeVAxXNkHp/
         wPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703065921; x=1703670721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9qpB4qf3ZId6lZMFowk0z0oliDO3YWtk6BSWDnuZ0o=;
        b=lH7fkehjEA0jr+mUaAxrKL9iQaOmWp7MsAQWa/j7JSaIh2UUMrLYMvLuG+1WDObsr5
         rnMb/0XIXNgy32s3fwN2G3Wb3rlBYCVjHxHm0vIy9tx2yipxPVFtzdOLXcId4PJwWMue
         roI26ngGMTO3Qoa7ZKIHqTPTuIjxl1f1xTepKM3L/Kw92gpfMqtEPPt0o4p2NGnFOc/x
         o1DE21w2xRgCtKz/kJ0v4LezXe9WrYtv6XBSxJ/mJEl3ABSbHynHf5uV09bjirjOyCWr
         CQqoeR1l0cpAXGaNu2CvIB6fddsUte26/TaUCr0YXTXaYWwsB/Vp6uGM0fvpUGYBWpoc
         xNog==
X-Gm-Message-State: AOJu0YxjpXZXWew3Yhqv0Cu9KtCRDv6SXAZYYJGN22g2IALjk1MgOQhi
	DVb7ORrNAcZbO6sSg8dmSk8=
X-Google-Smtp-Source: AGHT+IE28g41l7HoQZQIn3TqFjt4hhf/zSXdXrozlWV0k0jrhm2KNFm8zxiuiquLZS9DJmjzTRsGSQ==
X-Received: by 2002:a17:906:10da:b0:a23:617d:1917 with SMTP id v26-20020a17090610da00b00a23617d1917mr1485420ejv.116.1703065920680;
        Wed, 20 Dec 2023 01:52:00 -0800 (PST)
Received: from localhost.localdomain ([154.72.162.158])
        by smtp.gmail.com with ESMTPSA id st3-20020a170907c08300b00a1c4fde4e88sm16596791ejc.18.2023.12.20.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 01:52:00 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
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
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [RFC PATCH 0/2] Add support for reading D1 efuse speed bin
Date: Wed, 20 Dec 2023 10:51:39 +0100
Message-Id: <20231220095141.27883-1-fusibrandon13@gmail.com>
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
cpufreq support series at

https://lore.kernel.org/linux-sunxi/20231218110543.64044-1-fusibrandon13@gmail.com/T/#t

which is currently stuck at

https://lore.kernel.org/linux-sunxi/aad8302d-a015-44ee-ad11-1a4c6e00074c@sholland.org/

Brandon Cheo Fusi (2):
  cpufreq: sun50i: Add support for D1's speed bin decoding
  riscv: dts: allwinner: Fill in OPPs

 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi |  8 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c        | 85 +++++++++++++++----
 2 files changed, 76 insertions(+), 17 deletions(-)

-- 
2.30.2


