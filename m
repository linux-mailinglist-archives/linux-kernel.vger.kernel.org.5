Return-Path: <linux-kernel+bounces-124561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EAF8919F3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547161C25074
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185DD152E10;
	Fri, 29 Mar 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boKF6lnz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4400B152DE6;
	Fri, 29 Mar 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715413; cv=none; b=YFJalUnkAf2fDY0A8daHXFv8/MYlzaidp5Jncp/LYj6Fw0KJkZVNKMT8Iz5OXrv8hmGPI2Qv4COIResSQ315fuiftevtZEI+7O8D83vxzW9sYQumxapSoZGdMgtwez9vRn4/Ym3MR2Ls5DvLWMvpxUeY1fiEMTrHRBswXVZUjyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715413; c=relaxed/simple;
	bh=vCxx4u3g/Ykc1ly+XTNGbwftS0EoDzWDxCDqc2saTCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OI+p57J0zQckpnd6Zh6KysuaO/obU+SDeBEa6ngsvtKe2thUqATY4cTiiKGG4pa2Y8kmvJTgtgndjjxpomjq4sOSVVXmhjcuHktZkcPE7J1cI6/eITuPUKhphJPkOzcZV2BB3TOEaK9bT6xy8Ab+nc18CLPOyuqrLD+cGywhFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boKF6lnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD25C433B1;
	Fri, 29 Mar 2024 12:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715413;
	bh=vCxx4u3g/Ykc1ly+XTNGbwftS0EoDzWDxCDqc2saTCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=boKF6lnzxFhs5rAH2Vk9LNvYxzPhTmwqX0KAnyk1Lnu8N7lHgQbbIvQGMrHTrNoyU
	 nIBn0bPMb4RPMN8IGu/IIqGGC0UWUGIPZhGCRdXjAAPuFrAzdUfJanY3Xsy66dY4lR
	 51tIirlQ+guFQaSD0Ed6ZlXjQnF7gFfgnPZcC9MwDabtvZRlowHRuoTyllTWyRyacJ
	 nzqP8/fghie/sEgvZVIncmPE39IUGfITdMKQ/cfqxCwnwJCmUixps2vxHucDW0bYzI
	 MlSAmCdOk9Z9rmCRFuB8OmjjskVGmLcmAUoGE/Altwvb1QGxgICWWbg179KXdr+eNA
	 ewXVaQU5s3BTg==
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
Subject: [PATCH AUTOSEL 6.6 10/52] wifi: iwlwifi: pcie: Add the PCI device id for new hardware
Date: Fri, 29 Mar 2024 08:28:40 -0400
Message-ID: <20240329122956.3083859-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index bc83d2ba55c67..dea4d6478b4f4 100644
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


