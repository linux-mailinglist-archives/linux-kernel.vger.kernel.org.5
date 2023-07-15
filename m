Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513DA754984
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjGOOyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGOOyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:54:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94E52715;
        Sat, 15 Jul 2023 07:54:37 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36FEmMZE003132;
        Sat, 15 Jul 2023 14:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NQLqszcrmhf4rKij9FRHxUbcmXIwDz/avW7JDEGn2Cg=;
 b=gQzOoulyJs+FVtSyzPQCDkfaSC3dmEi7raCGzqCTE8tflQCsniUKVRW1z8Yvr6Xceiqm
 /82mH8tHDaQTIWjPWDVKBWqFbjW20kDeHZ8dNsWjb9ZFcJ+LMiJTeGz+Df9MEWwKL9jY
 AA8hQ1OEujWDPH2zZ+eVl5kLsfFvGKMYSQBaSus4Neft+fsPsn554iUmBvrbchnI93V5
 rrOuV2nyMaBCELd2IMe/924AGcppoKZJelsffJHPN2OTkJrVKtuyZWOlPROVNnUwp3GW
 59u/ZsgO4Ye2IuFlPOAABrXMqMt9EA0Q/rYsvdZ9bHXDTSCBBeTv9x3n97q9qAvnpseY 2Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0erff5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jul 2023 14:54:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36FEsPjO006452
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jul 2023 14:54:25 GMT
Received: from [10.253.38.208] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sat, 15 Jul
 2023 07:54:23 -0700
Message-ID: <348c0a1c-e6b9-494e-1b89-dc6beaa9ef5a@quicinc.com>
Date:   Sat, 15 Jul 2023 22:54:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/6] net: phy: at803x: remove qca8081 1G fast retrain
 and slave seed config
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230714063136.21368-1-quic_luoj@quicinc.com>
 <20230714063136.21368-6-quic_luoj@quicinc.com>
 <ZLE0Tr4Tn+C0fI+V@shell.armlinux.org.uk>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZLE0Tr4Tn+C0fI+V@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9psDycC9Mdlhu3mlHx6F4QMCmCVdotCC
X-Proofpoint-ORIG-GUID: 9psDycC9Mdlhu3mlHx6F4QMCmCVdotCC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=494
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307150141
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2023 7:41 PM, Russell King (Oracle) wrote:
> On Fri, Jul 14, 2023 at 02:31:35PM +0800, Luo Jie wrote:
>> The fast retrain and master slave seed configs are only applicable when
>> the 2.5G capability is supported.
> 
> Probably worth a comment - or a helper function.
> 
> E.g.
> 
> static bool qca808x_has_fast_retrain(struct phy_device *phydev)
> {
> 	return linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> 				 phydev->supported);
> }
> 
> Which then makes the code more self-documenting.
> 

Hi Russell,
Thanks for this review comment, i will add this helper function in the 
next patch series.
