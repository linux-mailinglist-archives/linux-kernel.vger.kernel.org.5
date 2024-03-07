Return-Path: <linux-kernel+bounces-95767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2C0875244
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF68D1C2156A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D4312B144;
	Thu,  7 Mar 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SIOLXPmq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30711B94D;
	Thu,  7 Mar 2024 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822998; cv=none; b=OfELjcdkE6G/wBTcZ2PLx8ac/q/qu+YGJZVcP17TaSjvLW4rQS0g5jCUA4IX4oo3rA3+aPuZuoS9+lulKCm2fXCV2J48xPrjiYUCZ/RGun+NER0tznUw65KMyI8IvZf/T4Uu6p+vINKV/47vhglqiBUXVDrv9KH3K47tUR8ej0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822998; c=relaxed/simple;
	bh=m7rJ+0egJzJtARHOsYtJ2DtjkXer4oCX2aD/B5er6ws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gDo+rlk38MB0cm36Um08FxHrkmXaMUqFpeFxHU8C2s1XtPrEh2l9fI89+6TTR4XXeI/eT0TVVU7hbx9rmf7YajBWUhrmCIfJq6MUJF5T2aNl9/5lqZjt9lT5qyAA5+cSRQNGaJUIRK62TvoVRHDgu/PJsPbRbzMRZX1nLtaMq9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SIOLXPmq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709822994;
	bh=m7rJ+0egJzJtARHOsYtJ2DtjkXer4oCX2aD/B5er6ws=;
	h=From:To:Cc:Subject:Date:From;
	b=SIOLXPmqlTB70ND8BsPLGSLGfYA5mqSbmj9DKqb7/LD/nM5YLUUVR3ChCcuYr7Mxt
	 cfN0gc8t2z6aAJihuUIi4pRI82RNIoCGutJJv6rwVJ1IuMJ71ryILSSLi2lbtIh5vr
	 RdmsRCDa6/wbO6fhjctv0VIUE2EBNZjFO3lsBTkDO6QRKdKsWwyDTGvJFOsDYjMdK8
	 iR1MVYmcoNIrx/Jxcjg9MYGrhiPXqN/QxXeQeWrgNEfwjMFBScCwf4LA5t1DbYoot3
	 SY/sPFn+Agnxz3Z4KVI8Bpt1MH0LxqeOAHtUcr0Uty+jhr/YX16vk7LX5OFiqJ2PHD
	 yTAkhiFlrVr2g==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4C5FE37820DA;
	Thu,  7 Mar 2024 14:49:51 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	tianshuliang <tianshuliang@hisilicon.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	kernel-janitors@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc: remove unneeded assignment
Date: Thu,  7 Mar 2024 19:50:13 +0500
Message-Id: <20240307145013.2721326-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The err is being set to 0 and replaced every time after this
assignment. Remove this assignment as it is extraneous.

Fixes: e382ab741252 ("mmc: dw_mmc: add support for hi3798cv200 specific extensions of dw-mshc")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/mmc/host/dw_mmc-hi3798cv200.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index 61923a5183693..6099756e59b3c 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -87,7 +87,6 @@ static int dw_mci_hi3798cv200_execute_tuning(struct dw_mci_slot *slot,
 			goto tuning_out;
 
 		prev_err = err;
-		err = 0;
 	}
 
 tuning_out:
-- 
2.39.2


