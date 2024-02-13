Return-Path: <linux-kernel+bounces-64056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A5885397D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD2E1C20E24
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43F2605C6;
	Tue, 13 Feb 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SuF2eLG3"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F1605A3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847696; cv=none; b=ly515qx1TJAWkpv0FYCpbcpegbTQC73gLN2PiQGmERkHkIJ488DOT0HNMMxNGax8pAapnN2JsaRXjHAS2Eux70TQWuiRMRtmJU3/iI72omn/3nNaoNoi+ffZQWGGSpYbhLBSDF7UEGFoG+WR6/pz5+wxTyx8vIH/N8nSAQJHgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847696; c=relaxed/simple;
	bh=qUDpWufqOP0+PWEnGi4jvXwLx/nEOG4F3D3IgB3iO4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lMFzzZAYidB4zSj6iFCgAyebv0RqeUCzHxt8KgZHoykBlnl/LLYcx2wQpCAg249LlWg+2bj7KXwA2CV5uWGFb5pwVQ6MkzKzeGJmewjeXiEZ+aA5sJH96QSrXwVRkdt5tiy4VnESbZ1M35CrFA6fWZZ2N42jBdiZ37xNuPVfqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SuF2eLG3; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-562131bb958so437224a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707847692; x=1708452492; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+WHbON2JSYzrGtsBd+Bvl8eFVRHPgb/kBoMusZieaI=;
        b=SuF2eLG38/F+r9Tr/LjUNQ0auUlOkYvSKGcinnZEtpVXPM4u0m7tnxl8xefYfNA0UQ
         jErGcJF8Vc97lCjJKlOSBVO74eb5MMe/oKdZQFPPGzY8jJcOo/EzIQN23Ucg+TftvgE/
         SB7bea/c0FtiK7sS9WHLUdCui1ZCcivGaC/JhD7IDRbpuZd6ZfmL56YsXI7fH1YaUjGU
         KCzd8/aGwS4siTNYGdVghfqUg2PaMkpGPBIhCJk6gMuQOMMsNmPspzRco61sqRjdOUPY
         6PyZTiWtGVDcCGgDtbWMTWYXrTXndPefn2OX3N8gi1/kva1z8aVgNDI3iRIFKnnWc3BU
         gZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847692; x=1708452492;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+WHbON2JSYzrGtsBd+Bvl8eFVRHPgb/kBoMusZieaI=;
        b=UsWy9BpUq6N0UMvkXwRxruqjoZxVU2GYS9TvWYRvKryONm3NyAMEMps0YmbJQRa8HW
         /9GRN3DQeIEGnPB81GL4DUR1tCQalggtkby8F5OF23jXkuT+O4jXYGEV3TBUuLRwmiRt
         7uB2dhEr5QvoV2j5rTSC5rNlqcGp2cEHlKoUIqo+NHb1EIK183bgRZ9+0qWNVU7m1OJK
         mZ6Nov4d3HKxDnx0cUDPmC1o794Aao00itvcP4g0iLWmcSneyKd2XQ7prt63YNyFpY/3
         rJvZPqxem3Pao1wYEB2YyPvBH3ukgos2xZAX3Wznay/rPBPdQVcv3TbEJzR4pLxajnfe
         J2uw==
X-Forwarded-Encrypted: i=1; AJvYcCXvq/NpDhY/TR6fWsYSYYAw4pyqm/jNC1e9blD0q5e2//94gLqetpZWHkfUJE/w1kKFWeAeP0FdTboqVDXfcQVyOQxxiEoCba0ARe+C
X-Gm-Message-State: AOJu0Yzm5c9WdvCHoqrjFYd3yLs5PKusWRGRnRin88Oj9RyRgwlAJESr
	PV+2Y2FmcVYS2qc2Fdl8sMMD/IuDkeGneySS3QVuu2v6O+LvSi9MK1G/lFXzGFk=
X-Google-Smtp-Source: AGHT+IFWCTr8oDNuetE1UMBMX0h8FuBHaqRwIHB/Dr1kwXZYVGHgvdLsTypTigVsdOewUWEp8b9Gmg==
X-Received: by 2002:aa7:cd72:0:b0:561:f8f0:33ee with SMTP id ca18-20020aa7cd72000000b00561f8f033eemr287257edb.34.1707847692644;
        Tue, 13 Feb 2024 10:08:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvPiSHWgg1v4Pv6U8ngSel5c0LfVZ7RbHdILANjpT0ZIk4xIXGDYxJdONi57F+KKg+mmosjuCfV6tehu+0gkUTjwgJUY7ljO1NX6eOouw5DOlPBaAl2KciPQSgkFQEp7tqsQvy+JPcwTU9oku+uajansVZmswJl3Z8Rsfk3eaEBB7vC+e79t4To+/iT8dE8l1iSxiSFpuSHzfL2xwGlI6BbfB54zJJ1N9uPpwMH69u7EWjKiyY2TmqZD01GsyNcOlhb1az7M8XHgRR82yhQR273Eri3BdHniZu0LKZe+Pm30ZI+Z1eL3N4GnxAHwB+z3S+PTWnwODlLsfsSlmYw4VwDMyPE+je5+V0dD5/qA6RV72IMvs0r3tC2XktCckEU5JMQ98BqkL/E5Omo2QteAABqnjLpHL3PdZNDzyJeBim2D1GlENtlAECL5bTflyzBZsKAx0I1r8I5I+82ezt9TMza+Xnek3IJo7ocrId/Q/QIWuOsmrjKWnmfXh8YBQ+Hg4N9s4dTeZWmJiqtVvXnaQjpsTCA/MFeoTJHWPDueBANtl2yejC1TvoTF7xWqs=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id t22-20020a50d716000000b0055fe55441cbsm4133469edi.40.2024.02.13.10.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:08:12 -0800 (PST)
Date: Tue, 13 Feb 2024 21:08:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peter Wang <peter.wang@mediatek.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Stanley Chu <stanley.chu@mediatek.com>,
	Can Guo <quic_cang@quicinc.com>,
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bean Huo <beanhuo@micron.com>,
	Ziqi Chen <quic_ziqichen@quicinc.com>,
	Adrien Thierry <athierry@redhat.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] scsi: ufs: uninitialized variable in ufshcd_devfreq_target()
Message-ID: <c787d37f-1107-4512-8991-bccf80e74a35@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is one goto where "sched_clk_scaling_suspend_work" is true but
"scale_up" is uninitialized.  It leads to a Smatch uninitialized variable
warning:

drivers/ufs/core/ufshcd.c:1589 ufshcd_devfreq_target() error: uninitialized symbol 'scale_up'.

Fixes: 1d969731b87f ("scsi: ufs: core: Only suspend clock scaling if scaling down")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index d10a77d05d2f..a8a9edb7ba24 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1514,7 +1514,7 @@ static int ufshcd_devfreq_target(struct device *dev,
 	int ret = 0;
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	ktime_t start;
-	bool scale_up, sched_clk_scaling_suspend_work = false;
+	bool scale_up = false, sched_clk_scaling_suspend_work = false;
 	struct list_head *clk_list = &hba->clk_list_head;
 	struct ufs_clk_info *clki;
 	unsigned long irq_flags;
-- 
2.43.0


