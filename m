Return-Path: <linux-kernel+bounces-97928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D909A8771C7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F081F21641
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8753444373;
	Sat,  9 Mar 2024 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mLzs/VVe"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92316FF52;
	Sat,  9 Mar 2024 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709996930; cv=none; b=GdYrWXfV/at65dBmcIu0R6cPA6vglihqTi5+0JV9tgOTkCxObhY8rhbJgNOomb+X/HNcdPjFNb0Ce8ecXC4bChB95ptXE9EuuTVe2FHdhph1one7K/eKqWBzMGNrKNWhuL8BrdJmOMb2Q+HhU8D6Weg/C84FsYSMVDcmhxLemcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709996930; c=relaxed/simple;
	bh=31PkfWhO9EwrgdCPyiBVs/k/zyNrhWMw7xvb5zwugio=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iwAo5umT99e4DgzCYDcyGn6zDU+QjvyaDK2CIVW/aO9E6woTBI/vgjAavp/+CEJzcHCKHIbgK3Z2a8K0v3Cj2i2hT6wEiLZQ94DxjyyQv0gV6eOtML3+5bpZhQBv/zcUV/KHkWLSjDxjk7D7+CzIj7NUK9q1gGGfBzbFemUv3lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mLzs/VVe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709996920;
	bh=31PkfWhO9EwrgdCPyiBVs/k/zyNrhWMw7xvb5zwugio=;
	h=From:Subject:Date:To:Cc:From;
	b=mLzs/VVega4YNVv4SENlLM/qRWV2TlJQfuJfBgbqQXk/CjAk/6PXI+tpk2kT9onxv
	 5AkXJ0zWitGaxrV/WLu/RuEDSC8MgoKz3/KUZhnPeU+/D7lBMIJ0p58KrcEYAxeiWZ
	 Pc4q9aUbNgOvGBDfTdBJ8tnG3PxR4zEOzGNgrH2Unu6eCt8HmBu8VqiJPZUnd+o3I4
	 tiS9VxlZ8tTU99HBMlzfUlPAmsITCeGXcM5LNB8MrVkIqSZ0gVR+7Qwz5hVtOlmTNV
	 PkcvvoEcEyvr20P+4dqm/4s8vElq4LGE2DsCN2f8QkAIyIcXisBj3fqO/FPYWH7Oww
	 G2K9BBSAxe2yQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 681503781FE9;
	Sat,  9 Mar 2024 15:08:40 +0000 (UTC)
From: Sebastian Fricke <sebastian.fricke@collabora.com>
Subject: [PATCH 0/3] Mediatek VCODEC documentation improvements
Date: Sat, 09 Mar 2024 16:08:37 +0100
Message-Id: <20240309-mediatek-typos-v1-0-fa4aeb59306c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHV77GUC/zXOWwrCMBCF4a2UeTaYtt7qVkRkMpnaoTQpmSBK6
 d5NBR//Ax+cBZSTsMK1WiDxS1RiKFHvKqABw5ON+NLQ2OZgW9uZib1g5tHkzxzV0OXoz+7UEnY1
 FORQ2biEgYaNKZchC4Y+CY28/+sHRZ04C+mG5sS9vH8vbvd1/QIctFhnlQAAAA==
To: Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, Sebastian Fricke <sebastian.fricke@collabora.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709996919; l=2297;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=31PkfWhO9EwrgdCPyiBVs/k/zyNrhWMw7xvb5zwugio=;
 b=OkOVcTTG2YGevUqfNzU1aWJ7+b+fkcOnRUpoGHmsooG/RmUwQJ0j7hRIrlJucOwy/MB2hN2NWwTx
 rIJv/+QEAXDzDj8eROpxp/B3bfFeLCa3nC+ps2Im7qR8nH9uUT8K
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=

The documentation within the codebase contains multiple issues regarding the
use of the english language, during my recent work on the driver I discovered
some of them and fixed them on the go. The list is by far not comprehensive but
as much as I am willing to do on the run.

To: Tiffany Lin <tiffany.lin@mediatek.com>
To: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
To: Yunfei Dong <yunfei.dong@mediatek.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: kernel@collabora.com
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>

---
Sebastian Fricke (3):
      media: mediatek: vcodec: Fix multiple typos
      media: mediatek: vcodec: Improve wording & fix grammatic issues
      media: mediatek: vcodec: Replace false function description

 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c         |  2 +-
 .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h     |  4 ++--
 .../vcodec/decoder/vdec/vdec_av1_req_lat_if.c        | 20 ++++++++++----------
 .../mediatek/vcodec/decoder/vdec/vdec_h264_if.c      | 12 ++++++------
 .../vcodec/decoder/vdec/vdec_h264_req_common.h       | 10 ++++++----
 .../mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c  | 14 +++++++-------
 .../vcodec/decoder/vdec/vdec_h264_req_multi_if.c     |  6 +++---
 .../vcodec/decoder/vdec/vdec_hevc_req_multi_if.c     |  4 ++--
 .../mediatek/vcodec/decoder/vdec/vdec_vp8_if.c       |  4 ++--
 .../mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c   |  2 +-
 .../mediatek/vcodec/decoder/vdec/vdec_vp9_if.c       |  4 ++--
 .../mediatek/vcodec/decoder/vdec_msg_queue.h         |  4 ++--
 .../platform/mediatek/vcodec/decoder/vdec_vpu_if.h   |  4 ++--
 .../mediatek/vcodec/encoder/mtk_vcodec_enc.c         |  2 +-
 .../platform/mediatek/vcodec/encoder/venc_drv_if.h   |  2 +-
 15 files changed, 48 insertions(+), 46 deletions(-)
---
base-commit: b14257abe7057def6127f6fb2f14f9adc8acabdb
change-id: 20240309-mediatek-typos-c85d7b63ca91

Best regards,
-- 
Sebastian Fricke <sebastian.fricke@collabora.com>

