Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7F778B646
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjH1RTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjH1RTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:19:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11374B0;
        Mon, 28 Aug 2023 10:19:18 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SGBZft022780;
        Mon, 28 Aug 2023 17:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D2ksgObqAlukQWeANxBNxuwi2J0iB4+8/6c9S/1O/tk=;
 b=PT5cg4ob8Z9jINDlFJyM8FPaIMHXOQ0wcX4sfAb6xkahoeMmI1WhdUva8mF7g9dfFTRm
 PPMEq+Rl+73QphpufRcQRiRE4Kdn7fcJ1LeA6BmSve80P8J3GeOheXhfAhCi6W2aCC9+
 7iFGRJb3nLBe9TGAZsUV2X/fWyT8O8GT61+GWwozdI1C3oE+oG8P9QoOG0L6BzosE13T
 hPeCNncWm/DVTEUnZDrKdvsmE536SfwDREq+QlO0MRiLD2u4w/mQs1NTZoSFiPucGH5o
 IhXpIlYLuPqWvLINEU68wuqpiycfHUSUfOEa1pLhs7rMiqbMTQkXxiupmh0Hp2DT/uMa UQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq9m8v97c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 17:19:11 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SHJ7ch009970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 17:19:07 GMT
Received: from [10.216.60.216] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 10:19:01 -0700
Message-ID: <badd7471-b28f-4948-b6b4-eddb8bf1b0d6@quicinc.com>
Date:   Mon, 28 Aug 2023 22:49:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Arun Kumar Neelakantam <quic_aneelaka@quicinc.com>
Subject: Re: [RFC PATCH 0/1] Add driver to read secondary bootloader (XBL) log
To:     Ninad Naik <quic_ninanaik@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC:     <psodagud@quicinc.com>, <quic_ppareek@quicinc.com>,
        <quic_kprasan@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>
References: <20230822121512.8631-1-quic_ninanaik@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230822121512.8631-1-quic_ninanaik@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CnhnLhBUdJS5nYTihipZ0q85IOZeKst3
X-Proofpoint-GUID: CnhnLhBUdJS5nYTihipZ0q85IOZeKst3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_15,2023-08-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/2023 5:45 PM, Ninad Naik wrote:
> Boot time logs for Qualcomm secondary boot-loader or XBL can help to
> identify different set of information regarding firmware configuration,
> SoC boot KPIs. A dedicated region is carved out in the memory map in order
> to store this log in the memory.
> 
> The objective of this driver is to read the XBL boot log stored in
> this memory region post boot-up, and provide an entry in debugfs, which
> can be used to read back the logs and print them on to the console.
> 

I see couple of use cases for this kind of logging like logs from boot, 
Hypervisor, Trusted Execution environments and also one in upstream for 
chromeos EC console. Can this be made a generic driver which take log 
name, log memory buffer address and size to read from debugfs.
> Further, this log can be parsed to extract different set of information
> as required.
> 
> For example, one use case can be parsing boot time KPIs to calculate,
>   - PBL End time
>   - SBL End time
>   - UEFI Start/Stop time
> 
> Corresponding log contents as captured in /sys/kernel/debug/xbl_log entry
> which prints the above counters,
> 
>          S -     59378 - PBL, End
>          B -     68198 - SBL1, Start
>          B -   1308877 - SBL1, End
>          UEFI Start     [ 3370]
>           - 0x0AF001000 [ 3375] Sec.efi
>          UEFI Total : 466 m
>          POST Time      [ 3836] OS Loader
>           - 0x0ABE10000 [ 3838] LinuxLoader.efi
>          Exit EBS        [ 4878] UEFI End
> 
>          /* Note - these are few excerpts picked from the complete XBL log
>           *        as tested on SA8775p
>           */
> 
> Ninad Naik (1):
>    soc: qcom: Add driver to read secondary bootloader (XBL) log
> 
>   drivers/soc/qcom/Kconfig        |  13 +++
>   drivers/soc/qcom/Makefile       |   1 +
>   drivers/soc/qcom/dump_xbl_log.c | 139 ++++++++++++++++++++++++++++++++
>   3 files changed, 153 insertions(+)
>   create mode 100644 drivers/soc/qcom/dump_xbl_log.c
> 
