Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBBD76A43A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjGaWkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaWkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:40:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E51198D;
        Mon, 31 Jul 2023 15:40:44 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VMbxgh016037;
        Mon, 31 Jul 2023 22:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rIlBLIb6J29dQChrALBuoQv3IUru+Su4cNGIp9R6VBM=;
 b=CQpCVOceVSzG/zkrcdzTVAgLDszSm3tfp9irZVQZTmTWZbETwbWwjSdg9shLTHxpvGxc
 hcyIvCBR11ZzB7F+Wwv7G7oJRInRYbgOPl4DIJZM9Uy0AeQ/QYNTROpDqAyMKsm1OssL
 9ViwfxnkRniBJ0FPGMBQZafbmS/3oD+izUch9ZAISqN01SEaw39BUQDkno0fMhSgyNQI
 7O69hbMmZLvER7tm/nLQEK/B3y42LgKmnOB/h+nzFwKv6IJ3TuSmwRg7EI5rA5SebjLI
 TiZ8ObDuBsYDDpDSASP+6mPuZyBwr/vav3tS1Wxgi6pKyYel3nDhWXUH4/kCIYUiLE5B vA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6ckfhnqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 22:40:26 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36VMePaK021667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 22:40:25 GMT
Received: from [10.110.3.154] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 15:40:23 -0700
Message-ID: <3e2bf03e-2bc1-445e-d8ce-4975c044eea0@quicinc.com>
Date:   Mon, 31 Jul 2023 15:40:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] EDAC/device: Add sysfs notification for UE,CE count
 change
Content-Language: en-US
To:     Deepti Jaggi <quic_djaggi@quicinc.com>, <james.morse@arm.com>,
        <mchehab@kernel.org>, <rric@kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <quic_psodagud@quicinc.com>
References: <20230731220059.28474-1-quic_djaggi@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230731220059.28474-1-quic_djaggi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P3kjkgWgpgSkJneTiXXD32nX3aszakiC
X-Proofpoint-ORIG-GUID: P3kjkgWgpgSkJneTiXXD32nX3aszakiC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=416 spamscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310206
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/2023 3:00 PM, Deepti Jaggi wrote:
> A daemon running in user space collects information on correctable
> and uncorrectable errors from EDAC driver by reading corresponding
> sysfs entries and takes appropriate action.

Which daemon we are referring here? Can you please provide the link to 
the project?

Are you using this daemon?

https://mcelog.org/ - It is for x86, but is your daemon project different?

> This patch adds support for user space daemon to wait on poll() until
> the sysfs entries for UE count and CE count change and then read updated
> counts instead of continuously monitoring the sysfs entries for
> any changes.

The modifications below are architecture agnostic so I really want to 
know what exactly we are fixing and if there is a problem.


-- 
---Trilok Soni

