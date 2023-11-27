Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA597F9C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjK0I64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjK0I6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:58:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1429E;
        Mon, 27 Nov 2023 00:58:54 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR6qhTu030841;
        Mon, 27 Nov 2023 08:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VUK2zSLPO3Hh4UQ4+PimsBW853SUNPurIoSc11ax5Ls=;
 b=DoSx9Yil81hIL58c1nDBlKGdJHL2JKMbWIcGb6AdBzlBj8OREJjJl6W7m+PehIphDWSw
 Ytx8PFBUQ2vUN1iJU1ZasJmSPunruwsRpI+zRQr0erYsX9b4qXJ3yWUf09htyniBWi7o
 NXLgMw76ULRxiKp8EEkMwdygcXG0a0OjYyZ4jhRY86JCipkpPKhc9BrxTpLjbBRlZwJr
 F2so/t1672l2QKrSlF1Dv2E+tX8BCZ8ZX21AYej7gBpuSnotBDpno/qgd7q0sIUk8ube
 pEORjGVF+jZZtBuZCBDTXYcFUluS61gqokbM3Fa5P4mfzJ2f0e23w41LGTjJC3Zu/oBC uw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk9adkntf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 08:58:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AR8woMe019288
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 08:58:50 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 00:58:48 -0800
Message-ID: <d4d25747-83d4-a8e7-7968-caf3b14a844c@quicinc.com>
Date:   Mon, 27 Nov 2023 14:28:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: dwc3: core: Add support for
 XHCI_SG_TRB_CACHE_SIZE_QUIRK
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20231121135936.1669167-1-quic_prashk@quicinc.com>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20231121135936.1669167-1-quic_prashk@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: akeJg2k1-GmsaR_m0FX6W1FHUIJH0psr
X-Proofpoint-GUID: akeJg2k1-GmsaR_m0FX6W1FHUIJH0psr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_07,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270062
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21-11-23 07:29 pm, Prashanth K wrote:
>   drivers/usb/dwc3/host.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index 61f57fe5bb78..ee3b667a88b2 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -11,6 +11,7 @@
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
>   
> +#include "../host/xhci-plat.h"
>   #include "core.h"
>   
>   static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
> @@ -63,6 +64,7 @@ int dwc3_host_init(struct dwc3 *dwc)
>   {
>   	struct property_entry	props[4];
>   	struct platform_device	*xhci;
> +	struct xhci_plat_priv   dwc3_xhci_plat_priv;
>   	int			ret, irq;
>   	int			prop_idx = 0;
>   
> @@ -87,6 +89,14 @@ int dwc3_host_init(struct dwc3 *dwc)
>   		goto err;
>   	}
>   
> +	memset(&dwc3_xhci_plat_priv, 0, sizeof(struct xhci_plat_priv));
> +
> +	dwc3_xhci_plat_priv.quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
> +	ret = platform_device_add_data(xhci, &dwc3_xhci_plat_priv,
> +					sizeof(dwc3_xhci_plat_priv));
> +	if (ret)
> +		goto err;
> +
>   	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
>   
>   	if (dwc->usb3_lpm_capable)

Is the above approach acceptable? I'm not sure if accessing xhci-plat's 
structure from dwc3 is a recommended way. If not, then can we go ahead 
with the following approach where we add a property to XHCI SW node.


--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -89,6 +89,8 @@ int dwc3_host_init(struct dwc3 *dwc)

         memset(props, 0, sizeof(struct property_entry) * 
ARRAY_SIZE(props));

+       props[prop_idx++] = 
PROPERTY_ENTRY_BOOL("xhci-sg-trb-cache-size-quirk");
+
         if (dwc->usb3_lpm_capable)
                 props[prop_idx++] = 
PROPERTY_ENTRY_BOOL("usb3-lpm-capable");


--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -323,6 +323,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
                 if (device_property_read_bool(tmpdev, 
"quirk-broken-port-ped"))
                         xhci->quirks |= XHCI_BROKEN_PORT_PED;

+               if (device_property_read_bool(tmpdev, 
"xhci-sg-trb-cache-size-quirk"))
+                       xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
+
                 device_property_read_u32(tmpdev, "imod-interval-ns",
                                          &xhci->imod_interval);
         }


Regards,
Prashanth K
