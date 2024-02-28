Return-Path: <linux-kernel+bounces-85180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B68886B1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E97F1C239F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D677215957C;
	Wed, 28 Feb 2024 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="oNJKQz4V"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293C71586E7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130500; cv=fail; b=sREbkKVKpeZHQbde0xeBt2QR+umDnyzzL51AMrQWIRHFxqwAfyBYKUr0v64SgbrlfmaEraidJ2tAr7sAqQMay8FcferH8sSzTvZ4q/vs39pF4dp7COXAdCpUrlsAuuv/4pI2EInpKoP1/tzNkVSM9fkOztK8qvL1F3H8PVl3VGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130500; c=relaxed/simple;
	bh=V1NM7comayqquyIZj6XeIozgkyq2rfEs0Y4VFB/Im7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGfw1e2CcA1UEtARujbcqxJEuDniJRI6TMkn3sotl1ig+9OCDZR2VO29TFIKUmavOrcBr8D9hKVd9j2o0/O0UhwoW83ASXUWMD81lp89Hg2shzw4ixqk4mkmKKwzHN3Muvqj4RHd+u7HOfOkWuPRhTrADwPfXxkDSvQZJOBCx0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=oNJKQz4V; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.19.198])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 7E9D010050142;
	Wed, 28 Feb 2024 14:28:10 +0000 (UTC)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.197.65])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id D211710000F2D;
	Wed, 28 Feb 2024 14:28:02 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1709130482.555000
X-TM-MAIL-UUID: b87ca807-3a99-4a9f-ba48-222bb185718e
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 87BC210004D8B;
	Wed, 28 Feb 2024 14:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UidLQtGN4jiBr3upsnE4iIVFBXOpaJvECL08uFD9xXr/fbuJ+Q6HpbVSWDb6ISj5qQytxHgHIoHYDcS+h1OLIw7ep2MyES4HLdYN4/N+Q3hpnQuFk4oUZmo0hgusS7xXL6c6pxzfSKE4btsdoBTG7CbfOGzJ36BIip4qQ1FqYHyjeP/srevAfJ9Z746a3/c9hBXYHKYFkoBIlQ+vlM5wtdz9WHKLgIodwJBt4WsZXIlUJNraxnf9YlOkfM8ezD18PqMTls0PlEStkSdvON8gPgQYY7WTkyh5ySXCUsV/Wd1qfvfJaaS/KaZaQ10oGEYB1tHy35s2m/ZSqMwXdSeabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgqwcFQA4akIkJAuAlqUX0IBOrtaip8D9sVqIdUbFqw=;
 b=M1XWElRWQXUl+3s7NhA63feSSNc4vrNOEX737h8rQ8Z6tCgxFhH6ESVNFuRWZ9tnKx7NLII7qcuvhDZjnPmR32DaXGgfQGBmjmGedytXfMXqg6lZv1Ref/azKarIDh1x2q5ii4TXtDVlaAvvI80kZGz2eSQ7hblHxlE9GJhyhUZbHF/D/MzLQA2RypQwreNJ/uRADRBVfigJpIR+jD6Xyg0I6uuNEUv3p9VC2zkCPPXzR1oYyjaytOAbLyq9NYIdzuo2RFitcV9AbXC/p2R7munzYqSuAZgyxiol6SgxOJkBhT9iUPcbXxYmnwgZJ1llhjroyGJClKwqAGIu1CgXjQ==
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
Subject: [PATCH v1 1/3] virtio: Add ID for virtio SPI.
Date: Wed, 28 Feb 2024 15:27:53 +0100
Message-Id: <20240228142755.4061-2-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240228142755.4061-1-Harald.Mommer@opensynergy.com>
References: <20240228142755.4061-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004A:EE_|FR0P281MB2089:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 19302f3d-9bb7-4d0d-e351-08dc386977ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DLxstYOV5VE0Rx2v5EGhWTy/UprEI4S6l9o/4xsvKU5vI2+abH34D2F1hqFu4ygSGZlp96zqJe0g4l0Bb8rmhmoOUd8KrA7W5EztK72J+z+FxjmT6NqKVUy0jC6jDHu+n28M5dqoB1+mVXTc8wnnQqfqNP5HfAiywoVl4NspA9RXXO1psQ6tBqfjzk1TdJa6mAu8Jj+G+sgcYl+gesraiUBRG++h8T9/f8WbiUpo+9dKJBWdfoeCiQni7Bwj1GwN26bdEZ14JPfbxQjyYhVNpNSC73ebSJ+NlGnk5nVYfikux7T09JayjRT1CdlmDxWPunmfkhY2+zFdQA+1qopTTHmzQUsPc2nN8fmojn02BAWyU2OTT7aGZwxRhJTBuOavMZFoyusG8X69j3AqfF5puEipSPvxXT1JxZWfDG0YfK4x7jmFFOfiH1m8IiOx4NUJtXt9WFFYTLskVm/Jkfx1JlT7GWfY5ztomGPPfBcPcGOaZuQ3M0Lpt/KyQPFiwIDHe0Slt6YoTxL3gCIfWpuOW8eKC9mBtm/N9SiRlFYyan6eFhdpZiUIqGcku3EDZT8S+7k4xGwLKJP4gZSoki/N6df0gICglkqGxIcSpY30B11EkI5fG2Sx2nmw3ty+YW6eyMIGBEvPJOMTzp2MrZyQY4W47P3j309HgC1zZJn5paY6/9Qr2+uykp3W3Q3NRyhJsVyFf4VjSCUbu+MvXR/Jh+M5o9Z+bKz74Z8EiA+kQVVg1Vc3Qmq4RnVxmz3U/Kmo
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 14:28:01.1493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19302f3d-9bb7-4d0d-e351-08dc386977ca
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2089
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28218.007
X-TMASE-Result: 10-0.491300-4.000000
X-TMASE-MatchedRID: Dkfyeyxtv0bJ+P2VFrJmrBkPtuOr7qUwbNjTSFpLxCgW+iZuJylrLk9A
	UWTSPmMGupoogdfVK+Jd4x1IUlKnFM8TyCfmBrmqW8gh3wzbqBNwRUdni9UCWPdzaXqYo8IqVxH
	vEGsKrsW/2tJ3foSBQiPzRlrdFGDwfH2QXwfwYBCUHCQ9y5SdWZ7ayFyYRC038/sI6NCSAcVCG+
	H1Pc3TBA==
