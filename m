Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE75D75497D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjGOOvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGOOvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:51:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7B9D3;
        Sat, 15 Jul 2023 07:51:37 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36FEU0Px019590;
        Sat, 15 Jul 2023 14:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sR+6w+TyfRpBvpuJZSw75v/cgQGr9NGQpIDgesINvf0=;
 b=nTBlUU87yoeNibSqr4sOPs96GFSNtGW5bJ7cek63XK6Sh46bF/E5ZbbZbuaM803+9HsF
 Wiga2oSlnKmjATabYwJqS48wA6gy8JKkJQ8IVP3VdNhMWjxAwIssPyaFSA4/H5W35tdD
 zLBcG1kUOHfbiJddfTd2yU2IvpH4wZyGpqGrNEBET5wenoizGDpwoni++MOD2qZpomW4
 xTU1sdtG8IvzuJFV8/pRTNb8P4Y3Hm+eO9knMmWF6A7dHAO0ME13iCpUVJOwlDGNhqNH
 NHFRrau1LSi299OlEdenPb8j4RvW91BudYhzcRuRMxVkSw1AyY9/GKJaMVgvUj18aDFR gg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run1ggfhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jul 2023 14:51:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36FEpIP2031601
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jul 2023 14:51:18 GMT
Received: from [10.253.38.208] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sat, 15 Jul
 2023 07:51:15 -0700
Message-ID: <d8fbe5ba-64b6-a03e-d554-558192f7b9f7@quicinc.com>
Date:   Sat, 15 Jul 2023 22:51:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/6] net: phy: at803x: merge qca8081 salve seed
 function
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230714063136.21368-1-quic_luoj@quicinc.com>
 <20230714063136.21368-3-quic_luoj@quicinc.com>
 <ZLEn7OhlX9X609eh@shell.armlinux.org.uk>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZLEn7OhlX9X609eh@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X6P44GqUhztbbEOnFP62FfxLw_ggYaf8
X-Proofpoint-GUID: X6P44GqUhztbbEOnFP62FfxLw_ggYaf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=386 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307150140
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2023 6:48 PM, Russell King (Oracle) wrote:
> "merge qca8081 salve seed function"
> 
> I'm not sure what salve has to do with the seed... seems like a typo?
> 
> Otherwise,
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Thanks!
> 

yes, Russell, it is a typo, will update it in next patch set, thanks.
