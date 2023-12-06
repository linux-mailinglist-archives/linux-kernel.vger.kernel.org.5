Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449D8806E83
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377778AbjLFLsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377634AbjLFLsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:48:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4965210E6;
        Wed,  6 Dec 2023 03:48:44 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6ASh92021416;
        Wed, 6 Dec 2023 11:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=i/AKFSSfnBuhU1k9dGXdGPic9GfGYHJhpTGcMfynM8w=;
 b=PJSVzEFL+NDlG3tEvn4GOXdDbzSh2OuYHvAYz9OeJU3CHSqQ0tCEs7mum62+0otk4o8d
 WL+VZK3Xll7T1mN0itr3VjOf6TiTyGXuSkSl/g/rZojAibnTwZTlh1LuzjbzKAoL+1JQ
 UOkHku2AthZ2ixW/PLJ9atJC7iPB6F2FN4BE81QM5e4eACK1ldQN8Ce2/DMTRZl0przZ
 +tma1kkahi/y3EvNi6PJII8CRCmsTpezcl9phj7JCxxWeRGQS1DNEkuavVoBvzNY8HLz
 jnaVirdz9TG4zp1v7jn55g3qiv71f/CQP/CU3lBtHID50msjhIDUWYMgZP1Hy1qWV+9G yA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utd5nhhd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 11:48:16 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B6BmFK1013080
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Dec 2023 11:48:15 GMT
Received: from [10.216.47.147] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 03:47:29 -0800
Message-ID: <5d5f3955-fc30-428c-99f4-42f9b7580a84@quicinc.com>
Date:   Wed, 6 Dec 2023 17:17:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: qcom-ethqos: Add sysfs nodes for
 qcom ethqos
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>, <andersson@kernel.org>
References: <20231204084854.31543-1-quic_snehshah@quicinc.com>
 <3e4a1b9c-ed0f-466e-ba11-fc5b7ef308a1@lunn.ch>
From:   Sneh Shah <quic_snehshah@quicinc.com>
In-Reply-To: <3e4a1b9c-ed0f-466e-ba11-fc5b7ef308a1@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hZ9NNN9k50p4_qLz5sJ2DEbMAxBD1qip
X-Proofpoint-GUID: hZ9NNN9k50p4_qLz5sJ2DEbMAxBD1qip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_09,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 clxscore=1011 mlxscore=0 mlxlogscore=727
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/2023 8:38 PM, Andrew Lunn wrote:
> On Mon, Dec 04, 2023 at 02:18:54PM +0530, Sneh Shah wrote:
>> Add sysfs nodes to conifigure routing of specific vlan id to GVM queue.
>> GVM queue is not exposed to PVM stmmac, so TC ops can't configure routing.
> 
> Adding files in /sysfs has ~0 chance of being accepted.
> 
> As requested, please explain what all these different hardware blocks
> are, and what you are trying to achieve. We can then recommend the
> correct interface.
> 
>     Andrew
> 
> ---
> pw-bot: cr

We have multiVM Architecture here. PVM  will have stmmac running with 4 Rx Tx queues. stmmac in PVM is responsible to configure whole ethernet HW MAC/DMA/MTL ( including clocks, regulators and other core bsp elements).
In GVM we have thin Ethernet driver, which is responsible to configure and manage only 1 Rx/TX queue, i.e 5th Rx/Tx ethernet queue. GVM can't access any other resisters apart from this 5th queue specific MTL and DMA registers.

We need to route vlan traffic of a specific Priority to GVM Queue (Ethernet queue 5) via programming a MAC register. The MAC register is not accessible in GVM and has to be programmed from PVM. stmmac already has TC OPS to program this routing via vlan priority. However, as PVM has only 4 queues enabled, TC tool will not take 5th queue as input. Hence, these nodes were added to conifure the MAC register to route specific vlan packets to 5th queue in GVM.

Note: The queues mentioned above are HW MTL Queues and DMA Channels. The routing can be done in the HW itself based on vlan pcp before the packets reach to driver.


