Return-Path: <linux-kernel+bounces-124493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B17448918DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679871F24C14
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C03313D29C;
	Fri, 29 Mar 2024 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaTT5DZs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAB913CFAE;
	Fri, 29 Mar 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715233; cv=none; b=l3A3FCSSJoBHqZw9N3rk4UJ4+QPFpCNA5rhtr2UFkFRZ6rL1BAYSjIsGL/QWdwOyv7Oyyd7rqP8VgRq9WejTWHJrdfTXUyvNCVgGyo1p8LzMlDeTXJ0uSMB6He5sxoy2MXQoTQ683TqJCI+Hhpq0S0VXC/C5K5IhiOvY6lxQfJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715233; c=relaxed/simple;
	bh=CgloNMT+OHmOkxzDP97vM9hq1ZmZ1DI4SGWhhetlt1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLFOf/wzqHnmvCHXgVLDWSAPsSsR8YQvUl7a/OWsGMg3n37sXowQcW0rTRgmLIL1edSFVAGGAkyMYFPJszj1LjI1SICLtMfw94qiAycLs020e+r2HIrvY27YGCUrdK4A88E+LK9RpZTr7fV7JGeXFcfJhULfBdyvCJkL0rRoTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaTT5DZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEF5C433F1;
	Fri, 29 Mar 2024 12:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715233;
	bh=CgloNMT+OHmOkxzDP97vM9hq1ZmZ1DI4SGWhhetlt1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JaTT5DZsUTRvx7wijqPFC49GvcWHsPHU5y6dXVfWtuoNru1baUP+n0Fq9nmiJ/Ibf
	 hZWyQSWS/VR7q8la12y8PlnkXL8HpI4l9gjZ01vnLVcj/Czf1EhEmORUwfkMriCoZY
	 2kPqbo+7si5KAp0vb2CHI5qMQnze6VM6eF6HsJMJlDz2CkcdMhmlz07nivUmxCMaiz
	 v8Fjl2lM5Vt3VlgYjpzMlc7e6rO1X5GHCO9LGNz1QrY59cRNGl/Fc4g0+P5BfSKUJr
	 Z+k0suGWh9eXF+Rr2T5SiyOiMz7+rSwjlO0vzMvo/TltanI2VLmkmNHldtTD1XFSP+
	 UYXvDjFog/NFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 12/68] wifi: iwlwifi: pcie: Add the PCI device id for new hardware
Date: Fri, 29 Mar 2024 08:25:08 -0400
Message-ID: <20240329122652.3082296-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

[ Upstream commit 6770eee75148ba10c0c051885379714773e00b48 ]

Add the support for a new PCI device id.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240129211905.fde32107e0a3.I597cff4f340e4bed12b7568a0ad504bd4b2c1cf8@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 2c9b98c8184b5..271be64ce19ae 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -502,6 +502,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 
 /* Bz devices */
 	{IWL_PCI_DEVICE(0x2727, PCI_ANY_ID, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0x272D, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA840, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7740, PCI_ANY_ID, iwl_bz_trans_cfg)},
-- 
2.43.0


