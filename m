Return-Path: <linux-kernel+bounces-20403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DC4827E4E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B83B236E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805926D6EF;
	Tue,  9 Jan 2024 05:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oEP/DGGF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D3065C;
	Tue,  9 Jan 2024 05:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408NZ2ra031357;
	Tue, 9 Jan 2024 05:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LekOZ25M5MgIUTbVHPQ4h4bL3UgN+dZGJYO8vJbrwTY=; b=oE
	P/DGGFugdcHC/HGMgpcTL5sZS9r4elaa69FqYB0tvRkn4dbDcPxkeoqqctmVFI0l
	tZuL0JNkXiHKPTcGWo2MmkVtQ6FVsrERhvsNtdjf/RBG4soweSKxncZLhof6ds0k
	HMP7Y/BNwSVDysihFl6izuf4ydwQWGg1vayjgCW8HJNeP7fybqXbYPeDzn7CPzov
	dJmRffWBymYUabYW3Cfyob25wVds7EBafI4DWvB2thczDTFiIbT46JMW/lsnhH/4
	OYvy+htw4SBToJuOy9YIy1Fiwcdr2vnMciMc4DvFlxFHIXN423micw3sRqE50tlw
	lHXw74j0NYesvTqVrTNg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgkkh9jka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 05:20:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4095Kg6I018882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 05:20:42 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 21:20:40 -0800
Message-ID: <3e311ffa-1be2-4361-a17f-4527461c9b6b@quicinc.com>
Date: Tue, 9 Jan 2024 10:50:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
Content-Language: en-US
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman
	<mathias.nyman@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20231212112521.3774610-1-quic_prashk@quicinc.com>
 <20231212112521.3774610-2-quic_prashk@quicinc.com>
 <2023121518-uncharted-riddance-7c58@gregkh>
 <849d0ea9-d4f7-c568-968c-88835f64fadf@quicinc.com>
 <2023122212-stellar-handlebar-2f70@gregkh>
 <43ff1971-aeb1-21e1-4700-9ee84cd5aede@quicinc.com>
 <b88a9573-6ab5-ed86-dabc-dd07875f88f3@linux.intel.com>
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <b88a9573-6ab5-ed86-dabc-dd07875f88f3@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iwVAl3-SMpA7fHL2jrewOcOmbcYgVyAs
X-Proofpoint-ORIG-GUID: iwVAl3-SMpA7fHL2jrewOcOmbcYgVyAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=717
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090036



On 02-01-24 06:02 pm, Mathias Nyman wrote:
> 
> I remember this now.
> 
> Original series had three patches, two adding the feature to xhci, and 
> one for dwc3 enabling it.
> The xhci patches were fine and got in.
> 
> https://marc.info/?l=linux-usb&m=160570849625065&w=2
> 
> The last dwc3 patch had issues and never apparently got in
> 
> https://marc.info/?l=linux-usb&m=161008968009766&w=2
> 
> As this feature hasn't been enabled and code not widely run I think it 
> would be  better
> to skip stable for now. Stable can be added later once this has been 
> successfully running
> in upstream for a while.
> 
> Thanks
> Mathias
> 

Thanks Mathias, do you want me to send the patch again without the 
stable tag?

Regards,
Prashanth K

