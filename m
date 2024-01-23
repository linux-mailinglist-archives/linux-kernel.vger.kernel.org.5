Return-Path: <linux-kernel+bounces-35955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCDB83992C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DC78B2CB13
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB74582D70;
	Tue, 23 Jan 2024 19:03:53 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C167E823AC;
	Tue, 23 Jan 2024 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036633; cv=none; b=jJVI9HxeOafSzFs5Uyb0sVsgAy1P+/TllYTvkFAWo1hayXrrWZI/UZilkpMbRilBRvWB0Ke9os51JR+GoKVjDJWPOTdtRHAtPt7qKWRzmI+tTl3VqhCmiBdRAQbHZVO1ySiazNPn49IqzjIs2S3YqJ9x/ClB7vNMzoymmbnrslw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036633; c=relaxed/simple;
	bh=We19aMhbuWFsJ/v3vK0iNouYJaFw2e3+AUW20mweEw0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HQUl0oW2g2N7+GhCpDXvd0e9BkrkkzhvN7VMp1RZ+XNy8unHR3Bkv1reo9tmtG6gfd/xHBppjbOd921yHv7khamFpjK2IH95I6DsuanxRnyrmWa7Knq79Bju6UoH95YR6ea7Yg485t+3xH7lxGXK/CgUvQJ5CfoputFP2nNYuUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a271a28aeb4so502193966b.2;
        Tue, 23 Jan 2024 11:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036630; x=1706641430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkLWkJq+0orHwi6nAn/z0/+dex0RNyYzqHn1OEoQDF8=;
        b=Yj9zvKBmVg2uAqEuUZu6TLH9Wom0ZRZkDPNM1Db3Toj+CRBbcPJ+Kxl6urhOgtBrfc
         igw9/Ww6WAG5MPHocoFRNjuaV27IXnYO4/SJ4xwmar/v4OYMnblu9geUx3btNZehwirk
         h6UEfVOwCf1gC9Y122YRiFb/bC5EbAYOylGFYQcj7l+vzoDbeE4mUHvjksIa4NZj9/fM
         j5RUDLQ6grJnJxtO72UzBfuF2a3SoxtZRvAShe8DjBHZpbDILaERe5uDHBZdZtghZJS+
         jMUcXwy7Z3vtwjcUNbboq88kzxYBt4msWMNFFOVkHDlvjAO3kGBvn+uMJvHcLP+PoBqJ
         qhOQ==
X-Gm-Message-State: AOJu0Yw23FFOk4rkaIN3W682Nyqq2FqfwGP8ecBcuA5yrkNq8y3P0uo1
	kOcFwjDiNUfVH5XvuXOSyj2Buih9FDwPwZpegKH26tvVFjmT3khoK6z3+5iPQKU=
X-Google-Smtp-Source: AGHT+IGDnDyQ5G4JtH1fiUeVNpZ5QlAO0wOxRl79/NJ9DKPEhvzcTj4XgZ/62uiUA1iDq7HRdaHFaw==
X-Received: by 2002:a17:906:846a:b0:a30:bdd4:ecfd with SMTP id hx10-20020a170906846a00b00a30bdd4ecfdmr170350ejc.37.1706036629641;
        Tue, 23 Jan 2024 11:03:49 -0800 (PST)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id s1-20020a1709060d6100b00a2684d2e684sm14699524ejh.92.2024.01.23.11.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:03:49 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 00/10] Fix MODULE_DESCRIPTION() for net (p2)
Date: Tue, 23 Jan 2024 11:03:21 -0800
Message-Id: <20240123190332.677489-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are hundreds of network modules that misses MODULE_DESCRIPTION(),
causing a warnning when compiling with W=1. Example:

        WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com90io.o
        WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/arc-rimi.o
        WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com20020.o

This part2 of the patchset focus on the drivers/net/ethernet drivers.
There are still some missing warnings in drivers/net/ethernet that will
be fixed in an upcoming patchset.

Changelog:
---------
V1:
  * https://lore.kernel.org/all/20240122184543.2501493-2-leitao@debian.org/

V2:
  * Limit the patchset to 10 patches.
  * Rewrite the following module description:
	* fec
	* bgmac
  * Added acknowledge in the following driver:
	* litex

Breno Leitao (10):
  net: fill in MODULE_DESCRIPTION()s for 8390
  net: fill in MODULE_DESCRIPTION()s for Broadcom bgmac
  net: fill in MODULE_DESCRIPTION()s for liquidio
  net: fill in MODULE_DESCRIPTION()s for ep93xxx_eth
  net: fill in MODULE_DESCRIPTION()s for nps_enet
  net: fill in MODULE_DESCRIPTION()s for enetc
  net: fill in MODULE_DESCRIPTION()s for fec
  net: fill in MODULE_DESCRIPTION()s for fsl_pq_mdio
  net: fill in MODULE_DESCRIPTION()s for litex
  net: fill in MODULE_DESCRIPTION()s for rvu_mbox

 drivers/net/ethernet/8390/8390.c                 | 1 +
 drivers/net/ethernet/8390/8390p.c                | 1 +
 drivers/net/ethernet/8390/apne.c                 | 1 +
 drivers/net/ethernet/8390/hydra.c                | 1 +
 drivers/net/ethernet/8390/stnic.c                | 1 +
 drivers/net/ethernet/8390/zorro8390.c            | 1 +
 drivers/net/ethernet/broadcom/bcm4908_enet.c     | 1 +
 drivers/net/ethernet/broadcom/bgmac-bcma-mdio.c  | 1 +
 drivers/net/ethernet/broadcom/bgmac-bcma.c       | 1 +
 drivers/net/ethernet/broadcom/bgmac-platform.c   | 1 +
 drivers/net/ethernet/broadcom/bgmac.c            | 1 +
 drivers/net/ethernet/cavium/liquidio/lio_core.c  | 1 +
 drivers/net/ethernet/cirrus/ep93xx_eth.c         | 1 +
 drivers/net/ethernet/ezchip/nps_enet.c           | 1 +
 drivers/net/ethernet/freescale/enetc/enetc.c     | 1 +
 drivers/net/ethernet/freescale/fec_main.c        | 1 +
 drivers/net/ethernet/freescale/fsl_pq_mdio.c     | 1 +
 drivers/net/ethernet/litex/litex_liteeth.c       | 1 +
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c | 1 +
 19 files changed, 19 insertions(+)

-- 
2.39.3


