Return-Path: <linux-kernel+bounces-34011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B87D8371E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A937C28B61B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D525F85D;
	Mon, 22 Jan 2024 18:46:38 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7445F578;
	Mon, 22 Jan 2024 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949197; cv=none; b=LaVCqwpFo9i1BGEyg3HzbIRjz3evCJciOk+1q1facAkDN2+P5hyi8M+h4NhrITQk98NESaIk8ULdRhRqjkKl4gmTscYNOMiZqBJtKaizA0eGFO7kiXkB5h2RCM0ftbinkT6EcDeMlX/TvyHSV9essPM8BHFZjJE+vej7RXw+b7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949197; c=relaxed/simple;
	bh=5ioWY6cZMA7SINIP4rC5nvm/iCXXDx+mOGXSFMiYuNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2GcgMXZD5MF2bTcickFMOiIW4j53FqW+MmsLO0/1YZjxwGoUO83PEMXUexFZAE9mPUNL5kXoGhiSmxsGqhQdBrQjhLQ0Y+JKnYR0qcMo5tuNtb/Bq6QBmEdzVu8xqGPtIbW2abE7CceaoibZdLCigek9WvkpW5Erft5m9cpuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50f11e3ba3aso4949185e87.1;
        Mon, 22 Jan 2024 10:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949194; x=1706553994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUjkdIPV4RyRqGQf6e4w7ul6m32fEFyDKsrtQ13Dd7k=;
        b=t+VH5YnYRUArLo+1DuaCbKRFoU5kbpaEp5kQqB/+LYKN+kEYMFqfizUKSsqqJdAaNn
         GpUbXJc1/eFwNxlVFS4rboYiBciBl2G1l9e6rytbnEcNcz/Jy0lsCE7fek5WqlPc9G87
         ANQoyhzubISDy5Beg7QlAcxyQu/J6e5FM7M7hmlFtWlGwtUixxus1tTXCmrSwny/oVI/
         ifd3kJPEULWky8V92m0+J0yXmL3XrWDcfO5nJ8o/N64B0yS6eqcNFZHpMr8IDdtV0Ebr
         QLVNdZjZyAVg+upLNgQbriBIdLkKcxBwY63XFS4XplbjEIuS7ILoy5KHHfc0om0B32hc
         V0sw==
X-Gm-Message-State: AOJu0Yx3mZMA5cv1o3LCyAn3mjHuOm1Dui/NpeCtvPxCrMtB/nW+Qaul
	jzviag5fWDhdHLfBWC2UOABvG4JrfTLaQZjKeD2Rgac4JetaBYQneB/yNiAWtRNJJvg0
X-Google-Smtp-Source: AGHT+IHJlVaR7M7rOyg8N8Ms83J5xrNsTkSCPc++kwM8OdBzzTHdEfe/0uDdMJaN2/pIDHbsZLN2oQ==
X-Received: by 2002:a05:6512:1025:b0:50e:b5fc:bdcc with SMTP id r5-20020a056512102500b0050eb5fcbdccmr2109330lfr.63.1705949194059;
        Mon, 22 Jan 2024 10:46:34 -0800 (PST)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id v1-20020a17090606c100b00a2a04754eb1sm13674761ejb.8.2024.01.22.10.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:33 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org (open list:MARVELL OCTEONTX2 RVU ADMIN FUNCTION DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 12/22] net: fill in MODULE_DESCRIPTION()s for rvu_mbox
Date: Mon, 22 Jan 2024 10:45:33 -0800
Message-Id: <20240122184543.2501493-13-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122184543.2501493-1-leitao@debian.org>
References: <20240122184543.2501493-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Marvel RVU mbox driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index 9690ac01f02c..b92264d0a77e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -413,4 +413,5 @@ const char *otx2_mbox_id2name(u16 id)
 EXPORT_SYMBOL(otx2_mbox_id2name);
 
 MODULE_AUTHOR("Marvell.");
+MODULE_DESCRIPTION("Marvell RVU NIC Mbox helpers");
 MODULE_LICENSE("GPL v2");
-- 
2.39.3


