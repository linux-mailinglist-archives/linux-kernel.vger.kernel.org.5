Return-Path: <linux-kernel+bounces-67791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3DB8570C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E1B1F22701
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A91419AD;
	Thu, 15 Feb 2024 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrBMMaHN"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADD513DBB3
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037635; cv=none; b=E3KQCar9gJdgy2W2Vt8j/7XXYa46c+PcprstUHFq3YuNBLtCnbsJsb0Q0rHUMevAA4M90rwHvlssigFsQydcRryMVu0X/1kymjx2wQQK+wttN2k/GTn2iMUoeQt8B8KZP6V63wUfsjHJj6xHUYA89HU+rvve6rYQUYWFSsDh8Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037635; c=relaxed/simple;
	bh=XnFYaR+j8cXDRfdSASbIWHQxzHD5XY3BItp+mlM97jE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SBc3t4vxoHeCm1DK5k+p1gS+Gpcr+eyfTm9CxAQ/cdGT8hGHCbQRbFNMvU+Ap6IyELV4MzlVRsOk5XjesUAenGtFPqYBRay+gbqqod5G50pTuSsiedZLLpiifFsg8s/qo+dSx/wmMXiy68BGLQfJZtM+/KTJon6d1ZRHryg3gfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrBMMaHN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so2383982a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708037632; x=1708642432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B8uMPEt1VqqPCM4teLHLJiETOk2ZEgqVh3I3k6LiZj8=;
        b=hrBMMaHNVM2CD5lFrDiTSUsK1KeyTbFnZfuVjDNw6M9p9ufDZaK65iRpIgFCRINNiK
         qjvPkuffoOkBHEsquLGK/YNZSpqz7n8L5F8BDr68Qm/2xlJ5DL2jZjNqaqWjAgtD6W6+
         lf738yqD+oeMrEwNPCBJ/DOFzdrqx2caO4JZ0/yD0dz5IfWd+5NYyA6wRubfjqENhKTh
         aASXlRaVZ5p2rr3/wGZO+mcgL9Lx9jSrTv+gYvN25EF6RFqQJqnprNIz9IgvRfwD/5Al
         y6zH7I+ORvipiYNkF7YEhRLfcTxSw+RECgEf+YzkyogtgP1ICV+zretPPPIqm9qch+JR
         Smjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708037632; x=1708642432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8uMPEt1VqqPCM4teLHLJiETOk2ZEgqVh3I3k6LiZj8=;
        b=praK8HE9Nltr/x7ZOdzPXh4sX1EF9B0JHRxPzIF87Xy6VThK3Np4hfihu1f4VQfMZQ
         TI2Se4rEEkTvyABiqJJqldFHx9XHWM4WRLFZFr9gh0KKycfZfWl9/B93s4hS14te/QDK
         OpnEV37yVJWZ1fVpl2dDuwAn30/qvx7llOOXmOwD2RPkTNSrwkbBo919zi+kR/vYBmEH
         7wnRyP2wRtrxksvHXAmI4k6KaQbXdqzwAPuYGcQQPqnh7R6HsxflSn+JwGw0PDKKYS80
         ZRimxF/BlTCsJ7dOrkQuw62v0BUFnoCQAYkGTI28KakJbWBdAEPj6VXlo2DLAKs2x6D0
         4ZIg==
X-Forwarded-Encrypted: i=1; AJvYcCUqfZxpcJ24zjT/DBWSxoCtLCGqh7pKPP0KmWZr1SnPTGWYwbiYZtEj4riixIR0A+BDP1zTf2vEtiM8RKwahZzDUsIra3w58OD+2NEh
X-Gm-Message-State: AOJu0YyvKXKdaEhsiKjKivQ6X9CORGkE31jr0Ci89J2OfjR6cHyqi9hS
	xHs3mHZRX/i9LejVlLzQZgULjqbkmCsdNXiIs2K0/1QioxjqnhIb
X-Google-Smtp-Source: AGHT+IFlo2ZFjZKkscUV0bL+SgznBaVctw2W1+GyDMpwF9cTad8lPj/HYGbYR4mHHuMLUSHvASiJHw==
X-Received: by 2002:aa7:c149:0:b0:563:d042:4bdf with SMTP id r9-20020aa7c149000000b00563d0424bdfmr1041581edp.0.1708037631968;
        Thu, 15 Feb 2024 14:53:51 -0800 (PST)
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id p3-20020a05640243c300b00563c22abac2sm650782edc.61.2024.02.15.14.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:53:51 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH 3/3] Staging: vc04_services: interface: vchiq_arm: fixed several brace coding style checks/warnings
Date: Thu, 15 Feb 2024 23:53:28 +0100
Message-Id: <20240215225328.11141-1-mo.c.weber@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed code style checks raised by checkpatch

Signed-off-by: Moritz C. Weber <mo.c.weber@gmail.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 6 +++---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c        | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 1579bd4e5..c59bea191 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -432,9 +432,9 @@ free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagel
 				head_bytes = actual;
 
 			memcpy_to_page(pages[0],
-				pagelist->offset,
-				fragments,
-				head_bytes);
+				       pagelist->offset,
+				       fragments,
+				       head_bytes);
 		}
 		if ((actual >= 0) && (head_bytes < actual) &&
 		    (tail_bytes != 0))
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 76c277781..5213f7c55 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -230,6 +230,7 @@ struct vchiq_service *handle_to_service(struct vchiq_instance *instance, unsigne
 
 	return rcu_dereference(instance->state->services[idx]);
 }
+
 struct vchiq_service *
 find_service_by_handle(struct vchiq_instance *instance, unsigned int handle)
 {
@@ -1192,7 +1193,6 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 	header->size = size;
 	header->msgid = msgid;
 
-
 	svc_fourcc = service ? service->base.fourcc
 			     : VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
 
@@ -1618,7 +1618,6 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		break;
 	}
 
-
 	svc_fourcc = service ? service->base.fourcc
 			     : VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
 
@@ -1842,8 +1841,8 @@ parse_rx_slots(struct vchiq_state *state)
 			int rx_index;
 
 			WARN_ON(state->rx_pos & VCHIQ_SLOT_MASK);
-			rx_index = remote->slot_queue[
-				SLOT_QUEUE_INDEX_FROM_POS_MASKED(state->rx_pos)];
+			rx_index =
+				remote->slot_queue[SLOT_QUEUE_INDEX_FROM_POS_MASKED(state->rx_pos)];
 			state->rx_data = (char *)SLOT_DATA_FROM_INDEX(state,
 				rx_index);
 			state->rx_info = SLOT_INFO_FROM_INDEX(state, rx_index);
@@ -2177,6 +2176,7 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 
 	for (i = 0; i < VCHIQ_MAX_SERVICES; i++) {
 		struct vchiq_service_quota *quota = &state->service_quotas[i];
+
 		init_completion(&quota->quota_event);
 	}
 
-- 
2.30.2


