Return-Path: <linux-kernel+bounces-90871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CF587061A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF3DB2E711
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A609E4CB54;
	Mon,  4 Mar 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="0UQjOeib"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77104C618
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567046; cv=fail; b=kc1jNrfYTqVTNx9vj1FTbFemezDvkweNKbqrTU9uuQyZ8HnvElKZj1Ny+C6PvLIDowMXU1SZsDOXZLTM5phZUedJDb7xUjKP1alPaW0coltsZE2FKgyW/QB8d5km0F3HBHg4TtagTksQZG8TrS2peJGIXpWPvEt5m3AnvoTl7Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567046; c=relaxed/simple;
	bh=RzBeFF4PAbqaPB3+f7Q3ttAQEj1SAkBOW8h8In1anFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmec+Hq+zLyteAvTIWgESqjQMpVONw/6O+pypCgVygYA85T754vOgSSpYLgy05sLDpVoHcsebAQoQ2I45ouJ9mW5PqD44G/4pEizZnuc7BCHAd4iW0pwNqYEbUb2DtgOGZ4FMPXWlLDhqwGSR1UoOdhRJ4BdQhKEaJSL/LeiS3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=0UQjOeib; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.19.81])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 70DB5101E444C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:44:02 +0000 (UTC)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.191.80])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 04A621000134C;
	Mon,  4 Mar 2024 15:43:55 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1709567034.722000
X-TM-MAIL-UUID: b4de088a-1a65-4d20-889b-8a2c128128f9
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id B062C10004D9D;
	Mon,  4 Mar 2024 15:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCwyUmBm2cqlAZgjAOt3O+jiFv9eD1VuMPrrx1X/J76SNOsWegUIPuU3twdUF37eXAucPRzpPM/Y4Um44jxys7dHjZR54RPVwUaEfXwZDGY2rm72g/SnI414U0IYn317pvtvF+2rRZOvBaiDon5au69H2ymj2FHK6TjR6k8GeC/giN1+qA0fwnwBlij5xInfcPxMMDrnFZYoSbkuxaEwJPDTMqeIo+9o4ZGiaptZzbofWUNrfwx9rBV4U+4dHShylRRTOBVDsTIWd0WKzB9kNdAOJjBqifCVolbcWeZHa5oaTeXqvXBXJhH+U0TplsXIGgsVQYvLKeWVpJsoz7X0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kntnz4nXsN0pD+4/cLE3h+AknKtw7qGYV/69s2MXXRA=;
 b=DQliBXt8M3a99IA6qogXoCHPp6tK6cPjhVVaUIlcQ21VWt5W4AlzBkmoTAutuxnAn5L8fJ1pzZVHdEqnhOxHB/iOPtxIsbOJm3dQYjraMGm3eEgiKNXEozUluu1En9432zDQJjwPIOSijwPRWjH6W4+fChc7vSBWXx4XsOHo/4EWnPQcfhZjbd072BfxJIfV8hUk/hC9JR0VvuB23KMqEVzKH0apI3A+qRXUsVAUv8FbPSR+hRFQi283ea0OZ694ido6bzS2TrCMJ6mgT9U+P6Xw/Z1N3HzUTFr9EiGLd/VT/2b2hdNpzsc0PveVcZOqWgkztBYEmM2Klf3l0YUNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=kernel.org smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Harald Mommer <Harald.Mommer@opensynergy.com>
To: virtio-dev@lists.oasis-open.org,
	Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
	Harald Mommer <harald.mommer@opensynergy.com>
