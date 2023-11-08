Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFC47E5228
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343628AbjKHIte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjKHIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:49:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED33197;
        Wed,  8 Nov 2023 00:49:28 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A82qV4Y014988;
        Wed, 8 Nov 2023 08:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DCA0oQZXop6+akQSIhzDloGbKf2fbuO5jWBs663BxbI=;
 b=kkmtpINjF/k7dCAz+qInDyKf3X0QDy3LhSjn9vzEaQIZTn1imYBxXdPE1+NnIJ/Oehi4
 SxbefjKdDJsYWWYJ5XrwzvnVkiLuj8UpWDrbyJoTGvw/ogmXkrci9Ed+ji7tnfl2m5gP
 mvNFrcgEhrOe7cPy/L3mwAnHM0yLEYnDHlpYHMg3hwD+YIg3S0S8doQAtbtVTgwX6Rxr
 TC3IOqZtouHt9OYPft+gA8lOwOIlXygSw6BJwFSxBgAtZQjTKs/1guWwH08zkY75HryM
 Ysymr+Xu6/1+DOymm/d8bHj4NYxqefZM/32WoAZw8mrNFnkeMyZcBjv9XdyYAM+e2Eq9 NQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7w2ds4dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 08:46:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A88k9ZF006418
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 08:46:09 GMT
Received: from [10.253.34.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 8 Nov
 2023 00:46:05 -0800
Message-ID: <c1ec8f66-6f3d-ae1c-6fca-27f4d6e91b8a@quicinc.com>
Date:   Wed, 8 Nov 2023 16:46:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/7] scsi: ufs: ufs-qcom: Set initial PHY gear to max
 HS gear for HW ver 5 and newer
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Can Guo <cang@qti.qualcomm.com>
CC:     <bvanassche@acm.org>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <junwoo80.lee@samsung.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-6-git-send-email-cang@qti.qualcomm.com>
 <20231108053415.GE3296@thinkpad>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231108053415.GE3296@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vn2uCaR1X_8sh0l9WS2-A_NX1qY1BD2w
X-Proofpoint-ORIG-GUID: vn2uCaR1X_8sh0l9WS2-A_NX1qY1BD2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 11/8/2023 1:34 PM, Manivannan Sadhasivam wrote:
> On Mon, Nov 06, 2023 at 08:46:11PM -0800, Can Guo wrote:
>> From: Can Guo <quic_cang@quicinc.com>
>>
>> Set the initial PHY gear to max HS gear for hosts with HW ver 5 and newer.
>>
> 
> How about,
> 
> "For UFSHC >= 5.0, set the initial PHY gear based on the gear value returned by
> ufs_qcom_get_hs_gear(). For the rest, use the existing default value of G2."
>

It is much better, will improve in next version.

>> This patch is not changing any functionalities or logic but only a
>> preparation patch for the next patch in this series.
>>
> 
> You are also moving the default phy_gear code to ufs_qcom_set_host_params(). So
> it should be mentioned in the commit message.
> 

Sure.

Thanks,
Can Guo.
