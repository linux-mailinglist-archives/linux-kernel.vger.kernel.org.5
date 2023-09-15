Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7317A1374
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjIOCBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjIOCBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:01:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DF91AE;
        Thu, 14 Sep 2023 19:00:59 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F1V6Q5005452;
        Fri, 15 Sep 2023 02:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Wwhkcd5KuFfRX3TvSmdFYq+5k6+JLBhSTaII9+ZyzRk=;
 b=b381ccfuetInRtus+AKdVnOj/ofVv0qF2txAIpgiQQXw42Sviu6WzEafciLZKOS3SXH0
 gA+rLp6+tqt17QDjrRu2Wg1GKVFjmqRNajItYilH5OB0W/PxzKqWCe2Se0zq3X4kdxbC
 HAz8rp+UiDKjzWxpAkxgw2kkYRiPjdlzJg35+LVJT80gKPwWyQFXRWr6zo5oioiNsA3J
 +GnZCCBTRh39EeJehFQAGFtyngTQpYfkPW/otUEzbIqe/4FktLdPD41UJYgIvPH0pnCU
 cHgnm2c69EbArlV5JrgNi0145LEGGAanoJtD0j+DwQ38EgS6c+ew26KUM7kilZ+ic3yY lg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4dnng1nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:00:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F20HYa029583
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:00:17 GMT
Received: from [10.253.10.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 19:00:15 -0700
Message-ID: <dadd1df8-a861-3baa-8a21-0cd7dbabcbe3@quicinc.com>
Date:   Fri, 15 Sep 2023 10:00:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 6/6] scsi: ufs: ufs-sysfs: Introduce UFS power info sysfs
 nodes
Content-Language: en-US
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, <mani@kernel.org>,
        <quic_nguyenb@quicinc.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        "Bean Huo" <beanhuo@micron.com>, Lu Hongfei <luhongfei@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-7-git-send-email-quic_cang@quicinc.com>
 <8d95d169-452f-e426-938f-ccadf26de9ca@quicinc.com>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <8d95d169-452f-e426-938f-ccadf26de9ca@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bpJqWIAhwrzmugtubIlKdZDO6PNTLL2u
X-Proofpoint-GUID: bpJqWIAhwrzmugtubIlKdZDO6PNTLL2u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_02,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=729 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150016
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nitin,

On 9/14/2023 7:35 PM, Nitin Rawat wrote:
>
>
> On 9/11/2023 11:29 AM, Can Guo wrote:
>> Having UFS power info available in sysfs makes it easier to tell the 
>> state
>> of the link during runtime considering we have a bounch of power saving
>> features and various combinations for backward compatiblity.
>
> Please fix spelling mistake *bounch -> bunch

done


Thanks,

Can Guo

