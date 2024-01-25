Return-Path: <linux-kernel+bounces-38646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB68983C3A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A998B21877
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6250A69;
	Thu, 25 Jan 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VUWJQLE7"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32211C02;
	Thu, 25 Jan 2024 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189356; cv=none; b=sdkl3WVCcsQr8L8l9xNZNc6j511GRmhKpBt/iQCsezxB6TrsHGKH6XdKgffdPBL5/h/FN7FZwT9ZRrDXl8YkkTa1yXaQaO1n5v3+qPuv0BQVMpZu3M3+e7vS0VMbZPTOgD4F/gYqw+GgcwNHAMxQTyTHiWo7vFFEXpPpeWYIlB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189356; c=relaxed/simple;
	bh=eEaAEbCsUNoUCEW2DoNRhiVeLya79d2tMni5BQvRf3M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R6a6ZTtuyAqwrQslqsT0RC32bka3dIuKsFDOTZ0Pms1AD6aotFpzN3JPd2xo6UUhvRUefPKT1J/RGNgpBj81V5u6ChM6sXNH8lsOsnlYnm6h2leXmleC+Ua1ZVhPDf7CcAWmqZjwwQ4CD0qEW2W0hA7htdzpMZDjjry8HuJyzPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VUWJQLE7; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b49bc87ebb8511ee9e680517dc993faa-20240125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/AWJa3ygkQ0q+CkY7uyIsI0AWxkylCF/UmJXKu8eyf0=;
	b=VUWJQLE7Rjv3Qi7k0RwV7YiX4f2uKlFE/wtAhhRrOaoNfLMxN/sRdQ0CH134Nx5HuDIEeyNZB+OXIWtO5UTEqRWrn8W34prvoAROJprXzmgMeIw1fCNwAjuRZEVCB9KIHZ0rSMtDE2UwERodjKF3Nks1VYWBuezZZaEZKlfwrZM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:7db05860-5f52-4905-bf7e-4404721750da,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6e16cf4,CLOUDID:a481a78e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b49bc87ebb8511ee9e680517dc993faa-20240125
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <nini.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1740393932; Thu, 25 Jan 2024 21:29:03 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 Jan 2024 21:29:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 Jan 2024 21:29:00 +0800
From: <nini.song@mediatek.com>
To: <nini.song@mediatek.com>
CC: <ci.wu@mediatek.com>, <mchehab@kernel.org>, <nicolas@fjasle.eu>,
	<linux-media@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Hans Verkuil
	<hverkuil-cisco@xs4all.nl>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Jani
 Nikula" <jani.nikula@intel.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: cec: core: remove length check of Timer Status
Date: Thu, 25 Jan 2024 21:28:45 +0800
Message-ID: <20240125132850.10430-1-nini.song@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.077400-8.000000
X-TMASE-MatchedRID: J/H5Ci0f1rmmWOD8X0TFhBN+uzH2jcPDUXlp1FHYSPUG2HMvWEJeni2f
	RWXvh9E9TKdCZaWtTIRXTV9N8R+l8aSbvL5QzJ6IEhGH3CRdKUVAxXcQsCnxBd9RlPzeVuQQnbt
	Joik/uhtPwTClfwWa2Xug5fIqIMi34X8HWMSNX7rhG1IOMb7PsA/i8FY2vTOBmyiLZetSf8mfop
	0ytGwvXiq2rl3dzGQ19+9ZqEp9FTjW3puOnxUj54jKqFb5kA20IZC5yr1vP62yI+zZf2L25y7ky
	LWYE0faEsYRGRuZx3n2YxmhsvKIu/0krNbgAQ9znU2qXaDp0DUXRoPmWO3jekxwdkPqCq7vDEyN
	+J8hd+jCS9WgDXVPCp6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.077400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	136E736A2A19E8DE1F1CB962C7FEC4B6141D1A14242E7005AEC56E5E062997692000:8
X-MTK: N

From: "nini.song" <nini.song@mediatek.com>

The valid_la is used to check the length requirements,
including special cases of Timer Status. If the length is
shorter than 5, that means no Duration Available is returned,
the message will be forced to be invalid.

However, the description of Duration Available in the spec
is that this parameter may be returned when these cases, or
that it can be optionally return when these cases. The key
words in the spec description are flexible choices.

Remove the special length check of Timer Status to fit the
spec which is not compulsory about that.

Signed-off-by: Nini Song <nini.song@mediatek.com>
---
 drivers/media/cec/core/cec-adap.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 5741adf09a2e..559a172ebc6c 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -1151,20 +1151,6 @@ void cec_received_msg_ts(struct cec_adapter *adap,
 	if (valid_la && min_len) {
 		/* These messages have special length requirements */
 		switch (cmd) {
-		case CEC_MSG_TIMER_STATUS:
-			if (msg->msg[2] & 0x10) {
-				switch (msg->msg[2] & 0xf) {
-				case CEC_OP_PROG_INFO_NOT_ENOUGH_SPACE:
-				case CEC_OP_PROG_INFO_MIGHT_NOT_BE_ENOUGH_SPACE:
-					if (msg->len < 5)
-						valid_la = false;
-					break;
-				}
-			} else if ((msg->msg[2] & 0xf) == CEC_OP_PROG_ERROR_DUPLICATE) {
-				if (msg->len < 5)
-					valid_la = false;
-			}
-			break;
 		case CEC_MSG_RECORD_ON:
 			switch (msg->msg[2]) {
 			case CEC_OP_RECORD_SRC_OWN:
-- 
2.18.0


