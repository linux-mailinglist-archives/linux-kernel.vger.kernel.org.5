Return-Path: <linux-kernel+bounces-163574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D31E8B6D48
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F6C283D92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B764127B66;
	Tue, 30 Apr 2024 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SP1Wp1Ew"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989423AC16
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466980; cv=none; b=DSFvrWAyP/2N8+Fqnk4DHlh9Fg7tiKXgAPtqOP2jiQcT+FZN6sSMEbj2faKhK6jBCzxilOVueqGShvRgrbPcXwfISfmSzTny36ZJJDtBNdkdnMUBRP7du6K+fHqMIOBUFfXrWBo/5lp1CBNnZ+ufmHCcujG3+w78fiAEA2SpTeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466980; c=relaxed/simple;
	bh=5E5KFgzSxL7IRbPKBT7GufV4Bdk10uoomEz2Rqjkt2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BEFUpNW3uK1BFum47fQuzgNSK5DHw3WgFa55k5IjyoscZJ2QPFAdxkoJ8dePmU+nzBq+cEki6BuSNVzjSvGvAMTIL0M3AKcpsdG50i+uC8jeyO5B9i7ulKiYONNx2+Yfuulc+IysVKeNJattvjcn8x4+R1UWcfhEM4WoVV863jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SP1Wp1Ew; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41bab13ca4eso26503575e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714466977; x=1715071777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YfG6me67fWGciPrUzNBL5Z+8bCvXP8QGCYEi7OFKQJ0=;
        b=SP1Wp1Ewda6tCFK8P+DC9fB/u4VFIz/s3AUKFisxLVOxNwrj3fK4cCOOQB5l36UZF/
         uo2ag7fSmbZpYwOw0ao4cJvJccy47+AyymAAuo02ctgA2OYdPFJSZsDSnvIjTVg7Hg19
         NIxC3+S6hbPLI/0uYGMSnsHoMh2swDmfSTa3E1ivdIuXkA50xfSKhTHHo+heV3TkFWTD
         TZRPF8b3EZg/EbBspCKNHpM5X7BnOTkVxW8/JhWfTfhecOGfA6t9DVjgcgUQNpI5yevg
         v1N4NM/CgxhbFjaY4hkjPiaVe98zTGNEMf21J/GYo7O9m+ztEACZTrFcXc51X0+LNSfr
         NrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466977; x=1715071777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfG6me67fWGciPrUzNBL5Z+8bCvXP8QGCYEi7OFKQJ0=;
        b=pXrodItPiytfgd9DJU4dw6QYkSzb1ThWEK9wE0WdpZiCi0Yo2gt9jSs7OcG/XLqXLS
         s5jvksONj/R827GbXwxtbqBO50sK56t7PgBTpgXyWLCkxdLNe68XbekqsAj1kZGr33J7
         +jePsaMno7jk1Q0Id/I2IBJ/NNcBIxKrVvFtLmsCL2AEaySltubYHopNEi6astOpUcnC
         ReWNfGroeQwIRsGEhlK0qQVtMnLMguxK0NGih03zrtzwyvcZ1bFa6U4bGVn1WKB0ZS+Z
         rMWgow+1KygW9/H4khOt2cg9eh+DjV3Fd1nFNRxP+J465O1Wxnt7o8VvGOhByMq8KSc6
         jrDw==
X-Gm-Message-State: AOJu0YyFhOP/o6yiSbJzrEQoScL8R7QzFIBFnjVmoaoEXzVdt+VPLaNv
	pcphul12r+ptyZ2j0uz1UxR57DvKjV6CneFQIvG7pLvpu1T9aZTjedcDETrPMj6Gy5Pd6qkpsg6
	Y
X-Google-Smtp-Source: AGHT+IE7/+BniHYYFqDZ1wJfSjqL1YzM/T1gptkRodVYp4KJgo1WWLXLeu+oWiZYtlPRrxlbJQRixA==
X-Received: by 2002:a05:600c:a01:b0:41b:1149:d8d9 with SMTP id z1-20020a05600c0a0100b0041b1149d8d9mr11056714wmp.41.1714466976759;
        Tue, 30 Apr 2024 01:49:36 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm44490309wmo.36.2024.04.30.01.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:49:36 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/11] nvmem: patches(set 1) for 6.10
Date: Tue, 30 Apr 2024 09:49:10 +0100
Message-Id: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2008; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=WaP13kh78vCnwa/nVKiMFlfKY6JqtTt1j81Q6EY9gc4=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLCIDZY/5LHtelboax8n4iISgvdPdrSJBUm2+ OrTQRZG59aJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwiAAKCRB6of1ZxzRV N/roCACxGGz5LDKtBzG+LZkMgh9gZQcyMib26BZouvSO/gOl1eaQJqAfq469NpEqJBbZnkQVry0 U5GkP0vZPYeDzdOwdj0ta6qf9A9T512n9lUJKzHmS7r9Sr2YMxlC5PBYjW1rrCIwOcqvM4W522X IkdRvqOI4tPKhOYsBevfVIa0noOUjrr+uRbuAcPVAW/Ll9jsnOHLYcATPoLVY6OXAHUPvhAEFzg jwH3KTAs7tLBECFjs/0Sp+8WLc8ZglhhS/XW6VlNLq3MIbVLBWoQECJx3MiK2rybh/5sBAwHnn8 GSsZaUFRW7LnoKW27SGhjF5QsCcrPrbwDc4wlcqZmF7I1KqR
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are few patches in nvmem for 6.10 that includes
- few driver owner related cleanups by Krzysztof
- switch to device_add_groups
- add support for SC8280XP
- few very minor updates. 

Can you please queue them up for 6.10.

Thanks,
Srini


MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

David Collins (1):
  dt-bindings: nvmem: qcom,spmi-sdam: update maintainer

Greg Kroah-Hartman (1):
  nvmem: core: switch to use device_add_groups()

Konrad Dybcio (1):
  dt-bindings: nvmem: Add compatible for SC8280XP

Krzysztof Kozlowski (5):
  nvmem: layouts: store owner from modules with
    nvmem_layout_driver_register()
  nvmem: layouts: onie-tlv: drop driver owner initialization
  nvmem: layouts: sl28vpd: drop driver owner initialization
  nvmem: sc27xx: fix module autoloading
  nvmem: sprd: fix module autoloading

Mukesh Ojha (2):
  dt-bindings: nvmem: Add compatible for sm8450, sm8550 and sm8650
  nvmem: meson-mx-efuse: Remove nvmem_device from efuse struct

Uwe Kleine-König (1):
  nvmem: lpc18xx_eeprom: Convert to platform remove callback returning
    void

 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml    | 4 ++++
 Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml | 2 +-
 drivers/nvmem/core.c                                        | 2 +-
 drivers/nvmem/layouts.c                                     | 6 ++++--
 drivers/nvmem/layouts/onie-tlv.c                            | 1 -
 drivers/nvmem/layouts/sl28vpd.c                             | 1 -
 drivers/nvmem/lpc18xx_eeprom.c                              | 6 ++----
 drivers/nvmem/meson-mx-efuse.c                              | 6 +++---
 drivers/nvmem/sc27xx-efuse.c                                | 1 +
 drivers/nvmem/sprd-efuse.c                                  | 1 +
 include/linux/nvmem-provider.h                              | 5 ++++-
 11 files changed, 21 insertions(+), 14 deletions(-)

-- 
2.25.1


