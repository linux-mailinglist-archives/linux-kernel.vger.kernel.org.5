Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997BA78B77F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjH1Soz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjH1SoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:44:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B717795;
        Mon, 28 Aug 2023 11:44:17 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SIHdns009279;
        Mon, 28 Aug 2023 18:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QaqMdWc/Rsbi339/IdfxxzQ9dJKTmw5qyHB2f8RHKVQ=;
 b=JhaK52/kMS0z/43fpS1JAaYQTRtGbnrqMMF1ldTnU/YVze8/JM68TMutSGkHsQnxn4rw
 JJe+rV8StwC5giPgfs63mRBy9eWJs0lCeTXzNeGK/Jb2Wdo1CCjLmt686FZo5KQK1KFl
 Fx7E3RlbWgojKxce7Hsr4nNM6yxJ5VgBHjQaySQQctMf7eDWZPuJzLdKX4l042BnmbB5
 gXfLOmLLdrhOxe1JEyqkO3K+XPnhYv4JWqPeVo1AwUC6IrP10cVGUBX2V1aTVXeR0Evo
 HNrkQGK1xEXVdSHYrA4mKY2rlz2kcrTAiaoQkjXjZ8t0XZkk5D90pA5C+LAVy4n2Xger pA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq8ddm6ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 18:44:13 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SIiCpJ030675
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 18:44:12 GMT
Received: from [10.110.74.192] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 11:44:09 -0700
Message-ID: <0abc0e3b-077c-d7b9-e561-2c2e01d46540@quicinc.com>
Date:   Mon, 28 Aug 2023 11:44:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 0/1] Add driver to read secondary bootloader (XBL) log
Content-Language: en-US
To:     Arun Kumar Neelakantam <quic_aneelaka@quicinc.com>,
        Ninad Naik <quic_ninanaik@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC:     <psodagud@quicinc.com>, <quic_ppareek@quicinc.com>,
        <quic_kprasan@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>
References: <20230822121512.8631-1-quic_ninanaik@quicinc.com>
 <badd7471-b28f-4948-b6b4-eddb8bf1b0d6@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <badd7471-b28f-4948-b6b4-eddb8bf1b0d6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ghltwb4eMFXbIHZhal5VWW0eii8lOJHy
X-Proofpoint-GUID: ghltwb4eMFXbIHZhal5VWW0eii8lOJHy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_15,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280164
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/2023 10:19 AM, Arun Kumar Neelakantam wrote:
> 
> 
> On 8/22/2023 5:45 PM, Ninad Naik wrote:
>> Boot time logs for Qualcomm secondary boot-loader or XBL can help to
>> identify different set of information regarding firmware configuration,
>> SoC boot KPIs. A dedicated region is carved out in the memory map in order
>> to store this log in the memory.
>>
>> The objective of this driver is to read the XBL boot log stored in
>> this memory region post boot-up, and provide an entry in debugfs, which
>> can be used to read back the logs and print them on to the console.
>>
> 
> I see couple of use cases for this kind of logging like logs from boot, Hypervisor, Trusted Execution environments and also one in upstream for chromeos EC console. Can this be made a generic driver which take log name, log memory buffer address and size to read from debugfs.

The one downside of generic solution here is that log format may not be consistent. Some may have binary format of logs which will need further parsing in kernel or userspace. 

If we need to make such feature generic then it needs to be generic across arm64 / arm32 then and not SOC specific. 


-- 
---Trilok Soni

