Return-Path: <linux-kernel+bounces-154237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79BF8AD9C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229591C2121E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B67158A38;
	Mon, 22 Apr 2024 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKwfGySv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B56158A21;
	Mon, 22 Apr 2024 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830080; cv=none; b=MtL0OASVZ9CtACUGIlojhK4CvUJnu2bNHFq+ia9paCGjJz9/ecwfgx29xBTV/jMdqM7q6T2m9jSXMGlJ+stYk6j1HAkWEdLr1F/clH9PPdKMcgLRnmr/hoBminr4+1KvZN39llKbp5kzFynmNb1ZIttb88LqE/SqBvJjhP3+Owk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830080; c=relaxed/simple;
	bh=OBGzgHbyNRCadm3FlMUZPDHo1xwdodf+7htN+WHMExk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2BL9HDfoCynID3eXzPpVSpgEthAsLXz8O/8qi6iNV84G31kVX2aESD8JGcpTgIuQ6SJvkkrvonbVRFpAWouL9hReN2EF4/tw2EhfF7npH3y3SX1mu8pYI2Nn1WY8d2lrMpdNpIDKqYhS0MvFJs6FrqhTL0+GF3Gf2pQZJ6MZtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKwfGySv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D406C3277B;
	Mon, 22 Apr 2024 23:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830080;
	bh=OBGzgHbyNRCadm3FlMUZPDHo1xwdodf+7htN+WHMExk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKwfGySvcUVQPu+TCuQU/BMKnx6xXFMXG3G659ZSTsTlsBPJDqO05X2e/u1PNrz7R
	 gfyXioj9Gk3R8/rjXrSp8NRPAMsyPYK6PWF9s6qK/J5eMN2fPDwX/6HtSWx39J5Qlv
	 2kKARJWN8Gou/RUDfYgvkfI2RKux7aOpt4YhCLLSJI1NAvZOnAhabeyjdm+Z6Mt9e1
	 qyCy2xURyE+c1VI1cafaKe9EoE8NY60hta2KId1xThVI0HnrIk253sJcdOaM3tnHMp
	 buzs2/UfliXDi/XkCRMD1Jk/txyNT/xU7sR2prAmw833akX+LjXk39quX2u6dzvVel
	 2b3zKsT9uajhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jlee@suse.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 20/43] platform/x86: acer-wmi: Add support for Acer PH18-71
Date: Mon, 22 Apr 2024 19:14:06 -0400
Message-ID: <20240422231521.1592991-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Bernhard Rosenkränzer <bero@baylibre.com>

[ Upstream commit b45d0d01da542be280d935d87b71465028cdcb1f ]

Add Acer Predator PH18-71 to acer_quirks with predator_v4
to support mode button and fan speed sensor.

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240329152800.29393-1-bero@baylibre.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/acer-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index ee2e164f86b9c..38c932df6446a 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -597,6 +597,15 @@ static const struct dmi_system_id acer_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_acer_predator_v4,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Predator PH18-71",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Predator PH18-71"),
+		},
+		.driver_data = &quirk_acer_predator_v4,
+	},
 	{
 		.callback = set_force_caps,
 		.ident = "Acer Aspire Switch 10E SW3-016",
-- 
2.43.0


