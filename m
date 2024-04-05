Return-Path: <linux-kernel+bounces-132574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F8C8996BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210AF285171
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E27613C91E;
	Fri,  5 Apr 2024 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeBA8KKK"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B41312FB0F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302820; cv=none; b=rh6Dbuoo5REN66cnJ8QKUXH422V4/wkOElhx9+UZuHD+JfQs/iTm6ybN/4LLb0fihEu5+shvxVFeLxH7CIIVvP7nrQSZ406ZrREbzOeYLum1XHKPaHiaHXm4sG63EVj/FgDUrrt5zEXCDPcUm/eFU6258DOylzETHOH/rJuINQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302820; c=relaxed/simple;
	bh=YoCK0eHi9vC1QpW8oygU2C2KyLLNC61wcBUkYFvHKuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fh3o0QZxVhdzzHaed7gnVzOb3nqagoXLRm+JMLryD/HCXByKcwV0dSHfKPjqo/Da/Q7VGuaEH0oRonBlJ9Xel9oagXYDV+EaOwQEF9qc0qz5eAdWNvfAIqTUEe5nrzT0bA7eejA3qhdPAuQ35l4lcPFS0e7qxvM/LmG4BNcr4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeBA8KKK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34339f01cd2so1313347f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712302817; x=1712907617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNwZe5BOe/LQIqDd4/80RXtPtgdVPrSCbY1S4wwVTwY=;
        b=BeBA8KKK+hB+Tw7K6TnUgNj+s+MGxDNmBUJCl4GvX4YtAs7pFxG3047fZG/gjBiG2B
         hPLYPa+qg19HJBWTQzBPMJa9Kn/ASLVEo7r02OpyKXc6x/17dJEyB6rc77UV4vHG380j
         yZhoOfAk9kSkLSx7uevLEFt2Cs0oZlYxiQflJYSbKG+oMIzO4jGkQPb4xIQ2DfImmnCe
         MXpc4ALNuKABL7y682A+atzXRPSOrfTyIqhOjMYkAQ0kFnbC4XLam7KXyWIA8FDQrTQw
         EBOhWe33tOKSSMhrPvFXC91pgN6KLb06IhHVplQ6QPFiSwp2QsESY1iV/5sM1fV7eTYh
         7USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712302817; x=1712907617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNwZe5BOe/LQIqDd4/80RXtPtgdVPrSCbY1S4wwVTwY=;
        b=SA02AMuxXdaE0IQTDL2I5o0arJhQXinH4/mEJUkPa+SIY7ozi18MNjBrJU7kqCfcoo
         mICGrnsVe1xndVbZRDLofmNk+tNU7rNmBVJ8j8gK78Ikw8QHUn+HCnFQszLDMSMj5zw2
         HHhG6ET2WrTy/rQ4a8f3JdbzaYaZgrENCuGIUVIVOAzVNqONMhrMX1u5HyRV3RqO0kj4
         RXsxpuOj0kA+f7AUsarMHn5UpqH51gjMwp3IRomqNdy21FyGVUmLnFHjzjmCSKVCg5Vq
         eIU3dV8btRRx2kt4AMJzBZV5sxRGlT2qttqoTm2wt99mTQ7t2BnSfw7/dMInMd2snVo9
         KsYA==
X-Forwarded-Encrypted: i=1; AJvYcCXRJhERQkkScPA3/IWov7d7e6nvD4/I7V3KeGqTJmFUwUIdPLgK2lHrxYdGW6hH9WFQXmXq8Kbm9bSVbp/bgXpPdzVhi6QbJOvI/o75
X-Gm-Message-State: AOJu0YzVaFSdwsLpdI8iKrFeerJ20ayLkt+rxN88isZDOzCk77thRGw/
	tX9HgYMoNMGJstZAh+rAInlCzo7hQaGxWfsaUM8vKzw6lEjwUtkq
X-Google-Smtp-Source: AGHT+IEpHqb45+dVx4WtccQ09P9O9tIKvqgQnzhLdc3gA3jyZ2lskMNvWXD6mN3uquhggb1SLoWfig==
X-Received: by 2002:adf:b1da:0:b0:342:61ee:bee1 with SMTP id r26-20020adfb1da000000b0034261eebee1mr485769wra.23.1712302817549;
        Fri, 05 Apr 2024 00:40:17 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:737b:ef00:2bdf:f41a:ebd1:fb2c])
        by smtp.gmail.com with ESMTPSA id l10-20020adfe58a000000b003434f526cb5sm1311643wrm.95.2024.04.05.00.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:40:17 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] staging: pi433: Add debugfs_remove in case of driver register fails.
Date: Fri,  5 Apr 2024 10:39:59 +0300
Message-Id: <20240405074000.3481217-7-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405074000.3481217-1-ikobh7@gmail.com>
References: <20240405074000.3481217-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

debugfs resources were never cleaned in case of failure to register driver.

Fixes: 4ef027d5a367 ("staging: pi433: add debugfs interface")
Reported-by Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index b01ee145ff3c..77e37a5bd1a2 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1415,6 +1415,7 @@ static int __init pi433_init(void)
 	return 0;
 
 unreg_class_and_remove_dbfs:
+	debugfs_remove(root_dir);
 	class_unregister(&pi433_class);
 unreg_chrdev:
 	unregister_chrdev(MAJOR(pi433_devt), pi433_spi_driver.driver.name);
-- 
2.34.1


