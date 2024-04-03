Return-Path: <linux-kernel+bounces-129438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEB1896ADC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA21B2C4AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280ED135A44;
	Wed,  3 Apr 2024 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IYQR2xtT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF386F085;
	Wed,  3 Apr 2024 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136984; cv=none; b=bxY072x/HOUWQFY8cXagx49SZlOeBalFDGvXzKntPWDFYlC4F0c9CEgE0dbGx9cuz2RtPYRok5+UskC62V2yY/BtVcSnpT3wZzG/vmqKjCPQAwVAsuvJd4KB1xiD3mL42um7Ob3+INdy/dNJjx/qEUrLom8g4hjxaXuu9TRaLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136984; c=relaxed/simple;
	bh=Tcq6waVhu6x2uDMgdHob45eXvXyBR13IKWESGleO5QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CPMgbEsTeZd5R2Fyfqhln2oDhs0F6FqvBq98jeoOS1x31+s6MRsQw+Fc31zBC7gx3NmrpZGEQALKCevz/Sljm6PSSyXmwyL6aiJjYBZ/fCYJk6BP39QvzhH7kCl1ASjhW61OCWiX3QO64o0DTqoIPTfmeizoxJ03HhGPHc0MBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IYQR2xtT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433957Hi031954;
	Wed, 3 Apr 2024 09:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Qut8GT9o136iegY3V8uUsXMS6TUkzgV1SykQRe77Q5Y=; b=IY
	QR2xtTOWmpHRTvQOxsTjsECk6T4hfI1RxVZmH5wDG7heVeBwI2R9eTVRYCiMYvtT
	sn0ymhIrzBXtrycPZ4pfxFW0Bo3oU2Di73v46+juaRjKBJgUGdYS2bSm1LTxQmg5
	mtOqcZd0Y2eKXIueO3+TU1xdZA0wNYMpHlCKCCIm84JMviBTY1AMJnfKAPLWHvNx
	6cSwasdsKm5Ko+0qJ4FgZAzhxrnPQUTuyGyYcnukYkasH2toiYXmKtWyqEI8BcCu
	GXkRZsgTE5AxG3Q1vN3cgq/y1KB17OrIxUETbeYuSbFFzGp4PdDJI/yA6No55r9P
	gHOOQ0EuP7rX9GcBeoAg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x946002nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 09:36:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4339aHIL004891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 09:36:17 GMT
Received: from [10.217.217.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 02:36:14 -0700
Message-ID: <dc19ba7a-ee4b-48c1-ac8e-224077526039@quicinc.com>
Date: Wed, 3 Apr 2024 15:06:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcm6490-idp: Add change to name the
 regulators
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_kamalw@quicinc.com>
References: <20240329122940.3649730-1-quic_uchheda@quicinc.com>
 <20240329140534820-0700.eberman@hu-eberman-lv.qualcomm.com>
 <fvep7awia3eqlavh4ksscig4x2yc2szpy2uoi2p6ueofimv5ch@km4aekplcys5>
From: Umang Chheda <quic_uchheda@quicinc.com>
In-Reply-To: <fvep7awia3eqlavh4ksscig4x2yc2szpy2uoi2p6ueofimv5ch@km4aekplcys5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bUMKvSbmkLr76X2yZIpOpBRPo_n8IFhB
X-Proofpoint-ORIG-GUID: bUMKvSbmkLr76X2yZIpOpBRPo_n8IFhB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_08,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=878
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030065



On 4/3/2024 9:22 AM, Bjorn Andersson wrote:
> On Fri, Mar 29, 2024 at 02:09:55PM -0700, Elliot Berman wrote:
>> Nit: the subject line should be:
>>
>> arm64: dts: qcom: qcm6490: Name the regulators
>>
> 
> Much cleaner subject, but no longer matches file prefix.

I will update the subject line to:
arm64: dts: qcom: qcm6490-idp: Name the regulators

> 
>> I don't know if it merits a resend, though.
> 
> Yes, please.

Ack, will update the subject line as suggested by Elliot and Resend the patch.

Regards,
Umang

> 
> Regards,
> Bjorn

