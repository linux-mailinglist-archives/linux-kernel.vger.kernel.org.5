Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DF07914F8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346869AbjIDJsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjIDJr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:47:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDC311D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 02:47:55 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3848Nrt1024887;
        Mon, 4 Sep 2023 09:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TkIcV9E6SWOmgq+XNwpHIqoCFgDbDleLzT//H/OuNpM=;
 b=bRBDeMNaOvK3Fv/gyMvCuXVr9Awd4V6kqO193DprPN9p+zpXKzCrz0sqxo2BSfexLOrh
 lDsSTKiu2FdfAiWkVWEgjw0uxNNUG5yCNGatLSzCQhB9ADP5MYl+C7+7ypeYpsCldtdY
 MIFBE2kaPuMSi2+p5a8BQ84zZgY9GwfZ4eVHHzC80kx9Ncc4n9yJNH85GF2BnSdPXMl7
 2lPGfcak3iHJLs7Jv97kvtz4dHu2z0N4MhEcmLHZ7P1Dr/NDjdlYqpbJaS6tEVjrbtB1
 5xuQmhJQMNVlcKMwQ16i9hzdJosjbF2+2xh2luycyx6PHjYHGD/QfY2FK1jXWbqFPX1i vQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suxbfucje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 09:47:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3849lVhl021361
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 09:47:31 GMT
Received: from [10.216.34.10] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 4 Sep
 2023 02:47:28 -0700
Message-ID: <1ba68ccb-9faa-8f9f-64cb-cf74dc0a2184@quicinc.com>
Date:   Mon, 4 Sep 2023 15:17:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: ath11k: QCN9074: ce desc not available for wmi command
To:     Tyler Stachecki <stachecki.tyler@gmail.com>
CC:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux Atheros 11K <ath11k@lists.infradead.org>
References: <1326a6e4-758d-3344-d90c-8a126748b034@gmail.com>
 <6a0c3aa0-86a8-8c06-81df-2d7085946cf5@leemhuis.info>
 <16885654-09f0-c139-cc9b-c6c4d666932e@quicinc.com>
 <ae1ad814-5613-704e-b0b1-4f1fc4bead44@leemhuis.info>
 <1945f748-fb71-f1c1-83a2-ba0470daf817@quicinc.com>
 <ZPUXMx0H/8U9j15F@luigi.stachecki.net>
Content-Language: en-US
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <ZPUXMx0H/8U9j15F@luigi.stachecki.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9RlpnYF8scx8-IL0FdS9EILSQg7VGm3k
X-Proofpoint-ORIG-GUID: 9RlpnYF8scx8-IL0FdS9EILSQg7VGm3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040087
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/2023 5:00 AM, Tyler Stachecki wrote:
>> On 25.07.23 11:17, Manikanta Pubbisetty wrote:
>>
>> FWIW, Bagas Sanjaya just forwarded the report and the reporter is not
>> CCed afaics (bugzilla privacy policy does not allow this, which
>> complicates things a lot :-/ ). You have to use bugzilla to reach the
>> reporter: https://bugzilla.kernel.org/show_bug.cgi?id=217536
> 
> Hi Manikanta,
> 
> I just wanted to report that this is likely related to QCN9074 when the host
> system only has 1 MSI-X vector available for the modem and/or related to a
> product named "WPEQ-405AX".
> 
> I have two different hosts running the exact same kernel, same QCN9074
> firmware (WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1), etc. The only
> differences are that the one which does not work is running on a slightly
> older Intel SBC, with the older one leveraging mPCIe instead of PCIe and
> only having one MSI-X vector.

Yes, you are right. This seems to be a problem with some hardware having 
QCN9074. We have tried to reproduce this problem in QC on different 
hardware but could not reproduce it even once. Not even with one MSI vector.

> 
> I tried backing out the threaded NAPI commit and, as mentioned, everything
> begins working again on the host with 1 MSI-X vector. I have also seen some
> other oddities with the system only working with 1 MSI-X vector, such as
> the modem not working when I boot with hpet=disabled. I am guessing it is
> not related, but mentioning it just in case.
> 
> The only other thing I'll mention is that the CE desc errors are *only* seen
> after upping the link (via `ip link set wlp1s0 up`). After this point, doing
> something as simple as reading the temperature of the modem fails and the
> kernel log starts printing the errors described above. Prior to that, however,
> no error messages are seen.
>

True, I had worked with the reporter for quite some time. To me at 
first, it seemed like a problem with improper configuration of the MSI 
DATA in the QCN9074 hardware. I'm investigating further.

> I'm happy to be of service to test any changes you might suggest. Thanks
> for the threaded NAPI work, by the way - it definitely provides a boost!
> 

Sure, Thanks a lot.

Manikanta
