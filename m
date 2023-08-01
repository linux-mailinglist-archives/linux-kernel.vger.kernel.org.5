Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B7476A877
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 07:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjHAFsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 01:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjHAFs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 01:48:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8B31B5;
        Mon, 31 Jul 2023 22:48:25 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3712gRsm026351;
        Tue, 1 Aug 2023 05:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4Zn7E0Dl+W5BuwFXIKMOv+P0FYRaC1MsuIZCNeQvZfE=;
 b=Q8OLNOBhma2YcjkuHn4D1B/UHK/Uvmw+xyUPWJbyiQjhtiLwH6b2nkxKqe8moc6B3u6u
 O/l2UTHnUYb+vSNv1vNWkq6Vt0DSoP5ktZgEJM3+UhzOeQjgbGFyxl0DqY/D2Z57k0Ds
 95yw+hnjEeTsWYzRMtgcnH1q2cVrtinoF+w1AgiQ8ikZuNHJWohP+bPcOz4clc/RpEBt
 ra/rgdhlVk2JQCl/WB5wvnbP65SoBcyqp8gmeSBx+sDxVsInqZgdrsAvQd62Dxdtbg9i
 RBCWGORArslGr1KhowBM8nL6t3tFxjF8RhM6p1xQ9zvwDG9CjDWUbiYQLpGVZb4V7Nby cA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6rharcux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 05:48:16 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3715mFfJ027519
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 05:48:15 GMT
Received: from [10.110.54.109] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 22:48:12 -0700
Message-ID: <ce06c845-f3c8-a733-dc21-ee0ba4b4ca68@quicinc.com>
Date:   Mon, 31 Jul 2023 22:48:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] EDAC/device: Add sysfs notification for UE,CE count
 change
From:   Trilok Soni <quic_tsoni@quicinc.com>
To:     Deepti Jaggi <quic_djaggi@quicinc.com>, <james.morse@arm.com>,
        <mchehab@kernel.org>, <rric@kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <quic_psodagud@quicinc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20230731220059.28474-1-quic_djaggi@quicinc.com>
 <3e2bf03e-2bc1-445e-d8ce-4975c044eea0@quicinc.com>
Content-Language: en-US
In-Reply-To: <3e2bf03e-2bc1-445e-d8ce-4975c044eea0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0dEiw39yIqzBDRsd-yshWhcjDBf25sTv
X-Proofpoint-ORIG-GUID: 0dEiw39yIqzBDRsd-yshWhcjDBf25sTv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=475 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010053
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/2023 3:40 PM, Trilok Soni wrote:
> On 7/31/2023 3:00 PM, Deepti Jaggi wrote:
>> A daemon running in user space collects information on correctable
>> and uncorrectable errors from EDAC driver by reading corresponding
>> sysfs entries and takes appropriate action.
> 
> Which daemon we are referring here? Can you please provide the link to 
> the project?
> 
> Are you using this daemon?
> 
> https://mcelog.org/ - It is for x86, but is your daemon project different?
> 
>> This patch adds support for user space daemon to wait on poll() until
>> the sysfs entries for UE count and CE count change and then read updated
>> counts instead of continuously monitoring the sysfs entries for
>> any changes.
> 
> The modifications below are architecture agnostic so I really want to 
> know what exactly we are fixing and if there is a problem.

+ CC linux-arm-msm

Please keep linux-arm-msm in CC if there is a next revision.

-- 
---Trilok Soni

