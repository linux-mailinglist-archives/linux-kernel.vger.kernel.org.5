Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FC37649A3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjG0H6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjG0H5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:57:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282443C3F;
        Thu, 27 Jul 2023 00:55:08 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R6wa6J012197;
        Thu, 27 Jul 2023 07:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wNI0rleG38u1p1JaTjkOzXrKMH0gmtg9EtYqPGh7CRU=;
 b=exIVC8huDEZIxp+fq/elpwhB9teFLfBjyl0h1d5gQzkOlbBC9OXC/RF/xy2JtyMYpo6t
 CXPFyKwGqpMSrFji2IwwT11V1J3xqo87WfCBc3j/KO/ao/4V5gcpdGZt5f1icTndqjmf
 +yZ6yx72kg8dPRzjsHAnbHGZHvkg70Nh9XXdv6bt2nSG8S8o2qRctSRAPQrM2RwKd27r
 6+wJ9QF/jpcOW3oucyxLTWiaVSjjk51Of1WTG65/hc1ef5+KR0TR595qM5r2baj0pVE5
 3NX1ttt3lMLssSoCz4lX2MaTRGrC44mUUzD1ggC2KfDxxDJdceeH+r0a+R5abDnjrVa/ 5w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3krn83f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 07:55:02 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R7t1pW028870
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 07:55:01 GMT
Received: from [10.239.104.229] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 00:54:28 -0700
Message-ID: <af383bea-f30d-f0fe-500f-c50904505293@quicinc.com>
Date:   Thu, 27 Jul 2023 15:54:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 0/2] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     <marcel@holtmann.org>, <luiz.dentz@gmail.com>,
        <johan.hedberg@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_bgodavar@quicinc.com>, <quic_hemantg@quicinc.com>
References: <20230727044011.965205-1-quic_tjiang@quicinc.com>
 <ZMIb6RWvhvtteRXE@hovoldconsulting.com>
From:   Tim Jiang <quic_tjiang@quicinc.com>
In-Reply-To: <ZMIb6RWvhvtteRXE@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CxYAEnMOvumcmZg_anTe4Cc7Y61w5DZg
X-Proofpoint-GUID: CxYAEnMOvumcmZg_anTe4Cc7Y61w5DZg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 suspectscore=0 mlxlogscore=502 priorityscore=1501 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270069
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/27/23 15:25, Johan Hovold wrote:
> On Thu, Jul 27, 2023 at 12:40:09PM +0800, Tim Jiang wrote:
>> This series adds support for qualcomm bluetooth soc qca2066
>>
>> Changes in v13
>>   - change the subject name for patch 1/2
>>   - solve review comments for patch 2/2
> Again, this is not specific enough and essentially only explains why you
> changed something, but doesn't say what you changed.
>
> You also again ignored some of my review comments without even
> explaining why.

[Tim] sorry for that , seems the email I explain why we do not need to 
sort the btsoc name does not be sent out for network issue.

as qc define btsoc name does not be sorted  alphabetilly, and we add new 
chip name followed by old one , I think we only under this rule is OK,  
do you agree?  thank you very much.

>
> Seriously, you Qualcomm engineers really need to get your act together
> and stop wasting other people's time.
>
> Johan
