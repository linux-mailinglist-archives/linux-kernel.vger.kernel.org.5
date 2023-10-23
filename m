Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11487D2E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjJWJXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjJWJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:22:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580B7DF;
        Mon, 23 Oct 2023 02:22:57 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N7ROKB001098;
        Mon, 23 Oct 2023 09:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fwbyazHm8hZVd9PZZHKaafaMldOcy5KTgRiIiji7g5w=;
 b=m3plG33T2A46Yjv0tmLJP7Vdt+4SKqXnHZgaxXR65sLy6/hbfPoeXV1aRkyp2cq5v+Af
 c04HWcsNNyiZzFE2nPGIRHXiTXNgy0gkltDElvOs/HJSO832KUgur+an3EpOiVfytGiV
 ccq5Fp6sh1KE8TboznCx/BdpY1eeBsuY7bWE1GtQc5Htjd2d51MNeyqx0Vv36ttob45O
 G2V4iM3Bo3HP63kYhIgqf15Pi2/wAzwTBnv4TmjaTK5Rg7In9SeabfSuQL4W3oHEOT5B
 Ak85FXoYRdoQxrcIG6x53a+yAKiIp/LzR19XY9yqI0AH2GaIVBWj/zdJ+33eC6EhruWp dw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv40ukvqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:22:50 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N9MnPF021668
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:22:49 GMT
Received: from [10.216.32.116] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 02:22:46 -0700
Message-ID: <ed5f20a5-52e5-9869-1a3f-576beb955f97@quicinc.com>
Date:   Mon, 23 Oct 2023 14:52:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tracefs/eventfs: Modify mismatched function name
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        <rostedt@goodmis.org>
CC:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20231019031353.73846-1-jiapeng.chong@linux.alibaba.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20231019031353.73846-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tpkuJTp245L927l8gSIK4AvNj8ZIyO3H
X-Proofpoint-ORIG-GUID: tpkuJTp245L927l8gSIK4AvNj8ZIyO3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_06,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1011 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=737
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230080
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2023 8:43 AM, Jiapeng Chong wrote:
> No functional modification involved.
> 
> fs/tracefs/event_inode.c:864: warning: expecting prototype for eventfs_remove(). Prototype was for eventfs_remove_dir() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6939
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> ---
>   fs/tracefs/event_inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 1ccd100bc565..ba9d1cb0d24c 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -855,7 +855,7 @@ static void unhook_dentry(struct dentry **dentry, struct dentry **list)
>   	}
>   }
>   /**
> - * eventfs_remove - remove eventfs dir or file from list
> + * eventfs_remove_dir - remove eventfs dir or file from list
>    * @ei: eventfs_inode to be removed.
>    *
>    * This function acquire the eventfs_mutex lock and call eventfs_remove_rec()
