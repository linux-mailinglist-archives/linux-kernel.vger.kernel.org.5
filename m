Return-Path: <linux-kernel+bounces-62939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F70852824
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E647285575
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ECB11CBC;
	Tue, 13 Feb 2024 05:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VxKh36by"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED786816;
	Tue, 13 Feb 2024 05:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707801114; cv=none; b=OK1rWs8QSBtPjB1n2ZmGOT5xfR9r33XoVe+LXOekVxlVEJSFWqxCZEn6zwXyKC/9bWGIqSQDbk72/3NIdyJ6UVGCLMQWZ7t77O32U31zQhOz7Ya8SJe2Y5RwqFkNu83eZyCEmp9h9CS3s6XZwSkXocV7zwQJZSuNdIAhkXN3Muo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707801114; c=relaxed/simple;
	bh=2cRg5PTMD1OekiCwTi9/R6UfME4t4DHHZMMym8ELcmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nvD8Mx2xtenKquModrDWi+teUvK3QgmvtSi0K+n/fjlNbLUt2j+AS6b1QLAUkqz79ITHlhMhvAUtSebIhJSbrVZ6pc71YjcwSnxym7+m5XZWgEiJTWYc2MLzln361IMyshuHG4CfR4TbUBBo4iJ3GHNnovrYUZG+BGit3lMnjsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VxKh36by; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D51RC9015011;
	Tue, 13 Feb 2024 05:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=imfofRntNZMlx4asuGo431nZornTV50xVbosiKaTmpA=; b=Vx
	Kh36bySIvF/3r8olVx+GrjCiUelxG802o90wucEsWDHA99I7gm4RMPhZ5PXbX7Lz
	UB/7s7YJ0cRjQT2qNElW1UAfRJfM5t6D9yOP1lkfVrvjN+vgGwjzJWeWWsugyDYO
	CneAJ8/0MWUTiAId2sX/yyOvmt5yrivjCaOdPeFHskxYYCKnA1+/6RxuMAZe1ktV
	HolAoMULs+nJaFiM/NQfrwBl+xKuEnTBA4sfsomBXk6E6pkbjTn8HS1LaTBgX6kw
	JtP/6fjA/bjqOUbW8w0Oyw1r/6B2yrtXPbsRky3LAlkHhCZ2IkUH7FEQ8HStt1Gu
	mlLprBu8nF4XeTJ1lbDg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gs1j68e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 05:11:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D5BeXp011945
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 05:11:40 GMT
Received: from [10.216.7.28] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 21:11:35 -0800
Message-ID: <690e4b4f-ae93-4458-88cb-131cb98574c4@quicinc.com>
Date: Tue, 13 Feb 2024 10:41:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sa8540-ride: Enable first port of
 tertiary usb controller
To: Andrew Halaney <ahalaney@redhat.com>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>
References: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
 <20240206114745.1388491-4-quic_kriskura@quicinc.com>
 <23824242-1b37-4544-ae9a-0a5a0582580e@linaro.org>
 <CAA8EJpqbXvKMQktGsxMFJnR+fXoOz8hFmm+E3ROPTjjiD0QLvg@mail.gmail.com>
 <6q2ocvrujbli42rjddflyol74xianr7j47jwcgdnnmwjanv25d@uw2da7zulqqd>
 <CAA8EJpr6k8c5C54S9xxQgZvd9NYFoxi5qQrOTz2AMrp0xeZZpw@mail.gmail.com>
 <baw3wxbdvzpkqqb6a7iut2wpt6jgzyqii5uyfkzptzt4ryjvao@4tpee6nqup5w>
 <b5c25274-9af0-4b3e-ade7-9a55d3cecd29@quicinc.com>
 <stci5fykvlstgvblrtqd33f2mgbnwlc4rwguwfybqm3awbasmq@uo2qqszrgz2s>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <stci5fykvlstgvblrtqd33f2mgbnwlc4rwguwfybqm3awbasmq@uo2qqszrgz2s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q4Lxcsdu5tMoJF_ZwMVaRRXSkJwcpL17
X-Proofpoint-ORIG-GUID: Q4Lxcsdu5tMoJF_ZwMVaRRXSkJwcpL17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=725
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130036



On 2/13/2024 12:47 AM, Andrew Halaney wrote:

>>
>> Hi Andrew,
>>
>>   Can you help test the following patch. It is just an add-on to your
>> original one. I don't have a SA8540P Ride at the moment and getting one
>> might take time. Incase you can confirm this patch is working. I can push v2
>> of this series.
> 
> I just realized that unfortunately I no longer have access to a
> sa8540p-ride, and I'm not sure if I'll regain access.
> 
> So I would not be opposed to dropping this patch altogether and someone
> dealing with sa8540p-ride when they can test it :/
> 

Hi Andrew,

  It would take time for me to get my hands on one of them. I can take 
up this patch once I get access to hw. In the meantime I can push the 
first two and get this series with.

Regards,
Krishna,

