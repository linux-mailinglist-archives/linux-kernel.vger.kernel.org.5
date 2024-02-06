Return-Path: <linux-kernel+bounces-54838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A0084B445
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF1E1C23168
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427E8136644;
	Tue,  6 Feb 2024 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gru4W1hU"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B2D132485;
	Tue,  6 Feb 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220254; cv=none; b=UBsEQIaLPT6CQg49wsrUdKEI5W6PxYBFMI1rRggeLrvxUMUDRJHveiqQ/T7qHxx3fRBDPiHaD8PxL7QHsC2/rSn76Vc9DBTQSJ2zu63ANev6gtfrJgC2S+ujXLEh/lln6Si3PnG3CQxC0G2koGnAoKgLuVxiqyaj9t3INKZB3xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220254; c=relaxed/simple;
	bh=MXy0vLxc2auHj0tkkF/yP1Sf/E3BfLaVPsdnJde3zb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qE1XQI9ILadrm//8XzMpyL5RL3H2PRmoOPHHFfQdBIvFrJVwCjMpsuJEpJxomYSR/bwz7WZbYEYOrdsTzN2zUNxr9Nw9kfANFLrJeO2Yh7xtlELCebN5qbiuYQxQ0FdhSeGD96wCw7s4tI+rhxaaF5oE0cARKJIflQR04vuyYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gru4W1hU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fe2d3d5cbso4179285e9.2;
        Tue, 06 Feb 2024 03:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707220251; x=1707825051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYNUifZdSRo+Yp7HFzuhxHtZjGlzamsP7EmAKufyL/M=;
        b=Gru4W1hUDolSgdXYp7Huhx8KaacPr//YpUuNEXbUSs0Nv4IHDN3hu8CH0sl6Wkd8Xe
         xrEHXjnVeNbRHmLSekMS5eycovbpT6lXr9iaY/NVcHK9cCbjgmaqQZfof0VjWaBqPniR
         jDwvIfxI27uF8pjAMBiOXcIK+ygyTKJ1o4KOI+ZMdvykrH/IbpnSi7FfcHiuJq75bcf7
         VRIF/UjFXcH9VwpQAWoLkVEMaRJfupuYsk8lqOqWwuWAawk2gFvPu7pKT1G9dnrupRZ2
         9JSI0Kqd6KXd0jfAIdgwsI2qR+XQ2zHJ5K4EOWcdVc3dso6xudXukZvyoBwLjmmDY6DD
         Skdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707220251; x=1707825051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYNUifZdSRo+Yp7HFzuhxHtZjGlzamsP7EmAKufyL/M=;
        b=E8028nREsVbK3fd/MTkgKfr8M3pGlQVM9gMV9ypn2+YiCEQWQwYtqMmTUmCJwPj/Qu
         pWsI6hrLGUGZKRvsM5ic4bPLcnnKLyGhqF1gzjFnDgStQR98iYepTjW/5+6LTf9uD+c+
         ebo0v8WYJqb0WuNe7zz1iD0QQsgPLv1YmQ9J7XWiJWZG/8x9M9LfVH4YmqGM+VtY7VX+
         Cox62CuycVAf/LU8v370dqT1bETnraVKJyG+3UVP/iqKQuGWw6GWYHymJdqyPBTK1e4L
         eR7b5c7cgr6QuoMEABju9EVeTbnVr1nDUFs7tN3KN3RjPntHN8m2WORiZfTYAaImWRcj
         PpTQ==
X-Gm-Message-State: AOJu0YxB77lk8J3v4uuA4SK1Nu/kw4GJSZfF3UIojEoy8PrtmvUPrM5x
	d/2WK27Y4w3ZS8nJMEx96jXgy+tUPj2Eq6yo6hfdKwwRtyuEqwZM
X-Google-Smtp-Source: AGHT+IGC5esrui+sG2dOYhE7Q/uegfsl5mT6asLY0QjzTpHwtRUJq3JMz9jLVlv3cOi7ZSv12hY1pw==
X-Received: by 2002:a05:600c:1d12:b0:40e:a36e:f0b4 with SMTP id l18-20020a05600c1d1200b0040ea36ef0b4mr1883162wms.6.1707220250869;
        Tue, 06 Feb 2024 03:50:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+lQuXEmJWPrGnLh06RNXzlAqm3JldR7mVVhTibhNS0zVit9eFqgcu/gGGuMIDTxX5GPSoi2vRxt+EsFWzjptK1OWcPSAJBe0wgmjP3Yutig4j6+MCqMsp9FpLE5GD4yRi2gJ45H0jKuwq36dsKO4BPmBqjDEgno937X9bsqXCym+48uqDjkqbI+7cPegU9CjlaOQhvrn/H0sOUWRsrWfAYwjhCGWriYrNAEeDOJFCJGoeJOAV3V6p6z4Hxr76CZNmcBffHdqBlGIgm4A/OzQmWAr3lLB5ZfJ88xVMf8LQSncewG3abUXPSXCH0CSmTXTd0MunxaVYUyaPYNg=
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0040fb44a9288sm1766218wmo.48.2024.02.06.03.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 03:50:50 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Manish Chopra <manishc@marvell.com>,
	Rahul Verma <rahulv@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] netxen_nic: remove redundant assignment to variable capability
Date: Tue,  6 Feb 2024 11:50:49 +0000
Message-Id: <20240206115049.1879389-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable capability is being assigned a value that is never
read and is being re-assigned later. The assignment is redundant and
can be removed. Also remove empty line before assignment to capability.

Cleans up clang scan build warning:
drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1189:2: warning:
Value stored to 'capability' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
index 35ec9aab3dc7..51fa880eaf6c 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
@@ -1186,7 +1186,6 @@ static int
 netxen_p3_has_mn(struct netxen_adapter *adapter)
 {
 	u32 capability, flashed_ver;
-	capability = 0;
 
 	/* NX2031 always had MN */
 	if (NX_IS_REVISION_P2(adapter->ahw.revision_id))
@@ -1197,7 +1196,6 @@ netxen_p3_has_mn(struct netxen_adapter *adapter)
 	flashed_ver = NETXEN_DECODE_VERSION(flashed_ver);
 
 	if (flashed_ver >= NETXEN_VERSION_CODE(4, 0, 220)) {
-
 		capability = NXRD32(adapter, NX_PEG_TUNE_CAPABILITY);
 		if (capability & NX_PEG_TUNE_MN_PRESENT)
 			return 1;
-- 
2.39.2


