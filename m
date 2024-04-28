Return-Path: <linux-kernel+bounces-161431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D128B4BE7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7DB1F21551
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697FC6CDB1;
	Sun, 28 Apr 2024 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NScmQQYc"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FCF56B67;
	Sun, 28 Apr 2024 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714309671; cv=none; b=bXEkxdJaUjnrlP9qzydwATMQmUdB7r/9uYbjCBXFTHdHOVZlcjaxPuhFnI0deMrb2FQb7WaHmfQUSgyk1uGEojqiQ34o3l1wzO+zSqw5r9mWwg1UOQ7nCGzSjicCDulVOJAo7fvRyjny3f3UiUn1bSwVaH7KQarXRdVotKcsW0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714309671; c=relaxed/simple;
	bh=qJiPzaCHgpBOVM6yCV+xmpVFt9aLiLDftr3YDd+v0ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKnWO8SOCyFIaDtaW6vLT9WgIveR3yPPBsep7PkkLkCNqf333Oq0EhyZShzm2yu+RlEjrAg3DTjd7juN9UgkvM9f4ZqaWxPncyCppmwml3pB6CxhkrJKB26wJf5sc0W+CkUZpRMyOil2S/WJz8NRUWL0GcA6QMRzWOem7Zurei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NScmQQYc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ebso13881815e9.1;
        Sun, 28 Apr 2024 06:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714309668; x=1714914468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E9ZvuRd4f88ObhLFiN+dWlmTukj+GNweC07d13EWQyc=;
        b=NScmQQYcJXOxhtg5+gan/JomJJECcAXuyYKA1ianjRs09sQIxWtoAUwXXUwjZIZncT
         JaFdiqlH9xNrk4c6UvFdwKirgpKRRa345kwIdVY9EaAyiTb4GVsCnMEBfZ4QqvtiLWRW
         sRRC+bRCDHi6DnL6cLXs/gYEgbjAnCYnTDQvCVtlDQzjvcYLkYfF8PjkdNpQjzf1Ziex
         Ie1Pq05V01QLUm5B5w5bfRdBPRXuA789E2pxIbWo3fFI1v8IkwuOfQAPLd5/6TZ95dJq
         9lyDQYqZzptaCg04qGYmnlKmtZbIVnTw39nq7mkhxUsCkFzQiBVAJZ7ZJ975VeVaBh9D
         oYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714309668; x=1714914468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9ZvuRd4f88ObhLFiN+dWlmTukj+GNweC07d13EWQyc=;
        b=UvgmZc+ArJL5spG6IfeAtcPLVWhSUKkyvhBxfBcAhCrmQEK+4QX66RC7JpIcma9nje
         xJIp0y6thUlbQlV4wK8nt6UAFdWyfntvwat6Ksht/k1n9/g8EbPDy+M1UX6iKmDarw3T
         l1UXslZp0rCdwtdGt1/RiRQ+m56VnPLCMxme6LXF460fI910fLLfGJ6GU8N7vEbZNba1
         OKYPblEdkowh6U2stZafA1EP5ZawzDAS+hkE/J7RZ+N2BxgDbH7hxZCUuhgplUpg1C9U
         ZUkfv1p0/vCN1loCnrjPo2WbiG25pY03rU8NSIcWwjxztZGKhLW2Ihl2oFpgxuACm8Fd
         du3g==
X-Forwarded-Encrypted: i=1; AJvYcCUJYM3zgdUwbFRtBcjKr2EELSty3OxLrokNo1zL5TBb7qvHlBYZlymrkqX3BuYOl+jlhPXINFDHo7PEIOh0s5mAbgIzVw/R4+c/hesk
X-Gm-Message-State: AOJu0Yz/xXmU8Nhya0O9+8wKGkdZoymI/7vJYq+ntZ1yGfOFkukBPTg/
	dpMhArHkDtIz8+K3wKMymgbDJkRzLd/78f3/9pqEEW+6dD7Pt/b2
X-Google-Smtp-Source: AGHT+IFl9PLyWAf9UGyn9+0VvGAYZp4lWlEyMOeuf/EUWbihkMw5bmJGK5uVxDjoe8u1aFafeHZ7yQ==
X-Received: by 2002:a05:600c:1d2a:b0:419:f630:57c2 with SMTP id l42-20020a05600c1d2a00b00419f63057c2mr7257986wms.37.1714309668373;
        Sun, 28 Apr 2024 06:07:48 -0700 (PDT)
Received: from fedora.. ([2a01:e0a:a9f:60f0:5d0b:d730:cb58:674c])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b0041b434e5869sm12827996wmq.43.2024.04.28.06.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 06:07:48 -0700 (PDT)
From: Thomas GENTY <tomlohave@gmail.com>
To: hdegoede@redhat.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tomlohave@gmail.com
Subject: [PATCH] bytcr_rt5640 : inverse jack detect for Archos 101 cecium
Date: Sun, 28 Apr 2024 15:07:36 +0200
Message-ID: <20240428130736.877917-1-tomlohave@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When headphones are plugged in, they appear absent; when they are removed,
they appear present.
Add a specific entry in bytcr_rt5640 for this device

Signed-off-by: Thomas GENTY <tomlohave@gmail.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 05f38d1f7d82..12c90cb2a782 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -610,6 +610,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ARCHOS"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ARCHOS 101 CESIUM"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_JD_NOT_INV |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ARCHOS"),
-- 
2.44.0


