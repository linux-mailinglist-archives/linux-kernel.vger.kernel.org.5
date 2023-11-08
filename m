Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34747E51B1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjKHIKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjKHIK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:10:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3C8119;
        Wed,  8 Nov 2023 00:10:24 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A83jANC001200;
        Wed, 8 Nov 2023 08:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Q8Zimj+6ER+LiXleTvjK47h11kqzqHinnD5XfGGj8yI=;
 b=SrYBjsrFhpidRJ8ixgqmTBjGSRuU2F6UxUl7Xz934yfzwcS99rzYDfTzh3BvBI4wxOEv
 nrrp7gsJ/MEzpsC/NOjLxWN4dvzEWaiXLiweBjNGTt5W6l0wIS3jGMDd7U/m1EpHix9/
 SJ+r8KPcLbexfBODyHCDyDjdp+rMgjayaB5aXndPvMkFK+2TqeM+5S1FbDhRg7P/u9Bx
 bEZSpM384LYSqnlVaWgoZrhsDVgne8htRBy/RiN0rV/VTzpzmQt7RPob7GqsjskUmzZf
 Twya4ss3CF9WEEi6F2qg+yoHduqiwac95iYt0Gq6HaRBPQ4dZbvKEXO5uUd6RivsJxnK ag== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7xyu0tx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 08:09:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A889U8h027582
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 08:09:30 GMT
Received: from [10.253.34.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 8 Nov
 2023 00:09:26 -0800
Message-ID: <88bd674d-4fc9-0ff8-5f05-cf9f124c3f12@quicinc.com>
Date:   Wed, 8 Nov 2023 16:09:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/7] Enable HS-G5 support on SM8550
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Can Guo <cang@qti.qualcomm.com>
CC:     <bvanassche@acm.org>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <junwoo80.lee@samsung.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <20231108051156.GB3296@thinkpad>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231108051156.GB3296@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zwsWysGdt-z8URBc7hFl7_TwOlmKNnv8
X-Proofpoint-GUID: zwsWysGdt-z8URBc7hFl7_TwOlmKNnv8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=716 adultscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 11/8/2023 1:11 PM, Manivannan Sadhasivam wrote:
> On Mon, Nov 06, 2023 at 08:46:06PM -0800, Can Guo wrote:
>> This series enables HS-G5 support on SM8550.
>>
>> This series is rebased on below changes from Mani -
>> https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-1-manivannan.sadhasivam@linaro.org/
>> https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-2-manivannan.sadhasivam@linaro.org/
>>
>> This series is tested on below HW combinations -
>> SM8550 MTP + UFS4.0
>> SM8550 QRD + UFS3.1
>> SM8450 MTP + UFS3.1 (for regression test)
>>
> 
> You are sending the patches from QTI email and that's not supposed to happen I
> believe.
> 
> - Mani
You are right, not sure what went wrong with my config. Will change back 
to quicinc mail next time.

Thanks,
Can Guo.
