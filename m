Return-Path: <linux-kernel+bounces-56895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D1284D0F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72EF01F2282E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8A812F38F;
	Wed,  7 Feb 2024 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cHpzZGOe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A7E83CD2;
	Wed,  7 Feb 2024 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329402; cv=none; b=WM8MDSSkCL5KXvz2k5MW1Sbyx+xAY4Z9dSG0l1WNjLNoBP8WWfGc04HsQxo91T6GHUFsaUpgkJbwLjYUPqA6tzAqP6cDN3NXes0Q9Mnk+8pw4PKKb1Uz9QE60liwMR6O7k3ICzHziZBS2a+yeDgyoUz2sUvuo19q1z4XA8XX4CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329402; c=relaxed/simple;
	bh=PZhwfw3yFoBnmTr5KEskYLgTZtjV2a5wBbQGa0szcWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tbr76eMgEpfWfelUAMyZoMJNoBa8wR6LV4QmItPqjIXaqvsUoa/X6nNF7pRaCYcz5Be84bfgkwc36RyHOyO//i8axMLTNzjIOWwPhYY65aR5tuSUbrQj8obLgc0HPRfY1aTrNNbSasM/iYKOr4e08KpEfZLjCd2pSfewAwHQYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cHpzZGOe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417GixPD004624;
	Wed, 7 Feb 2024 18:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VRwwrWgHIcGNWJXD2OwHm/m6fXi9xzKbfg18D7NF6nI=; b=cH
	pzZGOe2yWgX4wM9d9QOSAQ9hVZfponNfCuEF6cUksSdzxyG65zvBsfBXCKo/19hG
	2vHm4WWWb3buUq2CihCGUIWo1pm/2ls99IRL8rKG+MZ2eV7mT9heu2jUJ4DIdfWi
	yoOXpjexYhhPU6977o2P8kcGpTibUAkM3C/DEhKR+YiPAtzCoizmhoFOKQcCbMxT
	m/9WGbz7BqbgtOCx+ijqL+rZG3AAjIeDg6rmV1riOQnQSXi01PUe4n4akdVpczSQ
	NdwRgouaXHihYuDizUaKF9VvY2CoJu1u/B3UmPM7zayKpmVL+olm0pzY0ipwnBmu
	d5SKvEViZHs65w5lG6iw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3x41t41q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 18:09:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 417I93r7011560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 18:09:03 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 10:09:02 -0800
Message-ID: <883d5c25-e607-bfe7-1fc1-cad86e828be6@quicinc.com>
Date: Wed, 7 Feb 2024 11:09:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] bus: mhi: host: free buffer on error in
 mhi_alloc_bhie_table
Content-Language: en-US
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: Kalle Valo <quic_kvalo@quicinc.com>,
        Carl Vanderlip
	<quic_carlv@quicinc.com>,
        Sujeev Dias <sdias@codeaurora.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Siddartha Mohanadoss
	<smohanad@codeaurora.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Alexey
 Khoroshilov" <khoroshilov@ispras.ru>,
        <lvc-project@linuxtesting.org>, <stable@vger.kernel.org>
References: <20240207134005.7515-1-pchelkin@ispras.ru>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240207134005.7515-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TGyWmJChje4FlG2rHaPHG3yk2Tldqovb
X-Proofpoint-GUID: TGyWmJChje4FlG2rHaPHG3yk2Tldqovb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_09,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=685 clxscore=1011 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070134

On 2/7/2024 6:40 AM, Fedor Pchelkin wrote:
> img_info->mhi_buf should be freed on error path in mhi_alloc_bhie_table().
> This error case is rare but still needs to be fixed.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 3000f85b8f47 ("bus: mhi: core: Add support for basic PM operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

