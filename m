Return-Path: <linux-kernel+bounces-28533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C580E82FFC2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683E81F2573B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078218C09;
	Wed, 17 Jan 2024 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="ape5bBJm"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15CE8BEB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 05:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705468885; cv=none; b=TcsDvFI8u2duPrMClpQvQVZgwexyMkQeRy5ecFl0TpxR+38DS+5RSLh7vaE4EGyi9NSecHR++UaIT+dlQZBKEgAnp/7I1h62mugpsTRhiwRGDgQd4q3xWylU5857ZwRHtOyyCiktspzrQKvkA6nUWOGdnB6u+Gucpoh9g/Uo5Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705468885; c=relaxed/simple;
	bh=XChOQZiLY86dRsr1VE6ZcLqDvgwKnJ4yez14ExK0pk4=;
	h=DKIM-Signature:X-AuditID:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-Brightmail-Tracker; b=BEQWQUyxaezCxfT/dNz3JUPVOYrS4kT4qwIoSYME62Dm0T1TdOfL28J0y1UdMS/nENy8yHIhiUmDyyAtmRvugM19abOVTEye0v5R/N5xsCrZV6suLwdZB+fPUuADe1T5PGxMYicTmcKPi5Huk63SpwwlqXTx72sN5zc8piZh8N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=ape5bBJm; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1705468877; x=1708060877;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XChOQZiLY86dRsr1VE6ZcLqDvgwKnJ4yez14ExK0pk4=;
	b=ape5bBJmezNfhg8g3Zm4TzYcL7WAATbeK3Jcaq4xlFLGuYd5nS+xOesAvIuk2N2Y
	jHmGOhuYhySDqKDJ7Al3ZA6+sl9XRquD3hhvWdmKYCF+oe/TERx9dHfVWvXvwfVm
	bfwFGmH9l/AXSwCI9FOOo6tby2Tb4O5P1iEbgo8Y170=;
X-AuditID: ac14000a-fadff7000000290d-ae-65a763cd6b85
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 4A.3E.10509.DC367A56; Wed, 17 Jan 2024 06:21:17 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 17 Jan
 2024 06:21:17 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <lee@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<miquel.raynal@bootlin.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>
Subject: [PATCH] dt-bindings: mfd: ti,am3359-tscadc: Make dmas & dma-names optional
Date: Wed, 17 Jan 2024 06:21:04 +0100
Message-ID: <20240117052104.747333-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWyRpKBR/ds8vJUgxf3jS3W7D3HZDH/yDlW
	i74XD5ktdrQtZLG4vGsOm8Xh9n2sFq17j7BbdL9Td+DwmLem2mPTqk42jzvX9rB59He3sHp8
	3iQXwBrFZZOSmpNZllqkb5fAlbF57222gj62iuN7fzM1ME5n7WLk5JAQMJG41XmKvYuRi0NI
	YDGTxNy/k1khnMeMEh8nvWAHqWITUJe4s+EbWEJEoJ1RonHiPiaQBLNAnMSXl8fARgkLBEv8
	aelhA7FZBFQlTj1dywhi8wpYSJz6t4QFYp28xMxL39kh4oISJ2c+YYGYIy/RvHU2M4QtIXHw
	xQswWwgo/uLScrjeaedeM0PYoRJbv2xnmsAoMAvJqFlIRs1CMmoBI/MqRqHczOTs1KLMbL2C
	jMqS1GS9lNRNjKBAF2Hg2sHYN8fjECMTB+MhRgkOZiURXn+DZalCvCmJlVWpRfnxRaU5qcWH
	GKU5WJTEeVd3BKcKCaQnlqRmp6YWpBbBZJk4OKUaGDV/HH2syTbHdwPv7M+7Tia//z43Iopl
	tkpG/sdUGTaHpGVWp2713ubM3LLEcu9P1S9SfVGG97xd5quvdw5ZW/O8lsesZflar5qAnf2z
	3+o+3XicK6PihvaRffd3u676ctI+TNh9wxwHrwPHa7Z+iVqR/qbkXest/ekvikr4roSdvKF/
	YWfOjS9KLMUZiYZazEXFiQC6cEUyYgIAAA==

The driver does not require dmas or dma-names to be configured for the
ADC to work properly. Remove dmas and dma-names from the required
property list.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
index 23a63265be3c..70b5dfce07d2 100644
--- a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
@@ -61,8 +61,6 @@ required:
   - interrupts
   - clocks
   - clock-names
-  - dmas
-  - dma-names
 
 additionalProperties: false
 
-- 
2.25.1


