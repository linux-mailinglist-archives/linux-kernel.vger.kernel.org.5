Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DE77EB58D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjKNRca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKNRc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:32:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C056B6;
        Tue, 14 Nov 2023 09:32:25 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEFXajA002169;
        Tue, 14 Nov 2023 17:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4IFXMhp5iGw8C58z5StYp12aOmOoam/kEzBPeX7wr8U=;
 b=GmUlKENNjzl76JFMkZB9GeN8mEbsJv7UOywky8DwKt7ladh1SfWxTBKfZdB4d1oxNOVD
 kAmyD5qyRI1fvWtLCDBVk1dmkj1OfHw4g1bK739YESENHau7JVZozRiZeM5u+bP4LVce
 J09N8y5Ct5unPE+MxGoZrDZFBFD1wH9Pvg0iaZwt3fEKoZR+tI8/hpmOcMOTDr724/Jj
 MKis7yrp7BvKa5odplsW6rp+3UusB2bLrT+xeCYOsGKUJb2NrDQ9+VylW34PVIchJr55
 hzYXQ73FiR2Z+t3AosrsCIciHAOWodDl2bCUDaj0xiiZ+o2YAJA4gJK/Z/s/eoKZl3oX 7w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucba6rc9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 17:32:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AEHW5sb019176
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 17:32:05 GMT
Received: from [10.110.49.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 14 Nov
 2023 09:32:04 -0800
Message-ID: <b70d8041-901c-48f6-8790-35e354c30865@quicinc.com>
Date:   Tue, 14 Nov 2023 09:32:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k_pci logs errors about missing pre-cal and cal firmware on
 a laptop
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>, Kalle Valo <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <ath10k@lists.infradead.org>
References: <7158e5e9-8bdc-4660-ac5d-5e3f81cf6158@molgen.mpg.de>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <7158e5e9-8bdc-4660-ac5d-5e3f81cf6158@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GMdICbtdDsdyIELinfoFrQw6o9ivISlJ
X-Proofpoint-ORIG-GUID: GMdICbtdDsdyIELinfoFrQw6o9ivISlJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_17,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2023 4:13 AM, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Onn the Dell XPS 13 9360 with Debian sid/unstable, Linux 6.5.10 logs the 
> error below:
> 
>      $ sudo dmesg | grep -e "DMI:" -e "Linux version" -e microcode
>      [    0.000000] microcode: updated early: 0xf0 -> 0xf4, date = 
> 2023-02-22
>      [    0.000000] Linux version 6.5.0-4-amd64 
> (debian-kernel@lists.debian.org) (gcc-13 (Debian 13.2.0-6) 13.2.0, GNU 
> ld (GNU Binutils for Debian) 2.41) #1 SMP PREEMPT_DYNAMIC Debian 
> 6.5.10-1 (2023-11-03)
>      [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 
> 06/02/2022
>      [    0.580689] microcode: Microcode Update Driver: v2.2.
> 
>      $ sudo dmesg --level alert,crit,err
>      [    0.053566] x86/cpu: SGX disabled by BIOS.
>      [    1.942183] psmouse serio1: synaptics: Unable to query device: -5
>      [   14.401112] ath10k_pci 0000:3a:00.0: firmware: failed to load 
> ath10k/pre-cal-pci-0000:3a:00.0.bin (-2)
>      [   14.401143] firmware_class: See https://wiki.debian.org/Firmware 
> for information about missing firmware
>      [   14.401185] ath10k_pci 0000:3a:00.0: firmware: failed to load 
> ath10k/pre-cal-pci-0000:3a:00.0.bin (-2)
>      [   14.401233] ath10k_pci 0000:3a:00.0: firmware: failed to load 
> ath10k/cal-pci-0000:3a:00.0.bin (-2)
>      [   14.401273] ath10k_pci 0000:3a:00.0: firmware: failed to load 
> ath10k/cal-pci-0000:3a:00.0.bin (-2)
> 
> As it’s logged with error level, I’d like to address the ath10k_pci 
> errors, but I am unable to find the firmware in the Linux firmware 
> archive [1].
> 
> What can I do about this?
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: 
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/

Adding the ath10k list so this isn't lost in the noise
