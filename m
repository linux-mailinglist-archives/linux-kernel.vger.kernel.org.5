Return-Path: <linux-kernel+bounces-605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60352814377
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928DC1C22601
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B6215AC2;
	Fri, 15 Dec 2023 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MxwXPl+P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109C112E72
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c3fe6c1b5so4214595e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702628502; x=1703233302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A+lOs4gkYAACppAY2kdvQATd+r6Z9Q2LiHrQpE+mRls=;
        b=MxwXPl+PJ18Ag0GL/PNbvpL/nrYGm8X/GryjFOaYOpAWDNuU1syVQd0yS6wiuEW9cp
         j0BGwt8Fzo/5fn8u4b5pWPFk04NUIN0QdvXDPUD7MXniz36xHDd5k7zZLNCcLEorxbJQ
         MaoTqHgrrCkA/xfnIXGnM0pAqX5r29zzBt933XX/wMWlmnn2jM1e0M5CoiyV+ubLurR3
         pChuiTGCm0EnUDYOp/kC38iGQuBM/RbATioPWaqK4o2f2ZnTPit3yrw0AayAtLYtoV2n
         150daLuOfaahNmF6/anh+bESEc7GwtxHQj+1Uo5uLi8Q+1Dg5mirpCPf5nQrPMnMe4zf
         gVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702628502; x=1703233302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+lOs4gkYAACppAY2kdvQATd+r6Z9Q2LiHrQpE+mRls=;
        b=ZLjqdmbsYpaYl8gZr9fM04sybjWOfbdtZKBaxJ8fGAJOe8tWWaoxbWPB46s4e0mzC3
         SHPdYtt+wGosNg/9tlEqyykwGXsxC0KO10zxa5DqbQ4s7OcrfqvK/TyhiczT3VF3w7um
         9SLpAlIt4rG3wqfMEFIWqkPa69XrpjbEV/v+zrT9JfBeqdZrS5zA1udRcaRYvgr6XEXg
         w4/Vpwhk+j3wpb6FkUVcz7aZsREUK3OiiV1G+D6pdqIIhkeIJp3bfcF6/iUbpv8+0xQK
         wDAU5wNQbDcP8LnIShYIM8MlW0+1mIzMYpUoQkpKXWyry2wHuMkM1r5zGUSpxNt49nsB
         6TzQ==
X-Gm-Message-State: AOJu0Yz/zsZ2wn9Zoc8cH8+2clpSLjMqkD/aZa+ttZ5eVLei2L7EkUuI
	u/hT1TGZweQT2XQc+7Kzb9bzuRJogY67DaJ1/PtBUg==
X-Google-Smtp-Source: AGHT+IFX1tTpRGCSxp+cq7RlCbaxBlH1syZP3YTzhVKkBaJNlqIxXXiNSxv3v+lxbajKjrAm74XoCA==
X-Received: by 2002:a05:600c:1827:b0:40c:2c9e:fc91 with SMTP id n39-20020a05600c182700b0040c2c9efc91mr5764431wmp.103.1702628502300;
        Fri, 15 Dec 2023 00:21:42 -0800 (PST)
Received: from 1.. ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c1d8100b0040b47c69d08sm30365570wms.18.2023.12.15.00.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:21:41 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: pratyush@kernel.org,
	michael@walle.cc,
	miquel.raynal@bootlin.com
Cc: richard@nod.at,
	jaimeliao@mxic.com.tw,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 0/4] mtd: spi-nor: mark the flash name as obsolete
Date: Fri, 15 Dec 2023 10:21:34 +0200
Message-Id: <20231215082138.16063-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=710; i=tudor.ambarus@linaro.org; h=from:subject; bh=P8W6Kt4BEVUIRZcat7DedtunBYKq3OpRYhBXNL66gWY=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlfAyRLwec4+I7ocGSoj7FDGVlW+e7nQVG1johQ u+xd1JSNDOJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZXwMkQAKCRBLVU9HpY0U 6emLB/9znn5PIDd1X3eRIcBPPTpde5tUMRYEZb1m/91Rpts+Sgh9QkS4YdfSJSEeaVB0YZ27hmY lbP9NHCSPsxvuucds2ZCdLthU7AoI/adjPMSsjTEaoZs+O/z9+AY3SQQWb6HVz+Uec6fYzUUiAS mHbxv5kXcAJEDuawEi5zlFe9eV+bZqdQrEWTvF2fQ+fBdg8cS11zbfg+QeLOgIZrdWHazzsvxph ybp+e69cpjXSuq1cHnF4eaLEhs5UDxTdHu9R1nRiD23cOrWwgenc9JAo3gVhhDF9aHBIp2XAsyQ YD+iTKBZt85ijZA6wiLpf6fPBpo5O1+9KBxRqj97eoywGXEK
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit

The flash name is unreliable as we saw flash ID collisions. Mark the
flash name as obsolete and print the manufacturer and device ID where
name was printed.

JaimeLiao (1):
  mtd: spi-nor: sysfs: hide the flash name if not set

Tudor Ambarus (3):
  mtd: spi-nor: print flash ID instead of name
  mtd: spi-nor: mark the flash name as obsolete
  mtd: spi-nor: drop superfluous debug prints

 .../ABI/testing/sysfs-bus-spi-devices-spi-nor |  3 +++
 drivers/mtd/spi-nor/core.c                    | 22 +++----------------
 drivers/mtd/spi-nor/core.h                    |  2 +-
 drivers/mtd/spi-nor/sysfs.c                   |  2 ++
 4 files changed, 9 insertions(+), 20 deletions(-)

-- 
2.34.1


