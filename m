Return-Path: <linux-kernel+bounces-16683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8DE82426A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B87C28472C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7D628DB6;
	Thu,  4 Jan 2024 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UhqynyYG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2163B25559
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3373a30af67so391651f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 05:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704373336; x=1704978136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qJnh8AIcAKZQaw54XikqgZNFVCwv53vFvEp1sREEes=;
        b=UhqynyYG1cNDNg/fEPcXwN+p9G5KyL12APCnP4H/JxuDZ5JsGtXDEhxvPzO2racoXy
         MEdyfvrgHzBGxJtRrPpzthabhuxASCa/PbGQ32Ww8dTQAzuLNpb2Mk9WbHartKlEwGq2
         EYRKFqkDj0FH1N632N3cZRGpqPDjomrr4J8kYPD1a5pV/f13Thz8DvH7VTgSdlsm66PB
         fcv5QwxPc/QPehh7mkJnc9hn5R971W+eIYHeazoadTce4aRUP0lKaXfyHz5INW8//UcG
         k8pbJh+F46ufTQ6Ij9/Us6M2qjmB3c+KlTTeIULks2gP89LK1Jlae96Z8/iiw+qLZVNj
         5dFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373336; x=1704978136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qJnh8AIcAKZQaw54XikqgZNFVCwv53vFvEp1sREEes=;
        b=chCo4mCdKsD3oYCffFEAahVXY5NYqlv2j+AICLChtSurJCbDjkZBe600Q7+BIPT3cy
         65HjOMHJ1QF17jBpJGT00FIfmfB2ZnBrOzi6nbdZ7eY6lDvvQ9d0LU1RHwigy4GSAycl
         +qGqrUjeI5vLc8UMLKokwCrudDFiu/tX06r1sJegWcwS6NKHr4JtgzGBValZET9q1DlL
         9XldlCuVtMojqsuOcq3Y7V7LCHAv4l9kmsLmNfGCPH6RuzX1C8L1pWraCqOnxbUaz24v
         mHIuutLA24KsAFJRILGbid35HwgPlChF9nuJOn0V7yx2PTcAkYDCoVmebY2K6EdKV1nb
         CL8Q==
X-Gm-Message-State: AOJu0YwvzbLZVYemMjLI947CuT4GlDAkc+fjMeV00E7EvWCwypOyrNn8
	0gLHc6u/tUgIZ7WVW4L++eamqH0cBKB60g==
X-Google-Smtp-Source: AGHT+IEqja+u1Zepunc8yCe1PWCPYTJaRhSPQH3gTIMidcrQA/WboeRZVVunuvMn3vOkG/I8lK1Owg==
X-Received: by 2002:adf:f6d1:0:b0:336:74aa:d78b with SMTP id y17-20020adff6d1000000b0033674aad78bmr238945wrp.145.1704373336434;
        Thu, 04 Jan 2024 05:02:16 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5b69:3768:8459:8fee])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b0033660f75d08sm32887387wrv.116.2024.01.04.05.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:02:16 -0800 (PST)
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
Subject: [RFC 9/9] arm64: defconfig: enable the PCIe power sequencing for QCA6390
Date: Thu,  4 Jan 2024 14:01:23 +0100
Message-Id: <20240104130123.37115-10-brgl@bgdev.pl>
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

Build the QCA6390 PCIe power sequencing module by default.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 361c31b5d064..7daa863f25e5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -210,6 +210,8 @@ CONFIG_NFC_S3FWRN5_I2C=m
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCIEAER=y
+CONFIG_PCIE_PWRSEQ=y
+CONFIG_PCIE_PWRSEQ_QCA6390=m
 CONFIG_PCI_IOV=y
 CONFIG_PCI_PASID=y
 CONFIG_HOTPLUG_PCI=y
-- 
2.40.1


