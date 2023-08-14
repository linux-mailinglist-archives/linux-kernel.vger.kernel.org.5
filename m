Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602A977C078
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjHNTM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjHNTME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:12:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365DE1715;
        Mon, 14 Aug 2023 12:12:03 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EImPmq002065;
        Mon, 14 Aug 2023 19:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Fdu8U/KbX15uj3P9MqoAZsTVeW2ftg4r8vqL0iPXDfI=;
 b=R8LQ1YF3V3a43t5YJr/E39VAIGr0QJHd7/44gnAuN/FKtz6V2TqDohbanhRZfiIYKE4G
 /c8Sa/GPXvNRF5VuDmNFHqlx7Twv7PSyyTNjgT7DN1HCA5+DcXQv1yyvwMrxe7kaS2Tj
 8wOtToYOYyseT6T1vGwB6VGzEyfskPJ3aa1GQxz2SvgAgET4aFNkEawLo6D6dmxE0EIR
 qmn68EmRVl+e6ORgiLracXqZyc7apfQKTmxRb4BtM9EEFG8vGRS7UIGUc9YWjxDODOv7
 ZHSXLrHs3k7ZElL2/tfmps0eUyh81z9/12zaDY9iqWDWeUwGr/Pyf0e6sDTdB/udN5fs bA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3j94p63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:11:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EJBXXK022519
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:11:34 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 12:11:30 -0700
Message-ID: <e692b072-30b3-5f09-a11f-9d05ca3a5b0d@quicinc.com>
Date:   Tue, 15 Aug 2023 00:41:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 18/33] iris: vidc: hfi: add Host Firmware Interface (HFI)
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-19-git-send-email-quic_vgarodia@quicinc.com>
 <f31de68f-e64b-2b1d-7fbc-6bf7f94347af@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <f31de68f-e64b-2b1d-7fbc-6bf7f94347af@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dXT9tebr2hUL-Pjn5hDW25KGFjW5GW4J
X-Proofpoint-GUID: dXT9tebr2hUL-Pjn5hDW25KGFjW5GW4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140178
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 9:28 PM, Bryan O'Donoghue wrote:
> On 28/07/2023 14:23, Vikash Garodia wrote:
>> +    rc = hfi_packet_sys_intraframe_powercollapse(core, core->packet,
>> +                             core->packet_size, enable);
>> +    if (rc)
>> +        return rc;
> 
> I'm 99.9999999999 % sure this is misnamed.
> 
> "Inter" means in-between two things.
> "Intra" means inside of one thing.
> 
> So "intraframe" means inside of one frame "interframe" would mean power
> collapsing in-between two frames, which is what I think this does.
> 
> And I'd still rather be adding inter-frame power-collapse to as many
> different versions of the existing silicon and new silicon as opposed to
> segregating it off in a new driver.
> 
> I'm assuming that more than sm8550 supports it since @ the end of the day
> this is a firmware feature to power-collapse during an active session when
> we aren't busy.
> 
You are actually 100% correct here, it is indeed inter frame power collapse,
Will rename this api with hfi_packet_sys_interframe_powercollapse

Thanks,
Dikshita
> ---
> bod
