Return-Path: <linux-kernel+bounces-124610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0DF891A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8240285D63
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2665115ADA1;
	Fri, 29 Mar 2024 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iImWKph5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5888D15AD87;
	Fri, 29 Mar 2024 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715539; cv=none; b=XjFbN+7pZ47NXDBwzOR/q+2boqecxLL8xiyuCnu+FnKJ4dvrfnmNTT+U20qSeBFp45wY6TL+uCXyVJEIL4qvBO34uBfpJZw8ZdgxRiTkKul5mEcF8f2eI37lXjKBbZ4tjHr+fFGiqvdByVgYMIOKXf9buEu+EsCeJbhVgem2XnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715539; c=relaxed/simple;
	bh=qQebnllPk5LkfOKlhw91bpGz6v4lIiE+uLqg0LZ1brE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwqUjwGtKCs7WFTkTMjdjRhjFdfZVxTQXE8F5UBd8iFl6/vLzlV/E4+i3khVulLuP9iqRm3tGHwBissSpvjQOcNtLS5hPEYFSP7hNYLTmqrAIWu7Osx7NVVQNDx12RsBSksNWjWrT4mn6mh3yIF3MeOvmd6AlRlPL2DoHltkTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iImWKph5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CB7C433F1;
	Fri, 29 Mar 2024 12:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715538;
	bh=qQebnllPk5LkfOKlhw91bpGz6v4lIiE+uLqg0LZ1brE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iImWKph5g2WwH/2Q7x/iIxy1DxRiSE/Jd9AAzH3K4mwlsRmF5uwcIPbzimJ8aJr21
	 SIHMTPGPwv24YC+bj1OaNi3aRrFKsUyUUcL/y+18B0jBIk79UlI+fC5kpkODjSxJ+K
	 Ljsl3C/6ApomF3S4kH5/p11sZEIg2JmG6R25KjXZDwjOGkuEjP3CmUIA5gRo1dD+AC
	 5+YolVq84m7U71edsI02EAJeRCdHcTsGFlQPKbK/5wg/PMKlB0eZxsrYq/tMJkqjoO
	 QEzqTqGJPFL6cNe5sPQh2FsvK+95BdUYrN6WSjihzDNH/M0uyXNeEsV0xR6rZw3kz2
	 bFRL3R48M/4kQ==
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
Subject: [PATCH AUTOSEL 6.1 07/31] wifi: iwlwifi: pcie: Add the PCI device id for new hardware
Date: Fri, 29 Mar 2024 08:31:26 -0400
Message-ID: <20240329123207.3085013-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 4d4db5f6836be..7f30e6add9933 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -505,6 +505,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 
 /* Bz devices */
 	{IWL_PCI_DEVICE(0x2727, PCI_ANY_ID, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0x272D, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA840, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7740, PCI_ANY_ID, iwl_bz_trans_cfg)},
-- 
2.43.0


