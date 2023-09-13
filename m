Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7D379DDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbjIMBnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjIMBnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:43:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7F6115;
        Tue, 12 Sep 2023 18:43:29 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CMfnKN022593;
        Wed, 13 Sep 2023 01:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KgnrvvmpqVf8ybI9GD5xikjAqw2tZ8lUw09C/wzwsf8=;
 b=U0L/ZrttT9mZCtvNzxPRQOOoc2kBb2Qd+J892xTa32ZpfZ6lj+lGvTcqGu8Q7remO100
 oZxcJ/6Jd07aXfod6mMnWO0dQQ/U2hqGIz91AaxzFrDGbnHgDIEnBRdwYVr8KEK4/e4r
 9Yix0kFT3khoFvp8aUZnRaDpmfxdqt794qOYl3NSF2QPJr5jTho4y7LyS+hmm9d84277
 NRWjU54kdfTeZ4/Yzti8B+Qu7kkUYE03sbH8kIscNIa5VK5gdD++Jy8RgsCxEG/rmWO3
 BHZ2yE+6igiAjoVXXv+ooC2a8tP5aNxfvlMh2ij4DDJOEnBVqtKINWHh1gFmmGHV0Vjp eg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y7u8ey0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 01:43:01 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38D1h0qg029321
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 01:43:00 GMT
Received: from [10.110.7.172] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 12 Sep
 2023 18:42:57 -0700
Message-ID: <ed4de855-12e9-7f57-b384-aeed71b4afb3@quicinc.com>
Date:   Tue, 12 Sep 2023 18:42:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND] EDAC/device: Add sysfs notification for UE,CE
 count change
Content-Language: en-US
To:     Deepti Jaggi <quic_djaggi@quicinc.com>, <james.morse@arm.com>,
        <mchehab@kernel.org>, <rric@kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <quic_psodagud@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20230912212508.4691-1-quic_djaggi@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230912212508.4691-1-quic_djaggi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VX00M3KnQ5x8I8-bFcAl1XkBCvGoevDg
X-Proofpoint-ORIG-GUID: VX00M3KnQ5x8I8-bFcAl1XkBCvGoevDg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=624 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130012
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2023 2:25 PM, Deepti Jaggi wrote:
> A daemon running in user space collects information on correctable
> and uncorrectable errors from EDAC driver by reading corresponding
> sysfs entries and takes appropriate action.
> This patch adds support for user space daemon to wait on poll() until
> the sysfs entries for UE count and CE count change and then read updated
> counts instead of continuously monitoring the sysfs entries for
> any changes.
> 
> Signed-off-by: Deepti Jaggi <quic_djaggi@quicinc.com>

Can we please continue the discussion on the original thread? I don't see need of doing RESEND. 

-- 
---Trilok Soni

