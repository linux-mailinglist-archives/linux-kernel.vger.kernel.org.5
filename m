Return-Path: <linux-kernel+bounces-38550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B4183C165
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59403B22E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7720936124;
	Thu, 25 Jan 2024 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gKVCRgso"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C4832C60;
	Thu, 25 Jan 2024 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183784; cv=none; b=uP698p4/6TBEaq0nlaEfsGFGbIlEA7LI2j6yWJhueO0uDNOSLNOGGn6uxpvAbrPRui3N1yqH4uJYt1tqLhNDveEbkfe5pcNksOFo/WeT9m1byDnJ1/RqRp7WclRXU+x1ciyRElvj6P9f9V59swb8gmgjXeVjLVOCg+tpLU38Ii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183784; c=relaxed/simple;
	bh=pVYp9O+3KHP6dSaOJJFXlCGVAkTCRfiOR9NfQPXybOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tRx3iPU/E0iazpzqHNCjxzmTV/dOY5P/AEs58YMiEjxw5EsQqtOWCTCp1Q3gTb1doOcqThuZIrVRtEzh7rvEU0wvlMK7U4XSfPKgkmobChCD8HlTaJjTSN81xtpdtG7Rel8sGdg0mbgmoJcdcUTRgzS/OB0Wl5PZlZ6M1QMz9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gKVCRgso; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PAcfAl017102;
	Thu, 25 Jan 2024 11:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XsFxrNXnL0etd2WijQ0G7fSVz+PvUHKHNS9SOxeNwaw=; b=gK
	VCRgsomPCmnMsq1yd1QAQkr9dQpSf2ucCneJ3ltPLJ1ZJNzcCAguNaUWFy7Q47s3
	YOgRBrNfNx162ObprEGH/1NCjpSc+OyVGYTbDl5TbLq7QRkK0NnQ4J11SCLeLsX5
	KUODImWh8+Ulk6N5AYDBSJfb02R1Gf11icslmM29nDC0lJGhOIK5Y9uKikT6gJE+
	Sh/iMKdswqFZypRe2tjLZcRTbdgF218FMzV0bK5YFU7Qn14btzTsIgIPY7qeH5eC
	vZhXSwrbz2fUz436plkWf7vv4tkmaHeWP6bBXXaY7tz1rPQfcr6dya82LGqqgxTT
	ZQd/iDzuh0OCMcwHtqFg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vup2tg7e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 11:56:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PBuJxC013788
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 11:56:19 GMT
Received: from [10.217.217.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 03:56:16 -0800
Message-ID: <7f87bfec-8369-4aa7-abdb-da3593f33051@quicinc.com>
Date: Thu, 25 Jan 2024 17:26:13 +0530
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
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kamal Wadhwa
	<quic_kamalw@quicinc.com>
References: <20240123102817.2414155-1-quic_uchheda@quicinc.com>
 <CAA8EJppwboaEbKFFACr3LO0OHg4iOJPapKRqoH2EGEYcjV6HfA@mail.gmail.com>
 <735575f5-ee46-4c91-b0bd-e9c6fb97361c@quicinc.com>
 <CAA8EJpr6XrhNp2gdbqmCow7ShXLNXEwGZ-a_Yxr08bcxtORg6A@mail.gmail.com>
 <b4a9ad3e-392f-42ff-8fed-dd86b013176b@linaro.org>
From: Umang Chheda <quic_uchheda@quicinc.com>
In-Reply-To: <b4a9ad3e-392f-42ff-8fed-dd86b013176b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Fh311nFbI1sLfk2_XUJfihU8HajC0A7i
X-Proofpoint-ORIG-GUID: Fh311nFbI1sLfk2_XUJfihU8HajC0A7i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=571 phishscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401250082

Hi Konrad,

On 1/25/2024 3:15 PM, Konrad Dybcio wrote:
> 
> 
> On 1/25/24 09:26, Dmitry Baryshkov wrote:
>> On Thu, 25 Jan 2024 at 10:10, Umang Chheda <quic_uchheda@quicinc.com> wrote:
>>>
>>> Hi Dmitry,
>>>
>>> On 1/23/2024 5:48 PM, Dmitry Baryshkov wrote:
>>>> On Tue, 23 Jan 2024 at 12:28, Umang Chheda <quic_uchheda@quicinc.com> wrote:
>>>>>
>>>>> qcm6490-idp platform supports PM7250B PMIC as well.
>>>>> Add support for the same.
>>>>
>>>> The platform can not "support" PMIC. Please fix the commit message.
>>> Shall I change the commit message as below in the next patch ?
>>> "Add PM7250B PMIC support for qcm6490-idp"
>>
>> This is also not accurate. You are not adding support for the PMIC.
>> You are describing PMICs present on the board.
> 
> Umang, consider one of:
> 
> arm64: dts: qcom: qcm6490-idp:
> 
> "Include PM7250B"
> 
> "Enable PM7250B"
> 
> "Configure PM7250B"
> 
Ack, I have sent new version of my patch which addresses the feedback.

> Konrad

Thanks,
Umang

