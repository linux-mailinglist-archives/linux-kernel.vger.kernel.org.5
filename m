Return-Path: <linux-kernel+bounces-163720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149328B6EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C226D283F53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7C7129A7B;
	Tue, 30 Apr 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6h27Eav"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471271292CC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714470590; cv=none; b=S/93H7ufNwe4wb6E4zwGQCWU3jAVJXVrBBmakLAl9Fnk5meruL4wWHq7yQhUwlZETDxBeEGorZW7R52zSlJmMuijYV8V2I6FgnQOLCZgD30hg6hE3JdEt0EHQi6WOl8piOFOqV9i2ajqTWUB4344dmnBwchFhfHXTqAUBNS+s48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714470590; c=relaxed/simple;
	bh=+Yl5WcLATDY6Hk/ADA/oOADRGUb1ZKc09PdetCkIgLI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OCNbuGl6lkTczLWiydWFpJ1FqJEjcEhEf92Tlq/sTl56p9M+b15lhVnFuuqbvYz6kMzJ4kvdZtu12QIpyrJBLnSBj6+RiIOBMR5fAqM6aVAmlOdtO63P/zsY/PzQuCVXp4FZTWutGzpxH2FiV1ymbRfEiRy0t6ZN8o9SWPbG2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G6h27Eav; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a51a7d4466bso602031866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714470587; x=1715075387; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jpoZkA6m6TkJgLTdGIIOPYxXqE9n34qTSSRnWAeB8zo=;
        b=G6h27EavxCd0nD8Jwo0EGr/TQNTWTCL7KTruEOiurK0xOOL6knKCcgHQTaIlBjCNQH
         4tF8ozsZiL1dTmHjOuuhMIAXulcm2L4hFCLF0Y/zOQaCPJKi/Kx2Pc//r4iVOUx5Xesf
         lh/vbjJaSg3JlEuMONL9eweP34IzuwVnn9Q4smnw66F9J68VN5tIlV9he3ktk6n6Nrlc
         /JrF2URTnzPnC+F6rspgTgJqBzgHsdvG08bp+0ckB1gU0YEbnEnBYiLHjc7Cz7HBgTgy
         zirhl1zngd7yB6fYNNqktL/2R4EePY9W3iwERfDWxGbo9ko6+y101Px5uDybVvZ+6PGw
         jQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714470587; x=1715075387;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpoZkA6m6TkJgLTdGIIOPYxXqE9n34qTSSRnWAeB8zo=;
        b=vB5H+A7FwvzG6FilqULPzDb8vpCdNhO18qhiTBm4DMTI2wNniI+3MN2QjQfNieJdjj
         /bvPTOFiWxdfy84AIsib74nLBXOyYuHKARMf+u0QfYYLiLXWmy8Ox2dr6egNNd9FaXt2
         bNNCaNLdhfk7TcvTuWB4mlUCmxP+sJl5PzlB6ZvO8IEzRPzy+McNSSR0tyMs0cPKgf5G
         3zsekeVtdnpHmbm1rJdkWIebRfRJmu7sJ1ZC5QrCUbFx1e2hn1BxMgG3cvF2/HKK9BEl
         lnDnsB0M1c+fd5RvNBXOzLVcmhKXD16lJkEI0Puu6W+NxL3yhkuBgpIS4fP1dJrHmFCw
         qwig==
X-Forwarded-Encrypted: i=1; AJvYcCX4yA6czFTphGennJ20nP5IQokcWEZqob4Si9UbRRx8yfs6Sbd1uST7HaQaEohRu2itFh1gLd0yWRNbkUiaJkS4VOdARvIy2M19nS/c
X-Gm-Message-State: AOJu0YzYJlqyRLE/lwdEwtdXCrT5rOdSs99hKoDt4h1tJk7k8KViY0ik
	/Hzofcr4mLMR51tL2A99rfVBMjK+kzSiJa74W7cvMDXwgsIgiEinOmWdfaWG2ig=
X-Google-Smtp-Source: AGHT+IEHj1s1mj6uPULOTCJsma5iVRNovhYpwjfGLJb26YwhziqJe4wRQdYRirn6ZwiRD+j/sdL+jg==
X-Received: by 2002:a17:906:fa1a:b0:a52:1e53:febf with SMTP id lo26-20020a170906fa1a00b00a521e53febfmr7416379ejb.69.1714470587603;
        Tue, 30 Apr 2024 02:49:47 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id dk21-20020a170907941500b00a55aee4bf74sm10981024ejc.79.2024.04.30.02.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:49:47 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/4] hook up pin controller clocks on Google Tensor
 gs101
Date: Tue, 30 Apr 2024 10:49:45 +0100
Message-Id: <20240430-samsung-pinctrl-busclock-dts-v2-0-14fc988139dd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALq+MGYC/43NQQ6CMBCF4auYWTuGliLBlfcwLEopMBFbMgNEQ
 7i7lRO4/N7ifxuIZ/ICt9MG7FcSiiFBn0/gBht6j9Qmg860yYyuUOxLltDjRMHNPGKziBuje2I
 7C5pro3VuSlUYBSkxse/ofeQfdfJAMkf+HG+r+q1/hleFGRa+ygtVVl3u7H2kYDleIvdQ7/v+B
 Y/CVTHJAAAA
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

This series hooks up the individual clocks for each pin controller in the
gs101 DTS.

On Google Tensor gs101 there are separate bus clocks / gates each for each
pinctrl instance. To be able to access each pinctrl instance's registers,
this bus clock needs to be running, otherwise register access will hang.

The driver update to support this extra clock has been proposed in
https://lore.kernel.org/r/20240426-samsung-pinctrl-busclock-v3-0-adb8664b8a7e@linaro.org

This series depends on:
* hsi2 series:
  https://lore.kernel.org/r/20240429-hsi0-gs101-v3-0-f233be0a2455@linaro.org
* pin controller clock support:
  https://lore.kernel.org/r/20240426-samsung-pinctrl-busclock-v3-0-adb8664b8a7e@linaro.org

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- use <0> instead of a placeholder clock (Krzysztof)
- Link to v1: https://lore.kernel.org/r/20240429-samsung-pinctrl-busclock-dts-v1-0-5e935179f3ca@linaro.org

---
André Draszik (4):
      arm64: dts: exynos: gs101: specify bus clock for pinctrl (far) alive
      arm64: dts: exynos: gs101: specify bus clock for pinctrl_peric[01]
      arm64: dts: exynos: gs101: specify bus clock for pinctrl_hsi2
      arm64: dts: exynos: gs101: specify empty clocks for remaining pinctrl

 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
---
base-commit: d04466706db5e241ee026f17b5f920e50dee26b5
change-id: 20240429-samsung-pinctrl-busclock-dts-46b223471541

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


