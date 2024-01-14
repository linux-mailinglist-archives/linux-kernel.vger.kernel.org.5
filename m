Return-Path: <linux-kernel+bounces-25519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E3382D1B8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 18:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0521C20D9A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 17:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7BDF5E;
	Sun, 14 Jan 2024 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Qp35Crx/"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948ACCA42;
	Sun, 14 Jan 2024 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40EGPmNC028268;
	Sun, 14 Jan 2024 09:22:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=E5WheNxtE7KIkYNksOdMvdibyOlZ+13KdYGfnetHwPQ=; b=Qp3
	5Crx/5wb1l1BKN0t7tyocWgwSMQUsJFKkQFVr+VlNUhjMXHXJDitfydM23KLmP3r
	uY8Fk3zGN6+sovJ2o0F5/+H9kpsRZ/fdMMTVJYqJhaidcd4wGa1/OBOrVvtwkjMr
	955nSKJlY6A3ikOrwohSSIqCAzDKXnm+1r00AoOzk/DbmR9ZB+2a9XrBmslFZtuX
	YoCvjcsuiOgd6hrPZCtPd1aJH9ZlfVFeudmQ0T/4rRuJy1HjQlhOSgx9K77YpEC4
	zY7ytYwxIjzQg3Pljp9ZCtwGHJmuaDmbDjP7a0pndBluJgwK03/fYx5oVfk4Z7r2
	QcvpKwakhecwNhLQGag==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vmj24g66u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 14 Jan 2024 09:22:02 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 14 Jan
 2024 09:22:01 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 14 Jan 2024 09:22:01 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id A62A95E6872;
	Sun, 14 Jan 2024 09:21:58 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <gregkh@linuxfoundation.org>,
        rowland.harvard.edu@mx0a-0016f401.pphosted.com, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v4 1/2] dt-bindings: usb: Add Marvell ac5
Date: Sun, 14 Jan 2024 19:21:53 +0200
Message-ID: <20240114172154.2622275-2-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240114172154.2622275-1-enachman@marvell.com>
References: <20240114172154.2622275-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JhQHn7g1R_7aAEHXoMKbfFbne6enF0oS
X-Proofpoint-GUID: JhQHn7g1R_7aAEHXoMKbfFbne6enF0oS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Add Marvell ac5 device tree bindings to generic EHCI.
This compatible enables the Marvell Orion platform code
to properly configure the DMA mask for the Marvell AC5 SOC.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 87986c45be88..2ed178f16a78 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -77,6 +77,7 @@ properties:
           - const: usb-ehci
       - enum:
           - generic-ehci
+          - marvell,ac5-ehci
           - marvell,armada-3700-ehci
           - marvell,orion-ehci
           - nuvoton,npcm750-ehci
-- 
2.25.1


