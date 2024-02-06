Return-Path: <linux-kernel+bounces-54614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C771C84B185
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36FB5B22D32
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC87012D164;
	Tue,  6 Feb 2024 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pOX4kbbn"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD912D14D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212518; cv=none; b=tje2NanUqNfp44g/FRwGSB0oDR58kXw+7SAyR6JAKPjhNzlcRRZ1OQjmbEh40p8RwIlQ1AYf9hXbCQ+Es9oyQJlDXkqmX+/pz8ofeFg2fMfSHykHhMVLa7SRMs8Lm2wZFKzwWSPIjtBovAbFBbpVpt9CQ/GoJl3uhii5z5lba1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212518; c=relaxed/simple;
	bh=bzedo6w2sVKvO39Zdi8zshHDEowHD0bVTtf5g9U2YNw=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=BjWAAB2aPG7iBei1T1fKQ1q7yTLrAv+9u2dj+oHdK3MAkYdt0Q7z4g3pAM29b/wNCZ/YJA9Yx+bKJYkL2FV77lQLqpnWd8kOxDi/TKvl/CtUTH8BM6O9vMQMd2t/RpdhRXAB+eOrwj4B1atxcPgRYC+HrEQRm2Vt3ZIzAgINpRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pOX4kbbn; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240206094153epoutp03c0cdfa70d79b71163340ad0b71e0da5f~xPLxTiVkS0707607076epoutp03O
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:41:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240206094153epoutp03c0cdfa70d79b71163340ad0b71e0da5f~xPLxTiVkS0707607076epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707212513;
	bh=6FS5OxjDvcI+9OytrSkqO4qI4whSWvgqrs/WRChPmI8=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=pOX4kbbnINMQqLbPbVq/0LTNtB8CdIpT6bBXAYxd3z6ZirCy5Ofeodrqk2jzRWpWY
	 D+7TTB+mBr+zpxADU/URzhlcoFmJiJZTOPKJJ4mxPNSLcFJV5lKoHsK3SQM+llBac1
	 SA4IbjjS4ySmZRiRyJ0UYEbJe9pOUgi8SZN0Zy/E=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240206094152epcas2p1c921e056f2588e840065ede5f46a109b~xPLwqOpLg3006430064epcas2p1N;
	Tue,  6 Feb 2024 09:41:52 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.98]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TTdYr0Z5Hz4x9Q0; Tue,  6 Feb
	2024 09:41:52 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-3c-65c1fedf9e0a
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	85.0A.18994.FDEF1C56; Tue,  6 Feb 2024 18:41:51 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH] perf: CXL: fix mismatched cpmu event opcode
Reply-To: hj96.nam@samsung.com
Sender: Hojin Nam <hj96.nam@samsung.com>
From: Hojin Nam <hj96.nam@samsung.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
CC: Wonjae Lee <wj28.lee@samsung.com>, KyungSan Kim
	<ks0204.kim@samsung.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240206094151epcms2p373ed7f50efa332765e14bff2b5a2abe2@epcms2p3>
Date: Tue, 06 Feb 2024 18:41:51 +0900
X-CMS-MailID: 20240206094151epcms2p373ed7f50efa332765e14bff2b5a2abe2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmue79fwdTDZqOW1usWniNzeLoHg6L
	TY+vsVqcn3WKxeLyrjlsFkuvX2SyaLljarHx/js2Bw6PNfPWMHq0HHnL6rFpVSebx+Yl9R59
	W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIT
	oOuWmQN0jZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XE
	ytDAwMgUqDAhO2P5pENMBRc5K3btnMPewLiRvYuRk0NCwERi67bnrF2MXBxCAnsYJRb/usjY
	xcjBwSsgKPF3hzBIjbCAjURT/y4WEFtIQE5iz4nzLBBxDYm13w+DzWETUJNYeP8SM4gtIlAl
	cf39UyaQmcwC25gk/j5cygixjFdiRvtTFghbWmL78q1QcQ2JH8t6mSFsUYmbq9+yw9jvj82H
	qhGRaL13FqpGUOLBz91QcSmJT3c3QcWLJWbvXwYVL5BY8WMR1C59icbr79lAbF4BX4k379Yy
	gdgsAqoS87esg+p1kbg38Q1YDbOAvMT2t3OYQeHALKApsX6XPogpIaAsceQWC0QFn0TH4b/s
	MF/tmPeECcJWktjf0Qo1UULizonLUNd4SEz5eJwZEoSBEt2r/7JOYFSYhQjoWUj2zkLYu4CR
	eRWjVGpBcW56arJRgaFuXmo5PH6T83M3MYLTppbvDsbX6//qHWJk4mA8xCjBwawkwmu240Cq
	EG9KYmVValF+fFFpTmrxIUZToK8nMkuJJucDE3deSbyhiaWBiZmZobmRqYG5kjjvvda5KUIC
	6YklqdmpqQWpRTB9TBycUg1MWRnH91pJdKzUqT1xROz8tLd8Gxuyf/1L3/QnqfdsZfDfR6Y3
	fbxmL7o5b3ZxetNUx6agg27xsy/9zL2bdEqk/fg/mwXs7UuYmVxnXdhUc9vtQ9fHaxqiNu6x
	Mx4qn3957dWfH8r6pytFFqc3vt0YbrTCZcLXm7y8lgG6QbaHnhSEB94vD/EzmWIq8XKCGdPp
	Tvmd7P/aJK2naJzbzP1qvaFolajKpFATvv4JXqdiqk80OS6QtDIy+R206q3dloS3xgLmysXC
	YZ37+T/73P+3+M/hnInz5U0vxxl/dM4uuDvJ/8u+qZyiCxuenjd9rV2990zIU9m1d/kmdyes
	a06e81y7574p99w1ya3fH5mbKrEUZyQaajEXFScCAG87ZjMkBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240206094151epcms2p373ed7f50efa332765e14bff2b5a2abe2
References: <CGME20240206094151epcms2p373ed7f50efa332765e14bff2b5a2abe2@epcms2p3>

S2M NDR BI-ConflictAck opcode is described as 4 in the CXL
3.0 specification. However, it is defined as 3 in macro definition.

Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
---
 drivers/perf/cxl_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 365d964b0f6a..bc0d414a6aff 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -419,7 +419,7 @@ static struct attribute *cxl_pmu_event_attrs[] = {
        CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmp,                     CXL_PMU_GID_S2M_NDR, BIT(0)),
        CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmps,                    CXL_PMU_GID_S2M_NDR, BIT(1)),
        CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpe,                    CXL_PMU_GID_S2M_NDR, BIT(2)),
-       CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,           CXL_PMU_GID_S2M_NDR, BIT(3)),
+       CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,           CXL_PMU_GID_S2M_NDR, BIT(4)),
        /* CXL rev 3.0 Table 3-46 S2M DRS opcodes */
        CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdata,                 CXL_PMU_GID_S2M_DRS, BIT(0)),
        CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdatanxm,              CXL_PMU_GID_S2M_DRS, BIT(1)),
--
2.34.1

