Return-Path: <linux-kernel+bounces-63621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E90D853261
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF91B21F67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C088B56762;
	Tue, 13 Feb 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="LNZxWmwK"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B066856741
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832452; cv=fail; b=IFwIodOm8Z1JHb8vcfJB/kgBvJ9AsXMsZwogRhIKxhRJqw7s23qlHIBAbzFvKaQZNd50vp3/nilNalIokvqXaEVMK1jUg4H1oMajcb3nZCcs7XxJYbspj0Lubr9yPsFOxx1hM58557BCXdZLkdJidUTBk237W0dqeVHCTd9Rxjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832452; c=relaxed/simple;
	bh=vxJDzfugATK5AKeNs1Bln9eDUQfEBCiBMJjhnvCsSdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tune/xgG2sVxTqvO8IRzfJr4sRVjpa3SysPqwpd0B4pA6gM8b8FclaOnQpJjtFb/W7opkDJ/ptphnAIZ1zONsyCGwkswukTFwpq1CJUdk1ZDo5lFDczBaVSUGnl/9wRKtsSKmm/mAmv60jfC5cbhLGSs5tvgCySp66nJK1jlQKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=LNZxWmwK; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.10.81])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 4592910033308
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:54:08 +0000 (UTC)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.181.221])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id B2BB110000F6A;
	Tue, 13 Feb 2024 13:54:00 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1707832440.377000
