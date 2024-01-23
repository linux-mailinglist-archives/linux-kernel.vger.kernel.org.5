Return-Path: <linux-kernel+bounces-34789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74670838779
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB50B249A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B459B54;
	Tue, 23 Jan 2024 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR7cpByZ"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D559154;
	Tue, 23 Jan 2024 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991385; cv=none; b=UeZJ9ONuRUiWGMXYcEL/VqEFpvcMAodYUyOsjiGnZ0lD7H1LqD1fMAz9K+wR2BC2hgFDdSLvEDSxyrOOnAqFZTdjafc9WP3IEBfYYp7U1tXEkINtnMe/5HE53wryp9o55HWN8mgVrK+YZJKZjTPfMuMYi3olXTzJc/K0w7LVv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991385; c=relaxed/simple;
	bh=IiUyY278CqVxfhgKrqP9nTOWuIkaA6ZM+n4Y0G/wGAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YZ+tawNg+uLBvyU9OtTCitCrx6Tl0Ybn5TEEw/HwvLHeEdKpirtKMfbJuHvcYjQbKMzoQiv3V7fJI1W2H7C23FDHBfypzmJJbWk9ebkFos+bCWvMI3MJOOWJNBlLy9OWOxE2ZguPueJeIWNk8QLNbvLlBLoac0KX35ggqJiIbhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR7cpByZ; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59502aa878aso1771772eaf.1;
        Mon, 22 Jan 2024 22:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705991383; x=1706596183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfmMQ6q+Rk7UQCSUv/GdFILmuXL5VoDA33Tjpgxnrs0=;
        b=CR7cpByZ99k5pjRO9CarcL4cC8YLurUvPKp1byy1poviOIPghKcuu+2gyXdxJTFLg9
         BBuRQwyPHoeiZFs7GPtK0lUnRlsmuvdq/0a56zJGt3brIJTX6oM8v4L/t9rhIR+Xv26s
         iWWJasRw7ZJK0KQVOXgBFPDEWLBs+WO1+TOKoJ8PCJH1gP+4OcbssZIn3o/um3mECEuq
         NImjx9ppJ7c3pDLZM6x/vdJNmKvBdCYKQPi+XCOg4ndzPWYOE+luU3aXoKfo0rgoyROq
         9PRS9YttOyf5MHDS2JywH/Cf2ZunNHo3kKu95ct+eSUSL/gvg3/oRC/+FPCgvlSCAn7y
         Ie3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705991383; x=1706596183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfmMQ6q+Rk7UQCSUv/GdFILmuXL5VoDA33Tjpgxnrs0=;
        b=oufdt2HY4G3uEnIYmqwqkFiURplb9+OgwVCc+OzjnABhV1VBb1xYTZMldXBlK1gR88
         l3WDhugPBpWVlfczJjG4pdMgwevphjD/T6fl+c36eP3W2SveGjVvLtpbmtxUPRGRDv9R
         bWlSVCtipK6oP9wxYAaHOKm8g2aEEccQ1ocoVMWhu7DvCg2hDBnACpio5w4SgSdv9f6C
         EEPYf0uequ5H0UBO2ISZWe+LeuFD2CKIfujuVPR10+pefgBEFPe9LGyR4ru1bDlK4Rbd
         vLxa4czHmhSYWNRVfwBl48tVywzZAK+sx2OT9/6C5IlQ2YSK8yKsCoGw0NJ5l6X9WCna
         fV+Q==
X-Gm-Message-State: AOJu0Yz+w4ddfpfPmOdH/2UEeFB6l8C6UOSkfABO8V6IUWaxcHb7rEM4
	CgPH66O6fTlnZryiRUnp0k4+vTP5lo5xQctkfIhFGwlREC1PxynM
X-Google-Smtp-Source: AGHT+IESfDqjTxbklBtj2YiYH1ivBt1xUOm/kWAkRtJkgQMD2V6EPmYEgYPGbXCM1XSTBW+VuzNV3w==
X-Received: by 2002:a05:6358:d59b:b0:176:2d73:64c2 with SMTP id ms27-20020a056358d59b00b001762d7364c2mr3479548rwb.16.1705991383314;
        Mon, 22 Jan 2024 22:29:43 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2ac-a4c6-7d2b-d8b3-ed27-1f50.emome-ip6.hinet.net. [2001:b400:e2ac:a4c6:7d2b:d8b3:ed27:1f50])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b006d9b2694b0csm10595188pfu.200.2024.01.22.22.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:29:43 -0800 (PST)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V14 19/21] mmc: sdhci-uhs2: add pre-detect_init hook
Date: Tue, 23 Jan 2024 14:28:25 +0800
Message-Id: <20240123062827.8525-20-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123062827.8525-1-victorshihgli@gmail.com>
References: <20240123062827.8525-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 9f82dda93733..872ce3b767bf 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -399,6 +399,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("Begin do uhs2 detect init.\n");
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
 		return -EIO;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 1085942d47a9..fb10a26dc251 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -724,6 +724,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1


