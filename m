Return-Path: <linux-kernel+bounces-118912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5075F88C114
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00321F3B711
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952E659B7F;
	Tue, 26 Mar 2024 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="WoF4tzNU"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C26481A5;
	Tue, 26 Mar 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453531; cv=fail; b=XTsLdlqU+4pa25RMiMVWjm9Z7U+luMDvg/nCoLNk5wnl4MgAv85+GQhLoZ7rmQEZGVknRKhWhfzeAAZQpcNkef+7o8jxfkEmJV59cK1oGv3G6ZMsSeJJkGoE3e3tiCbU9QVSzNmIPTc3i1jkUiObWomSIhzjUhXNZxCDI2dFy2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453531; c=relaxed/simple;
	bh=RzBeFF4PAbqaPB3+f7Q3ttAQEj1SAkBOW8h8In1anFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVxC6jOZ1ZIR/LmmOHKcArI6S7QXUuwSsUVtC5FrR3eNFxic70mZhreNvtzYTnGuuWYPoRXXWA5hkhrY5JJpEaHuw9ZJ7n7SCbcFEqW/VxDv3CPVfzFnCmMd6x6rextIxZH91+1I/h/M+x0uZDFyCU/rDHQ/EuAE8pxkTXHX0+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=WoF4tzNU; arc=fail smtp.client-ip=18.185.115.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.10.233])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 08FFF1005551C;
	Tue, 26 Mar 2024 11:28:31 +0000 (UTC)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.199.142])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id A345010000D9C;
	Tue, 26 Mar 2024 11:28:23 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1711452503.194000
X-TM-MAIL-UUID: 821e7b7e-8ff8-4021-8dcc-cbbcee05ab72
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 2FA2E100003AE;
	Tue, 26 Mar 2024 11:28:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDhCb3Gx1iVCh1ZdcyqHkB1RL0m62TcY8oa5hQkeJh0d+VDDjnAfQRyjRp0OATdJh6oFZj2bYYBsKfEnjMKHDvKG2ktMYs7YV0rZrBQjACjW9iFp3wy4/Ndb0NZFUQ6iTGh4Ja8C/X5389EiGe7bVf34CME0XeH98s6IqAML2+4z4wZdb0M7T2lz3QvKcDlPfQZQyck+Y3s3usnWjhz3xWwhr8hEqbgI9AFXEoyrw8KBylISS1h5cww6OGpv5bTmRrhTUo6yjb1ifKqOkpFEOCbPt7cYDXcTuUutpiGC6eJxZncWbJknLDoKLa86T5LdcglVwWFf8X3cks8cwrXfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kntnz4nXsN0pD+4/cLE3h+AknKtw7qGYV/69s2MXXRA=;
 b=E6KFteeQ3ZanebDeFI4Qf3j0vYQ0W6hkGesth5vJG8jQh5tQ74YUk97JszJ00KoMfaLUJtOOA2GBCigyB8oEjEKdAnxtQwHhwiOis+IKp6I3pIkSAqgw2UtmkffXnnLbX/D2XTh1Ne6KnZ4JY0cbxBBmBO9kdbopdZYYen9KucEERVGePlj6NJEsn0ClcJ99DaJhqpZwRD2V4xLx+Lutf+Jt9ISVBCBtMx697o5KusPvX1FNHQZb8DT0aaP8gd5RFylN4mPfqnJV+Tlc9NpsIANDjXbSdBSclx4LzaPTDzIJiBWupg1mVVvLibp1pzc1146aVo+rMKymma9N6pIDGQ==
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
Subject: [PATCH v3 1/3] virtio: Add ID for virtio SPI.
Date: Tue, 26 Mar 2024 12:28:10 +0100
Message-Id: <20240326112812.31739-2-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326112812.31739-1-Harald.Mommer@opensynergy.com>
References: <20240326112812.31739-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C708:EE_|BE1P281MB2648:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 18d72067-24c1-43fa-86b3-08dc4d87d720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HDSQPVNtF/xOl0n8DVbMbEDe2ECYQ0OQerItHXgbiK72HLLu4x46Y2Kpxjn46Uoebu71nWbGfXwKW7L49hE49m2eTqmw4jE1kPCqeMq3dYck2s0qxMTQIgICU7yg5Lr0Xi2jL3bCfCyReycJocZUVId3kEAh+qcDJs81SzEuDBLuAO1aniLOL0ENH5/2+yMZ+5rzI1Qx10O0Rui4ZUYmytS4dCm2R+rPRNSvP4bl81oUKKYqns9a04sKbLgyVqn9oAnNvbdszfzjmrootzDgQPjnn3X7KnhUGPw2EGQCixe27r1qzPqZRYYCp5KULz5QRuw/LOV1Xf1SKM26aM8fokT0gPu21UFCDYMFLE9s17j+AGKAJSL2115vjyzJHFecbEsSIb1XlPt5ErdYI4bhXeIrfK1opg9rpsfK5ygg/uQ61yn45UmCt9+WHyq4BKDgkLuXshVFwaQB50a09vqwbgHAMy+arjQ6VqXtCM9G2iqrp4wWEoIeXjCBYvXIpQZUgkwns2NOESQSn8f4LFnAF/v8ngBRa20RGvChiRVv45xQUDi3UIY87It0qOTGEiV6XvktA9Q6eFv2j1g48NO8tlK8lYcOS3Kpdok2QelhZOQUTuaCZ6TCP9Yz37vdyBJrtyoPlBD7f7sHXT62emTo4fnFV6Ssw3fJ/rdLc6wRXI+XaKUf7O7akqhPi8+B5jjVYgJuWddJP+uhaY2UQIQ7bLtqBxAIkP/p4pn9NQgKGesZmnSkak0Oo+kH3wrM9wDx
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 11:28:20.4143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d72067-24c1-43fa-86b3-08dc4d87d720
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C708.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2648
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28274.007
X-TMASE-Result: 10-0.491300-4.000000
X-TMASE-MatchedRID: Dkfyeyxtv0bJ+P2VFrJmrBkPtuOr7qUwbNjTSFpLxCgW+iZuJylrLkj6
	Xrm9PG3iupoogdfVK+Jd4x1IUlKnFM8TyCfmBrmqW8gh3wzbqBNwRUdni9UCWPdzaXqYo8IqVxH
	vEGsKrsW/2tJ3foSBQiPzRlrdFGDwfH2QXwfwYBCUHCQ9y5SdWZ7ayFyYRC038/sI6NCSAcVCG+
	H1Pc3TBA==
