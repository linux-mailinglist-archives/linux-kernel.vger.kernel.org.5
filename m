Return-Path: <linux-kernel+bounces-69553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F3E858B8E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BB11C22CFF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6611A78B4B;
	Sat, 17 Feb 2024 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YhMXet2J"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A640149DE1;
	Sat, 17 Feb 2024 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128662; cv=none; b=ADE+9GeR7A5Pm6MthVA1enWWyT2n5UXi9YkLOdfz3cc73UHbpYazXFhjOoypruj+D4JlOHvygGPbAcHqX+SWIU6rHrE7p4uiCJzf5R8M1nDoCnr/gBb6XkDbYS4i0tvSYkTwiZJSTR1MFmjqibdEMMFdpQDnLXoInCEfyrySDnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128662; c=relaxed/simple;
	bh=irvpJAWyfYNQcdfNO9eBX7aEjGvO1TfGb3rNzRGKzbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dy4ZwZCpGnoBrpix+1kzsPlZSrMMMnuejZNVBIQJ3pyZ85IxN1IBqLLD4gLePv+tddYWW3Qp59ScxUeVOshmRdetlGtAMgFm2YlohMJHjLpR+v1vYMyCOKciah/lc1cx3cMAM53VCFPk4QNlv8+2cgaQfYuctH2w4tn9Qdk7Uts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YhMXet2J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GNMLXI001167;
	Sat, 17 Feb 2024 00:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=gnJwXYlppG20lIVQdlnZ
	4yd3yQRuw/0NNcN3kah4t3c=; b=YhMXet2JHFujcZpg+cbrnUiR5gvePgXuOGyd
	meEjtL+m/dEOlt+7PnA9SEUFFe01v4TV+tk1LHZvnHAflFDW1ZjZPslJUNObQiwf
	M+c/QrQZmj0zhPduUKpkVj3m2C8wOrmJZyKSoemAblt3mlM9pFykkXsnDkfDFG/X
	DptUcZHbXnvJ/Slo3L97EfD7sHHQM11+B6xgRQQhnRAWsDWaCUIrxQ+gaj1nBd4R
	Gf78Yw3/pl7a8qyEUQ4A+SVrgZINkQX/7+QdojBBaUSDeFjhaEdjnQBCDJ5OIZn0
	81wlMnctvAU9jIc4DTigCeO+8AOF21shXSbNsNcMb1xHGRAfIg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wa61nhekc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 00:10:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41H0Ah7D017459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 00:10:43 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 16:10:43 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v17 49/51] ASoC: usb: Rediscover USB SND devices on USB port add
Date: Fri, 16 Feb 2024 16:10:15 -0800
Message-ID: <20240217001017.29969-50-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240217001017.29969-1-quic_wcheng@quicinc.com>
References: <20240217001017.29969-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DUA76mdZHjM0lWv1u10dqn0UOxarpnxB
X-Proofpoint-ORIG-GUID: DUA76mdZHjM0lWv1u10dqn0UOxarpnxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_23,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402160189

In case the USB backend device has not been initialized/probed, USB SND
device connections can still occur.  When the USB backend is eventually
made available, previous USB SND device connections are not communicated to
the USB backend.  Call snd_usb_rediscover_devices() to generate the connect
callbacks for all USB SND devices connected.  This will allow for the USB
backend to be updated with the current set of devices available.

The chip array entries are all populated and removed while under the
register_mutex, so going over potential race conditions:

Thread#1:
  q6usb_component_probe()
    --> snd_soc_usb_add_port()
      --> snd_usb_rediscover_devices()
        --> mutex_lock(register_mutex)

Thread#2
  --> usb_audio_disconnect()
    --> mutex_lock(register_mutex)

So either thread#1 or thread#2 will complete first.  If

Thread#1 completes before thread#2:
  SOC USB will notify DPCM backend of the device connection.  Shortly
  after, once thread#2 runs, we will get a disconnect event for the
  connected device.

Thread#2 completes before thread#1:
  Then during snd_usb_rediscover_devices() it won't notify of any
  connection for that particular chip index.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/soc-usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-usb.c b/sound/soc/soc-usb.c
index 53c4e399909e..821caff2061d 100644
--- a/sound/soc/soc-usb.c
+++ b/sound/soc/soc-usb.c
@@ -554,6 +554,8 @@ int snd_soc_usb_add_port(struct snd_soc_usb *usb)
 	list_add_tail(&usb->list, &usb_ctx_list);
 	mutex_unlock(&ctx_mutex);
 
+	snd_usb_rediscover_devices();
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_usb_add_port);

