Return-Path: <linux-kernel+bounces-809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238C781468E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE571C2325D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60BF24A0D;
	Fri, 15 Dec 2023 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sn6xdrpr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E5B2421D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c39ef63d9so5613715e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702638946; x=1703243746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gA5g8SlD4Sh4bqizs3nvEqR2SW/1b/NzRVccVFnTPVc=;
        b=sn6xdrprJgv1CFLAMyi6pnkz737b5RpnIzKKFw8YJ2DUPmG/lABea5tVuRRQzlurHM
         7oM3uVDXGlo/uDBwhv1QLEg7wl9n6mPqBSiPuNaStGwsHy08elrnHQEj4MNX58XhZeL9
         hPl+xeDJpIXxtCXVoKCcP+UTfKp87SQQHyQjCC8bt2yPSFsHvkhYpCw76hSEEjXDSUcr
         aX3RLrVRV9Og2HWXV2lGjfLqfL6V88fk0ZKew/hBLmpMjaWQGXpusoopErMKKFBrJmxL
         ScT51sd+GnjxdSMHJqpNpNX+IVwjUU8IwHr2v1umcQPjAJO2/miQ1gsrqiwelmL/H0ws
         VUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638946; x=1703243746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gA5g8SlD4Sh4bqizs3nvEqR2SW/1b/NzRVccVFnTPVc=;
        b=dV1sWBsF8rr9o28kfnivglKNR6fMkvnci2tPIbny1+fWM1le2RyJW0oV0VuVLGYoSI
         iItgZLysl2aHbS+MVINsi31BIbMZpJEpCk+VGqB96aIE+WQShwj2PAE2V6Vskh2yYpid
         mpSTPiRUEeLB8mrCn22ASHvqxKVc8u16zwJxIR1w/saygaYdj1vhGAZVjL2gSgSNY6Y8
         QTbzr1RnWQu9fIx3kyByR9tqodSyg/kr39b8zMSQhyP2PUO6IEs5UzGoSFyApaf08Fbn
         PHUR+MP/bBX2CZAfywWrTHWSBFehsb91or7GQbiId34OwgrfkLiL652KZuaZePKAJF0C
         xA5Q==
X-Gm-Message-State: AOJu0YwDfhQY3plFRmKgXI/WifM8puvXEB4QdsvvrbUYUZ68u5oFfi4l
	0+C288v1Gk5XpoNBIqz6KXcmhQ==
X-Google-Smtp-Source: AGHT+IF6p/ZnjJC2Y37+Q6LcyC+TslmtcGOsKncwARM+77zJTHOSxVEwgXSCwgT1FrLl4BNar0DjLA==
X-Received: by 2002:a05:600c:1f8b:b0:40c:552d:1d5f with SMTP id je11-20020a05600c1f8b00b0040c552d1d5fmr3204334wmb.129.1702638945640;
        Fri, 15 Dec 2023 03:15:45 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g13-20020a056000118d00b003333d46a9e8sm18511497wrx.56.2023.12.15.03.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:15:45 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/10] nvmem: patches for v6.8
Date: Fri, 15 Dec 2023 11:15:26 +0000
Message-Id: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=iLjwbLCDy+wu6Z8ZCctBOo/B1pBtAVF17IHltOGMtgI=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlfDVXXJrBSOCQJuQ1b1pS35of26kHygKzIQxLJ fSPJZBKtIeJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZXw1VwAKCRB6of1ZxzRV NxN4B/9Kx20AHVPGl91PAo8UwxvrkM0wW3W/fvZISK3iCiHUTTHL/YzpF9EMEnz2hThgAqltDyA OBfe3FMfZADXEVHpUZ2eUUJc8zpctO7EO5k+hLtIR+KNuPOGCC7urzJOpsXLK00ijhwlo2JkGQF kg7Ugo6DG0QzLVxpPoLQmTbBegOb5a/e25g02SajrPfM4BAKThfqEY5VLI7Ff9J+2jxMZt+D/Cy zFVhFHN3RHv7BugGelypGTBonzKP1/SQCDk6gHtCy3rAjfWWBfLhxnTZmcZmahsTvofc4Q5iE4N wgqCZ6BD0vHSljM7y9hBPWX7gxA91VJhSFsmEsl/7aeFhzt4
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Here are some nvmem patches for 6.8 that includes

- sysfs support for nvmem cells.
- layout rework.
- add stm32mp25 provider support.

Can you please queue them up for 6.8.

Thanks,
Srini


Miquel Raynal (8):
  of: device: Export of_device_make_bus_id()
  nvmem: Move of_nvmem_layout_get_container() in another header
  nvmem: Create a header for internal sharing
  nvmem: Simplify the ->add_cells() hook
  nvmem: Move and rename ->fixup_cell_info()
  nvmem: core: Rework layouts to become regular devices
  ABI: sysfs-nvmem-cells: Expose cells through sysfs
  nvmem: core: Expose cells through sysfs

Patrick Delaunay (2):
  dt-bindings: nvmem: add new stm32mp25 compatible for stm32-romem
  nvmem: stm32: add support for STM32MP25 BSEC to control OTP data

 Documentation/ABI/testing/sysfs-nvmem-cells   |  21 ++
 .../bindings/nvmem/st,stm32-romem.yaml        |   1 +
 drivers/nvmem/Kconfig                         |   1 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/core.c                          | 335 ++++++++++--------
 drivers/nvmem/imx-ocotp.c                     |  11 +-
 drivers/nvmem/internals.h                     |  59 +++
 drivers/nvmem/layouts.c                       | 201 +++++++++++
 drivers/nvmem/layouts/Kconfig                 |   8 +
 drivers/nvmem/layouts/onie-tlv.c              |  27 +-
 drivers/nvmem/layouts/sl28vpd.c               |  27 +-
 drivers/nvmem/mtk-efuse.c                     |  11 +-
 drivers/nvmem/stm32-romem.c                   |  16 +
 drivers/of/device.c                           |  41 +++
 drivers/of/platform.c                         |  40 ---
 include/linux/nvmem-consumer.h                |   7 -
 include/linux/nvmem-provider.h                |  66 ++--
 include/linux/of_device.h                     |   6 +
 18 files changed, 642 insertions(+), 238 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells
 create mode 100644 drivers/nvmem/internals.h
 create mode 100644 drivers/nvmem/layouts.c

-- 
2.25.1


