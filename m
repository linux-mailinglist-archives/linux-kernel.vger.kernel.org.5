Return-Path: <linux-kernel+bounces-132981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70D4899CD2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711FF287152
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E231D16D337;
	Fri,  5 Apr 2024 12:23:02 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52C516C859;
	Fri,  5 Apr 2024 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319782; cv=none; b=sJbVE7vylr2YOqHhvFxvy7fBFYcv5+OjRQWHh8LSCLGpBxxvg6UXYKTq7nqXW80PNV/Rxmud9w5S07GYPxFjrqWpKfaE+GJFplHSnrpp6fMgrUSTnTINplLD1QOjPm34+52v6PqDE7FQYGC1OquPT8XFMtoHonUsiq43tXtyhcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319782; c=relaxed/simple;
	bh=UfsEjeHUgOR27rtbE3M4PujzAfOxibpW7ixsPpbhaI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJFdacjCPJTCr+/Tvk1eMdwSj4bY47fZWDBYNfut4fldf5znqy5L9j5oVbmrPvTDnyBB9MMzb6JMpAy4BbnxUSrqEE5FRGgTKsJ2Hg24DdPVh5NymbO23h6aZyIADEViUHGDh8EBgQOrovzmnedhNueHVFf+URW7K8P77N6zmUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a51a20a6041so79093266b.0;
        Fri, 05 Apr 2024 05:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712319779; x=1712924579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uOh18J18K7IiJjOdRTp7+wBD9ghOrm4r66dFYnU+6Y=;
        b=QG2PxBq5WT/EL0JYhscMaHNVD4Uwfmz7/8M4fvKcNvCTTu+2E0lj5QAeUDVk9pabPq
         mm5LjpzEusmbs4/pv7fHVdqgAIdQTwCpIrY5pG6/XuXtWhFvFZ+b32fkOQCpj2ZagDRC
         2QMgspbf0Wow94ZLZU0/JXF88R4vduURtfE2vxrbyOKkHjkjR5h4mBklALSW7SaexYwi
         BuzlboK8xlYocof8ca7Qy2gkPpECCACh42kFGeSins8dZOvQ/kt4xDVs2uaPdN1nwwdx
         SLJ/Iv5bPPU+s/vbn5U1/3EljCV6blLpAUjTtrP10u0GiEWtV6vSdm5wnmp6ecTdXJhu
         cG4w==
X-Forwarded-Encrypted: i=1; AJvYcCXf00yUkV9rUB1wL+mYTXnLlsbijjGCsSm4XNal4rWcs/K/qfLJgTuBxSZe21RUZRS18ytVOv1Cr2PA/A5cNPdAWfMxq9yOhgnMmAFDZFwyB07NsWkLbb6sodP0Cb/YgIGtmOuotWA=
X-Gm-Message-State: AOJu0YzmKuKawXXp5ktEwtPasvJQFAPnqLUiTeHZT6FbD2fCeNZ+gW3u
	YNoOE+vI+HD4tTE/HBpi+/L/4jPlwhD7IxEgo9wyE1A2WQgan2qH
X-Google-Smtp-Source: AGHT+IFdHsxwrbfbqJKvyoc+YkWTyw7/1mQKOsUp9VLVmBgIlDYCc0+Dird1CdX5KOpfcS1gvPdwJQ==
X-Received: by 2002:a17:907:78d7:b0:a47:340b:df71 with SMTP id kv23-20020a17090778d700b00a47340bdf71mr982006ejc.2.1712319778959;
        Fri, 05 Apr 2024 05:22:58 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id z7-20020a17090655c700b00a46d9966ff8sm790247ejp.147.2024.04.05.05.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:22:58 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	ath11k@lists.infradead.org,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	imitsyanko@quantenna.com,
	geomatsi@gmail.com,
	kvalo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/3] wifi: qtnfmac: Use netdev dummy allocator helper
Date: Fri,  5 Apr 2024 05:21:16 -0700
Message-ID: <20240405122123.4156104-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240405122123.4156104-1-leitao@debian.org>
References: <20240405122123.4156104-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a new dummy netdev allocator, use it instead of
alloc_netdev()/init_dummy_netdev combination.

Using alloc_netdev() with init_dummy_netdev might cause some memory
corruption at the driver removal side.

Fixes: 61cdb09ff760 ("wifi: qtnfmac: allocate dummy net_device dynamically")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
index f8f55db2f454..f66eb43094d4 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
@@ -372,8 +372,7 @@ static int qtnf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto error;
 	}
 
-	bus->mux_dev = alloc_netdev(0, "dummy", NET_NAME_UNKNOWN,
-				    init_dummy_netdev);
+	bus->mux_dev = alloc_netdev_dummy(0);
 	if (!bus->mux_dev) {
 		ret = -ENOMEM;
 		goto error;
-- 
2.43.0


