Return-Path: <linux-kernel+bounces-39204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8A683CC74
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5781C22E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BF513DBA3;
	Thu, 25 Jan 2024 19:35:16 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1480E13D50E;
	Thu, 25 Jan 2024 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211315; cv=none; b=fOAqq4IvNpzngOe42XDuC+B6/IgMlu9ixyztJ/SpRBUGzecFUD0AQEoxGJu3Vxy4IQSInK+T86jKrLp34+u3rQiqdqdRAIqvBvoglhQnx4tfHwNB3z0INquJjJlL8ocOB8qvckZ79JyPOPDwKdcADu6Y8O0KI7UC09+h3NoU/sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211315; c=relaxed/simple;
	bh=tb7pG4Gx5MK7Eia1h6jcI1EZZkS8HtHHsCJCPL6OLYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QUhO8oQeDgdvPAaqu5RzgQotuU8EZic188DzZNAHRm1LsjNyMLx9L1/a3KQlz+CyPtJZXr9iaJ3pR5v6BLUhiiO7YqWyMpS0XOFJSWxxG5YV/Nndi+066tfJmk0uaAgsnx8RYOTlJOtdN4x1YBoPaJSZnDPPNnW34kGgvYOMD10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a349cf29cso8345082a12.0;
        Thu, 25 Jan 2024 11:35:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706211312; x=1706816112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGmLc23v1u6+6WjtkvVm9SBv4tuVPEexURNJ93iDXFc=;
        b=ZjOSnylayHbj/yxNV99i7wIrDuPCrx+Y6t6w7gAFWllXv3ASM5QV7gKYs2WRvcAd+C
         s3lllZOQR3UdhDqJUnAC75wtowwCHaQ+uYYKukeERTH8VM2WlNo1mcbFFj/gixrIsQ9Q
         cn1nqv4gyDF7DdR8P7LgdvZ6bi4GGJcH50JA/THcn1QC2cFjd03M2/tBccs/JRAYCe2k
         Iw+u1/LoPF8X/UroyZGMH7+MS+xIcaipa9Qb+TOIelvwNp8WzkFOtNXlw3m2e3rUbTnQ
         k459RIncmjApH+KwWXiqHAyq4OtqlaMA+l+8PTlNOa+sJ55ULsDgo6pOKLzkGigEAgAG
         0PMQ==
X-Gm-Message-State: AOJu0YzcRYjhEjfl/hbQsEefThwV75pIvjVxgSE4Ug7WgHHD7ekZK+Xa
	lypFJk5R+WVEX4pPr4RUuXInaJBHkb+psqxHo3A2lmhce054Q0fv
X-Google-Smtp-Source: AGHT+IFVeeEVktNgBuKVO6oR2u37e9x6gYUsSjUoRk6tgXohRLJgWVCB876mDdz2Gv7bryRvOnrlDw==
X-Received: by 2002:a05:6402:741:b0:559:9da5:19f6 with SMTP id p1-20020a056402074100b005599da519f6mr74694edy.19.1706211312252;
        Thu, 25 Jan 2024 11:35:12 -0800 (PST)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id ef5-20020a05640228c500b00557d839727esm17807123edb.7.2024.01.25.11.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:35:12 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Alex Elder <elder@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-omap@vger.kernel.org (open list:TI ETHERNET SWITCH DRIVER (CPSW))
Subject: [PATCH net 06/10] net: fill in MODULE_DESCRIPTION()s for cpsw-common
Date: Thu, 25 Jan 2024 11:34:16 -0800
Message-Id: <20240125193420.533604-7-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240125193420.533604-1-leitao@debian.org>
References: <20240125193420.533604-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the TI CPSW switch module.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/cpsw-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw-common.c b/drivers/net/ethernet/ti/cpsw-common.c
index 26dc906eae90..57fe936bb177 100644
--- a/drivers/net/ethernet/ti/cpsw-common.c
+++ b/drivers/net/ethernet/ti/cpsw-common.c
@@ -90,4 +90,5 @@ int ti_cm_get_macid(struct device *dev, int slave, u8 *mac_addr)
 }
 EXPORT_SYMBOL_GPL(ti_cm_get_macid);
 
+MODULE_DESCRIPTION("TI CPSW Switch common module");
 MODULE_LICENSE("GPL");
-- 
2.39.3


