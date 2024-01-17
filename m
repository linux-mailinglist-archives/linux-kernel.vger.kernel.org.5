Return-Path: <linux-kernel+bounces-28719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 251D783023A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C666C2862CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1B314005;
	Wed, 17 Jan 2024 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hsiikKnH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F29134C8;
	Wed, 17 Jan 2024 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483362; cv=none; b=GuiirdxB5OcugHKNcS+elAF5wSvI4XF53K4ItdhmBERUxjbhgs1fRcn6btm7kirLwHzh3GiaL5FeOs23OA05WhDVUS5HYCjMHXBMC+nrxrCSGmsPgkDWId9x4lacZ5JDo8lLLH5ugdvcfKZccjtnlXcmHd0KhOI4O8+mjhYu6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483362; c=relaxed/simple;
	bh=8Hq12A3R9kvTLbQkGASmU/vU6L5V1gT75319YCZrdAA=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=GN07cMHkHcveypY3M3KaPblAn41i2LhkUqlh6Oo+EpxSzoHe9xas40SBUh8flLkK7Cszi1yOToperxN7F14WkZl5My9LBxF1XqigWd4P/NYshK4QK27npMSmFvvcSi/eI8zI0EIQus0jpvPdEpkKjPIIGnXxbaFIw7HmJwtOGpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hsiikKnH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H3vZhu027266;
	Wed, 17 Jan 2024 09:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8UyA6B+7jJ0WmY7unNvthyzBcl0PLj9aYF+nuReRk5s=; b=hs
	iikKnHFB1Jr9hsNvwVEsNmQ7vnDqxuzMu8eTX+3A5lVsDEI9qFVNEm5gVfpfNCg+
	YHcO0/EHhNFu+nJA+9jgJQrBY3zQ5lMxMhw7/xdW7vjkNlJJvh3txX54xbQOD/q7
	VtY02lg+u6GFNdULjidTk7y51GQukEoVMcRkD0EId0WIzX0QvlCPRvKEnu6scIDK
	CLio9bPNFRVcZKo0wHcs9yUnOWOdfGNlXGJ83JdUxG2Zb+Tl0JxebXYoTKcrUHby
	fuR6HmdRznQU7CTEuHNlf9ylM/HLBE/GnztFFYmHRO6tjG+DKmhXvq7waWRuB882
	b4koe5Q0qf3wK+7IWIZg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnq4t32tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 09:22:36 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H9MK53028097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 09:22:20 GMT
Received: from [10.218.39.189] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 01:22:18 -0800
Message-ID: <77ffee9a-cd77-6a09-10ee-bdf17bfca5ec@quicinc.com>
Date: Wed, 17 Jan 2024 14:52:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
Content-Language: en-US
To: Kuen-Han Tsai <khtsai@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
References: <20240110095532.4776-1-quic_uaggarwa@quicinc.com>
 <CAKzKK0qJOz_+pNAVAD8Ub6TZ9uhFOzuDC_bws9MVzxNa7RqYhA@mail.gmail.com>
From: UTTKARSH AGGARWAL <quic_uaggarwa@quicinc.com>
In-Reply-To: <CAKzKK0qJOz_+pNAVAD8Ub6TZ9uhFOzuDC_bws9MVzxNa7RqYhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u5vagpAXOvoNFeoDLpn6a8j_lY6X_0HA
X-Proofpoint-ORIG-GUID: u5vagpAXOvoNFeoDLpn6a8j_lY6X_0HA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_04,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=470 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170065


On 1/17/2024 12:47 PM, Kuen-Han Tsai wrote:
>>          ret = dwc3_gadget_soft_disconnect(dwc);
>>          if (ret)
>>                  goto err;
> For improved readability, we can remove the goto statement and move
> the error handling logic here.

Hi Kuen-Han,

Thanks for the suggestion.
Does this looks good to you ?

    int ret = dwc3_gadget_soft_disconnect(dwc);    if (ret) {        if 
(dwc->softconnect)            dwc3_gadget_soft_connect(dwc);

        return ret;    }    spin_lock_irqsave(&dwc->lock, flags);    if 
(dwc->gadget_driver)        dwc3_disconnect_gadget(dwc);   
  spin_unlock_irqrestore(&dwc->lock, flags);

Thanks,

Uttkarsh