X-TMASE-XGENCLOUD: 71954c90-8286-4cac-8128-cc0efeecd5c7-0-0-200-0
X-TM-Deliver-Signature: 3CCAEA605E708B390FA492E00F8BCDE2
X-TM-Addin-Auth: XXRe8DPUvH42gCBrsW/kOTuRc3bOJWthWc8c+dbQwTB36+xDKaa1MYMM11M
	sC4NkPEQXq9U4wYNkRbQ/rZWY3O/VDEmw4G+ovnQNcMHVuOULYpWlFQPQdZnctLSzJLLnjHQyOA
	uA+VAL05RpB6+K0y/KAC3AWJmXPwhgBLRBbEVJ4MfJ4WMjq7DGM3k/DB9JWmiDAZ63VvOSkc5mf
	M9NMDfjSThc1VnCpjvFropYtE2VRdQYyT/bMslkjCChz+85gDrYbst23so1xezx7gDa7TtEEBQo
	2T00Va9E4N9fxdQ=.y8iwB6t7sI2CbHf+8T+xlkOkhJhPmawkF8afPQw1hKDEzbqkfeNrryg2yF
	mI5bpezTc/J0bid1CC+6iYqkoMB8/aqOePa7FmrvsvUFjzXcjkHATWUxFMRExrNzPcYLR5Dff/y
	luyXHvoetLm5Xefl7+pYpHmg4t2szx/Yaw3xQTfaxXCKZ+42i9NDbHMaERKNPF0rJH0JEwvFy/k
	lGYajv1Y7hNGbLnsF1KzHwW9m6Mi24sSnlTHzLF0ceBiGWYSwPZ7+lOes4E/LDs9JFmOwxU2dH/
	ceooGCZdPKEAqUO8gnEgFWHbSds2dNQKMRandNm2HxCaGWODccF2FV1jYAw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1711452503;
	bh=RzBeFF4PAbqaPB3+f7Q3ttAQEj1SAkBOW8h8In1anFk=; l=777;
	h=From:To:Date;
	b=WoF4tzNU9HcFNncSzg9BSVp/Crdf8Po35kEMaM5l/rpdXqielo/TcxdQSSL/zx2ES
	 G4JsREI7R/LK4VSGBsj7//3FDUaOzki/DUJtUKvRtaSZCfBCfsTQA5ds0a2NKIsjOB
	 AHhxuiDu5kovgl3Dwim696VqUG8tJ/w/cq5SgJ+2TIUCnaKT5nPErMCVO8izWK6wI6
	 YYgYvBUXsIz74j83Ss0VWFRBH70BigWUMHw+QyImmt6JCWR24BXm6e1z9d2Z2zV6ar
	 GHuPNTWu9oVYgemLa69o2aq92oqzqkPVSZ9SIdb66CR92u2Iflka+eKVP14uLCp/4m
	 sgYD+1CxcS2gA==

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


