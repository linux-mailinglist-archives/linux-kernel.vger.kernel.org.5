Return-Path: <linux-kernel+bounces-31735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E11CB83331C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 08:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9FE1C22069
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A589523D1;
	Sat, 20 Jan 2024 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmBIDEJN"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4B1FD8;
	Sat, 20 Jan 2024 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705735726; cv=none; b=NyV8xBvqlfKhA9YpoaC5KsaMsbc4WJzHSrF4ogJhMR9+ZaWtlp8QYLVDLlwr3gnffSuPWOl2IXJY3kQL7YgiLwo/VUWJyEj36bgcZ2NhUWSBj8erhdvaHMiRnEKfC9MfnfMoZ0E+riyKWEQ9hblsYuq305EoJ7dnkbe0L0Nydm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705735726; c=relaxed/simple;
	bh=kK0kpMYOxiXwLFnjo4FjmVUfSst12YqHg95SBLX5nzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ahiMM1S5JzHvfz+cAL7YcOzUZ4H2/esxFxbC0TBh8T/bzjNvAl2izW+Ua2CQ/+eN3+0/iFU1CU1Qaq3MUijPFiPrprqbfdkvkH4RlWYy3Q8ndi6CbRRp16HWHbqRr+jGuQEBNeroJM311E45G7vqOlUyQ0i8fsXbFeaG7wL7p4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmBIDEJN; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3608cfa5ce6so5551055ab.0;
        Fri, 19 Jan 2024 23:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705735724; x=1706340524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=op8+puFUBQ0HGhLoj/M968f0BhKOR1Shj+6HmxTCqzA=;
        b=KmBIDEJNh5R53SUpmcioVHZ/Xf0vXxry8p2YWbvdRiYb7N/gse6/9nGQL6CdRULGWp
         gFOGwG92TssGymKNSyDW260EZuFbSb3bALiDHz4JzGd90BTA+DreqByZEK4kCy4r7Jy3
         x2tLwMnLQrW3Vzi+y4OlaeuPtN2kmNRIBMPLTV6zkIMNSIVVUwUQAgHwBWcnky8LNXKw
         OwzpJJkMZKO/9DxMLUrCmKKmRMo74MCUIRpb5pIeknbEkkETk+6RegB2+IYxh+SPWtxz
         PBiK3Mr/c1tSGHDhY3wf7d3Crh+1GnclkqsJYXQvFx6+aMoNthSzFEJsY+LLuoD9808a
         WiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705735724; x=1706340524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=op8+puFUBQ0HGhLoj/M968f0BhKOR1Shj+6HmxTCqzA=;
        b=KTDyD1oYznksBf3nrMORi14fVvgxeeGlR345rhxT6EHW4spvRV4lJ3PjRlIX/ReoEI
         X6lFXE3m7ZXZCmjFhzXSMpiuCmAJp4+cWVaqBptmi+tZuMzvdJfNU/mTt8f3ZflSGv1g
         PrTUJRle+HKkfutqDXLWIKEkw24Fjh13tm5lc3QGhO0wG8QhQ5C7x/rAHN84LxQM9yY9
         INY9OGc/R20PLKtFDWF4SVjdq3X3B8bbHC7F9KTc/kXloA/DwAwkS7/r2bt6tbHqEQ9o
         xPMyTWfUXFKoseMIsrr0Yk2OHyFIA7J/6y0GCl8kyHFLASzzyWBsUA0sHaA5rp/NKeu2
         cSog==
X-Gm-Message-State: AOJu0YynN5i4SHcZ/fwm4PMb5y/JM6LctOEOmgF/d4ZwR0Gj5ks+ePwa
	571adhBcajjjGHTz9jjbrKHWjhVZ03JZdcZv/VmRlUrT1hlIUqGw
X-Google-Smtp-Source: AGHT+IFCRPs1/tBVCZVWysUDtfO6FYq2BkYpRS7ZbSw9HL6hXinF0O1vRTzqZ9rM73oHYIUU5tKG1Q==
X-Received: by 2002:a92:d9c3:0:b0:361:ac32:5c7f with SMTP id n3-20020a92d9c3000000b00361ac325c7fmr1216491ilq.36.1705735723818;
        Fri, 19 Jan 2024 23:28:43 -0800 (PST)
Received: from fedora.. ([2402:e280:3e0d:606:d0c9:2a06:9cc6:18a3])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902ea0b00b001d50766546dsm4017809plg.184.2024.01.19.23.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 23:28:43 -0800 (PST)
From: Suresh Kumar <suresh2514@gmail.com>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Suresh Kumar <suresh2514@gmail.com>
Subject: [PATCH iwl v2] i40e: print correct hw max rss count in kernel ring buffer
Date: Sat, 20 Jan 2024 12:58:06 +0530
Message-ID: <20240120072806.8554-1-suresh2514@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pf->rss_size_max is hardcoded and always prints max rss count as 64.

Eg:
  kernel: i40e 0000:af:00.1: User requested queue count/HW max RSS count:  104/64

whereas  ethtool reports the correct value from "vsi->num_queue_pairs"

Channel parameters for eno33:
Pre-set maximums:
RX:     n/a
TX:     n/a
Other:      1
Combined:   104
Current hardware settings:
RX:     n/a
TX:     n/a
Other:      1
Combined:   104  <-------

and is misleading.

Change it to vsi->num_queue_pairs

Signed-off-by: Suresh Kumar <suresh2514@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d5519af34657..f5c1ec190f7e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12524,7 +12524,7 @@ int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count)
 		i40e_pf_config_rss(pf);
 	}
 	dev_info(&pf->pdev->dev, "User requested queue count/HW max RSS count:  %d/%d\n",
-		 vsi->req_queue_pairs, pf->rss_size_max);
+		 vsi->req_queue_pairs, vsi->num_queue_pairs);
 	return pf->alloc_rss_size;
 }
 
-- 
2.43.0


