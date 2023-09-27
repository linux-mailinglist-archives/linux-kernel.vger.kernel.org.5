Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897177AFB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjI0Gcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0Gcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:32:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E159C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:32:48 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R3u25e011005;
        Wed, 27 Sep 2023 06:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=h5K1jlSfNrsARIhYsOUQRLM3hcs6F6i6uIdfZHvbKBU=;
 b=ZsevH2crWpUKqktKcnOyaPes74V9iY6oq3rLMFnFP97/6ZHb8dKu3qoQKAbKfjHmQG/7
 7EnBn6d+Aus09Oh6ZFD65sEzkiOo/ZkXvUSE4rMU3ppDg752iqy79F3BGlj9UQB5sLIa
 taPvUtreJpWvhLRaKTg+tYoOwP0W01y4tv4iQxKjLtISwosP9Fh+Zozo6tlXOaMvu/VL
 wHjlm2hB9w35jeiE64Qpyl888RGD8TOm/fJe6IKWt18O5Hb9jS1cMYhpVlwZnVXBZJR1
 GT2oW8Ddp1guCLte7Q8U9UgEOPG64eMxUdBIkZutVpNTXbBM4FrD15qZSt15qTrJ9MA8 fw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbv662nu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:32:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R6WTLb016756
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:32:29 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 26 Sep
 2023 23:32:27 -0700
Message-ID: <dcb9094a-8e58-83ed-83af-05b879c23788@quicinc.com>
Date:   Wed, 27 Sep 2023 14:32:25 +0800
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
 <2023092705-canopy-spiritism-b0e1@gregkh>
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <2023092705-canopy-spiritism-b0e1@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7RmESI4hHrFmRA8sW30UcEbkdYDXNOQh
X-Proofpoint-GUID: 7RmESI4hHrFmRA8sW30UcEbkdYDXNOQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
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
> What commit id does this fix?

This commit c2c724c868c4("driver core: Add fw_devlink_parse_fwtree()"). 
Changelog mentioned:
"This function also ensures that no fwnode is parsed more than once by
     marking the fwnodes as parsed."

Thanks,
Zhenhua
