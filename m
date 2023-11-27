Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C182F7F9CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjK0Jr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjK0Jry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:47:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A46EDE;
        Mon, 27 Nov 2023 01:47:58 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR8o8fq005308;
        Mon, 27 Nov 2023 09:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DLa4Kp7HxsKcXRRks8BDl3egQFGnE2LXNIlaMAyxw7Q=;
 b=XqzAJ2zSnv7DTXF7VGACBJakjb64vYAAxtY1ccJwONLVIm1Lh4u84yqqnj8TX/RNCKXV
 obWKJMiYlUsp9NRZ0dfCo/vg57XOV6waAHO3QSybB+dixrgHrot77clBli+ZukL2z8wA
 UDN+Opqdf4YObRBCMYtPL5UbSpKok6oWkEib0Uhr9/e1bjZBhFP4If+emQWDR8R1kMZ8
 hDStzZyXIyLxnw73Mw/zW0DGpWodWwP0cMp192Wt09x+5VygI0CAuFlR5anY0+LLbY7H
 pm8nbnrGoHJToHtCTNB6k32OkD4QjuqFJ/vnKJBL9E/Zb/bUqKJxNAALxiLRY3EGMZlH Ow== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umqxh03w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 09:47:32 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AR9lV48000578
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 09:47:31 GMT
Received: from [10.216.36.194] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 01:47:23 -0800
Message-ID: <3bf6f666-b58a-460f-88f5-ad8ec08bfbbc@quicinc.com>
Date:   Mon, 27 Nov 2023 15:17:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: update Rx clk divider for 10M SGMII
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
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
        Andrew Halaney <ahalaney@redhat.com>
References: <20231124050818.1221-1-quic_snehshah@quicinc.com>
 <ZWBo5EKjkffNOqkQ@shell.armlinux.org.uk>
 <47c9eb95-ff6a-4432-a7ef-1f3ebf6f593f@quicinc.com>
 <ZWRVz05Gb4oALDnf@shell.armlinux.org.uk>
From:   Sneh Shah <quic_snehshah@quicinc.com>
In-Reply-To: <ZWRVz05Gb4oALDnf@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nrvAYn8HSf4OGhf24CFSTQKueIP7r0Ph
X-Proofpoint-ORIG-GUID: nrvAYn8HSf4OGhf24CFSTQKueIP7r0Ph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_08,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=620 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/2023 2:09 PM, Russell King (Oracle) wrote:
> Please reply _inline_ rather than at the top of the message, just like
> every other email that is sent in the Linux community. It is actually
> the _Internet_ standard way of replying, before people like Microsoft
> encouraged your broken style.
> 
> Also wrapping the text of your message makes it easier.

Noted. Going forward will make sure to reply inline.

> 
> On Mon, Nov 27, 2023 at 11:25:34AM +0530, Sneh Shah wrote:
>> On 11/24/2023 2:42 PM, Russell King (Oracle) wrote:
>>> On Fri, Nov 24, 2023 at 10:38:18AM +0530, Sneh Shah wrote:
>>>>  #define RGMII_CONFIG_LOOPBACK_EN		BIT(2)
>>>>  #define RGMII_CONFIG_PROG_SWAP			BIT(1)
>>>>  #define RGMII_CONFIG_DDR_MODE			BIT(0)
>>>> +#define RGMII_CONFIG_SGMII_CLK_DVDR		GENMASK(18, 10)
>>>
>>> So you're saying here that this is a 9 bit field...
>>>
>>>> @@ -617,6 +618,8 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
>>>>  	case SPEED_10:
>>>>  		val |= ETHQOS_MAC_CTRL_PORT_SEL;
>>>>  		val &= ~ETHQOS_MAC_CTRL_SPEED_MODE;
>>>> +		rgmii_updatel(ethqos, RGMII_CONFIG_SGMII_CLK_DVDR, BIT(10) |
>>>> +			      GENMASK(15, 14), RGMII_IO_MACRO_CONFIG);
>>>
>>> ... and then you use GENMASK(15,14) | BIT(10) here to set bits in that
>>> bitfield. If there are multiple bitfields, then these should be defined
>>> separately and the mask built up.
>>>
>>> I suspect that they aren't, and you're using this to generate a _value_
>>> that has bits 5, 4, and 0 set for something that really takes a _value_.
>>> So, FIELD_PREP(RGMII_CONFIG_SGMII_CLK_DVDR, 0x31) or
>>> FIELD_PREP(RGMII_CONFIG_SGMII_CLK_DVDR, 49) would be entirely correct
>>> here.
>>
>> You are right here for GENMASK(15,14) | BIT(10). I am using this to create a field value.I will switch to FIELD_PREP as that seems like a better way to do this.
> 
> So this is a "nice" example of taking the use of GENMASK() and BIT() to
> an inappropriate case.
> 
>>> The next concern I have is that you're only doing this for SPEED_10.
>>> If it needs to be programmed for SPEED_10 to work, and not any of the
>>> other speeds, isn't this something that can be done at initialisation
>>> time? If it has to be done depending on the speed, then don't you need
>>> to do this for each speed with an appropriate value?
>>
>> This field programming is required only for 10M speed in for SGMII mode. other speeds are agnostic to this field. Hence we are programming it always when SGMII link comes up in 10M mode. init driver data for ethqos is common for sgmii and rgmii. As this fix is specific to SGMII we can't add this to init driver data.
> 
> I wasn't referring to adding it to driver data. I was asking whether it
> could be done in the initialisation path.
> 
No, IOMACRO block is configured post phylink up regardless of RGMII or SGMII mode. We are not updating them at driver initialization time itself.
