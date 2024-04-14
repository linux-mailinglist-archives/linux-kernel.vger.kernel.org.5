Return-Path: <linux-kernel+bounces-144353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED708A44E3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 21:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158C61C20CD1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B376C136997;
	Sun, 14 Apr 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OmS1D4l4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5CF135A75;
	Sun, 14 Apr 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713123123; cv=none; b=Pd7HGHx5I/oCSnYPEOKJKLv4pTv1bhU3x8JeE8toxzjnKlXSB4Fse3RaP0+ubtduy2R3LI7JW9d83qEkp4SKldZzrKDdl3K6h1aO+aYQ6zMLFrK1kWg6ILdusZiHsgEb++kgqtnG4md2UfJgBswlOWgSpMTlDRXTXAMV+AMbsB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713123123; c=relaxed/simple;
	bh=4hVe1msDqYXAoKQ28JxOMcWAKonmNm7OOzOK1/G9c6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=e1RF9Q8HL6KtKCw9Uu4tL3gd9XVWTLg+P66fWoCcEpZQWK+2ABowZHon2qYeGjGxNES0f2xUPr1/dHO7460QeFRdYiMI+ymGo2c1ohrr+KxrJYBMlF27fcNJ6IJdAzwWzZ3AYjXiS8GiBYxILA1aGpd4/AmSJZ6zpJIpfchWSMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OmS1D4l4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43EJSY7l012744;
	Sun, 14 Apr 2024 19:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=zKTLKTw5l0AX+U16UvtK38C4in2uHJEeDuYt0ZBJ/sk
	=; b=OmS1D4l4wAnwoe3N5exr7FIYK5I7bnoDoy+2ekgNl42UwZyGrEotgl+3C/D
	7vybfzSGZlqScgpsqZS6kqw1aaeldUdBN5d56SQ4RX0rS68ktKx6Q2xYgEyLL4cd
	OxTtwSdzbL/ilF7oIx03xxnidl1Y+d3FfpHZcd2relC1Ec4AJIOXOrPZc7zo7dG2
	JS6Rhe+/IMPnSOvgxT23lS1hxxEvchCQd5FtCDgiWrB2HoKM87bzAXPNhqfLG8sh
	Tp6GU319QO3J3nbo+VzBU2Cwf0osytG8FB/7V1CX9TE1GLp/rxHtppugZMGXPhfG
	Acc5yDmyxtwKEk/karcZlpfU6BQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfh0wt9wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 19:31:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43EJVc7r023182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 19:31:39 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 14 Apr 2024 12:30:31 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Sun, 14 Apr 2024 12:30:27 -0700
Subject: [PATCH v2 4/4] arm64: dts: qcom: Add PSCI SYSTEM_RESET2 types for
 qcm6490-idp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240414-arm-psci-system_reset2-vendor-reboots-v2-4-da9a055a648f@quicinc.com>
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
In-Reply-To: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
CC: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vU-ZoGUfNMIciOgV6Xlw2HowjVpU46vB
X-Proofpoint-GUID: vU-ZoGUfNMIciOgV6Xlw2HowjVpU46vB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=850 impostorscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404140142

Add nodes for the vendor-defined system resets. "bootloader" will cause
device to reboot and stop in the bootloader's fastboot mode. "edl" will
cause device to reboot into "emergency download mode", which permits
loading images via the Firehose protocol.

Co-developed-by: Shivendra Pratap <quic_spratap@quicinc.com>
Signed-off-by: Shivendra Pratap <quic_spratap@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index e4bfad50a669..a966f6c8dd7c 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -126,6 +126,11 @@ debug_vm_mem: debug-vm@d0600000 {
 		};
 	};
 
+	psci {
+		mode-bootloader = <0x10001 0x2>;
+		mode-edl = <0 0x1>;
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";

-- 
2.34.1


