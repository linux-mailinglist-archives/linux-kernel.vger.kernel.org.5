Return-Path: <linux-kernel+bounces-11351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B681E4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFAF51F225C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703FE4BA81;
	Tue, 26 Dec 2023 05:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n1meGHlE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102CB4B5C5;
	Tue, 26 Dec 2023 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BQ4x1vh023783;
	Tue, 26 Dec 2023 05:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=AyqDWWihAa1zlhpr5k42krhHmxZ0myDPF3QTT8zp9NU=; b=n1
	meGHlEsCsluHafGFtTwuvJMifnQNJa8FEsvtlJ8nlefSur5otdGfcwQnk9YH7uVD
	cWUzKu4U3nQRYtuCN/l3EywoLHKNv78k/Yhg7KWJd4PmQSs5Tpqeys8F1Y8rbaK4
	LZMFDUO38onxuVPhChmsSRY2dWYqjB5eVs12vF0KKWXNj7p5NWoZhxoq0aUm77kw
	2ZGlaDybLcS104jnB5+a9fBLzryvHO7U/w6tPNNELA2Ilgz89ZVXCVNE6fhfD2tc
	JX6vfiJBK/xMmaRgln8/ZGQRzbo0rPyx99ivZXxCIXxrglrs0GUwNUtKX1zRg3Iy
	o8GgF5p2p1ax/1wimwuw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v7gd98pbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 05:24:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BQ5OkDR027920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 05:24:46 GMT
Received: from [10.216.25.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Dec
 2023 21:24:43 -0800
Message-ID: <43ff1971-aeb1-21e1-4700-9ee84cd5aede@quicinc.com>
Date: Tue, 26 Dec 2023 10:54:38 +0530
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <2023122212-stellar-handlebar-2f70@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X-atXzeIR_zyOLS9sZHi_nMTKlRz2t-U
X-Proofpoint-GUID: X-atXzeIR_zyOLS9sZHi_nMTKlRz2t-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312260037



On 22-12-23 11:40 am, Greg Kroah-Hartman wrote:
> On Fri, Dec 22, 2023 at 11:29:01AM +0530, Prashanth K wrote:
>> On 15-12-23 06:12 pm, Greg Kroah-Hartman wrote:
>>> On Tue, Dec 12, 2023 at 04:55:20PM +0530, Prashanth K wrote:
>>>> Upstream commit bac1ec551434 ("usb: xhci: Set quirk for
>>>> XHCI_SG_TRB_CACHE_SIZE_QUIRK") introduced a new quirk in XHCI
>>>> which fixes XHC timeout, which was seen on synopsys XHCs while
>>>> using SG buffers. But the support for this quirk isn't present
>>>> in the DWC3 layer.
>>>>
>>>> We will encounter this XHCI timeout/hung issue if we run iperf
>>>> loopback tests using RTL8156 ethernet adaptor on DWC3 targets
>>>> with scatter-gather enabled. This gets resolved after enabling
>>>> the XHCI_SG_TRB_CACHE_SIZE_QUIRK. This patch enables it using
>>>> the xhci device property since its needed for DWC3 controller.
>>>>
>>>> In Synopsys DWC3 databook,
>>>> Table 9-3: xHCI Debug Capability Limitations
>>>> Chained TRBs greater than TRB cache size: The debug capability
>>>> driver must not create a multi-TRB TD that describes smaller
>>>> than a 1K packet that spreads across 8 or more TRBs on either
>>>> the IN TR or the OUT TR.
>>>>
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>>>
>>> What commit id does this fix?
>>>
>> This doesn't fix any commit as such, but adds the support for
>> XHCI_SG_TRB_CACHE_SIZE_QUIRK (which is present in XHCI layer) to DWC3 layer.
> 
> So this is a new feature?
> 
> How does this fit into the stable kernel rules?

This isn't a new feature. To give some background, upstream commit 
bac1ec551434 ("usb: xhci: Set quirk for XHCI_SG_TRB_CACHE_SIZE_QUIRK")
added a XHCI quirk which converts SG lists to CMA buffers/URBS if 
certain conditions aren't met. But they never enabled this xhci quirk
since no issues were hit at that time. So, the support for the above 
mentioned quirk is added from 5.11 kernel onwards, but was never enabled 
anywhere.

 From commit bac1ec551434 : "We discovered this issue with devices on 
other platforms but have not yet come across any device that triggers 
this on Linux. But it could be a real problem now or in the future. All 
it takes is N number of small chained TRBs. And other instances of the 
Synopsys IP may have smaller values for the TRB_CACHE_SIZE which would 
exacerbate the problem."

For more info: 
https://lore.kernel.org/all/20201208092912.1773650-3-mathias.nyman@linux.intel.com/

> 
>> I have CC'ed stable kernel for this to be back-ported to older kernels
>> (#5.11).
> 
> Why that specific kernel version and newer?  Why not list it as
> documented?

I mentioned 5.11 because commit bac1ec551434 ("usb: xhci: Set quirk for 
XHCI_SG_TRB_CACHE_SIZE_QUIRK") is present from 5.11.
> 
>>>
>>>> ---
>>>>    drivers/usb/dwc3/host.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
>>>> index 61f57fe5bb78..31a496233d87 100644
>>>> --- a/drivers/usb/dwc3/host.c
>>>> +++ b/drivers/usb/dwc3/host.c
>>>> @@ -89,6 +89,8 @@ int dwc3_host_init(struct dwc3 *dwc)
>>>>    	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
>>>> +	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-sg-trb-cache-size-quirk");
>>>
>>> And this is ok if the entry is not present?
>>>
>> We are intending to use this quirk for all the dwc3 based devices since the
>> DWC3 XHC needs it.
> 
> So you do not have this quirk yet in the kernel tree?  We can't take
> code without any in-tree users.

This is a 2 patch series, patch 1/2 sets a property from dwc3 layer. And 
patch 2 enables XHCI quirk based on the property set from DWC3.
> 
>> If the entry is not present then we will hit stall if
>> certain conditions aren't met (have mentioned the condition in commit text).
> 
> When will the quirk be added?  To what platforms?

I guess there is some sort of confusion here, sorry for that.

Earlier Tejas Joglekar from synopsys pushed a patch in XHCI layer which 
converts certain SG lists to CMA buffers if some pre-requisites aren't 
met. And this operation is done if an xhci->quirk is set 
(XHCI_SG_TRB_CACHE_SIZE_QUIRK - BIT39)

- 
https://lore.kernel.org/all/20201208092912.1773650-2-mathias.nyman@linux.intel.com/

- 
https://lore.kernel.org/all/20201208092912.1773650-3-mathias.nyman@linux.intel.com/

But here the option to enable this quirk was done using XHCI priv data

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index aa2d35f98200..4d34f6005381 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -333,6 +333,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
  	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
  		hcd->skip_phy_initialization = 1;

+	if (priv && (priv->quirks & XHCI_SG_TRB_CACHE_SIZE_QUIRK))
+		xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
+
  	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
  	if (ret)
  		goto disable_usb_phy;


And this XHCI quirk (XHCI_SG_TRB_CACHE_SIZE_QUIRK) needs to be enabled 
for DWC3 controllers. There are 2 ways to do it. One way is by directly 
accessing XHCI private data from DWC3 layer (dwc3/host.c) which is not 
cleaner approach.

So I'm reusing the device_create_managed_software_node() which is 
present in dwc3/host.c to add a quirk to XHCI node, and enable 
XHCI_SG_TRB_CACHE_SIZE_QUIRK based on property set from DWC3 layer.

Thanks,
Prashanth K

