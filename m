Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5687E3AAD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbjKGLCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjKGLB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:01:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE98EA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:01:55 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7A8O9D024099;
        Tue, 7 Nov 2023 11:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hYFzKG0Bzit1hbzSGTpLmhkQeKvJs4Z83u1O4jqdkcM=;
 b=QoVP9h8fEBKk86hL2oeidTKHE2MX6lNAJ2pAt93FpHT8va4mWxHig5qdqmPBYJJh4aDs
 bA6zIsNmjfS0tI7CMr3kIanVnN+bZasQFmdH8myqIw4UwPg3T6G8T7Gl1e0p26IRnWJ5
 hJYkiN9eco5lF45X1XKPpc3vrApWwxJ83JUZnNTOUsYhMo4nNzoBgmZ9CzuMWdyXHLDB
 z5SuZKrDmfQTgzO8ZJq4AciWrGHHNURonTuE7UAuxMiv3DSpcRQYk7vkjDMT7erYiiq9
 ZSFvkomIPawylWqRP+gQMmslm8tQvE2RurLzyM8i7zeGKyGrZfWQp01Q+aqDHYKJT9ou 9w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u6wer38s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 11:01:48 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A7B1lDL022013
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Nov 2023 11:01:47 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 7 Nov
 2023 03:01:46 -0800
Message-ID: <57d38bd4-d9ea-6ce4-b7c1-1a05097c7338@quicinc.com>
Date:   Tue, 7 Nov 2023 16:31:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] devcoredump: Send uevent once devcd is ready
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1699280735-31482-1-git-send-email-quic_mojha@quicinc.com>
 <2023110659-december-cranium-c98e@gregkh>
 <c4abc49c31643baa34bf889d689e8c587c28da54.camel@sipsolutions.net>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <c4abc49c31643baa34bf889d689e8c587c28da54.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZJ_YJMCkt_zGn7mLM6yPlVB_IgzHIeTh
X-Proofpoint-GUID: ZJ_YJMCkt_zGn7mLM6yPlVB_IgzHIeTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=611 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070091
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2023 1:07 AM, Johannes Berg wrote:
> On Mon, 2023-11-06 at 20:36 +0100, Greg KH wrote:
>> On Mon, Nov 06, 2023 at 07:55:35PM +0530, Mukesh Ojha wrote:
>>> dev_coredumpm() creates a devcoredump device and adds it
>>> to the core kernel framework which eventually end up
>>> sending uevent to the user space and later creates a
>>> symbolic link to the failed device. An application
>>> running in userspace may be interested in this symbolic
>>> link to get the name of the failed device.
>>>
>>> In a issue scenario, once uevent sent to the user space
>>> it start reading '/sys/class/devcoredump/devcdX/failing_device'
>>> to get the actual name of the device which might not been
>>> created and it is in its path of creation.
>>>
>>> To fix this, suppress sending uevent till the failing device
>>> symbolic link gets created and send uevent once symbolic
>>> link is created successfully.
>>>
>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>
>> What commit id does this fix?
>>
> 
> I guess the original introduction.
> 
>>   What in-kernel driver does this affect
>> that is using devcoredump?
>>
> 
> All of them really, it's really about how fast userspace is to access it
> after the event.
> 
> Looks fine to me, FWIW, but a Fixes tag wouldn't hurt.

Thanks, will add the Fixes tag.

-Mukesh
> 
> johannes
