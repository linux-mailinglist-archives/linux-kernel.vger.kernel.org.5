Return-Path: <linux-kernel+bounces-56422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B5A84C9F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21901C25E11
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1761D527;
	Wed,  7 Feb 2024 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hXZMIbRw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091E32560B;
	Wed,  7 Feb 2024 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306744; cv=none; b=uNJuTSqfn2uXW7YV0XagJa61bF/AVQlLNi001dE0t+bVk3kNg5LwFweKhTodPK1RtXGgwsYP87b6NYQS6rDXJ42D4CrJB1gjRKDkf8T9ZYBTwoZccsnHsL8tDOHUxWZ8qogoPx4R7sI+g3pto3iuAbrafboE3JLz+60mn1Ny2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306744; c=relaxed/simple;
	bh=XD640F5iTSZXIjl6aEqDrUVojoQ2lsSyrOaHCQ1IyIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eZeQ43eVKA/IoL6E6LU+Dz8wmz8oCSdGqH+LUR9B5G+SHHgds5BUp45VMbHhBez7xxH7X+kGaJlGFa3b13s/jzOIwAe4zaNeMjwoQ+P4oLF51S1rYIAS+iFjEe/4fR8j56JYBIYZN3ElBLcSAbLk0bEDzpTj404DCBtYUCAfPsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hXZMIbRw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417Ble7P030028;
	Wed, 7 Feb 2024 11:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oZfRncVqEFp1cWYqquAibwYhDJfa0mmo/1DFZ23d00o=; b=hX
	ZMIbRwVIiOVfBZ6ABjlfgSYvTdX94ElEfbyKSsV2yFpbKzQmaBh3PKkbhoXf0ZHO
	V0c/UI5Z+kuW5YfmZwYr8WdjAOAeraGR7l8EjCSNVTwgA1jMCLyFlry03MtZvzOZ
	OXL8vtlzPAdNhvZxqLb9KqwNyR5n49oYTm53crzYC666KwpBW4s3OLOCRw60GWqL
	trjZ+81FZSZnK+PhNXL+Y4knT/MA/YCYh8bAG4itZ0i4WnKoum90Z0U+0kfMnKK9
	OZxRJ4fJ1pNDujHccvV49aDn7YqhKyIcbEGItLvRMuIe43Sbw5snYKzYHjewVSas
	1apvXGLHtvXvorYIpTyQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3ub6hkes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 11:52:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 417BqHfO002483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 11:52:17 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 03:52:13 -0800
Message-ID: <1af9d3cf-33d7-8eac-7820-3db5b881e866@quicinc.com>
Date: Wed, 7 Feb 2024 17:21:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/2] Correcting the voltage setting for vph_pwr
To: Bjorn Andersson <andersson@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Naina Mehta
	<quic_nainmeht@quicinc.com>
References: <20231220110015.25378-1-quic_kbajaj@quicinc.com>
Content-Language: en-US
From: Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <20231220110015.25378-1-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RhJ4sOUMzl2zlvglL1Y5wcnhkdd2J23L
X-Proofpoint-ORIG-GUID: RhJ4sOUMzl2zlvglL1Y5wcnhkdd2J23L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=414 adultscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070088



On 12/20/2023 4:30 PM, Komal Bajaj wrote:
> Correcting the voltage setting for vph_pwr for qcm6490-idp and
> qcs6490-rb3gen2 boards.
> 
Can you please apply these two patches.

Thanks
Komal

