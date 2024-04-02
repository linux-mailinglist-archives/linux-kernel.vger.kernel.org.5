Return-Path: <linux-kernel+bounces-128503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD10D895BC1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3C51F22A83
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C258A15B121;
	Tue,  2 Apr 2024 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="biBREyki"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8437315B0ED;
	Tue,  2 Apr 2024 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082617; cv=none; b=MN4N007MkqqjYbJmUmKWuQ4ZXw8j9r5YONSz3nPs7W1tuBzXqudRmihi5IRzeP37HwUFfKINhlPTBJCwYCSt3NtJ877/WpPNjsItHcXnffus9ksdz2XvPMkpv86yIBtgCPLs9yp0+CmBidvJqP+M5A9E7st0gVSo70mqcJFt2E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082617; c=relaxed/simple;
	bh=uOOqOGJkcjNWVvkBUSEI7eW++vFoiDQBBlkzXOrfJ60=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BtqCt/kFAhPGIHLaB1pnVNHGi1TSThc0bL3sFBBykoMaLia25j4V/XucIUpK1xLZ+Q847keL0JkCaIYzBWqNruxEW+5EH14Z3soach3qcAcq2Nz9ch819yL1hLojJm8czf+A3W/eMBDYp091meQR3mi9neVruz4IRRtJ4uf9NZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=biBREyki; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432HJS4D016776;
	Tue, 2 Apr 2024 18:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/nhzaRCV/5qt6/+uWIVNFZNDsNUTGwbH39DgJi3ti+A=; b=bi
	BREykiNDbn6PzmyItUuTVU2xyIOfVxVQ5Z3SFHFJ+IwDUfChTMhHVUE8ouVFrNE+
	3JEfyn2ShLL7gu5ZT9I9DD6en7VaLC95w+GxXdyYv6MLHciZeFv08YASeCAAH4jq
	oabGKybEnGkOXGhG8cxpMrxh+4Zg0N4CPYea6m4nC+lQxx955XGDay++qCjgOGHb
	Rw9k6XdFu7KltoEb8mwBpfjMNu1CG4CwhGG6NXdNEmTP3SLB3MqDIaG5y8TqAgiH
	3EYN9ZewpN5N8GY7NuT8RsEdrP1JeXcTTu4t+5xtcHTQcHjPgBSp7yEmeNCOo+X7
	r5DNKz2OTHf6oMRQYVyw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8fm1shy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 18:30:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432IU9ZJ009732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 18:30:09 GMT
Received: from [10.216.46.192] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Apr 2024
 11:30:00 -0700
Message-ID: <62461275-16d6-935f-786a-e602b4b91dde@quicinc.com>
Date: Tue, 2 Apr 2024 23:59:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 6/7] dt-bindings: clock: qcom: Add GPUCC clocks for SM4450
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        "Satya Priya Kakitapalli"
	<quic_skakitap@quicinc.com>
References: <20240330182817.3272224-1-quic_ajipan@quicinc.com>
 <20240330182817.3272224-7-quic_ajipan@quicinc.com>
 <06bcdb86-ad14-4b52-b61b-44191d6ca22d@kernel.org>
 <79dd5585-db7f-4a02-bb89-b83f91067956@kernel.org>
From: Ajit Pandey <quic_ajipan@quicinc.com>
In-Reply-To: <79dd5585-db7f-4a02-bb89-b83f91067956@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UT1mo3sy_L6_RGT5Pgr2n9ncxebbx9KB
X-Proofpoint-ORIG-GUID: UT1mo3sy_L6_RGT5Pgr2n9ncxebbx9KB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_12,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=923 suspectscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020137



On 3/31/2024 2:00 PM, Krzysztof Kozlowski wrote:
> On 31/03/2024 10:18, Krzysztof Kozlowski wrote:
>> On 30/03/2024 19:28, Ajit Pandey wrote:
>>> Add support for qcom display clock controller bindings
>>> for SM4450 platform.
>>>
>>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>>> ---
>>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Un-reviewed. I did not notice that this was not tested at all.
> 
> NAK
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline), work on fork of kernel
> (don't, instead use mainline) or you ignore some maintainers (really
> don't). Just use b4 and everything should be fine, although remember
> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time, thus I will skip this patch entirely till you follow
> the process allowing the patch to be tested.
> 
> Please kindly resend and include all necessary To/Cc entries.
> 
> 
> Best regards,
> Krzysztof
> 

Apologies somehow missed including device tree mailing list, Thanks for 
review and suggestion will take care of this in next series.
-- 
Thanks, and Regards
Ajit

