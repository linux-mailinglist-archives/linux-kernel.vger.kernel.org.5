Return-Path: <linux-kernel+bounces-31876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C258335C9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A401282B77
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BBA10942;
	Sat, 20 Jan 2024 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b6qv0YjJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53D038E;
	Sat, 20 Jan 2024 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705777854; cv=none; b=DK4NBWNpgkgYQhGfQD3U6tvHwEh/fPs01BkmZBz/E7ibRS4eLV+PBe+NBmqq9cTu7HrU1CFY6BJzgSNnFuGdPrwHyz4/OP8firXe4UlmIYDEjVUqQ5r4cd09W445bLy2NpigGv3A82Elxl3N6gtN8M6t6E2j/kTbvyA/gyLCuuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705777854; c=relaxed/simple;
	bh=5b67qNmT8ovdAlyPlZflP/DjhI48KrRa1Ytn1JLEqSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rR8KYv8FlI6xppV1a/qFFAD/6G7dU4G4n3VqqpWgyRa0VDfpr280zh4YtjIFuL3W6H5Adw6t4ov2L/X837e5Mm+OqGAUKWQg9rPRa9nOLmHD2Xpbg8nOKQXtSNNldARIpfBnLJBhoQc/wwEt7+UUCcGhnJBosqSFYL2YIx3PdJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b6qv0YjJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40KJAngH013169;
	Sat, 20 Jan 2024 19:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=otwob6cs32dG5UDBoNGyI022yD3cQ7raIIQ+IY6hiuw=; b=b6
	qv0YjJngwpemfiacBkBK9Jjlb+aIjC4edF3nQKVTyXpJi+Qqnvby5pKEAL2Gw0Re
	J6cG+8X6CDkWY44HFJm+eXxKyDmqqgC16mqV0J2O5MqjhATr+j0L/lxz1K7TLTYR
	FKgBhzPxWpmC+vBjQCAS2PkQXkzXHnf24QMyxOR0kkSo/WpAi86I7Ubl6q32FTew
	QLNXVVmkcP+noyIviqjSJ4QyR/Ulw5YglK8q9WpjDRPoKuHgMKNIU/Wr1W7CY4Se
	MSL315PTjbEH6QdJ+bDOkm0Cvn/szs0yOqpvhq7d2s+cxGOUaWQ5WpO60C9+OICt
	bAHChT7CN4ayQRoq9X0g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr6d7gxam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 19:10:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40KJAmRm012906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 19:10:48 GMT
Received: from [10.110.32.149] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 20 Jan
 2024 11:10:44 -0800
Message-ID: <6e40dd60-884f-be23-0052-d14f7194f844@quicinc.com>
Date: Sat, 20 Jan 2024 11:10:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] dt-bindings: hwinfo: Introduce board-id
Content-Language: en-US
To: Amrit Anand <quic_amrianan@quicinc.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Elliot Berman
	<quic_eberman@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BBVM5LgkdQB1AVt_q61z26E9NFLJB9RV
X-Proofpoint-ORIG-GUID: BBVM5LgkdQB1AVt_q61z26E9NFLJB9RV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-20_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=436 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401200156

On 1/20/2024 3:20 AM, Amrit Anand wrote:
> From: Elliot Berman <quic_eberman@quicinc.com>
> 
> Device manufacturers frequently ship multiple boards or SKUs under a
> single software package. These software packages will ship multiple
> devicetree blobs and require some mechanism to pick the correct DTB for
> the board the software package was deployed. Introduce a common
> definition for adding board identifiers to device trees. board-id
> provides a mechanism for bootloaders to select the appropriate DTB which
> is vendor/OEM-agnostic.

Please extend CC list to more architectures? linux-arm-kernel, risc-v etc; since
the proposal below is not specific to ARM but any architecture is using the 
devicetree. 

-- 
---Trilok Soni


