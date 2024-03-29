Return-Path: <linux-kernel+bounces-124381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BB989169D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D131F2292C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2997A535D3;
	Fri, 29 Mar 2024 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="QWUo2zVz"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A09535A2
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711707614; cv=none; b=iU7JEz7p7IqfcYQVX4LYE8xun5HvicGxZ+/pkGFvknYJjPpHkTJkhTFcuCcctbw5qWETh07i5jsvB6wRkMOqj5LMWWQ7erVoZFo9qnJ16jlDqcTvDaqfyHvPi7rKcJb1QWhI6hjO7iqY/xzrrSOeLcw+E3CYmkOgGc6eyiiJYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711707614; c=relaxed/simple;
	bh=fuZByx8fzLgKEPKGZasvkuC5RywOXYCpi/Dnn5CXt2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pBg1mQtY+WWisd8ftxnczImvUCF2akkMBfmR7x2MqlH0+d5nKf0blI1UeVKQUAN2dUGLxQ8fkfTU+06uaoLS/bzm0sXUnF3f7OwMKgmA2PQ+QllsVHFceiJjFJRceTQhee/lqmJz8PigRsYX4Ny+w/UszTFLW3bfA1UFLBXduZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=QWUo2zVz; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id pgl8rXEyPs4yTq9LGrTzMH; Fri, 29 Mar 2024 10:20:10 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id q9LDrXL2gybtzq9LEr16u6; Fri, 29 Mar 2024 10:20:09 +0000
X-Authority-Analysis: v=2.4 cv=RsAOLzmK c=1 sm=1 tr=0 ts=660695d9
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=K6JAEmCyrfEA:10 a=oz0wMknONp8A:10 a=vU9dKmh3AAAA:8 a=fbhHIwXGltMNw4B7xfYA:9
 a=kn2rRUdfO8ZCmn3LMDoc:22 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UBMulemZbzLE4JR+qzWiUaTzOCoEImChdUYi/0nrLrA=; b=QWUo2zVzH8RFssCyT7ReqUEgxQ
	Bm1KEbEqkVhPypR7j2sbbgBaQSx9GWYbGENFRB+lPPSaxmpTPpAvV5DlH2d99bZVewKgaaEZyqCuG
	kZn/Yib/ex1ZY4WA9JrGG22vC65YVlYyGzVxJL9jEQ187vAr6AJy56WKkYu7n3aQCN/sjuEIqblTa
	41sUb2GNrZUG9osmiIrLHVfabpTjUuNPnFSowgzGuv8VHksQqe6+BFNc3YYnafAs9LEmYRVsuNIpl
	6x+Dc5vQJmFiQ/vO1iUZuQcc5P7j/7ePhQU4ZscosVzdsKpQProrAOMD+RkJ35eKFC9HR6SJzdUDL
	8dIkwQaQ==;
Received: from [122.165.245.213] (port=37812 helo=localhost.localdomain)
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <karthikeyan@linumiz.com>)
	id 1rq9LC-000Rqk-2q;
	Fri, 29 Mar 2024 15:50:07 +0530
From: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	parthiban@linumiz.com,
	saravanan@linumiz.com,
	Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
Subject: [PATCH] drivers: rtc: rv3028: check and update PORF flag during probe
Date: Fri, 29 Mar 2024 15:49:40 +0530
Message-Id: <20240329101940.1424643-1-karthikeyan@linumiz.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1rq9LC-000Rqk-2q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [122.165.245.213]:37812
X-Source-Auth: karthikeyan@linumiz.com
X-Email-Count: 1
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOVNyxYL5HyytG7WXuqdZ04lA9DfDvMXjemnjkreTU4+jofvfnsayTI5hAopUAVX3ZFWcBys5635luUehCVvPo8B0NykFbmHKLhrpkCr9pKSbiO1+UVa
 3OJqGl8TPLP0BGBZHJrjEVh9+6Z8szsgVbpMnsY9SDPr8bJb8BvvpZWw9a785Lm31PJf4EkBbsozM3tnfPWUMLyxpjohfUct5t2RTqsKx7dobNPogVE+7Gui

PORF flag is set during power reset and voltage drop below Vpor
data in rtc device is no longer valid if PORF flag is set
and software must reset to 0, in order to perform sanity
check on rtc data

Signed-off-by: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
---
 drivers/rtc/rtc-rv3028.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index 2f001c59c61d..e9699ff0c4e8 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -951,6 +951,13 @@ static int rv3028_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	if (status & RV3028_STATUS_PORF) {
+		ret = regmap_update_bits(rv3028->regmap, RV3028_STATUS,
+					 RV3028_STATUS_PORF, 0);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (status & RV3028_STATUS_AF)
 		dev_warn(&client->dev, "An alarm may have been missed.\n");
 
-- 
2.34.1


