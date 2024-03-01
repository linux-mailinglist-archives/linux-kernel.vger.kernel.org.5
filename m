Return-Path: <linux-kernel+bounces-89238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B27A86ED1B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A33282686
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB105F47C;
	Fri,  1 Mar 2024 23:57:42 +0000 (UTC)
Received: from regular1-05.263.net (regular1-05.263.net [211.150.70.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E45525610;
	Fri,  1 Mar 2024 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.150.70.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709337461; cv=none; b=eQufeh2ba2nyJoRm7g4TgPqmQDTw408rcF8GhGYvk6WiI5fnMYSqNnUVhDgXyhaaIn1ZYWSkapdC43txs6+QWdFTUS92bYHs1FawPwa4knwsH2fybq4wQ3BICvWMp33UUHMMT2qENuz6GvPKlCJ2tYCzKZu7udbl5scbKdrXIgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709337461; c=relaxed/simple;
	bh=k2o/QV8UyXt9oT7L/NC/Nc82MzIZe4ycxiieEa2xQI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbtFw8Y7JB1Ornw3GpbHtCsTNulmYVODT5qyexNmPcJahL/OFcaOE8tO86gJkqKuTPrPxBI6fVums09kFeuVORWYwiDmqhKkL/Z8qFC9a3VzxgJMKYYdkeFydRsFcCgGOaCG0uPv19Ql0mwj7RwrYDb0blHYqxr3sV3qDmMfspI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techyauld.com; spf=pass smtp.mailfrom=techyauld.com; arc=none smtp.client-ip=211.150.70.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techyauld.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techyauld.com
Received: from localhost (unknown [192.168.167.70])
	by regular1-05.263.net (Postfix) with ESMTP id 0F04C155B;
	Sat,  2 Mar 2024 07:57:29 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-ADDR-CHECKED4:1
X-SKE-CHECKED:1
X-ABS-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from localhost (unknown [118.193.106.122])
	by smtp.263.net (postfix) whith ESMTP id P32683T140305418225408S1709337448143058_;
	Sat, 02 Mar 2024 07:57:28 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:yzheng@techyauld.com
X-SENDER:yzheng@techyauld.com
X-LOGIN-NAME:yzheng@techyauld.com
X-FST-TO:rogerq@kernel.org
X-RCPT-COUNT:7
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:118.193.106.122
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<307a65f41081e22e4aab4ed94088de0f>
X-System-Flag:0
Date: Sat, 2 Mar 2024 07:57:27 +0800
From: Brock Zheng <yzheng@techyauld.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>, 
	Tony Lindgren <tony@atomide.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory/omap-gpmc: fixup wrongly hierarchy of the
 sub-devices
Message-ID: <laqqencookmgwesfaetd5xw5wfmjdffmjvyjitapfehmu7zy5y@k7gsdexf3jcv>
References: <6fftq2zlkpaf7xptyff6ky63cinr76ziyvdbm5jhj2apubr5vf@l4gvbdax3l2e>
 <f45b3195-38a9-4c49-b873-01e5a0b275a3@kernel.org>
 <20240301133809.0d26865e@aktux>
 <f59c9450-2784-46fa-afc9-4f194055cb24@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f59c9450-2784-46fa-afc9-4f194055cb24@kernel.org>

Hi, all

Sorry for the wrong mail Content-Type. My Neomutt is not configured correctly.
Updated info here:

On TI-AM335x，my FPGA under GPMC local-bus can not work on 6.x kernel.

GPMC <--> FPGA  <--> sub-devices....

I found that the platform sub-devices are in wrongly organized
hierarchy.  The grandchildren are now under the GPMC device directly,
not under it's father(FPGA).

Signed-off-by: Brock.Zheng <yzheng@techyauld.com>
---
 drivers/memory/omap-gpmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 80d038884207..1f2568e43086 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2175,6 +2175,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
	int ret, cs;
	u32 val;
	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
+	struct platform_device *child_pdev = NULL;
 
	if (of_property_read_u32(child, "reg", &cs) < 0) {
		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
@@ -2330,11 +2331,12 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 no_timings:
 
	/* create platform device, NULL on error or when disabled */
-	if (!of_platform_device_create(child, NULL, &pdev->dev))
+	child_pdev = of_platform_device_create(child, NULL, &pdev->dev);
+	if (!child_pdev)
		goto err_child_fail;
 
	/* create children and other common bus children */
-	if (of_platform_default_populate(child, NULL, &pdev->dev))
+	if (of_platform_default_populate(child, NULL, &child_pdev->dev))
		goto err_child_fail;
 
	return 0;
-- 
2.44.0



