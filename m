Return-Path: <linux-kernel+bounces-90927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBEA8706E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27DC1F211A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5394C60B;
	Mon,  4 Mar 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KXq3IymV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D88828;
	Mon,  4 Mar 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569259; cv=none; b=ifeOdebCAsCjhde7mWb0vp4dkMUov39AWlFkZSh2yiz4Cb+p97vkUb2syHV41bqxIfcJrplndPlq32H0jrMeVuw0JzhSTnbP3lCr1lzTBiEW/s8cbeWTOpDWnaC4k7rORQRndwZpeQ1uIwpoPjhZj/tPRPWMkgqAiuh1RSyq0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569259; c=relaxed/simple;
	bh=xapk+o4LkyAtTFDuzK4KzFAFpaNguNxC/HJKXHpho3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iurY2f013ULYVF5d8OLkmkZqSZ9+LF3sdvCPKUXtGbzli6n836x+xDDPkJ4nC7Fg6TSv0o1Rk6GEMDTfdchwNEDkBBm5xTt8orz8+Ne15eqS4alrH8FCBGfgJeI53RvAARaFCU9zOSRNlPVyGbYmDFOkZ2UVEybrZJLZIKzNudU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KXq3IymV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 424Fsxhc009372;
	Mon, 4 Mar 2024 16:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=luqHtL/ifKsi3nTud2EGsB27luGkQ9iJ6ha/rabF93Q=; b=KX
	q3IymVHDBcfO3aNTpYLA/RnZpS3SgJaM52SKpeQWuLt7TBK4icMN5Lsu9CeQK3rJ
	QhJNMVIO7wMuWNE11DKn0tSWqZ3aDbf8GkktOPKrgj96frRbMShx5eBiYtBNpr5c
	/QvTNJ1CTw1++xyejcMkbUHPNsGQwN+NDBrJ+d76b4YQ3YEz0HGCUnR22rPqmVQV
	EW1MhIV6rZ6zFil/KTALV4LHM/iMLH3/S35EPjjTJmniG+/iMVLX2Xxa9wZWUE1p
	q7y5Sjxmg1GnUx9ULkKBDBESVS6G3o9813o+7i1IMzBg27yL9L4InsLoM8aXoj32
	e/lC0JiwllIWI7hZYXjA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wn96es50n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 16:20:53 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 424GKq9I010201
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 16:20:52 GMT
Received: from [10.216.35.58] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Mar
 2024 08:20:49 -0800
Message-ID: <9fbe1a2c-6d2b-db4f-12d7-e7136ad9cce1@quicinc.com>
Date: Mon, 4 Mar 2024 21:50:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] firmware: qcom_scm: disable clocks if
 qcom_scm_bw_enable() fails
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ajCwg2s2cw4P9sbVTOMmlQFzXFIY6e-w
X-Proofpoint-GUID: ajCwg2s2cw4P9sbVTOMmlQFzXFIY6e-w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_12,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1011 mlxlogscore=859
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040124



On 3/4/2024 6:44 PM, Gabor Juhos wrote:
> There are several functions which are calling qcom_scm_bw_enable()
> then returns immediately if the call fails and leaves the clocks
> enabled.
> 
> Change the code of these functions to disable clocks when the
> qcom_scm_bw_enable() call fails. This also fixes a possible dma
> buffer leak in the qcom_scm_pas_init_image() function.
> 
> Compile tested only due to lack of hardware with interconnect
> support.
> 
> Cc: stable@vger.kernel.org
> Fixes: 65b7ebda5028 ("firmware: qcom_scm: Add bw voting support to the SCM interface")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Based on v6.8-rc7.
> 
> Note: Removing the two empty lines from qcom_scm_pas_init_image()
> and fomr qcom_scm_pas_shutdown() functions is intentional to make
> those consistent with the other two functions.

LGTM..

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

