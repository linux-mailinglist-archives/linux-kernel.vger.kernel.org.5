Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA46A772417
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjHGMcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjHGMb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:31:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7357810F7;
        Mon,  7 Aug 2023 05:31:56 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377CLbWv020687;
        Mon, 7 Aug 2023 12:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IeSCRN7LQH0G+TbFV5xj/6YyE8DspF7qV0UbMHUtQn8=;
 b=nPrXVmvHaf8Wz9/R2oW0bDnaRWZ6cy1QrsAo40ICODcnh87tKqwE7rFbZNp47UyagARl
 GcG3qxOLlTinHJPTLwYP4l4yy+NzmeHLV0QvXpynCnddscll4inHKlFHgShDU6mVLxvi
 PtgdpYVCgD1HSPxgVuyRdo8qyz0f3CwUiOOdOLadQ7j3oXYfhuleww6GrEunxnhp8kEh
 wC2vg5snBLM6fbBNx8fLPqxi8gw1H3/5i2o+Jc4O9uxRPSX/vzI24+utcrnjBTQWtaQf
 QN0X6+vafMINL5Leq1nn5Hc0SZo98FqTBlNSN8ZfzsraE7bhq9hImXhtlROcP3DVl7at 1w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9dcybg78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 12:31:39 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377CVdru003542
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 12:31:39 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 05:31:35 -0700
Message-ID: <81b15738-615d-a039-7bc3-22aa5b3a54bd@quicinc.com>
Date:   Mon, 7 Aug 2023 18:01:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Feedback on Qualcomm's minidump (debug) solution for end user
 device crash
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Brian Masney <bmasney@redhat.com>
CC:     <linux-samsung-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <0199db00-1b1d-0c63-58ff-03efae02cb21@quicinc.com>
 <ZL6t/sZTZBfvSYOm@brian-x1> <15caeb52-b670-9000-fa2b-b8d1b8485016@kernel.org>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <15caeb52-b670-9000-fa2b-b8d1b8485016@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7NUSzpeiHBwBl3kjaqMRKkjROOgAmd4j
X-Proofpoint-GUID: 7NUSzpeiHBwBl3kjaqMRKkjROOgAmd4j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_12,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 mlxlogscore=651 suspectscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070116
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/2023 5:14 PM, Krzysztof Kozlowski wrote:
> On 24/07/2023 18:59, Brian Masney wrote:
>> + linux-arm-kernel list
>>
>> On Thu, Jul 20, 2023 at 08:32:24PM +0530, Mukesh Ojha wrote:
>>> Hi Samsung/MTK/Any other SOC vendors,
>>>
>>> This is to bring to your notice that, we (Qualcomm) are working on
>>> upstreaming our minidump solution which is to address the problem of
>>> debugging on field device crashes where collecting entire ddr dump
>>> would not be feasible and collecting minimal data from the ddr would
>>> help in debug direction or even help in root causing issue.
>>>
>>> We have recently posted v4 version here [1]
>>>
>>> Based on comments[2], community is more worried about, if each SOC
>>> vendor come up with their own dumping method today or in future and
>>> whether it can have a common solution to a similar problem faced by
>>> other SOC vendor.
>>>
>>> We wanted to take your feedback if you also encounter a similar problem
>>> or maintain something similar solution in downstream which can be
>>> upstreamed. This will help us in a way to have a common solution in
>>> upstream.
>>>
>>> [1]
>>> https://lore.kernel.org/lkml/10dd2ead-758a-89f0-cda4-70ae927269eb@quicinc.com/
>>>
>>> [2]
>>> https://lore.kernel.org/lkml/CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com/
>>
>> Adding the main ARM list to solicit feedback from other silicon
>> manufacturers.
>>
>> The cover sheet on the v4 patch set is available at:
>> https://lore.kernel.org/lkml/1687955688-20809-1-git-send-email-quic_mojha@quicinc.com/
> 
> I doubt anyone follows the lists, so at least Cc some maintainers.
> 
> +Cc Alim, Kukjin, Vignesh, Nishanth, Matthias.

Thanks @Krzysztof/@Brian for extending the list.

-Mukesh
> 
> Best regards,
> Krzysztof
> 
