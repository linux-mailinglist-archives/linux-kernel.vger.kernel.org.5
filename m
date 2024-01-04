Return-Path: <linux-kernel+bounces-16680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E8A824255
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7A9285042
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4856324B40;
	Thu,  4 Jan 2024 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DJZleFYX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2142C249FE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cd1aeb1b02so5584961fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 05:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704373332; x=1704978132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA5aHFJ46r457gaZ61RwpP8TkLsec2lgKs71JTHrGEQ=;
        b=DJZleFYXxWZY9pk+c/Ehi5OSl4NVSFuUu0j6/9cSWmaVsDXtL+d0AQVaTqQW/o4yPM
         WdIHaj4c4UsRzaN/lYeVhjzLv3/EOXF7yrgMQW42nEQJT6xgoO/ZhlR8tlJ3jvsK3rpu
         ph8iby0pvdvmWGu7eaqSJPd4trBW03ILPcVsOfSEA1ynVrf8IIbWTajurqnnVSp7AK4D
         pgikgrkCWXfgAqDkPT6Y+YwanUmfQ9cEVRbcSWY7DRowbuht9QlZ79B3u5N2DkCjaVsg
         UuDiLboYKrUsnxfLIp/YVPG0Xa798MDz3yABbVRGL9y/GccdLVm/F0NJ+h4OvGDp130p
         EwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373332; x=1704978132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DA5aHFJ46r457gaZ61RwpP8TkLsec2lgKs71JTHrGEQ=;
        b=w6fHlg8hBDMi4Mv1LNgtkNUmtoiq47+mfyn9wo0cwCKBYY660ChVTZSdvHJHyTbCNC
         wgAszsHoaS4OEJepFMbPbAGX5ht9V1b0S3jJWpe6EOwtef5rix6DAp70L7xkdzLA/X44
         lWTvuPgq0fPyPRV4x8vFQ1r6VedBMIno36oqGL+A7empYx7hgdmjC+LQus69uOpU2jwO
         zaKhYwAGk1EtNkrnSKiGQr3+lthfAXPw2jYd30EjdsB8TKTO2TQg1v6BNRs8DgrFqrN0
         1M8rI8PbvJpSaRDuXw3jNQIjO7kZ8Z439b82rBxcisOMM/vkaOk+A49v4lMYAAw3UbGP
         6JRw==
X-Gm-Message-State: AOJu0YwVmkR/TI7ErVZvy5oBHpuXaLUxl2WEpUTc6mWkyiaqCRdJDZfu
	FB32bgiylqnrQczK2F4d/ud4P1Nkvy7YyQ==
X-Google-Smtp-Source: AGHT+IEDdRsPhWrWa3EOX7GzwSp1+D8RAfZyh7Y4UQZnWMuUFL0QHtHvjG9EaWqRMVvXI0CWBZWV0Q==
X-Received: by 2002:a2e:7d07:0:b0:2cc:d574:6057 with SMTP id y7-20020a2e7d07000000b002ccd5746057mr314367ljc.73.1704373331828;
        Thu, 04 Jan 2024 05:02:11 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5b69:3768:8459:8fee])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b0033660f75d08sm32887387wrv.116.2024.01.04.05.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:02:11 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peng Fan <peng.fan@nxp.com>,
	Robert Richter <rrichter@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 6/9] dt-bindings: vendor-prefixes: add a PCI prefix for Qualcomm Atheros
Date: Thu,  4 Jan 2024 14:01:20 +0100
Message-Id: <20240104130123.37115-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240104130123.37115-1-brgl@bgdev.pl>
References: <20240104130123.37115-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Document the PCI vendor prefix for Qualcomm Atheros so that we can
define the QCA PCI devices on device tree.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2dc098b39234..297d6037cd12 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1128,6 +1128,7 @@ patternProperties:
   "^purism,.*":
     description: Purism, SPC
   "^qca,.*":
+  "^pci17cb,.*":
     description: Qualcomm Atheros, Inc.
   "^qcom,.*":
     description: Qualcomm Technologies, Inc
-- 
2.40.1


