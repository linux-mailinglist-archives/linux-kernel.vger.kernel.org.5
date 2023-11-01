Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463447DDBB2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjKADxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 23:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjKADxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 23:53:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D486A4;
        Tue, 31 Oct 2023 20:52:58 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A13DHNN011202;
        Wed, 1 Nov 2023 03:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lI1uPXHNWfyND8UYOC0iunYvAoyuHzcWQtdeMMxdcy8=;
 b=Rr/M4KUlmxqTJ5H4BZRCXelUalKEaRbPKnnlXrU60MGcdVvxsDTqHdQXJnGuQdxAA2SU
 /l8tqd+BOTZgsdChPw3KQDVQ6wZDc/WhmP7zNHvouvS61tVD3WwmZLnY1JiMSvmAxSLO
 C7juaM7YouG0l3s0YR8f53WcCNbnrvWQXajj8OCMQNn4oyDLPry7oF5G6lcczw0KAHa7
 4VQc88zYwzZ4YOpzSCcw9AEKChxTYkzMJv/MVvUwdCaXG+lFVqX7lQf+EmzUiTgwLvA4
 ohixtB+2rAbs4BbngutMNaNjnV5lDf4O+KweMB8RYoz6o/RbkkN51cCuy3UZwk/eWU4F 7w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3ayvrk2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 03:52:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A13qbul013415
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Nov 2023 03:52:37 GMT
Received: from [10.253.74.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 31 Oct
 2023 20:52:33 -0700
Message-ID: <e984ae48-5bc1-8bbb-b5cc-49832d789a47@quicinc.com>
Date:   Wed, 1 Nov 2023 11:52:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] scsi: ufs: ufs-sysfs: Expose UFS power info
To:     Bart Van Assche <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1698745992-5699-1-git-send-email-quic_cang@quicinc.com>
 <fe022e5f-e7da-480b-9d1c-ce2a6388d768@acm.org>
Content-Language: en-US
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <fe022e5f-e7da-480b-9d1c-ce2a6388d768@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EWJtmnr_fPNk38WXXD6Ax_tRZMbhXF4B
X-Proofpoint-ORIG-GUID: EWJtmnr_fPNk38WXXD6Ax_tRZMbhXF4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_10,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 phishscore=0 priorityscore=1501 mlxlogscore=764
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010031
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 11/1/2023 12:23 AM, Bart Van Assche wrote:
> On 10/31/23 02:53, Can Guo wrote:
>> +What: /sys/bus/platform/drivers/ufshcd/*/power_info/mode
>> +What:        /sys/bus/platform/devices/*.ufs/power_info/mode
>> +Date:        September 2023
>> +Contact:    Can Guo <quic_cang@quicinc.com>
>> +Description:    This file shows the UniPro power mode of UFS link:
>> +        == ====================================================
>> +        1   FAST_MODE
>> +        2   SLOW_MODE
>> +        4   FASTAUTO_MODE
>> +        5   SLOWAUTO_MODE
>> +        == ====================================================
>> +
>> +        The file is read only.
>
> For this attribute and the attributes below, shouldn't these be exported
> as text instead of as numbers? Shell scripts that read and use these
> attributes will be much easier to read if these attributes are changed
> from numeric into a textual.

Done.


Thanks,

Can Guo.

>
> Thanks,
>
> Bart.
