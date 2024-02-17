Return-Path: <linux-kernel+bounces-69944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFEF85909C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B9B1F219A9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094417CF0A;
	Sat, 17 Feb 2024 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="okau/IxH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F4026AE0;
	Sat, 17 Feb 2024 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708184726; cv=none; b=pp1EsPLWjyMxNNST4ZJQJaz8cMG2mFLQTKFJbxdpBoE5MCQXGTKT5Xxg0ZpE4uGmC3yLwSwk6rSJGGyzyYbNVCYz2F+EfHuviL0cdSAll3rriDWv/UNNSGsQOG8Bn5tWlRCtW6gXw4Yk254QvlH9dobH0sSK6IzQIW2zJhkTGhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708184726; c=relaxed/simple;
	bh=Pn42SOug1SeuUwFUNDXOg1b5cYz8sTuWFoTywf+qOKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bgnIIn9LndHF1Cgt6cJOgsIKp8rEY2drwLIkbLjY5fgLLZ2Vtl5IJaJDk5hCnHTM5/MOoCUl3vWc7FYBz8eStgds5zyLPtYgm3i36ZYh3ybWwG9EQMFvgXLLRIfuC1O+T1Cjd78pqRa5Cpbs2VS0yMKbdS5P6dz7qprCFuNEIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=okau/IxH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41HErtwF021695;
	Sat, 17 Feb 2024 15:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DXamrJ4SOCBYjAmqzjslC7fuieKptJ71ZD0J10qEzJY=; b=ok
	au/IxHG6vmukrkgzYuPL3h8FpnVdAmse3RBs0N4kUoriRkPEDdDk20DACTtX2OFP
	ZVreTFt1JcspCYWUm65q73nsp9l832XpEtfarCRzBzvvpI11JxqPdugZ2nBA1QHW
	Q990VthQcENY5dL1DE+Hcigf8CSBz4FM+S12RYcgLSH7/wWtLXcEK7PrcF9TH/iA
	mN6ltLbQ0N5mkT0sY6yPW9X9r32vpDKpHaULgcriVvowOAd5GZAtmetbyM3cV6FT
	SsQKf8Po2jq5iJmItFWX7M9VT0m8vf/h1/LAVzAHthq2qhO8dIYWA3xKN3N0YZ1w
	NcJRNNi0D12729w9Ku9w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wamvy8pfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 15:45:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41HFj6w6032663
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 15:45:06 GMT
Received: from [10.216.61.130] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 17 Feb
 2024 07:44:59 -0800
Message-ID: <74f585c2-d220-4324-96eb-1a945fef9608@quicinc.com>
Date: Sat, 17 Feb 2024 21:14:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] clk: qcom: ipq5332: enable few nssnoc clocks in
 driver probe
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Andrew Lunn <andrew@lunn.ch>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-2-19fa30019770@quicinc.com>
 <7a69a68d-44c2-4589-b286-466d2f2a0809@lunn.ch>
 <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com>
 <17e2400e-6881-4e9e-90c2-9c4f77a0d41d@lunn.ch>
 <8c9ee34c-a97b-4acf-a093-9ac2afc28d0e@quicinc.com>
 <CAA8EJppe6aNf2WJ5BvaX8SPTbuaEwzRm74F8QKyFtbmnGQt=1w@mail.gmail.com>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <CAA8EJppe6aNf2WJ5BvaX8SPTbuaEwzRm74F8QKyFtbmnGQt=1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uxrDFjrn2vWVtpU3K4Bwl7Q9vQyozlnx
X-Proofpoint-GUID: uxrDFjrn2vWVtpU3K4Bwl7Q9vQyozlnx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_13,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=804 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402170128


<snip>

>> Reason being, to access the NSSCC clocks, these GCC clocks
>> (gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk)
>> should be turned ON. But CCF disables these clocks as well due to the
>> lack of consumer.
> 
> This means that NSSCC is also a consumer of those clocks. Please fix
> both DT and nsscc driver to handle NSSNOC clocks.


Thanks Dmitry. I shall include these clocks in the NSSCC DT node and 
enable the same in the NSSCC driver probe.

> 
>>> Once you have actual drivers, this should solve itself, the drivers
>>> will consume the clocks.
>>
>>
>> Given that, NSSCC is being built as module, there is no issue in booting
>> the kernel. But if you do insmod of the nsscc-ipq5332.ko, system will
>> reset.
>>
>> Without the networking drivers, there is no need to install this module.
>> And as you stated, once the drivers are available, there will be no issues.
>>
>> So can I explain the shortcomings of installing this module without the
>> networking drivers in cover letter and drop this patch all together?
> 
> No. Using allyesconfig or allmodconfig and installing the full modules
> set should work.
> 


Okay, Got it. Thanks for the information.

<snip>

