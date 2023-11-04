Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8E57E0E12
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 07:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjKDGZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 02:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDGZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 02:25:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DD4D4E;
        Fri,  3 Nov 2023 23:25:49 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A46Mj2s003718;
        Sat, 4 Nov 2023 06:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FF+AubAxdBtQyqoK1rXHKIxkMnLgY9CQlvcYzJVd4tI=;
 b=SHycbO/qK4paUUQn4nC+afmkMkO/OyRo+SpdGRCZccsYrrgAso/Xuy/FtXfF6EV4fCtr
 4uXCMO2ZE9KKyklkmCESMpzRLkbew/I559xMfcNIf2Eb+JcCRz1HFWTg+0vvB0p3XvHM
 A7HMzTJuMWKZ5I4EXWFmkaTlvBlpZexvptML5eCpTJwXqFZgkpAXc07JLQ1QBz4Ug2qh
 IQgj1b9MD1aEj55aoqH1VCuVkv31HYhnAv9u2uKA+BclJZOhnh7c3Iklx0hqPEPjsfCu
 wFOt2Obnv5iPHJGQGdiwJ1aYtU7qJ4tPsyhw+GoQLX6IuRAKdPTErmokhZ2Ieb9qK4h+ cw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5eekg6rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Nov 2023 06:25:30 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A46PUGP002481
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 4 Nov 2023 06:25:30 GMT
Received: from [10.253.39.47] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 3 Nov
 2023 23:25:27 -0700
Message-ID: <7f0df23b-f00e-fef8-fa03-314fcfe136eb@quicinc.com>
Date:   Sat, 4 Nov 2023 14:25:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] net: phy: at803x: add QCA8084 ethernet phy support
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231103123538.15735-1-quic_luoj@quicinc.com>
 <806fb6b6-d9b6-457b-b079-48f8b958cc5a@lunn.ch>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <806fb6b6-d9b6-457b-b079-48f8b958cc5a@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b80QBcTX3QKOAy7HFz7Xuppm_qjj_JcN
X-Proofpoint-GUID: b80QBcTX3QKOAy7HFz7Xuppm_qjj_JcN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-04_04,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=815
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311040052
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/2023 9:01 PM, Andrew Lunn wrote:
>>   #define QCA8081_PHY_ID				0x004dd101
>> +#define QCA8081_PHY_MASK			0xffffff00
> 
> That is an unusual mask. Please check it is correct. All you should
> need its PHY_ID_MATCH_EXACT, PHY_ID_MATCH_MODEL, PHY_ID_MATCH_VENDOR.

Thanks Andrew for the review.
The PHY ID of qca8084 is correct, i will update to use 
PHY_ID_MATCH_EXACT in the new added entry for qca8084.

> 
>> @@ -1767,6 +1781,20 @@ static int qca808x_config_init(struct phy_device *phydev)
>>   {
>>   	int ret;
>>   
>> +	if (phydev->phy_id == QCA8084_PHY_ID) {
>> +		/* Invert ADC clock edge */
>> +		ret = at803x_debug_reg_mask(phydev, QCA8084_ADC_CLK_SEL,
>> +					    QCA8084_ADC_CLK_SEL_ACLK,
>> +					    FIELD_PREP(QCA8084_ADC_CLK_SEL_ACLK,
>> +						       QCA8084_ADC_CLK_SEL_ACLK_FALL));
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		/* Adjust MSE threshold value to avoid link issue with some link partner */
>> +		return phy_write_mmd(phydev, MDIO_MMD_PMAPMD,
>> +				QCA8084_MSE_THRESHOLD, QCA8084_MSE_THRESHOLD_2P5G_VAL);
>> +	}
>> +
> 
> Please add a qca8084_config_init() and use that from the phy_driver
> structure.

OK.

> 
>>   	/* Active adc&vga on 802.3az for the link 1000M and 100M */
>>   	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_ADDR_CLD_CTRL7,
>>   			QCA808X_8023AZ_AFE_CTRL_MASK, QCA808X_8023AZ_AFE_EN);
>> @@ -1958,6 +1986,11 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
>>   	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807a, 0xc060);
>>   	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807e, 0xb060);
>>   
>> +	if (phydev->phy_id == QCA8084_PHY_ID) {
>> +		phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8075, 0xa060);
>> +		phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807f, 0x1eb0);
>> +	}
>> +
> 
> Please add a comment what this is doing.

Ok, will add comments in the next patch.

> 
>>   }, {
>>   	/* Qualcomm QCA8081 */
>> -	PHY_ID_MATCH_EXACT(QCA8081_PHY_ID),
>> -	.name			= "Qualcomm QCA8081",
>> +	.phy_id			= QCA8081_PHY_ID,
>> +	.phy_id_mask		= QCA8081_PHY_MASK,
>> +	.name			= "Qualcomm QCA808X",
> 
> Please add a new entry for the 8084.
> 
>         Andrew

Will add it in the next patch, thanks.
