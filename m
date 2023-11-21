Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8647F2D47
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjKUMfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbjKUMfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:35:17 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0DB13D;
        Tue, 21 Nov 2023 04:35:12 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALA9X8k022595;
        Tue, 21 Nov 2023 12:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PGU0MWzfni8uZCA1g4/HDHP1TtIUgmy0VuY7aaFWkT0=;
 b=CG04AIpUnH1G2IPMbM3MNQdQ3IPP5M+Bqms2wZpeOCFZpq1yIsZTgAOyzcVNVHt3zHMR
 C3nspEojD9c7CE/aKALeDPtNczINWpBo2p1oXCmqvPbizjSW9yfTImsIZVbQpN3lx2Mp
 qP5VAgijE6asY6dLzUgblX7HVeIvyMMI367jprje0sI3hdXri/uowZke7jGqTUkUR4XA
 5YsgC4hilONJqd+ETTSV6/fsSAXvHJD6JLvaUG0ECnPCfs/RI+sy1A5PgOMr9LTq+KP2
 78Mb7xVYHVKixhRvtLRN7J6RECp9ubeC6v/JDexXhERoOPHxLHa079Lt1VgLj2k43oqD Lw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uge0025wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 12:35:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALCZ5u8024985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 12:35:05 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 21 Nov
 2023 04:35:02 -0800
Message-ID: <8ffbb08a-730a-6b67-a22f-bbe009d5e2c3@quicinc.com>
Date:   Tue, 21 Nov 2023 18:04:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 0/2] Add support for xhci-sg-trb-cache-size-quirk
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, <stable@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Tejas Joglekar <joglekar@synopsys.com>,
        <linux-kernel@vger.kernel.org>, <linux-usbyy@vger.kernel.org>
References: <20231120055803.224634-1-quic_prashk@quicinc.com>
 <6e435e84-fea9-4f74-8977-d589cbc31ded@kernel.org>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <6e435e84-fea9-4f74-8977-d589cbc31ded@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: msbxiVd55hvgBas3noiNzGC4vBLbgUgB
X-Proofpoint-ORIG-GUID: msbxiVd55hvgBas3noiNzGC4vBLbgUgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_05,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 mlxlogscore=817 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210098
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20-11-23 03:00 pm, Krzysztof Kozlowski wrote:
> On 20/11/2023 06:58, Prashanth K wrote:
>> XHCI_SG_TRB_CACHE_SIZE_QUIRK was introduced in XHCI to resolve
>> XHC timeout while using SG buffers, which was seen Synopsys XHCs.
>> The support for this isn't present in DWC3 layer, this series
>> enables XHCI_SG_TRB_CACHE_SIZE_QUIRK since this is needed for
>> DWC3 controller.
> 
> You keep Cc-ing incorrect mailing lists (bogus addresses). Just use
> get_maintainers.pl  --no-git-fallback without changing its output.
> 
> I repeated this comment multiple times to Qualcomm. It's awesome that
> Qualcomm participates so much in upstream development, I really
> appreciate this. However repeating the same comment over-and-over again,
> makes me quite tired. Can you instruct your colleagues to use b4 which
> solves this problem? If not, use script like:
> https://github.com/krzk/tools/blob/master/linux/.bash_aliases_linux#L91
> (or one of many other variants posted by multiple people on the mailing
> lists)
> 
> Best regards,
> Krzysztof
> 



Thanks for your comments! I accidentally added 'yy' in the USB mailing 
list while configuring it. A careless mistake indeed :)

I will resend the the patch without adding the quirk (only driver 
change) since this should be applicable for all the dwc3 devices.

Thanks again,
Prashanth K
