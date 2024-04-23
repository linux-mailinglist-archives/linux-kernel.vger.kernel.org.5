Return-Path: <linux-kernel+bounces-154871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFF38AE23E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5FCEB2146C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF2B626DF;
	Tue, 23 Apr 2024 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CvnlVTN0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DE2366;
	Tue, 23 Apr 2024 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868435; cv=none; b=K8KF4X0ITukmhpTLibQlDgkZUlqivkCHu8wRMhJY0Y5aMCfGiz+ZnGZ9HnMz2S76+xbdVnnku9jkEB2PE2LumtdbKdCVbPSjBS/b0GxoO9LnVedFfZEdOPYwNrskrENVi8l7xmneI0vBybiDdZ2piSjx7fP49S5zZZkAF/jUN+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868435; c=relaxed/simple;
	bh=/bZ82DGC6U3HDWawM1cRynxpD3o8hqyuB863UbXFOnQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=M5JWzraIn3yPhCER3D7hDZ8mObomYOcTAD15i4yvaxktm1HqjItfOReSnzR+BAyutKa1l6t5wYax02DE7ODX3TSVFJea34d90hLH9gUtBvrz0VncPJM9FZaOTydXawHLqddNKx5jmiZ/FuruzEPoEEZ6oab2Xlll4TxKEYEmrnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CvnlVTN0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N6wd6I005564;
	Tue, 23 Apr 2024 10:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=7AnI/uyFKC4S
	KaAb9v8+z/bzOcA9CJ07KJFIVbSQ0dk=; b=CvnlVTN0IqKTZ+t2HqjL6Fs9IALs
	QCtIrz5KPIgjotpYTiaLcNly+G+9iXiXlFVUdjHjcYLfsiCy1hOvmBpeQia+ft+q
	FXPjdXKpDsr9DIDIeoyVsJ7kQyfTwEwpIw65OXxmFuEpFZGQvB60RsL6leDaiy62
	JCs2/EJx+AevZ8dTvWMsj4bBJrFPDDOaoL6/B+zyR/3Yc5CeTmTQXFDDXLXZfVJW
	unGNbf//HCZyUmWCGq7CpIxAfp+TJmwpAFYSX/t/P6gxzj7yCtjMqk9zYqwhAZRY
	PrXLTg9DokZ5rbZb1hSZB24Ktic4jrxDSMONZntClcwkFwvn8HkOy1Wqtw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp855rfe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 10:33:43 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43NAXe04003599;
	Tue, 23 Apr 2024 10:33:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3xm6ske0b4-1;
	Tue, 23 Apr 2024 10:33:40 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43NAXds2003594;
	Tue, 23 Apr 2024 10:33:40 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 43NAXdc4003592;
	Tue, 23 Apr 2024 10:33:39 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id 110BB5B10; Tue, 23 Apr 2024 18:33:39 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v4 0/3] Add sysfs entry to EDL mode
Date: Tue, 23 Apr 2024 18:33:34 +0800
Message-Id: <1713868417-37856-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VEGPX3RHhgsvNvn6wVjWPSZMk1EdjcI4
X-Proofpoint-ORIG-GUID: VEGPX3RHhgsvNvn6wVjWPSZMk1EdjcI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxlogscore=836 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230028
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add EDL sysfs entry for mhi controller that provides edl_trigger callback.
Add mhi_pci_generic_edl_trigger for qualcomm sdx55,sdx65 and sdx75 as
edl_trigger callback.

v3->v4:
1. Modify some comments, commit message and sysfs entry description.

2. Add error cleanups if get channel doorbell offset fail.

3. s/force_edl/trigger_edl

4. s/mhi_get_channel_doorbell/mhi_get_channel_doorbell_offset

5. Use mhi_get_channel_doorbell_offset in mhi_init_mmio()

v2->v3:
1. Update Documentation/ABI/stable/sysfs-bus-mhi with description of
   force_edl sysfs entry.

2. Add comments about edl_trigger callback in mhi_controller struct.

3. Follow reverse christmas tree in mhi_pci_generic_edl_trigger.

4. Add a new API in MHI to allow controller to get CHDB address and avoid
   duplicating the definition of CHDBOFF.

v1->v2:
1. Move all process needed by qualcomm sdx55,sdx65,sdx75 to enter EDL into
   mhi_pci_generic_edl_trigger() as the callback to edl_trigger.

2. MHI stack creates EDL sysfs entry to invoke edl_trigger callback so
   that devices need different mechanism to enter EDL can provide its own
   edl_trigger callabck .

Qiang Yu (3):
  bus: mhi: host: Add sysfs entry to force device to enter EDL
  bus: mhi: host: Add a new API for getting channel doorbell address
  bus: mhi: host: pci_generic: Add edl callback to enter EDL

 Documentation/ABI/stable/sysfs-bus-mhi | 13 ++++++++++
 drivers/bus/mhi/host/init.c            | 39 ++++++++++++++++++++++++++---
 drivers/bus/mhi/host/main.c            | 16 ++++++++++++
 drivers/bus/mhi/host/pci_generic.c     | 45 ++++++++++++++++++++++++++++++++++
 include/linux/mhi.h                    |  8 ++++++
 5 files changed, 117 insertions(+), 4 deletions(-)

-- 
2.7.4


