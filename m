Return-Path: <linux-kernel+bounces-38136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4723783BB53
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B8F28B423
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BB417582;
	Thu, 25 Jan 2024 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fY1i3K6J"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A060717753;
	Thu, 25 Jan 2024 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170226; cv=none; b=HIw65tNWOKU7yAx2LjpZ2XDRm6MV8lDNZLNbcdQA+oBzpEJh3vqPjTE4pVFhOHLSlDqe119uwREnHBTro2FE7jGD/aHnMl9rtQCGrQw94QrLxfyoupxPhtLfIEVzJboA0WqU40zEDPxZQRnBpjD+vDN7G4W76WSYJDxHjAgMec0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170226; c=relaxed/simple;
	bh=xX6dfMVAAl26JdXVEmOv1Zgk1LFWe/cS2pQ7+3/KTmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rIgCHs+eg9Y8CxDRHMCv0RoOYlIIvli7aJs7dyNbUW57V//9dcGDap3FF1XUZmEzdss+g1hiLqX70+wgXQhHrEfmJD0BKItKeMzzSues5AKDoY2YUKkxLeqGnm/2knPpT8HDXeQk8/3fRQl2gN2apJI7GlFc9qK1pcDJq74I5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fY1i3K6J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P6RwgH009598;
	Thu, 25 Jan 2024 08:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=82RcTBntBxCMTFQR0KeZzqWngRbmEZfz5tqmRVi5d8I=; b=fY
	1i3K6J/tgZ+C1J2XhaDrMR5KmOIvh0q74NgCj/O8nvmXW9zOFfNFM11K3ayjzQVy
	PttmnCyY1VRJHOFzSbAYACRNgi6SPTkoQCn45hHX/8LlHfXmasEk2RiXvmq2ZO0N
	XFaQWWNdaQ5APt/RQpkwjF0MTZO5MJMfkMrRGNkQ3PUAeOZDMvLSR2QMYIc0qMpl
	pLYdogWXAllaJrHlGHlN8Kjbvm3VJM+6YqfpM2taBRSrXjBh4PvX2EHq9Xrk7/r2
	NvoF/EAaWjyvdOKPLvbOZUvY+p5ZDE9fQCFxpqY+SzEMDbBRNzCEYtRsHxfItAAL
	c0OQBwW+HySs6wCHXfjw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vu1ccjk5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 08:10:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40P8AJP0021848
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 08:10:19 GMT
Received: from [10.218.5.40] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 00:10:15 -0800
Message-ID: <735575f5-ee46-4c91-b0bd-e9c6fb97361c@quicinc.com>
Date: Thu, 25 Jan 2024 13:40:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] arm64: dts: qcom: qcm6490-idp: Add support for
 PM7250B PMIC
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kamal Wadhwa
	<quic_kamalw@quicinc.com>
References: <20240123102817.2414155-1-quic_uchheda@quicinc.com>
 <CAA8EJppwboaEbKFFACr3LO0OHg4iOJPapKRqoH2EGEYcjV6HfA@mail.gmail.com>
From: Umang Chheda <quic_uchheda@quicinc.com>
In-Reply-To: <CAA8EJppwboaEbKFFACr3LO0OHg4iOJPapKRqoH2EGEYcjV6HfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PEOyn16eRRCZQsONcqP-fwK7-WekyvX7
X-Proofpoint-GUID: PEOyn16eRRCZQsONcqP-fwK7-WekyvX7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_04,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=509
 clxscore=1011 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250054

Hi Dmitry,

On 1/23/2024 5:48 PM, Dmitry Baryshkov wrote:
> On Tue, 23 Jan 2024 at 12:28, Umang Chheda <quic_uchheda@quicinc.com> wrote:
>>
>> qcm6490-idp platform supports PM7250B PMIC as well.
>> Add support for the same.
> 
> The platform can not "support" PMIC. Please fix the commit message.
Shall I change the commit message as below in the next patch ? 
"Add PM7250B PMIC support for qcm6490-idp"

Thanks,
Umang

> 
>>
>> Signed-off-by: Umang Chheda <quic_uchheda@quicinc.com>
>> ---

