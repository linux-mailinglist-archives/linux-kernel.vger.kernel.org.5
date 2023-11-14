Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42BA7EB64C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjKNSU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNSU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:20:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2300121;
        Tue, 14 Nov 2023 10:20:23 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE9nLBZ027118;
        Tue, 14 Nov 2023 18:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=X1VJdgR4tz03dcjXQbECSZw/oGJ+qUKedww40+GLQIY=;
 b=i8BEesgr/IlekKM9WdnGC8xCepZKv9CLyhC8tYCvhwnOaHzI8/tEL6P3cpxxiCTjWK0W
 Yr51N2c+RDaHAbQBRNSLFDQ1bqHKt52rTy7LnQEMhq+D3pOlEbeAmYN0o7hG9PwP4nPg
 hu6bWRolcTSkONBIRTC5uTHY3OZb2r2pcXXXDCOfmicpfuc7Vz8TwrniBk4s9aq+3G2x
 D1OdvCv0iXAejqGwmIN4SlXKddgRbYpa9n1utwJMVtp4RGkiGxFvBHzsufOfd/oIzavj
 n1wS8S/xz4PrW6ndB+lPIqRUfI0nHx7KG1/ti0n8NdPJq40dzDZpIjYRefDChu+b7K0X uw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uc4fy1hqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:19:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AEIJqMU014141
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:19:52 GMT
Received: from [10.110.49.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 14 Nov
 2023 10:19:51 -0800
Message-ID: <2e4be606-68a9-455b-a43d-20b8375efc49@quicinc.com>
Date:   Tue, 14 Nov 2023 10:19:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k_pci logs errors about missing pre-cal and cal firmware on
 a laptop
Content-Language: en-US
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>, Kalle Valo <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <ath10k@lists.infradead.org>
References: <7158e5e9-8bdc-4660-ac5d-5e3f81cf6158@molgen.mpg.de>
 <b70d8041-901c-48f6-8790-35e354c30865@quicinc.com>
In-Reply-To: <b70d8041-901c-48f6-8790-35e354c30865@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UJ2b_q-aVrCi3ID0Crd25oJh5yHl8dJh
X-Proofpoint-ORIG-GUID: UJ2b_q-aVrCi3ID0Crd25oJh5yHl8dJh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_18,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/2023 9:32 AM, Jeff Johnson wrote:
> On 11/12/2023 4:13 AM, Paul Menzel wrote:
>> Dear Linux folks,
>>
>>
>> Onn the Dell XPS 13 9360 with Debian sid/unstable, Linux 6.5.10 logs the 
>> error below:
>>
>>      $ sudo dmesg | grep -e "DMI:" -e "Linux version" -e microcode
>>      [    0.000000] microcode: updated early: 0xf0 -> 0xf4, date = 
>> 2023-02-22
>>      [    0.000000] Linux version 6.5.0-4-amd64 
>> (debian-kernel@lists.debian.org) (gcc-13 (Debian 13.2.0-6) 13.2.0, GNU 
>> ld (GNU Binutils for Debian) 2.41) #1 SMP PREEMPT_DYNAMIC Debian 
>> 6.5.10-1 (2023-11-03)
>>      [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 
>> 06/02/2022
>>      [    0.580689] microcode: Microcode Update Driver: v2.2.
>>
>>      $ sudo dmesg --level alert,crit,err
>>      [    0.053566] x86/cpu: SGX disabled by BIOS.
>>      [    1.942183] psmouse serio1: synaptics: Unable to query device: -5
>>      [   14.401112] ath10k_pci 0000:3a:00.0: firmware: failed to load 
>> ath10k/pre-cal-pci-0000:3a:00.0.bin (-2)
>>      [   14.401143] firmware_class: See https://wiki.debian.org/Firmware 
>> for information about missing firmware
>>      [   14.401185] ath10k_pci 0000:3a:00.0: firmware: failed to load 
>> ath10k/pre-cal-pci-0000:3a:00.0.bin (-2)
>>      [   14.401233] ath10k_pci 0000:3a:00.0: firmware: failed to load 
>> ath10k/cal-pci-0000:3a:00.0.bin (-2)
>>      [   14.401273] ath10k_pci 0000:3a:00.0: firmware: failed to load 
>> ath10k/cal-pci-0000:3a:00.0.bin (-2)
>>
>> As it’s logged with error level, I’d like to address the ath10k_pci 
>> errors, but I am unable to find the firmware in the Linux firmware 
>> archive [1].
>>
>> What can I do about this?
>>
>>
>> Kind regards,
>>
>> Paul
>>
>>
>> [1]: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/
> 
> Adding the ath10k list so this isn't lost in the noise

The calibration files are optional and you should not see any warnings
if they are not present.

Note ath10k explicitly calls firmware_request_nowarn() when it loads the
files since it doesn't want any warnings from the firmware loader if the
files aren't present.
<https://elixir.bootlin.com/linux/v6.5.10/source/drivers/net/wireless/ath/ath10k/core.c#L929>

And ath10k itself explicitly doesn't warn:
<https://elixir.bootlin.com/linux/v6.5.10/source/drivers/net/wireless/ath/ath10k/core.c#L1259>

So I'm confused where these warnings originate.

Based upon the message:
[   14.401143] firmware_class: See https://wiki.debian.org/Firmware
for information about missing firmware

it seems you are not running a stock kernel. So perhaps Debian has
modified the firmware loading such that it ignores the FW_OPT_NO_WARN
flag and warns even when told not to do so? This does not appear to be
an upstream kernel issue.

/jeff
