Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D5D7AFB31
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjI0GiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjI0GiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:38:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C14A3;
        Tue, 26 Sep 2023 23:38:17 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R6aZMS012952;
        Wed, 27 Sep 2023 06:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4i4Rs2Gw3sKQAemTlW9aNC01Scl3fW/betrdids60e4=;
 b=ipY5jE9KhWt6/0jf1Kgdz7Evf9F0etr1cRDF97+HMtJmOrP6+mMQf8pB/5e4D2RxBuDv
 a85wg1pxQJ7urjIeZFrzF7cDgdvOVobzFBzLgAnAbfCJgcWIwnsmpDeLR4SbbMiwAn0T
 wteoxy43TZElS9wrs/x99n72UiBOFzUJvNMb3oil5au29aDONXw+LZyWMmtSDOiFyK2g
 v3fALTXJqOTdq9EGA3uK4L/ejLr0kNSqwlMrHew63YmjYxVZvJZxldRuOtjynR8YyWFZ
 aZ0hyAL+tIBY/D9nkJLFkPCJ9GtgRBeBJaFQUeNhAYauLR/+qbVz3hEthpVXSm62Zulg 3A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc5hc0y19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:38:05 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R6c4Zp011291
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:38:04 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 26 Sep
 2023 23:37:59 -0700
Message-ID: <b31e427e-071f-1ded-eeb0-eb9a0f5dc075@quicinc.com>
Date:   Wed, 27 Sep 2023 14:37:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v9 00/13] Add support to configure TPDM DSB subunit
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1694670204-11515-1-git-send-email-quic_taozha@quicinc.com>
 <2fe54425-70b5-95e8-1e9e-337424827adb@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <2fe54425-70b5-95e8-1e9e-337424827adb@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8_S7EGau8sETySx_yqtG_GmL9t6EKOm7
X-Proofpoint-GUID: 8_S7EGau8sETySx_yqtG_GmL9t6EKOm7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270055
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/26/2023 9:12 PM, Suzuki K Poulose wrote:
> On 14/09/2023 06:43, Tao Zhang wrote:
>> Introduction of TPDM DSB subunit
>> DSB subunit is responsible for creating a dataset element, and is also
>> optionally responsible for packing it to fit multiple elements on a
>> single ATB transfer if possible in the configuration. The TPDM Core
>> Datapath requests timestamps be stored by the TPDA and then delivering
>> ATB sized data (depending on ATB width and element size, this could
>> be smaller or larger than a dataset element) to the ATB Mast FSM.
>>
>> The DSB subunit must be configured prior to enablement. This series
>> adds support for TPDM to configure the configure DSB subunit.
>>
>> Once this series patches are applied properly, the new tpdm nodes for
>> should be observed at the tpdm path /sys/bus/coresight/devices/tpdm*
>> which supports DSB subunit.
>> e.g.
>> root@qemuarm64:/sys/devices/platform/soc@0/6c08000.tpdm/tpdm1# ls -l
>> drwxr-xr-x    2 root     root             0 Jan  1 00:00 connections
>> drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_edge
>> -rw-r--r--    1 root     root          4096 Jan  1 00:00 dsb_mode
>> drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_msr
>> drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_patt
>> -rw-r--r--    1 root     root          4096 Jan  1 00:00 dsb_patt_ts
>> -rw-r--r--    1 root     root          4096 Jan  1 00:00 dsb_patt_type
>> drwxr-xr-x    2 root     root             0 Jan  1 00:00 dsb_trig_patt
>> -rw-r--r--    1 root     root          4096 Jan  1 00:00 dsb_trig_ts
>> -rw-r--r--    1 root     root          4096 Jan  1 00:00 dsb_trig_type
>> -rw-r--r--    1 root     root          4096 Jan  1 00:02 enable_source
>> --w-------    1 root     root          4096 Jan  1 00:00 
>> integration_test
>> drwxr-xr-x    2 root     root             0 Jan  1 00:00 power
>> --w-------    1 root     root          4096 Jan  1 00:02 reset_dataset
>> lrwxrwxrwx    1 root     root             0 Apr  5  2021 subsystem -> 
>> ../../../../../bus/coresight
>> -rw-r--r--    1 root     root          4096 Apr  5  2021 uevent
>> -r--r--r--    1 root     root          4096 Jan  1 00:00 
>> waiting_for_supplier
>>
>> We can use the commands are similar to the below to configure the
>> TPDMs which support DSB subunit. Enable coresight sink first.
>> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
>> echo 1 > /sys/bus/coresight/devices/tpdm1/reset_dataset
>> echo 0x3 > /sys/bus/coresight/devices/tpdm1/dsb_edge/ctrl_idx
>> echo 0x1 > /sys/bus/coresight/devices/tpdm1/dsb_edge/ctrl_mask
>> echo 0x0 > /sys/bus/coresight/devices/tpdm1/dsb_edge/ctrl_val
>> echo 1 > /sys/bus/coresight/devices/tpdm1/dsb_patt/enable_ts
>> echo 1 > /sys/bus/coresight/devices/tpdm1/dsb_patt/set_type
>> echo 0 > /sys/bus/coresight/devices/tpdm1/dsb_trig_ts
>> echo 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm1/dsb_patt/tpmr5
>> echo 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm1/dsb_trig_patt/xpr2
>> echo 1 > /sys/bus/coresight/devices/tpdm1/enable_source
>>
>
> I have reviewed this set, except for the last patch, rest looks fine.
> If you could resend the series with the comments addressed, we could
> queue this.

That's great. Thanks for your review.

I also want to make a minor change.

Can I rename "tpdm_dsb_attrs_grp" to "tpdm_dsb_attr_grp" in the next 
patch series?


Best,

Tao

>
> Suzuki
