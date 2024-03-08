Return-Path: <linux-kernel+bounces-96991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3BA876427
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15BA1C21400
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED5A56B83;
	Fri,  8 Mar 2024 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EbOBsIR5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4856763;
	Fri,  8 Mar 2024 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900281; cv=none; b=Ep5lBSrNm2etJfLqtoRX/VSNaN9HZKOGHmPpMEV7hH9MwnPf3SLidYCTOZs9DLhL6Zp6c09PzBUMzZyqgE4LYdk54gY/1eGJSWyySshQizIdm3bgbDtTYO9i/VN+qjX0y1Z163na6wjMkorkKarwSkn6mc/FDIuqEj+jF+1jjc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900281; c=relaxed/simple;
	bh=pwUsUTNB4CXn5jwmeq9Yam1lIk14dD1UFdgsfTppWeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ruFBAc+zVLf5g8eR+RBZmKX47QXbKGlMvTYz3KWMZHOeV5KXoBaF4od1xRQoGD9UmDEdjkVN1M3NmnQJwjOCd4BzflPF460iZMr0V6YVYw2JXJLqiD33pSUmIfVEJzCpNeNrVQktM1gNWnhv9VicoQjOnXnW3t9rwWMh1vBbRmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EbOBsIR5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428CG7fr016040;
	Fri, 8 Mar 2024 12:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=J6c0uTF3I1nxAq5/QiDVTuwY4eatOHB2G6Mxe9XZGS0=; b=Eb
	OBsIR5Yp1KuXcNP6CZ3qN8ti4Sd+I5cp1Js9wD3sVqRZHIMuvfwe22HAjDwx5X1P
	GNhjBIl8wJFhjQhmGi+Vqvd0RGYGq1vvefswCma13yNRzGeD8Usf0QvulBjSkqXF
	ahaiYi63PkUtyqiaS2zqeTSb039sv0irgs1dTqGBwATZQ74tc52QcYy2QF06gznL
	w6WKOC6ULPRC2i27US6+o00ZGVpfcaC1qo6zNNb+TfmqYQQV9bOxsB9ohIANP/V2
	zlfai4X7nbWL6B/gvNpAmelS2uHkiFS1mgs+qBTmjryixojVZL+PbobwCx8M44Gp
	ygUGRm/gmw7/f4glKG7w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqyfsreab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 12:17:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428CHgQD011585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 12:17:42 GMT
Received: from [10.216.63.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 8 Mar
 2024 04:17:40 -0800
Message-ID: <4816d981-3955-495c-8fc6-3b9b15ba1689@quicinc.com>
Date: Fri, 8 Mar 2024 17:47:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_ncm: Fix Kernel Panic due to access of
 invalid gadget ptr
To: Hardik Gajjar <hgajjar@de.adit-jv.com>
CC: <gregkh@linuxfoundation.org>, <maze@google.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guofeng.li@gm.com>, <hardik.gajjar@bosch.com>,
        <eugeniu.rosca@bosch.com>
References: <20240307161849.9145-1-hgajjar@de.adit-jv.com>
 <8d116b78-9227-4e48-8d37-3a0cb0465dfd@quicinc.com>
 <20240308115506.GA5631@vmlxhi-118.adit-jv.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20240308115506.GA5631@vmlxhi-118.adit-jv.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g4r7HiYzWehTB7vfJPVAcvEQKnnvW2it
X-Proofpoint-ORIG-GUID: g4r7HiYzWehTB7vfJPVAcvEQKnnvW2it
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=806
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080098



On 3/8/2024 5:25 PM, Hardik Gajjar wrote:
> On Thu, Mar 07, 2024 at 11:12:07PM +0530, Krishna Kurapati PSSNV wrote:
>>

[...]

> 
> I believe using gether_cleanup altogether may not be an optimal solution.
> The creation and deletion of network interfaces should align with the behavior of each specific network driver.
> 
> For instance, in the case of NCM, the usb0 interface is created upon the creation of a directory
> in config/usb_gadget/gX/functions/ncm.usb0, and it is removed when the corresponding directory
> is deleted. This follows a standard flow observed in many network drivers, where interfaces are
> created during driver loading/probing and deleted during removal.
> 

Hi Hardik,

  Yeah. I observed this behavior.

> Typically, deleting the gadget on every disconnection is not considered a good practice, as it can
> negatively impact the user experience when accessing the gadget.
> 

Got it. I was suspecting issues might come up during fast Plug-In/ 
Plug-Out cases as setting and cleanup of network interface might take 
some time.

> In our specific scenario, retaining the usb0 network interface has proven to enhance performance
> and stabilize connections. Previous attempts to remove it resulted in an observed increase in time of 300ms,
> particularly at the start of Apple CarPlay sessions.
> 

Thanks for this info. Makes sense to keep it in free_inst only. But my 
initial doubt only stemmed from the fact that actions taken during bind 
must be reversed during unbind.

> Furthermore, it's important to highlight that in Qualcomm products and msm kernels, the inclusion of gether_cleanup
> in the unbind process was eventually reverted. While the specific reason for reverting the patch is unknown,
> it suggests that the addition may not have yielded the intended or required results
> 
> Following is the revert patch details in msm-5.4 kernel, if you want check it.
> 
> Revert "usb: gadget: f_ncm: allocate/free net device upon driver bind/unbind"
> 
> This reverts commit 006d8adf555a8c6d34113f564ade312d68abd3b3.
> 
> Move back the allocation of netdevice to alloc_inst(), one-time
> registration to bind(), deregistration and free to rm_inst(). The
> UI update issue will be taken up with proper stakeholders.
> 
> Change-Id: I56448b08f6796a43ec5b0dfe0dd2d42cdc0eec14
> 

Agree. This was merged first in 4.19 downstream (most probably for car 
play use case only) and then reverted in 5.4. But present 4.19 code in 
QC still keeps it in unbind path. The only reason I suspect it was 
reverted was to get back on to same page with upstream driver (atleast 
starting from 5.10, this was the reasoning to remove gether_cleanup in 
unbind path and put it back in free_inst).

Thanks,
Krishna,

