Return-Path: <linux-kernel+bounces-37670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D80383B366
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEF81F23DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12011350DB;
	Wed, 24 Jan 2024 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zdaom4Bl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B125F811E4;
	Wed, 24 Jan 2024 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129862; cv=none; b=eh3tW19Ud5ZUeMVPHV2DfvAJxwTAUzKXCs++nPKvUUekmVr0tsMXkixF16/6BNjaqHQOO9f9G9tmgATjQfNmeJpbxzH0/RzXzGKX7/9MID2kPty/yoLbusDTjuUuij2OkgJJDK4RyC9IIFAcQdS4KobhKtr3oTmFE7ZMPzxHPrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129862; c=relaxed/simple;
	bh=H1xEbd9zzwHNfjrx1DrQsztSJNREWKYjWs+YmjUUQ0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XV4D+IhgE03GBSI1m9cUyNnVKkpNdeQB5djPU7alE0vqKqIVF1+VYA/7g8cqPwGLSvsVrWosu5SnmCHEPbVqo/XjrKl6reLeGOAfpqKgPyMaxvBiNfCaMFqrwO3C3s/7wxEsN8dYEzsp7ld6yjvr24v8gjpSCP1G+YLbNaMSBmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zdaom4Bl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OKZIXw032422;
	Wed, 24 Jan 2024 20:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=D7PW03wxf6isXJvyOR/aX6S/q04NxOKTyXvKD94SUes=; b=Zd
	aom4BlZzx86dNbGMDcdBPZskuxffsXcvO02Mhd+WRN4whk9qnpJure/wS58DMwuv
	1t2jSnkxZI1ioym/zrQib3vGfOpjAGeKSlnDVMkNuV38isG7OAvGg1QEWc6t4jEQ
	qIGja+vZ7Yzo167AnRh1xl7itgZZdteNWdtcWAM/ImbZCtajov4mKRVC0RICBYi7
	51hqdGwgWCLCTV2+ykxaEeeyQ0dHiYUz5IGjAIsq8+i5zyzfWzp0ZBD3kbV66DnK
	ngegwG+Biw+JJHl6jQQ5xDSOCio99C52pyAlmhSW0lx8RD28PeQddnCKd7UYMgr0
	Ib4zUp96vNhWMbF4OpUg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vu6j2rj0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 20:57:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40OKvXCp009997
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 20:57:33 GMT
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 12:57:33 -0800
Message-ID: <64e98fc4-8c4f-6a19-929b-e9a37b7d1431@quicinc.com>
Date: Wed, 24 Jan 2024 12:57:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: aoss: Add tracepoints in qmp_send()
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240123-qcom-aoss-tracepoints-v2-1-bd73baa31977@quicinc.com>
Content-Language: en-US
From: Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20240123-qcom-aoss-tracepoints-v2-1-bd73baa31977@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r9ZsZ_oaZU8FFv-mn670ze3sZzylWbPY
X-Proofpoint-GUID: r9ZsZ_oaZU8FFv-mn670ze3sZzylWbPY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_09,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=954 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240151



On 1/23/2024 7:40 PM, Bjorn Andersson wrote:
> Add tracepoint for tracing the messages being sent and the success
> thereof. This is useful as the system has a variety of clients sending
> requests to the always-on subsystem.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> Changes in v2:
> - Corrected copy-paste error in include guard (now _TRACE_QCOM_AOSS_H)
> - Link to v1: https://lore.kernel.org/r/20240117-qcom-aoss-tracepoints-v1-1-4f935920cf4b@quicinc.com
> ---
>  drivers/soc/qcom/Makefile     |  1 +
>  drivers/soc/qcom/qcom_aoss.c  |  7 +++++++
>  drivers/soc/qcom/trace-aoss.h | 48 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
> 

Reviewed-by: Chris Lew <quic_clew@quicinc.com>

