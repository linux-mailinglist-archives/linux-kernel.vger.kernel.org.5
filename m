Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C697AFB29
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjI0Ge6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjI0Ge6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:34:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8734A3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:34:56 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R50DPf014618;
        Wed, 27 Sep 2023 06:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=61N9ZoqjtzuU2rmyiA1peYTNxh0ocssrGJlaOl23i0o=;
 b=eexUSusyIaAPnTZL3HpVrTCsHwVq4Tx0CXT0dub4GAhDPwhDGaBMIzMdB3kwtqBVx1OY
 Xjl5HL9g0hgDM1GgIcqbzJTR/iePoANGB+0jSdc/eVoJVfGsGEhDtp8UW3ygWqkiRZNi
 Xj6ankuHBm4WkHS+12B/Kbas7kdxa4wHAy1hTDfhtcfreok5awq3lhXZNNuE/Yk4YlOB
 1mWYPIBoJLdL7i1UkWxbyQi+BmobJmqEuVt55dapyuiSStdfGO1QGPHxEAiHLINLzsma
 SYCwmGGpZUiw4AYFOYqoW7aAwFou6xx3yaN5APXmrmEhshrELWSqtkSyOiGdXEL4JU7p EQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc43ms57j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:34:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R6Yldb007407
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:34:47 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 26 Sep
 2023 23:34:45 -0700
Message-ID: <9f04d29e-bd83-e8c1-7e55-b5a0441abc9b@quicinc.com>
Date:   Wed, 27 Sep 2023 14:34:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH] driver core: Clear FWNODE_FLAG_LINKS_ADDED in
 device_links_purge()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <saravanak@google.com>
References: <1695781810-5700-1-git-send-email-quic_zhenhuah@quicinc.com>
 <2023092722-proofread-vindicate-f26c@gregkh>
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <2023092722-proofread-vindicate-f26c@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ji4GXdBZ-yeE6oet8HOtsXLsBQ3VWr1H
X-Proofpoint-GUID: ji4GXdBZ-yeE6oet8HOtsXLsBQ3VWr1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270054
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/27 13:57, Greg KH wrote:
> On Wed, Sep 27, 2023 at 10:30:10AM +0800, Zhenhua Huang wrote:
>> Flag FWNODE_FLAG_LINKS_ADDED stops fwnode links creation. Current kernel
>> only adds it once after fwnode links creation in fw_devlink_parse_fwnode().
>> After that even device links being purged, the flag will not be cleared.
>>
>> Fwnode links are converted to device links and will not be added back
>> forever in normal case. Essentially if a device is registered and
>> unregisted (also deleted) before it is probed (due to missing fwlink
>> dependencies, abort in device_links_check_suppliers), the fwlink is not
>> setup next when device is newly created again. This means the probe gets
>> called without meeting all dependencies.
>>
>> It usuallly happens in the case of a glue driver. Of_platform_populate()
>> allows us to populate subnodes. We may do it in ancestor node probing
>> function, then check subnode's probing status because there may be chances
>> that suppliers of subnode are not ready. We may further need to do
>> of_platform_depopulate(which purges device links) and in some time
>> of_platform_populate() again. Such case we miss fwnode links(so that device
>> links) during second time of populating subnodes.
>>
>> Fix it by Clearing FWNODE_FLAG_LINKS_ADDED flag in purging device link
>> func, indicates both fwnode links and device links are absent.
>>
>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>> ---
>>   drivers/base/core.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index b7d7f41..2a1975d 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -1630,6 +1630,10 @@ static void device_links_purge(struct device *dev)
>>   		__device_link_del(&link->kref);
>>   	}
>>   
>> +	/* Clear flags in fwnode. Give a chance to create fwnode link again */
>> +	if (dev->fwnode)
>> +		dev->fwnode->flags &= ~FWNODE_FLAG_LINKS_ADDED;
>> +
>>   	device_links_write_unlock();
>>   }
>>   
>> -- 
>> 2.7.4
>>
> 
> Why is this a RESEND?  What was wrong with the first version?

As per request of codes author, I CCed saravanak this time :)
Nothing else changed.

Thanks,
Zhenhua
