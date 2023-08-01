Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2445576B57A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjHANI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjHANIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:08:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7494B1BE3;
        Tue,  1 Aug 2023 06:08:23 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371BVD7P005056;
        Tue, 1 Aug 2023 13:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VwgUdH+MaufB/wU+nqiO/XxR/TljLIzlrOeWTeFK7N8=;
 b=dSp+4izEPgDZfYPpWK8RfpGmZFi/W52zYtFpZQb32Tqr8ArnA2uTZBtPHA09mQTvUjAh
 PhcWNFMeJxY40ZDAe8RoBq3Fhfiq/6SKAWqkeo7VJvPnHGp+ueY8MoyHwi5562UzcOY4
 n9wMll7U1/9Bwdln2Yw7kfoowPBr4G2itqdn6QWpArmyCpviy5ZWAli0MpuXi4JtPb9O
 5kwyjeHZW2IjQNODi3/mBz1WrCZPnO6Afj8Wc1g53VE+ig0vFqMgQuXxTW09XaRmA0AW
 KJ+PiGvvmFjOyoPecFPudkz7hRxFlIjyjhHMFglcC7wjTiVXUzRvXHqkKIrGNo1BFHID wQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6e9j2m6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 13:07:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 371D7uUx020324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 13:07:56 GMT
Received: from [10.50.50.103] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 1 Aug
 2023 06:07:51 -0700
Message-ID: <8c591002-308e-bdba-de5f-c96113230451@quicinc.com>
Date:   Tue, 1 Aug 2023 18:37:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] net: export dev_change_name function
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        "Kuniyuki Iwashima" <kuniyu@amazon.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andy Ren <andy.ren@getcruise.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Venkata Rao Kakani <quic_vkakani@quicinc.com>,
        Vagdhan Kumar <quic_vagdhank@quicinc.com>
References: <20230801112101.15564-1-quic_ajainp@quicinc.com>
 <447ba1fe-b20b-4ed0-97bc-4137b2ccfb37@lunn.ch>
From:   Anvesh Jain P <quic_ajainp@quicinc.com>
In-Reply-To: <447ba1fe-b20b-4ed0-97bc-4137b2ccfb37@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sbk0xjos7k9BFLhwizpWoPSdaCfKsknr
X-Proofpoint-GUID: sbk0xjos7k9BFLhwizpWoPSdaCfKsknr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_08,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=712
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010118
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/2023 6:01 PM, Andrew Lunn wrote:
> On Tue, Aug 01, 2023 at 04:51:01PM +0530, Anvesh Jain P wrote:
>> export dev_change_name function to be used by other modules.
>>
>> Signed-off-by: Vagdhan Kumar <quic_vagdhank@quicinc.com>
>> Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
> 
> It would be normal to include a user of the API when exposing an API.
> 
> What module needs to change the name of a device? At the moment, only
> user space can do this via netlink or an IOCTL.
> 
>       Andrew
CONFIG_RENAME_DEVICES is the module which needs "dev_change_name" API. 
Our requirement is to change the network device name from kernel space.
