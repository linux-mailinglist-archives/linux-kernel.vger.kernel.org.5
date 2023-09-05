Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA686792A89
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242170AbjIEQjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354549AbjIEMcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:32:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3948C1A8;
        Tue,  5 Sep 2023 05:32:44 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385Btd7k023059;
        Tue, 5 Sep 2023 12:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AgNrNswn4VcaFj6jGrhdgQHzaU8E9gVGIM/4qiVwyAw=;
 b=dvlbBd1VfwIi1Iv6Ri2uuCXf37wMDpagodXaM8CkJmu14lIdzexEI4hT11R/U4nIwJ9y
 S450795vwKTVZgDx6XNlfktsBn/p8c4sjYrJrvxLFFzFm+AXt/6Ptoa53xqy2sC8ZNQk
 ZMPCDERYdXxy9dgH93lEn86UP3c9NjpIFrZAZfsNRmP8/VXyvn9+4p0g+wStutYH5Uri
 eXRPKdvJXanyIOD9oKq6JaSEd+yXRUkHByi7efbU5rQLGsdZ0hfb+AJLagYcblfQoWuu
 BleoysCTovFsdRJvryTWGh6tSWkGJYHXlrdvnzNfMx8x+5lrUBBJMr0h7XpoM4Cvw3rS pA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swprehdud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 12:32:33 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 385CWWUm020810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 12:32:32 GMT
Received: from [10.201.203.60] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 5 Sep
 2023 05:32:29 -0700
Message-ID: <4de3a3fd-a15e-3d0e-eebf-6a849b8810a3@quicinc.com>
Date:   Tue, 5 Sep 2023 18:02:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RESEND,PATCH 2/2] firmware: qcom: scm: disable SDI on IPQ5018
Content-Language: en-US
To:     Brian Norris <computersforpeace@gmail.com>,
        Robert Marko <robimarko@gmail.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srichara@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
References: <20230518140224.2248782-1-robimarko@gmail.com>
 <20230518140224.2248782-2-robimarko@gmail.com> <ZNlhSdh0qDMieTAS@localhost>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <ZNlhSdh0qDMieTAS@localhost>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W6_okIouROvwpjUZDGUKpXCMc-KJQt4s
X-Proofpoint-GUID: W6_okIouROvwpjUZDGUKpXCMc-KJQt4s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050109
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/14/2023 4:33 AM, Brian Norris wrote:
> On Thu, May 18, 2023 at 04:02:24PM +0200, Robert Marko wrote:
>> IPQ5018 seems to have SDI (Secure Debug Image) enabled by default which
>> prevents normal reboot from working causing the board to just hang after
>> reboot is called.
>>
>> So, let disable SDI during SCM probe for IPQ5018.
>>
>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>> ---
>>   drivers/firmware/qcom_scm.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index bdc9324d4e62..c6a38ce49fb0 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -1525,6 +1525,14 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>   	if (download_mode)
>>   		qcom_scm_set_download_mode(true);
>>   
>> +	/* IPQ5018 seems to have SDI (Secure Debug Image) enabled by default
>> +	 * which will prevent normal reboot causing the board to hang after
>> +	 * making the reboot call.
>> +	 * So, make a call to SCM to disable SDI.
>> +	 */
>> +	if (of_machine_is_compatible("qcom,ipq5018"))
>> +		qcom_scm_disable_sdi();
>> +
> 
> I see there has been some reservation expressed on this patch (via patch
> 1 comments). I suppose this would be a nice time (though months-late) to
> add my own potentially-constructive thoughts.
> 
> First, this is definitely a real problem, and for multiple products. See
> my prior art with the exact same problem:
> 
> Subject: [RFC PATCH] firmware: qcom_scm: disable SDI at boot
> https://lore.kernel.org/all/20200721080054.2803881-1-computersforpeace@gmail.com/
> 
> (I think you found this one already, although independently.)
> 
> Secondly, I think some reservation from patch 1 is on the precise method
> of identifying such problematic systems, and I think I agree with the
> sentiment. For one, I'm sure that in my case, not all IPQ4019-based
> systems leave SDI enabled, and similarly, I doubt all IPQ5018 systems do
> either. I believe any firmware that has this enabled in a production
> system is essentially an oversight and a bug; it provides negative value
> to non-Qualcomm-employees (who can't inspect this "debug" mode), and I
> also believe it can potentially be "fixed" by firmware updates. So you
> have cases where depending on which software updates have been applied
> to an original product before being reprogrammed with a properly-open
> Linux kernel/distro, the "same" product may or may not behave
> differently.
> 
> On the other hand, my guess is that it is truly safe (or, redundant) to
> make this call on *any* SCM system; if it was already disabled, then
> it's a no-op. Now, that may be inconvenient for Qualcomm employees
> trying to debug prototype boards, but that's a different problem...
> 
> So, it feels like either this should be:
> (1) done inconditionally (like my RFC above), or
> (2) supported by some kind of dedicated firmware or device tree flag, to
>      denote precisely which systems need this behavior, and not just
>      guess based on SoCs. We don't have any firmware interface for this
>      [1], so I think the next best thing is Device Tree, which I believe
>      is sometimes(?) allowed to carry "firmware" information, instead of
>      just "hardware" information.
> 
> For example, maybe we document a "qcom,firmware-sdi-enabled" boolean, to
> represent the fact that the particular board in question may hold
> firmware which leaves SDI enabled?
> 
> I'd personally also be OK with (1), unless we (or more likely, Qualcomm)
> can find some reason that it's not safe/redundant to do this
> unconditionally.
> 

  Sorry for joining this discussion late. This SDI bit is used for
  enabling ramdump collection in case of abnormal reset, like
  watchdog. That's why its enabled by default. That means it has to
  be explicitly disabled in case of intentional resets like, reboot,
  HLOS panic etc. So disabling should be done in panic/reboot paths.
  I guess it should be the same in msm's case also. Mukesh can confirm
  though.

  Also, on how to do it, instead of checking for 'compatible', i think
  would be better to check on availability of SCM using,
  '__qcom_scm_is_call_available'.

Regards,
  Sricharan