X-TM-MAIL-UUID: 8e28b5ff-b99d-4da1-81e5-b1a7645edc48
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 5C21810006A64;
	Tue, 13 Feb 2024 13:54:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RV+SUVWXya7nNmUsrhnIuUW0yZPvdhzMN6vilwnKGE3cHW4ZiMoDP2qxy8p2xYc8uizYTmfWYZ50YZNilcdUIbylB+EO9AktF/lhfFRaqtfpr1mLzXHBcxvQDz4uE20qc35gH5vw8U2OOvmQ/dVsaaLvtB6yXRDRvAgaIKPQBrbbOAApGOVs+9RW4as2HKGdtEtNfRfh2Ivcntz1+HhWuPaFbOGM8FqqV16G2wC+6L3AHbm8YfNkVKEyLY6we3m3u31vpFwrjDufpbpl1VUbErRbZ9158GkamNzOa3YKONQG684dPsOcq6nnz+qV8LbgsHZI+URXEyLwQQTyIqxDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viyVWJnpcnHHn4e7wd6VomAquY+WU2DNfPs+h1iKMyg=;
 b=kV4BkLbA45Hch3Jw+B8/mH7HRQ8crvkJaifsi3R8lzFCDJV7G28Y+KoLtf6YDlsKn9Mx52sauwLF3y3QqZLKMpYJNJ8bxGzYZ+EHtHyeakwD8kL3TohTcTW8rodVsaA/VWo+emgX4c4nNgYU5+K7iAmqS6RLCUHRdeGE0B6HKnlvEd10igtEaCR9rgSDW1ramxpexGylhtKE2n4/tpGLTqXM4Yds/0MKhXN51rde/KAPLDzYq2+YGNj7a6fLEu4boJMPrIYudzxRwkTK0bdv6F+jpISE97utyui6FRwFfC0g5azsoH2biadrHV7xaNq3md7AeSw4V9H4VBy0URbkGQ==
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
Subject: [RFC PATCH v3 1/3] virtio: Add ID for virtio SPI.
Date: Tue, 13 Feb 2024 14:53:48 +0100
Message-Id: <20240213135350.5878-2-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
References: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B7:EE_|FR0P281MB2812:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ef0117d9-a0b1-4f7c-ca73-08dc2c9b3a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LKBRatVhTWeY+up/njWv32ZbWpEaweOIfFzAzKVBhV71fQUZoXba2ydx7SKg2H6/f2s3z2+THgh/fE6Xfzc+Vazo8Fm5mFuXfJHTGhHykZCuD5trpflOcGOGdTfcH8R3OOP92GdDuvW87oyBA2vwqOEn8qlKYbkPdxcxEzNsMxHFhGlN3KoPKBc7KF5RLdMAgPbBawwxQxnRLysZC17lNXh2bMqRh31HVeIkVr2InHwG3/TTqy2A1mrU/CkT5YWnYl5qbzBkUplxVYIDSXyI7p/AdAeRw++BXBh2Mg3HQ4lwmptUbPKhUUyZSdUhg1Lg5FNvibfYC/5/TUzcEzLtFJGVyq5WRZrxQUMoWRIWYOF5emG+b+68ujdMbHKh7TIeN1Rm/nosgCCFejelI7kYPByZcl0ujnPVbxdPu1FqVTWe9tg7/oDLU4Gp7JZtUwUnrKhYo+xBaHoDMO0OpKyi29TdMS/c8TABNQFq33uonryxNDNDNJYwbI8LnKgVmGGZ7hdCfe7y3ALhGBkA04EV7bQ42zRqGaF1cN67gzRcjxagcQOwJ9xLFc/gqRG1Rq9jDfPqaCKww8aRx/jNA1DX0ilISaG77Q+2SRli4A7p5mo=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(396003)(39840400004)(136003)(376002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(46966006)(36840700001)(2906002)(4744005)(41300700001)(1076003)(107886003)(336012)(478600001)(5660300002)(8936002)(8676002)(4326008)(70586007)(70206006)(26005)(36756003)(2616005)(81166007)(110136005)(54906003)(42186006)(316002)(86362001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 13:53:59.3041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0117d9-a0b1-4f7c-ca73-08dc2c9b3a8f
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2812
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28190.000
X-TMASE-Result: 10-0.491300-4.000000
X-TMASE-MatchedRID: Dkfyeyxtv0bJ+P2VFrJmrBkPtuOr7qUwbNjTSFpLxCgW+iZuJylrLk9A
	UWTSPmMGupoogdfVK+Jd4x1IUlKnFM8TyCfmBrmqW8gh3wzbqBNwRUdni9UCWPdzaXqYo8IqVxH
	vEGsKrsW/2tJ3foSBQiPzRlrdFGDwfH2QXwfwYBCUHCQ9y5SdWZ7ayFyYRC038/sI6NCSAcVCG+
	H1Pc3TBA==
X-TMASE-XGENCLOUD: 390dc103-7c3e-4f1d-bc12-401e097fd074-0-0-200-0
X-TM-Deliver-Signature: 3A4896915A1EF00C4841768F8BE5A47F
X-TM-Addin-Auth: uwk93VsQgaowyGSVkHEK87ECh00UIDv4RsAmklPO4ufb4WqXtNw9H7OAWy3
	8vNeIkjRsZNww0Dk373g6LRuxem/xLVcZPIw2oP+TyhtGNz0KddxsS3AfY2kLmk+B7JQXbg78Y5
	xkw0LNiHjkG1xe2VKBxMcr317bKgZIH9m7u8eKGj5QbOvPA3ocsqLydgfzlmVifB/q0XBSrjvib
	MSh0jHdiNHnLwP4jhdAP9SYq1rzwwc/O3vFlXFaWnvW6g4T5Xv1BXwixaX17G3uJUsbXvJUUIOh
	f0Vs0OsdW8viVD4=.ZpApugKF5Yd9EaUBdKWP4+IGzg/0tuqkC2pt6z44PopaYj9Oajxh57bohY
	1aUv9Ah01iXTa2Dn8bGrAhEtKvuigV4N13xjZK3x8LMXq09TGkBGBKVnPGnP9H7kJInB16ooBN1
	qKnixkhfclBQocjU6Eok7BKyaJyANhaK5LlJo9QQqwrOSt6HuiPaUrHOxNJbqmuG3vU6KwpzGZN
	3AJBsnvaysheN1N0RUpuCC4+a2TSKKBrYRhArbYmYJrD4Sh+Pxk1Rkeq8WQaQrTCgkf/aSY9mkM
	aqyQcp9jzbqJlMJJw3g6h4v0a9e0pefpIvFGwtL2W6u6v2dwXoHU/IBc1vA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1707832440;
	bh=vxJDzfugATK5AKeNs1Bln9eDUQfEBCiBMJjhnvCsSdM=; l=777;
	h=From:To:Date;
	b=LNZxWmwKqR/jUiNfGFTrGsOI1gSshHvAy5fR/Wb7N86VAJZArcuSe+uMSd+5asvOh
	 eOkXb2nqqRoexH1mz3V703E39EUY4OMFwu/Lv1VuGsGNFEtO4s17Ye/K0USB0LmWQU
	 UOmk4W2TRiAuOiZFMJyO8JM7CCkQth1jlLCfucHrY0x1T3rusjQ2pFMIRo1oa5dwaJ
	 K+NmjCms9c6Xx7rm9F+3iNGmr6lZFbIIVby8JajbMkCMtN0dasKb0GXQKATzC7OSqn
	 V/jK4a01scbBRKftm88oKoDSgYY0aLgBJSisjOB/4EeWMdH5cI15dlUv9aKAXyFKXI
	 VGzSrSudt7Ipg==

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
2.43.0


