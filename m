Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C4980EA74
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjLLLfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjLLLfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:35:16 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5D5CD;
        Tue, 12 Dec 2023 03:35:22 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCBWBxX023198;
        Tue, 12 Dec 2023 11:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:from:to:cc:references
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=LDgvI07ObLh7qIhXltVCW2uzZOetks4/bakQTKmv6GA=; b=Fv
        sonUF9q5yu2V8CiD3z154iNCKutFE2sN00TLIGMm5RR+cZyKRpEUFzWCDJQfSDiC
        hFgflu7oUvNqOD61/4cKkvz7mE5fuCoSSQ10F/kHcUAtFSf4KTiol26Zg9i4rYGA
        PQ6uJTrP9Uk3sFyGRqWjatsm1lqAfKJT/aujkCIDIiusfxqArrx9QVq46m5qkqCX
        isuZHdUgVYRfnpbhXIJ+hUHhjSmwNLZ2gKTG0uBx0iGEs07IwcLEQ+7YDIfr3WOB
        PBLWZqFoCCzCXwaNCeUO1UJ+piNZhviBWFTAGCJltVx3RC/LPTmU+KEBIGYVNBqY
        ZaCmQ/MVymnRgM8rHChA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxkxfgexr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:35:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCBZI3U012093
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:35:18 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Dec
 2023 03:35:16 -0800
Message-ID: <605a4c59-6e7e-0ae8-a825-f364530216d5@quicinc.com>
Date:   Tue, 12 Dec 2023 17:05:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: dwc3: core: Add support for
 XHCI_SG_TRB_CACHE_SIZE_QUIRK
Content-Language: en-US
From:   Prashanth K <quic_prashk@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20231121135936.1669167-1-quic_prashk@quicinc.com>
 <d4d25747-83d4-a8e7-7968-caf3b14a844c@quicinc.com>
In-Reply-To: <d4d25747-83d4-a8e7-7968-caf3b14a844c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4d8uLoFOQo-fs-xTJs7WbQWsdZozOVE9
X-Proofpoint-ORIG-GUID: 4d8uLoFOQo-fs-xTJs7WbQWsdZozOVE9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=748 spamscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312120093
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27-11-23 02:28 pm, Prashanth K wrote:

> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -89,6 +89,8 @@ int dwc3_host_init(struct dwc3 *dwc)
> 
>          memset(props, 0, sizeof(struct property_entry) * 
> ARRAY_SIZE(props));
> 
> +       props[prop_idx++] = 
> PROPERTY_ENTRY_BOOL("xhci-sg-trb-cache-size-quirk");
> +
>          if (dwc->usb3_lpm_capable)
>                  props[prop_idx++] = 
> PROPERTY_ENTRY_BOOL("usb3-lpm-capable");
> 
> 
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -323,6 +323,9 @@ static int xhci_plat_probe(struct platform_device 
> *pdev)
>                  if (device_property_read_bool(tmpdev, 
> "quirk-broken-port-ped"))
>                          xhci->quirks |= XHCI_BROKEN_PORT_PED;
> 
> +               if (device_property_read_bool(tmpdev, 
> "xhci-sg-trb-cache-size-quirk"))
> +                       xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
> +
>                  device_property_read_u32(tmpdev, "imod-interval-ns",
>                                           &xhci->imod_interval);
>          }
> 
> 
> Regards,
> Prashanth K
> 

Updated the patch by splitting it into a series of 2 patch-sets
https://lore.kernel.org/all/20231212112521.3774610-1-quic_prashk@quicinc.com/

Thanks,
Prashanth K
