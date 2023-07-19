Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDC375933F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGSKjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjGSKjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:39:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1934A123;
        Wed, 19 Jul 2023 03:39:13 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J9qftQ024313;
        Wed, 19 Jul 2023 10:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JkudH1c3oKwKKnFqbu/S9SxFUUmz2K/EvaGFyEz42h8=;
 b=FidzWSJLE/v4eofpZRRQEunVe8XrbA5PSac+BKVKk3lwZMYSl3ZZwmMxb+Mi2umZ6R5T
 pHgy2X5ZVNYh3mT3Hs78SjTXmvmo9CtGbUhvk9GaxZhDtlXCUnsuDGJWzrPgcetGyPE8
 cZLbhBjFxFWrwOipHI0I9c8OWXExY68jOQUp8scUjklm8sRYQWI+U+HdK89qONo5K4W9
 S12mCJVPijRx9i3vdnHvpU71K5OCYw70B5fMzXNi8GoH/Ftisd0Rt/bXphAC+aAWIQ6Q
 0QgHJcrRtHZTloXWVpLax34q38mjVC3VGPRXLJ/pyz+kPap4R158mPCTj/0eV85yQqIM Lw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rx7rngra2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 10:38:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36JAcvD0028824
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 10:38:57 GMT
Received: from [10.218.19.82] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 19 Jul
 2023 03:38:40 -0700
Message-ID: <350d577a-f0b3-1f20-9c35-356355a9aa8e@quicinc.com>
Date:   Wed, 19 Jul 2023 16:08:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2] net: mhi : Add support to enable ethernet interface
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <mhi@lists.linux.dev>, <mrana@quicinc.com>,
        <quic_qianyu@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <quic_krichai@quicinc.com>, <quic_skananth@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1689660928-12092-1-git-send-email-quic_vpernami@quicinc.com>
 <20230718124334.GG4771@thinkpad>
Content-Language: en-US
From:   Vivek Pernamitta <quic_vpernami@quicinc.com>
In-Reply-To: <20230718124334.GG4771@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x272w4BEVPD0C_CfqfgobTQY7qlUmune
X-Proofpoint-ORIG-GUID: x272w4BEVPD0C_CfqfgobTQY7qlUmune
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_06,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190096
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Currently MHI NET driver does not support Ethernet interface,

we are adding Ethernet interface support to MHI NET driver, so new 
client can be configured to be Ethernet type over MHI by setting 
"mhi_device_info.ethernet_if = true"

currently we are not changing mhi_swip0/mhi_hwip0 to Ethernet. we are 
adding an provision to configure mhi client as  Ethernet type.


On 7/18/2023 6:13 PM, Manivannan Sadhasivam wrote:
> On Tue, Jul 18, 2023 at 11:45:28AM +0530, Vivek Pernamitta wrote:
>> Add support to enable ethernet interface for MHI SWIP channels.
>>
> Please add more info in the commit message i.e., why this interface is added and
> how it is going to benefit the users etc..
>
> Since you are modifying the existing mhi_swip interface, this isn't an ABI
> change?
>
>> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
>> Reviewed-by: Daniele Palmas <dnlplm@gmail.com>
>> Reviewed-by: Simon Horman <simon.horman@corigine.com>
>> ---
>>
>> changes since v1:
>> 	- Moved to net-next from linux-next	
>> 	- moved to eth_hw_addr_random() to assign Ethernet MAC address
>> 	  from eth_random_addr()
>> ---
>>   drivers/net/mhi_net.c | 53 ++++++++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 40 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
>> index 3d322ac..5bb8d99 100644
>> --- a/drivers/net/mhi_net.c
>> +++ b/drivers/net/mhi_net.c
> [...]
>
>> @@ -380,10 +405,12 @@ static void mhi_net_remove(struct mhi_device *mhi_dev)
>>   
>>   static const struct mhi_device_info mhi_hwip0 = {
>>   	.netname = "mhi_hwip%d",
>> +	.ethernet_if = false,
>>   };
>>   
>>   static const struct mhi_device_info mhi_swip0 = {
>>   	.netname = "mhi_swip%d",
>> +	.ethernet_if = false,
> false?
yes ,it is false as by default mhi_swip/mhi_hwip interface will be 
normal net device.
>
> - Mani
>
>>   };
>>   
>>   static const struct mhi_device_id mhi_net_id_table[] = {
>> -- 
>> 2.7.4
>>