X-TMASE-XGENCLOUD: b735a1cf-1976-4b90-88e2-ddd3f7a8b3b8-0-0-200-0
X-TM-Deliver-Signature: 2D089C40A783FCB8D0BEF08BB5813936
X-TM-Addin-Auth: RF7bVIu8C1u3az0nbR3z5Z6BQGKYS8nVx01kJQjkD80RVb2jz8Y9WzU+RfQ
	NyapUVYJ3zdyS0AxYF7E/za/BeqQq8tTy7x1zDnHg/7Rvn6gKO5FYd6mSjwGxuoABuW5Iur+o0H
	xpbAyf3R8U7+z0+D1U7ye3baBJgvw/5gKjT7ky1w0vN7me9F2Zv8WcWU6jGxmJzkeBrJ3fZoxBz
	GkdqJAyl80m0f1ht+KsC4JnqqZoO64+41MZt8styPtYFtyD4Nplo/godsysrjeOK8SQUnnIVOUk
	PJsXQP5Ywzod9Vc=.kWi2Git16ehkPFoCCU2yoyVxBZwQdc7DcNZ8p1OReEPiaR31xzmWOv2g5L
	TJ4zZqF3xypSW8DgagUs3HKILIIhlVnfPaqmvqMfJBcuxyn7OVAyoS8wYeLC4DizqjzzPV/s6mI
	dwpUHj6sNlT3hYf3/GCtiOu8/MFqwR8g4p4ee78ZomLatF54kqMBgJaJ0Rfw3NPK/6mFDepP2lo
	RxwEb6ja74vZz3n+QWjsjf/3UtwT/5D6pSctDvfFl+kgpMjQ+XHUu76lk7PBFuYJGFk0iVogPgI
	SZaoDAPC3rXKzPWDUy5uBbZasNI0Lqywyb4vxYOJ0SbPMz5KI9DWJRkAc6Q==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1709130482;
	bh=V1NM7comayqquyIZj6XeIozgkyq2rfEs0Y4VFB/Im7E=; l=777;
	h=From:To:Date;
	b=oNJKQz4Vg/zTKbPcAcvMiB9es6fHhiYj8hDnpwFkSK6NO094mz71iXk8vAt8NF7qZ
	 jWTTpghyhfvTpmaGfDKqywUTDqS4F/Gops3xJGA3pohneeT2t1Ko6azeXR4mXrbuJC
	 4wyg2YcY/InamvbI9T7lYxGrPia204IatOTT6nspfvRVor9lyUD65vNqd+9hs24+gu
	 sTEwBHtgBSwArIzrOgJraSv4I5XvvXwAkUdWPryLSfQgN/eHdWmU5FdC6yA4clLAJO
	 tqX/NqXY6kzKRrUe1kZ5EIrcHfxMrtQ4gcgV6X9bHzLxXKnxNArBgxub1m96r6ZF5o
	 JzSxdzAM9bKAw==

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
2.25.1


