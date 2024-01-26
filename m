Return-Path: <linux-kernel+bounces-40402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88C483DF9D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD0E1F24837
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8141F604;
	Fri, 26 Jan 2024 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYcGaIIv"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4911EB3D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289352; cv=none; b=mcZbwWYrBVinvLu4V7zhIO7BsYYiUvn80Qq/rBI8F8jlMdkn43kgZo0m1FQBYxIN76mN/P1hyFSGiX5exUUw7d7g0VdnfE1ES3TrHKnKJQLOg4N7vo3qQe+FBSH+v35llDFGUQGHhMuG0uMNeglCajU8ihyDkO/evvcUrJ4mzDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289352; c=relaxed/simple;
	bh=rydS2tXXKitlQ9ghWn8wXSHPCF7jrvQvSqSu0kQ0T3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pxhA82SaiHu3IhmwdhHWjBYXnP6TNoH9FB1p1d3yziD1AwlZI/wVArJv1vMNPvrSekCDL9pbrBEJRw7GRbnZST2b3mvYnjBeK5T6zU5D84HivoPlsLcj5Xm4ZRyZwTsCGrvEfc5cUsAHwpEGF0HyucSvSvQ0HZdbGDWfxZmyerY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wYcGaIIv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40ee705e9e3so7013675e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289349; x=1706894149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hBQadJTQmd+rp5iQVTCEPm0E+5bcMf5aFRFa6IDttrs=;
        b=wYcGaIIvFmyjnSYHxdTH/QCG9gYPfHFIuREZ93By7qny8de7z2A6glFU3V/mT+G247
         VHh1XvUW/ALFxRmWleCS2M54cJNqLZASDZhGqIdJu9rptiEdUCfE6c2vvwpRUHnS3ANZ
         /dxV2VswlW89LBHg4yMyDB6VJ/IYK6IifMu9WUoRDnzEgAcgNhBt/qeQkA7JECy4OE1R
         m9FNkEZiSnjHIU1+FG7bPkvdoKD5MhgG3SMKsqA4IP20fmTqvOTWDmutwUm8W6wT58+z
         PMO7dJSWwpZxd1Y131fnrK/i9Tr8dvdQbfiENBSCHav6P8pCCvf3Vp0Hnq2FnqJM3MF2
         3Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289349; x=1706894149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBQadJTQmd+rp5iQVTCEPm0E+5bcMf5aFRFa6IDttrs=;
        b=MO4aKw2Yrkew94Ei5JxKOFqKDb5/mhq/otzfDgGpCQO6DVmpj6fprWXNLvmRzTk5ji
         n73z4E8FPLaKjYFzCcEL/n25+p2bSHATmB0RUmZdh1U5ISH1oQiyBnouikPcY66KjoSH
         DqLZjzNxocd/0YvixcJjqlB3sYeGiW9Hhk/UY82WBwLdFuOJV3Yeg3NXx7ZbfSbQOU5Y
         W9rOcXk2eXImDELSd8YTk1Fz6+8v7ygqFZBlFqR/YW0L4VfEtNFgRtkx604dsXrZkx1k
         rzb8MoULTuC+km7Tk1q3UbFf4Lwsqgj/nPUxN/1V2dbtdjYaaPF0PIQIFgTlJhtx6qQ6
         ZdlA==
X-Gm-Message-State: AOJu0Yx+CxIL5sNH56drlzyS4Coirlbb80lKuYTtmeSD8m/n7C0B5vl5
	CNquqWy25WXHCYueSIPzin9yb2TPWSdvMRRPWgCOgThS4VwBv9bgiOyqeJZrehs=
X-Google-Smtp-Source: AGHT+IGRkC4wroA/6kPAgQvjykcxN7dPJ1nl0UjHKakeWfw1B7pvhfAxB8IyBSSZAdHdlBym1L3+0Q==
X-Received: by 2002:a05:600c:45c5:b0:40e:e025:8d4e with SMTP id s5-20020a05600c45c500b0040ee0258d4emr91907wmo.27.1706289348701;
        Fri, 26 Jan 2024 09:15:48 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:15:48 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 00/17] spi: s3c64xx: straightforward cleanup
Date: Fri, 26 Jan 2024 17:15:28 +0000
Message-ID: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Straightforward patches that clean the driver. Just compiled tested.

Stands up just the patch that updates the driver to use the bitfield
access macros. The bit operations shall be identical after the patch.
Sam and Andi have some concerns on whether using the bitfield access
macros are just a matter of taste, or they are actually necessary.
I think they are necessary. Here are the concerns/discussions:
https://lore.kernel.org/linux-arm-kernel/ee4107c3-1141-45ab-874c-03474d8ec18d@linaro.org/
https://lore.kernel.org/linux-arm-kernel/ri7gerw4ov4jnmmkhtumhhtgfgxtr6kpsopdxjlx6fylbqznna@3qgvejyhjirw/

Cheers,
ta

v3:
- reworked the bitfied access macros patch so that the bit operations
  are the same as before the patch. Fix S3C64XX_SPI_PSR_MASK value,
  drop S3C64XX_SPI_CS_NSC_CNT_MASK.
- add a new patches to explicitly remove a duplicated definition and to
  drop a superfluous bitwise NOT operation.
- collect R-b tags

v2:
https://lore.kernel.org/linux-arm-kernel/36a664b1-666d-4fc4-90d9-35b42e56973d@linaro.org/

Tudor Ambarus (17):
  spi: s3c64xx: explicitly include <linux/io.h>
  spi: s3c64xx: explicitly include <linux/bits.h>
  spi: s3c64xx: avoid possible negative array index
  spi: s3c64xx: fix typo, s/configuartion/configuration
  spi: s3c64xx: sort headers alphabetically
  spi: s3c64xx: remove unneeded (void *) casts in of_match_table
  spi: s3c64xx: remove else after return
  spi: s3c64xx: move common code outside if else
  spi: s3c64xx: check return code of dmaengine_slave_config()
  spi: s3c64xx: propagate the dma_submit_error() error code
  spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
  spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
  spi: s3c64xx: drop blank line between declarations
  spi: s3c64xx: downgrade dev_warn to dev_dbg for optional dt props
  spi: s3c64xx: remove duplicated definition
  spi: s3c64xx: drop a superfluous bitwise NOT operation
  spi: s3c64xx: use bitfield access macros

 drivers/spi/spi-s3c64xx.c | 298 ++++++++++++++++++++------------------
 1 file changed, 158 insertions(+), 140 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