Subject: [PATCH v2 1/3] virtio: Add ID for virtio SPI.
Date: Mon,  4 Mar 2024 16:43:40 +0100
Message-Id: <20240304154342.44021-2-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304154342.44021-1-Harald.Mommer@opensynergy.com>
References: <20240304154342.44021-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|FR5P281MB3857:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5c8fbc00-ba53-44fe-8f37-08dc3c61e53d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XDL8koXvHdXyTt/M2r9efgqR8YqR1DLyNbvFZGozHu6ohTfEsbQOGIjw1nP05itXQuPqpC8iz6rJ/2/zPtQfldQ/c30sE1KobcKYRUKDTOD3F6IVSz6MXerOwbg7PvoblQAf2vAH89BYrEWIivaN6inBF/0/wJl+AEhmt0ysW7SZm0159GQsYb3JHOuLtIeRodISKyX3DHEIhsia4catSvAjyYtKuJlJBSbIU46ClxzcWMguF8PdXTbgQb/Bvr3mj8Uqc83T1lWU9RG9kRnOU9K1KxnDnYW1d53Y3cVdzTHT12USiHwlGPuJ7Jo8iET08uZIvKA1WHhPBeEZtgsqHGbiZYjq/CsAWknwjCFNspuyWAM2sIIsvtRgXxxZHeaTFnyuEmUQlDz2OB6FXJTSQ1Md9c/O++uCjLV1aTw83oy7ZVCJW5edEYy2wEr7M1yoKLbQoOlwpvowqfRVYzCqtok6Np6jFG4qi1H6Wb7JKd0Z3jn9AvIx+Gd4EdeD7r/eYvCspb2d3sDYy4CVuLG6H2lRNxR6WIZSb9TioXJwnPC+xkCoavf/POJoBcjqAeJM82xkmmxbpsBpBLDgDn4RJRcSVDR+kIcZPHCuLcFuXfjMcNGCNdge4kaD2+mzEXJOzXSuD5dWON5NuLdPGHD/e8Uu/e+9josyX0awIRMwLdvwZYyI+Nl601VL6T9Xo5nWvMWQ3JZs4UYIRCEFy/hN1oB0SgES1eS96Vc+3f4fFvyA6JAuWVg7hDOkp66xt8um
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 15:43:53.4497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8fbc00-ba53-44fe-8f37-08dc3c61e53d
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB3857
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28232.000
X-TMASE-Result: 10-0.491300-4.000000
X-TMASE-MatchedRID: Dkfyeyxtv0bJ+P2VFrJmrBkPtuOr7qUwbNjTSFpLxCgW+iZuJylrLk9A
	UWTSPmMGupoogdfVK+Jd4x1IUlKnFM8TyCfmBrmqW8gh3wzbqBNwRUdni9UCWPdzaXqYo8IqVxH
	vEGsKrsW/2tJ3foSBQiPzRlrdFGDwfH2QXwfwYBCUHCQ9y5SdWZ7ayFyYRC038/sI6NCSAcVCG+
	H1Pc3TBA==
X-TMASE-XGENCLOUD: 2b091f75-e37d-419a-b308-5f9590abed20-0-0-200-0
X-TM-Deliver-Signature: 086371DEEB3430E14BBA2FD460A89F04
X-TM-Addin-Auth: dG965nxep5aCGkRsurwIKaQG/E/Y4xNEVI+1xVGHIbxZACrQYE5Yv6N3zQt
	tF1PDgaZMKkmUWvAFq4YE3dudxZ9xiBDm8m16QasPZkMpjni3wwu+MH4IS7wlX05+KLw4A3yoWd
	edtq0dTe85NDmQjgsfIz0nkvnpDJWoUv8IIbOWwQlZdTwkKBeDYsFpK07HXCdczCNVXnFdl2HJ0
	1yyA2BiFdc4RTC6Uq5cwUS08lG/D0BDm6U8LXWeKYOf921fw9gYdpBrAzstLzRd9hua39HbdzSP
	l46+IvTB9AWsNkA=.CcIwLPen+MCECblYpIqQP1Qq849YC0KeeA+RPFtkAYxj7vzXyCaJhzp17c
	qsCpCp/2lKD5VdcJBG4ukpQEvWFy6gvVmjK1UFW7IVDhwZEM/riZ5utoilgHziap1l2wi1dBOOn
	nF6xgPv+TygGNafnpd1e2CbDKi2vTIroH9B0Mi3+nRsLkb3odu04VcybfHqCdnEHWW0IN9V5rKX
	Bi1+/efk43CPcaL09bLP50vwm4VbE6xqgL/fIrA5X0rvnnM7QsUunvIiygMKMiCKintg3JzIcg8
	LTWk67rMyeiwj9NBoiHp2Mx1c/E0YODpW0jV+Zs/WGaTMcoall3+Lhs3XKg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1709567034;
	bh=RzBeFF4PAbqaPB3+f7Q3ttAQEj1SAkBOW8h8In1anFk=; l=777;
	h=From:To:Date;
	b=0UQjOeibImSLzahlu1GqohfE5FrH8kuOuwjnV9bsXMLh4F3X4WlVb6sK+8m7qWBpq
	 7r4dqVR39kJhGpLnKcfn5FHyVeqex7uUcRcK4lxFYKxnKdONRDLtWwlDxJ56UVc1Ld
	 zbFnSdTUi9rPlP40A/Wo82jWtDaL+dyeRfIAUG9eFtjhOg8JKXg6tt0U/UhoUgfH3C
	 /heZnkabvKadfQDB8hSdFIOx9muHn9akHn/1OFELb3EpBDgnCrxgxspADIxbNjuhZa
	 51N4rjdXeySNAuqthOLMdTti8d3fbYZzPq003s829IE330Td4glE1yMM7IzY96ocF+
	 tACLrHk8eazrw==

From: Harald Mommer <harald.mommer@opensynergy.com>

Add #define ID VIRTIO_ID_SPI 45 for virtio SPI.

Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/uapi/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 7aa2eb766205..6c12db16faa3 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -68,6 +68,7 @@
 #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
+#define VIRTIO_ID_SPI			45 /* virtio spi */
 
 /*
  * Virtio Transitional IDs
-- 
2.43.2


