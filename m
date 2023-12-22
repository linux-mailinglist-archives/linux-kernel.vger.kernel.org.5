Return-Path: <linux-kernel+bounces-9413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF6381C52A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB421F26201
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82247B664;
	Fri, 22 Dec 2023 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eNRT4Ptp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2F8F7A;
	Fri, 22 Dec 2023 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM3ejg4030490;
	Fri, 22 Dec 2023 06:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=C4woOBELh4mJQQo37VyG8Bj8eUCeG5gRVPhmz4yuOWw=; b=eN
	RT4Ptph6snWoOKqhe7iYO1k0PuPc57/Q0kWPdjQCuJbWUVwti2TgdNVQEhV4dGMc
	bRtsEwa49/EOpZzEw1JqeTuI78iTHKcSk3xXJ4bZwx8fvqkLzJdnRjGNIJQkqGog
	e1Q5KpIwXuE8pgUKMJbyh2KZl44tppzxaIhnlbvWbN0dYQ1UZsUWRX6KwGKC2XhK
	LbvlM2kH1sWzCxfXl9WvzCtzIP4DGlm5LTXGYG7ZWsaHDDpA+DObYi7DuglsdQZ5
	hBUQrcj0n/EYTnnE9XyF/ygdTafA532KIG3X4HY0perPW12kcEfoC8PLrB5IhMcK
	KvMDJPPeKAhTJrA4i/LQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4xe50t4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 06:34:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM6YJSM024535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 06:34:20 GMT
Received: from [10.216.61.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 22:34:15 -0800
Message-ID: <f8a82897-f1e0-4440-a04e-2b32b9e8a8d5@quicinc.com>
Date: Fri, 22 Dec 2023 12:04:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] The high speed related interrupts present on QC
 targets are as follows:
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, "Andy
 Gross" <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Conor
 Dooley" <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>
References: <20231222062720.10128-1-quic_kriskura@quicinc.com>
 <20231222062720.10128-2-quic_kriskura@quicinc.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20231222062720.10128-2-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mNi7OXZtnhIUHFkKys0I24oih5q6wZi1
X-Proofpoint-GUID: mNi7OXZtnhIUHFkKys0I24oih5q6wZi1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 mlxlogscore=441 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312220044

My bad. Please ignore this patch.
The commit header got missed in this patch. Will be sending a v5 
quickly. Sorry for the hiccup.

Apologies,
Krishna,

