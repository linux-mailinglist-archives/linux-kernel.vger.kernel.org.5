Return-Path: <linux-kernel+bounces-131286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A8C8985B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DF01F2956E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE78484FC8;
	Thu,  4 Apr 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jnvfx0Gl"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F2880623;
	Thu,  4 Apr 2024 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228639; cv=none; b=HgeAXjcv17JEvPQj9BHungO3eCHnBGl7Hu8iXfE6l5k9YmH6Qx5ErcbD4Ak5GbSGRcFzPpTzlipm8qEXnHCPJfX+uSt4ouDh6k8aAaYBGP1y3rWkd2XIL+fwRw0xGNH5qhPRYPxnuJNsci8jH7gQMhsMkRmJ7n5uuQNidFtZ6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228639; c=relaxed/simple;
	bh=5FyAg1K4ouJ5EWpDCLIPu6j4EpVqzUbJWImyGChBtls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ubzfCEWo/bmOEV6DrsXFTT5FcHTDY/eQcPFhXf2mzoH2d0vj5ALCV10Xcocyk6VwhYcRUKw4/qqczJ4NgZB4vm3iWM6CKNjQWhjhl4OsNn5Ap05PmmQ6XbgigVe4Ns9jSUFnSAH9ZLsvEGyLxXIuUAgKBV79r9nKq9yTuD2JC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jnvfx0Gl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4348RPhD001360;
	Thu, 4 Apr 2024 07:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=AXkpfDiS2TfBLEGZg8/Z2gQ/Z+9TV6MavTSUnKqZr3s=; b=
	jnvfx0GlhLUZy9wtSa2xfsto3RGR+yBco4SeVVW02oenWqdj2zNz/7LBz8g1JRVE
	w1rKSzigg9VMTIjCt0jzopn9sN4MNE38KzW5S6Iwthd/B5P6iSEFa/coTT/n/P/J
	5z7xtNCmqbEg02+3jLCsjHYlXKEgCBRBVIeJaFRVSgoQRGmaUsIJ6k2q0lKnZzIj
	M+bCBTeGxBA/D5nG56FprSGkKLL8Jn9FBKH9e0xaLRTLhPs+/n54fdMz05RR3lVK
	nuuJUZEtV0p/7acugpioLjhOf/toxPp1qAa595ztqrw84fLyaQs99sNEYOyFzrEs
	nxX9+l7xiSlQ3XVHhTrsVA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3x9eks2kxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 07:03:20 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 434B3IXT018909
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 07:03:18 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 4 Apr 2024
 07:03:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Apr 2024 07:03:17 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 434B2vc9008372;
	Thu, 4 Apr 2024 07:03:14 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 4 Apr 2024 13:06:23 +0200
Subject: [PATCH 1/4] dev_printk: add new dev_errp_probe() helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240404-dev-add_dev_errp_probe-v1-1-d18e3eb7ec3f@analog.com>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
In-Reply-To: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
To: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chris Down
	<chris@chrisdown.name>,
        John Ogness <john.ogness@linutronix.de>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712228790; l=860;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=5FyAg1K4ouJ5EWpDCLIPu6j4EpVqzUbJWImyGChBtls=;
 b=nzl0EQd5yurJfJRqTt/7lXZ9xzem5594ugLbq4+UL7SvtiNuJL+gXpEBfZ+jldHytMxlqdMU6
 Ofy/T44NONMDlG0DZ+yofl7Vinc1V2D9HTUZx1+7JSz7jBizycYI4ma
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: d_L781PnJ8F0700RrXkhJJHehi0_-ALa
X-Proofpoint-ORIG-GUID: d_L781PnJ8F0700RrXkhJJHehi0_-ALa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_07,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=959 clxscore=1011
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404040075

This is similar to dev_err_probe() but for cases where an ERR_PTR() is
to be returned simplifying patterns like:

	dev_err_probe(dev, ret, ...);
	return ERR_PTR(ret)

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 include/linux/dev_printk.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index ae80a303c216..790144f6f99c 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -277,4 +277,9 @@ do {									\
 
 __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
 
+/* Simple helper for dev_err_probe() when ERR_PTR() is to be returned. */
+#define dev_errp_probe(dev, ___err, fmt, ...)	({		\
+	ERR_PTR(dev_err_probe(dev, ___err, fmt, ##__VA_ARGS__));	\
+})
+
 #endif /* _DEVICE_PRINTK_H_ */

-- 
2.44.0


