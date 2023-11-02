Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E587DEA67
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 02:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbjKBBtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 21:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjKBBtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 21:49:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F15A110;
        Wed,  1 Nov 2023 18:49:26 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A20vYpB025132;
        Thu, 2 Nov 2023 01:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DNmtD1Fyx0xLwPw+8zOcJX13mv4B2aavfM2aRPNcGZU=;
 b=O+T6YT9EjTajZinTmphRzXYdyeFQpdJw4pNO9spo1lHGKPqEQWuIcE2PJh1AG7Q/t3Qv
 QruS9CzCJUs+F9zJmZ6EwHpuevCe0EaeUvoFPvuZZf44h3lYtr3uWsuvcNnpXGJurnp7
 W++Vr5RMSWkqK7hpHD4bc0vDnUY3X4evnolOGBXddfy0rY1WsJaI2AXDXiqsR0d5/HgI
 Y0Ck0OkDglXD7Se2FkbZrvPq5h6//pkrm0gzXkqhEvXMMivD1HZP0xTSmkm/fNdjI53Z
 bKDBK8qxMDLiGy75RZVjfxdIuta88Iv7ltveHXJngFVpsxUPlpyoO2P/N2S42MxPPGoP dQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3a5ekyxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 01:49:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A21n49Q002371
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Nov 2023 01:49:04 GMT
Received: from [10.253.74.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 1 Nov
 2023 18:49:01 -0700
Message-ID: <c4daed9a-4d76-a248-d560-edb851b4927c@quicinc.com>
Date:   Thu, 2 Nov 2023 09:48:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] scsi: ufs: ufs-sysfs: Expose UFS power info
To:     Bart Van Assche <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1698811243-5024-1-git-send-email-quic_cang@quicinc.com>
 <ebdbb2eb-0339-40a7-9697-6148fcda81a2@acm.org>
Content-Language: en-US
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <ebdbb2eb-0339-40a7-9697-6148fcda81a2@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B7oJ4lXpztjDpjji8uCVxKjctiTVRV37
X-Proofpoint-ORIG-GUID: B7oJ4lXpztjDpjji8uCVxKjctiTVRV37
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=892
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020013
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 11/2/2023 1:07 AM, Bart Van Assche wrote:
> On 10/31/23 21:00, Can Guo wrote:
>> +    return sysfs_emit(buf, "%s\n", hba->pwr_info.hs_rate ?
>> + ufshcd_ufs_hs_gear_to_string(hba->pwr_info.gear_rx) :
>> + ufshcd_ufs_pwm_gear_to_string(hba->pwr_info.gear_rx));
>> +}
>
> A nit: this is not how kernel code should be indented. I think that
> "ufshcd_..." should be aligned with "buf,".
>
> Anyway:
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>


Will address it in next version.


Thanks,

Can Guo.

