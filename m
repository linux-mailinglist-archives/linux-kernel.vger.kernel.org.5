Return-Path: <linux-kernel+bounces-16690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D553582427B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC229B23246
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DFE2232D;
	Thu,  4 Jan 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="WPPTqUZ3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F72230B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.10.186])
	by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 6F6D410A35F44;
	Thu,  4 Jan 2024 13:01:53 +0000 (UTC)
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.165.80])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 1C14C10000D76;
	Thu,  4 Jan 2024 13:01:46 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1704373305.809000
X-TM-MAIL-UUID: 7255899f-988c-4139-bb95-88cde1beafff
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id C59F010047C2A;
	Thu,  4 Jan 2024 13:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOqELa/huCpU7VEmB3YCfHCoWdTyI8sLpYRlDI+Xpag3HQDCDLlL/l0SAlTG35RwlXrbYTRtOpd3ecrcSLKOudilGwaMGRE05Z3we9x46F4ip90V5W/WPztnHf8Aa/ch6cLtFJbUt+aBJrkX8aA/nGkOl7RiYxbPQlUmOU+O5NrCKtuj/yaheXd4f32EoErLKiufiCJ+ruMHc/ue3g2MA1sOApXAmbbx9ThhpSq5/GzE/1tTDFbE5Thtypa+yjAbHo30AcA7NI2VV1xEIqMSngJVu1DX6ca0jxHETSgFQVMcDO37pUxj0nr/sl/j4WbqqRGMRxNfGKx9q9MYUvJz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSNSQiLw2taR/25gESYnwRtDRVy5PR4seJYFt74sGfw=;
 b=aC+E4tIxlNK7qh+Z+IPtxwEJRj7cXfKxMVsKPhXLJxybifQi/4s5TVIwTbtVs6vhPv8Y7gzFXNcAh0ntEHeFIiRzOQvXPAGlfF6FHFQEvz8rbOw6FsBP/Vm5XtkCel/IguF0k5B97s6mLiKf3S9hU1MHwaiLYop0pvhs7u3/mG8KuiHjM8WZZafRbSwDpqcXh8vbR7GD1KCnbzcDbB9nJ9d3uL5CUUjJ69c16CeK121H9+zgeyjllbGmbnmrNUxYViWIGN+UVxGx2bsg2cYkrrm7Hgvg388TCTfvkWnHJpDrRGWC/ONDXzyfMPm6pPnXfKsf2Yayk8bqsiCPHpzOxg==
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
Subject: [RFC PATCH v2 1/3] virtio: Add ID for virtio SPI.
Date: Thu,  4 Jan 2024 14:01:27 +0100
Message-Id: <20240104130129.17823-2-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
References: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT004:EE_|FR0P281MB2829:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4f8dda8a-b9b8-4b35-0bac-08dc0d254d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ip1ayQKnGEmRJs+lZv9K6b79AzCB2t0Lt+48AkdUTC3bPrJ9cznBmqLKJApMNHSBOLhypkqAcArx/swuzhlcOCXa+5n2s5n5eQf0z94IKl8HfJeWRej+rz5YfL45EtB/QLAgtAi7MZPg0L1Zt9O7mWap2B8JXgO/1oqpGImC/ISD8W17lSIHXN+NVMQU7qkQsxMFe92GIZMpgThrKontAqu2DcExzxRfmO51eiQ90lG/jexhuN28RO3RUFW8Udqq5ke1JEkumz9rvIAcEp+Mvnq0RJmoOIq7WubBQAm6U8GBbxjBpF5ZI1tPww0wONn1mgh1mLy5SCSDvZeRQarBzGb1cURLbtCiolO2MyUJ4hwSf5RTY/iJ3kxL9Dyt5OT0Zpd0G3qnfjB79a6+pylvnBtn61lRmolKUqy9PzAOKpIkpLpKMru4LrDexNB4YzXgagFrMhUvSQUucH4xQVzfzH07pTg8kAb9bMNJU9/h/A6p3pgjOGjfHI7MaKGaCAAIPPeiDWl9aOhFQ9uneqZU+Xv2Y5bYiWQiGmNbpiWLCOekd7D8UPvMs+yY3+YMoLcmww6ncIisfeipM/xioWN7S9uB4BX3ReFU1S/4dEKRrU8w+MYkRWOsfXcNsyO6JrAHWqi79Qv0DB6GXYAnUmcky08QHprLcpd3E7Q0o6z5cq3073KVIUiDOl7xXzHZVGPBhTQqBSO9qTU7AURSSpMMSY1IRyDq5sDzCNFQnuGxn+S2GwCSDvGZHTXCn90tEDFGODh5IT6o2YKMVytfKLlgRc4mm3gS0dHFjKvJdzGYPy8=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39840400004)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(46966006)(36840700001)(40480700001)(70586007)(2906002)(4744005)(5660300002)(4326008)(316002)(70206006)(110136005)(42186006)(41300700001)(54906003)(36860700001)(47076005)(8676002)(8936002)(478600001)(36756003)(81166007)(86362001)(107886003)(2616005)(336012)(1076003)(26005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:01:44.4830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8dda8a-b9b8-4b35-0bac-08dc0d254d8a
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT004.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2829
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28098.007
X-TMASE-Result: 10-0.491300-4.000000
X-TMASE-MatchedRID: UpZ+EYxJ0vnJ+P2VFrJmrBkPtuOr7qUwbNjTSFpLxCgW+iZuJylrLk9A
	UWTSPmMGwDaIN9ul/L4BWl4ObycmgvCdAcVltQ/eagSSqLE/BViyooG/3X7JDlo7GmCOJYd13+6
	k97GsyDhY8K0i1ArxDtV9etg/Zve8Xi/mhj8u3Y6g09DbTx3Qx+wYAW2kZxpQ
X-TMASE-XGENCLOUD: e7f244f2-4235-437f-9b68-d51fecf3b5cb-0-0-200-0
X-TM-Deliver-Signature: 7112093E0111FA70A881894C68BD17A3
X-TM-Addin-Auth: d9w0SVeA3ntyvMnVpb30OhQHgQx1p+VWZvoGray4zzDLevDa2wYpV5xHGQI
	if3OAnan6k8LgpR9YAW6GqfWoY/0pLU1Ls3d5Z/0jlS7rvG38IhLudMWoqTHWDcfbFsK/JSoglN
	I1BkqTVgVmckk3Yw0UGH9W2Z7LwCACaFRb2Vxkl9Cubtl22RFhNzL+F9qJd/GxcbXHd+J34aK50
	Rv3hWVnpEFJTzGz4AEvXFkL5R8Bg8NIhSnIpRhNGAqf0IGs9iQMhHZvARhrv5bFYcw+qeAkyPPp
	MMV0GZ3I0iHVsfg=.1RKwdRojhoeGJcBJv8y79Ft0TFAbdR5pAXUEsKnFeWUvKA+B7nnicuM3KH
	6pWRC3iY+J3BcXnZgo2rQLdxnbjqoPUQveZw5LiQ94xJnG20weR+/vU/R+FT6ekyA6lHAShVEFg
	nLVcgz2iGpZmZvqC6dwh8D7267RxvclltuOhqLcIuU+My0XdK/zFSEGeuh8RDP35hh5gidbGoaS
	5+iwaYRg4/bLTOETusQoqVoOt7my9VORSAIAX6YMgouUuDtdHTQHQnb/PB3nOa87Nnqbk8INsUo
	19YnAvZp9SD1F/HSvdwwN86u2sJY5UKCNeszbkt3U0Nr+qi9171xNQqWaAg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1704373306;
	bh=X4lHlvXtqSBf3mrkpOXdURMt/g8gLYp+Io15Exs90WE=; l=724;
	h=From:To:Date;
	b=WPPTqUZ37e/DPsDVjkR2UrrcpV2QYymOSFeiPLP61Q6RpRF+slxNA9dHACOxWJ0mW
	 Q232EQQAsdQkNFTZvGzybIsUhzDpPhssH9IePeUI5sxUGj5cmbjMVhdBKbylgM5G57
	 zssVSMh4z0+mRMbrqbo87FSbznI6WBSxl+hn241hb7AOuzNvBjYEelem6ex/jekeRO
	 hzHnl+HWw0r+qvIp3qmbl/IqdUuppmmVx+mMzJkrcUBcwGjN+5S4RpF+vRqCITdt4Y
	 yqK9myT3yeVmIOWiRrBHXzx5cSg4ucx8iGZ07T/N9Rip3dsSLyp+rDlV8IeUeEBcl7
	 /rPa+fK65mFVQ==

From: Harald Mommer <harald.mommer@opensynergy.com>

Add #define ID VIRTIO_ID_SPI 45 for virtio SPI.

Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
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
2.25.1


