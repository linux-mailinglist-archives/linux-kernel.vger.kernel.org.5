Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9186D7DC585
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 05:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbjJaErE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 00:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjJaErC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 00:47:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF92498;
        Mon, 30 Oct 2023 21:46:59 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V4jhvA026493;
        Tue, 31 Oct 2023 04:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hkr+7VY4tvVw+B1r5/YvNQcDTOdHdbaYXqeI/KPxxKo=;
 b=mVO8ywNgHZbxGXuH+UwzIceRsqvfY+lLKvJTN1lbZkcEUhwiQpYxHmuH7J+iQjeIBzxJ
 N+WRZgIKC0+2AoXF0p+wTul8TFesw0ly7JWvGNX6tmFMvzgIRj4zG7bppJa0qls61OKk
 yDaj5GJ6dWC/dbNF4OSOZAhoFN1IzD7DUR6LZ7ZqSpGLDP7xdcODZ+y1F5eA6IPkJQZ0
 xpekESj6nz9VbNfpBD894Qzm8b+bCZMrUQtntbvrBxrdRh6K961zbccHf/9jaq8+DiNo
 5eqqQfRCXKBcCJ51BSuiWZs4SjnQJaF6yfeOhRjl9lVV4NIJfwhTPwKbjdFzUX/BEh2P 6Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u280jtgud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 04:46:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V4kcBH005362
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 04:46:38 GMT
Received: from [10.253.74.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 21:46:35 -0700
Message-ID: <555470f0-91ec-ea8c-fd1d-3fb5d7059c26@quicinc.com>
Date:   Tue, 31 Oct 2023 12:46:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5/6] scsi: ufs: ufs-sysfs: Expose UFS power info
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <mani@kernel.org>,
        <quic_nguyenb@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "Avri Altman" <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        "Lu Hongfei" <luhongfei@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-6-git-send-email-quic_cang@quicinc.com>
 <78ad6b62-e197-417c-8f68-332d25c48879@acm.org>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <78ad6b62-e197-417c-8f68-332d25c48879@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7n7pC_6-2MgVgILmW9dxE1BfqyYJwJrM
X-Proofpoint-ORIG-GUID: 7n7pC_6-2MgVgILmW9dxE1BfqyYJwJrM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=552
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310035
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 10/27/2023 3:53 AM, Bart Van Assche wrote:
> On 9/10/23 22:59, Can Guo wrote:
>> Having UFS power info available in sysfs makes it easier to tell the 
>> state
>> of the link during runtime considering we have a bounch of power saving
>> features and various combinations for backward compatiblity.
>
> Since this patch introduces new sysfs attributes, it should include an
> update for Documentation/ABI/testing/sysfs-driver-ufs.
>
> Bart.

Yes, changes to Documentation/ABI/testing/sysfs-driver-ufs. is in below 
patch.

https://patchwork.kernel.org/project/linux-scsi/patch/1694411968-14413-7-git-send-email-quic_cang@quicinc.com/

I will address your comments and combine them two in one change and 
re-submit.

Thanks for your review.


Best Regards,

Can Guo.

