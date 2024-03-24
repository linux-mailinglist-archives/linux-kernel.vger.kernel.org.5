Return-Path: <linux-kernel+bounces-114849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69F08891B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A3D2924F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AAD27AF4D;
	Mon, 25 Mar 2024 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQrjZT5V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8642B27BBC6;
	Sun, 24 Mar 2024 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323523; cv=none; b=XMrnjGzGt2I89WX0qtKnvJ+Mj7HLBjebbf2HLqaH259yygmkJ+vXBDJZ/iz49y7TbQqnYCaC31ZUQD4ta0gQq3UbVAFWeTZcxVj0/kjoqm9ucmTjgLMQ7LGpdP3MId6gTFf7I+tb4OZ90g8D0ZYq2RjUw4QmUN6yA+J6xb7O6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323523; c=relaxed/simple;
	bh=WyKhuThbrHQZpL/P0WvBojbfkzb5nPMDLRDieLgx1i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFiUeGlQh8tCzCN0DyW69ghOQkYMOldQgbLm5s9/S9ffBVk/PWnBHRRDz4ZHW/9O+Lc7n8o0Up9t36ZQWslr3+UrR/rEk3Ee01Liuy9h0nzbyFFEc3ntvpljn7XRKD2I4No3cpuv6K/czmp2AOE/AuUEJGqH7dDSsN1Cs7EOg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQrjZT5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA83C433C7;
	Sun, 24 Mar 2024 23:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323521;
	bh=WyKhuThbrHQZpL/P0WvBojbfkzb5nPMDLRDieLgx1i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NQrjZT5VgYLNStFIe0clzgj5Zqu6jTnADOPN35y5dQ5ZaUxK8u2SbLeZQwaP/Hti+
	 kCVR5hLZsrZJcNnRczHyNw/nwZhwTpVnl0grGRQKt0m8YlcSYnggNsifNDg7aBSnK+
	 IRaYNVHmHJJ7Y4I1zv6WkHRoRgeNERPOg7v1h5DUCrdNFzM72pv2G6/Wq6SCkjnHnl
	 SStiUkUdC+f8sHSI/rG/oh7gsgcKm5onvfXWAsMSUhljouKPKFtjOmA8w2c/l0ycL4
	 rrfRJ2+XBwXfQa2gk+zqzned1QB0/ni8wCdKCywgwvcvBPRJ8soKru54LM2ISbVkxv
	 Cep/ePtBzQlfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Akshata MukundShetty <akshata.mukundshetty@amd.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 228/317] HID: amd_sfh: Update HPD sensor structure elements
Date: Sun, 24 Mar 2024 19:33:28 -0400
Message-ID: <20240324233458.1352854-229-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

[ Upstream commit bbf0dec30696638b8bdc28cb2f5bf23f8d760b52 ]

HPD sensor data is not populating properly because of wrong order of HPD
sensor structure elements. So update the order of structure elements to
match the HPD sensor data received from the firmware.

Fixes: 24a31ea94922 ("HID: amd_sfh: Add initial support for HPD sensor")
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
index 2d3203d3daeb3..90f39bfe8050e 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
@@ -119,10 +119,10 @@ enum mem_use_type {
 struct hpd_status {
 	union {
 		struct {
-			u32 human_presence_report : 4;
-			u32 human_presence_actual : 4;
-			u32 probablity		  : 8;
 			u32 object_distance       : 16;
+			u32 probablity		  : 8;
+			u32 human_presence_actual : 4;
+			u32 human_presence_report : 4;
 		} shpd;
 		u32 val;
 	};
-- 
2.43.0


