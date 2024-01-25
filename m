Return-Path: <linux-kernel+bounces-39198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F374083CC61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD271F27AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C76213666F;
	Thu, 25 Jan 2024 19:34:59 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8491350CA;
	Thu, 25 Jan 2024 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211299; cv=none; b=vA+VxcztDwzDEPRM30RozXLl4gBwRMXH+S6zqThV9mV23N0hd3INeJMxZsWca62GzdwKLghDhmNsDZ9tfYTdHszZhrjiAcRdHZTvjhYyfyTmxsMvdxO0kLZ80BJIqQcoSKa8zX+wabiCG66XGEGc2Osj92YqKsFaEb7U53tnCGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211299; c=relaxed/simple;
	bh=5utNw2RYEYsgkz2vA0EeA60wZxBqgOMXKDswub+R5gU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T5qEAfnyQh4/RBFAdvpOBg8TgRC12ms7/rGLfmP7RIdVvdGKXEdw9PfkMbzeT/wE6iFNBgwx3J0BQHnIMuuBLxnWGiXAvmwL2HVMS/pcWj1I+y97mSLBEPwko1fi5NTr3rCQqB7oovKOTtfoiWrH5IbEyt2MwoDacFo/d7TmlI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a30ed6dbdadso295521166b.1;
        Thu, 25 Jan 2024 11:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706211295; x=1706816095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqFdf8bspE2iTq4jgRiumJZgBb3Hpu0OZ0DjvWP2T2Q=;
        b=J8e2uu02324kJ4JZ332+W03LzYEdMZHKMxl4+fFl5zRN6/lEBQPYuy6m3648IjZkHf
         T5zjafYzPV8BgV2UB9h75s8xuJeXmwjRgsC2kgcCfIrjFLAjE1nWaBV+RPa9vhQv3a6l
         U2hYqVjJMHnYWPxkpfN4+9kvv7FPMZ9lJGPmEaCsU37X0xmKi2SM3NXU438QzKIFylzb
         +C91RKu0dh6EZ9D0tsaN+Vdpvw0AQDHFev9yfRBzkdnr2v+cr6Px4ThyVg8W7iiEtDbb
         lLhYFoMOEaHrB6o7B2mqbCtOme+fUue49Rj409yhsRtDQEyNEILdLkqTdJY3dzPTvTLa
         Ytbw==
X-Gm-Message-State: AOJu0YwWtN81JlksBxsoPaylrloe3iTTOnIa38lnCUTS2VDtsVawgUn/
	mhoyMyANwImD6vP3qsugVJPhLLXsPqzNgG5Qogd2aFvpvzkT78yU
X-Google-Smtp-Source: AGHT+IGMt3s/t1MTKagDBVORYjVaz0hCiMX8dPZYSknICXP6AG023mMwDTc7+0EUlFbiibacgGyNag==
X-Received: by 2002:a17:906:3405:b0:a23:5411:1c59 with SMTP id c5-20020a170906340500b00a2354111c59mr52569ejb.35.1706211295386;
        Thu, 25 Jan 2024 11:34:55 -0800 (PST)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090611cb00b00a3472da6696sm285372eja.159.2024.01.25.11.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:34:55 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 00/10] Fix MODULE_DESCRIPTION() for net (p3)
Date: Thu, 25 Jan 2024 11:34:10 -0800
Message-Id: <20240125193420.533604-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are hundreds of network modules that misses MODULE_DESCRIPTION(),
causing a warning when compiling with W=1. Example:

        WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com90io.o
        WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/arc-rimi.o
        WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com20020.o

This part3 of the patchset focus on the missing ethernet drivers, which
is now warning free. This also fixes net/pcs and ieee802154.

Breno Leitao (10):
  net: fill in MODULE_DESCRIPTION()s for encx24j600
  net: fill in MODULE_DESCRIPTION()s for ocelot
  net: fill in MODULE_DESCRIPTION()s for SMSC drivers
  net: fill in MODULE_DESCRIPTION()s for Qualcom drivers
  net: fill in MODULE_DESCRIPTION()s for dwmac-socfpga
  net: fill in MODULE_DESCRIPTION()s for cpsw-common
  net: fill in MODULE_DESCRIPTION()s for ec_bhf
  net: fill in MODULE_DESCRIPTION()s for PCS drivers
  net: fill in MODULE_DESCRIPTION()s for ieee802154
  net: fill in MODULE_DESCRIPTION()s for arcnet

 drivers/net/arcnet/arcnet.c                         | 1 +
 drivers/net/ethernet/ec_bhf.c                       | 1 +
 drivers/net/ethernet/microchip/encx24j600-regmap.c  | 1 +
 drivers/net/ethernet/mscc/ocelot.c                  | 1 +
 drivers/net/ethernet/qualcomm/emac/emac.c           | 1 +
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c  | 1 +
 drivers/net/ethernet/smsc/smc91x.c                  | 1 +
 drivers/net/ethernet/smsc/smsc911x.c                | 1 +
 drivers/net/ethernet/smsc/smsc9420.c                | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 1 +
 drivers/net/ethernet/ti/cpsw-common.c               | 1 +
 drivers/net/pcs/pcs-lynx.c                          | 1 +
 drivers/net/pcs/pcs-mtk-lynxi.c                     | 1 +
 drivers/net/pcs/pcs-xpcs.c                          | 1 +
 net/ieee802154/6lowpan/core.c                       | 1 +
 net/ieee802154/socket.c                             | 1 +
 16 files changed, 16 insertions(+)

-- 
2.39.3


