Return-Path: <linux-kernel+bounces-55930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB05784C386
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04D2B28013
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298651CD2C;
	Wed,  7 Feb 2024 04:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FF+s0BpJ"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF71CD13
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 04:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707279768; cv=none; b=GBUIU+csk+AKmaDPZsJ3VsEGD9TY6XkEpxiP78Ej9bNRVUKfQFgIeF+lioIYiFNjw/aEeakJL8IupkKaH4jnC0pQBk60JNOPVRh3bDiSpuJFPuMT0ldAyW6uMJDXnZVr/Vf1/xx/ZGRGJGV66+qbgC2cLuYVgpnR3bglSJpAMJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707279768; c=relaxed/simple;
	bh=rukCa+dU1eZ6GSZTI440gjVvfzDMVGjFz/6VQOVW/40=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=g6nPEC7zSUzan1UwKho/AMt07LcHnPQ89fSn3mwpfpc4DwvATsxepUw/iuu3dxGLLFRGBHXYvVddanK+1ut1nwd+vefpbTUvvHz0tNJ5yZb7pu8bl2NiG9hkrjy2UlIvYZBmpeUC0YbVMpSpRXnukGKtd+/kDsjUkOI8xOo/18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FF+s0BpJ; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240207042243epoutp01bf573941535ad2824de429c09a18f251~xeeY91aA60537505375epoutp01y
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 04:22:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240207042243epoutp01bf573941535ad2824de429c09a18f251~xeeY91aA60537505375epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707279763;
	bh=4iN7aGm2GIoezqePI+sDw2OitzYGXb1VOO9E8blVTaw=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=FF+s0BpJ/LSj+nf3wR66Ixm6kefAqja9n/FmuprwniZ7lFoZp6fCjtj4bFexkT7qw
	 vVPBosOVd5lwK3Kw+aFpYJaQg7j7NFk4xcEtfVFPaNK23oA5DbBNFGGmvwP+kp/zC1
	 qHIiD1B/BP6ehMhJUyFanZbx4101OaLIP1g0n02Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240207042243epcas2p1ac78a64d3306eafdf5de4ab77faa5fb2~xeeYeJ0kc1480014800epcas2p1f;
	Wed,  7 Feb 2024 04:22:43 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.90]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TV6R36WZmz4x9Q9; Wed,  7 Feb
	2024 04:22:39 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-ad-65c3058be231
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	20.AC.10006.B8503C56; Wed,  7 Feb 2024 13:22:35 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v2] perf: CXL: fix mismatched cpmu event opcode
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
Message-ID: <20240207042235epcms2p358e40f0409e25bd9e875ad1ae0dd0764@epcms2p3>
Date: Wed, 07 Feb 2024 13:22:35 +0900
X-CMS-MailID: 20240207042235epcms2p358e40f0409e25bd9e875ad1ae0dd0764
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdljTXLeb9XCqwcLD2harFl5jszi6h8Ni
	0+NrrBbnZ51isbi8aw6bxdLrF5ksWu6YWmy8/47NgcNjzbw1jB4tR96yemxa1cnmsXlJvUff
	llWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE
	6Lpl5gBdo6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2x
	MjQwMDIFKkzIzrjQeJG14Ad/xat3S1gaGDt5uhg5OSQETCQe3OphBrGFBHYwStzole5i5ODg
	FRCU+LtDGCQsLGAv0X+5hwmiRE5iz4nzLBBxDYm13w+zg9hsAmoSC+9fAhsjIlAlcf39U6B6
	Lg5mgW1MEn8fLmWE2MUrMaP9KQuELS2xfflWqLiGxI9lvcwQtqjEzdVv2WHs98fmQ9WISLTe
	OwtVIyjx4OduqLiUxKe7m6DixRKz9y+DihdIrPixCGqXvkTj9fdsIDavgK/E4f3r2EB+ZBFQ
	ldg+twaixEVi6843YOXMAvIS29/OYQYpYRbQlFi/Sx/ElBBQljhyC6qCT6Lj8F92mKd2zHvC
	BGErSezvaIU6RkLizonLUMd4SDyct4INEoKBEovXbGeewKgwCxHOs5DsnYWwdwEj8ypGsdSC
	4tz01GKjAkN4zCbn525iBKdKLdcdjJPfftA7xMjEwXiIUYKDWUmE12zHgVQh3pTEyqrUovz4
	otKc1OJDjKZAD09klhJNzgcm67ySeEMTSwMTMzNDcyNTA3Mlcd57rXNThATSE0tSs1NTC1KL
	YPqYODilGpj2Js7f98Ig+LfHbZmfVcWrLrcueh40Q+xkZJe9fl6JF2t0/bqDLO+Lru5+aXta
	P/Ow0cN1pk1MJvzHH09SPCldxF21zOPhOa4Lk5sYWTgmfzm/Mis80PWsyBPvoCZ3VZ2Ti7Q8
	DaLVp66Zsea30u67y0Syf3+6s3jB72yH7pLZOi+enbJ7xHagdNr/Rtu+jT8TChT109/eXRlt
	aHNg/Yxl8/sk18gZpZx90++6xWh5kMTX5ENdd9/6d9esfM+QNGN2VDXjqqjuTPflgdWLkyT7
	mO2cpA5F8Qh5unBvjrqYcnlNdmzY/F9+re8KV8xKSWs+/EGynGv/pMY43ZhVkxv35XT6JPDz
	ba6JMvdcxqfEUpyRaKjFXFScCABTg7sOHgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240207042235epcms2p358e40f0409e25bd9e875ad1ae0dd0764
References: <CGME20240207042235epcms2p358e40f0409e25bd9e875ad1ae0dd0764@epcms2p3>

S2M NDR BI-ConflictAck opcode is described as 4 in the CXL
r3.1 3.3.9 Table 3.50. However, it is defined as 3 in macro definition. Also
adds s2m_ndr_cmpm for bit 3 that was added in CXL r3.1.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
---

Hi Jonathan,
I've modified the commit messsge and code to reflect you mentioned. Thank you!

Changes since v1:
- Add s2m_ndr_cmpm event attribute (Jonathan)


 drivers/perf/cxl_pmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 365d964b0f6a..d85d53d907a6 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -415,11 +415,12 @@ static struct attribute *cxl_pmu_event_attrs[] = {
        CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_curblk,                CXL_PMU_GID_S2M_BISNP, BIT(4)),
        CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_datblk,                CXL_PMU_GID_S2M_BISNP, BIT(5)),
        CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_invblk,                CXL_PMU_GID_S2M_BISNP, BIT(6)),
-       /* CXL rev 3.0 Table 3-43 S2M NDR Opcopdes */
+       /* CXL rev 3.1 Table 3-50 S2M NDR Opcopdes */
        CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmp,                     CXL_PMU_GID_S2M_NDR, BIT(0)),
        CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmps,                    CXL_PMU_GID_S2M_NDR, BIT(1)),
        CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpe,                    CXL_PMU_GID_S2M_NDR, BIT(2)),
-       CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,           CXL_PMU_GID_S2M_NDR, BIT(3)),
+       CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpm,                    CXL_PMU_GID_S2M_NDR, BIT(3)),
+       CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,           CXL_PMU_GID_S2M_NDR, BIT(4)),
        /* CXL rev 3.0 Table 3-46 S2M DRS opcodes */
        CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdata,                 CXL_PMU_GID_S2M_DRS, BIT(0)),
        CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdatanxm,              CXL_PMU_GID_S2M_DRS, BIT(1)),
--
2.34.1

