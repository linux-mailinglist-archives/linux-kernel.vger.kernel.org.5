Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383767E128B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 09:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjKEIJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 03:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 03:09:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7F7C0;
        Sun,  5 Nov 2023 01:09:31 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A589E1L014896;
        Sun, 5 Nov 2023 08:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=E5l2n4+yNRyfg4fhfV7+iE84bhcyIEj5XbABJG5l/z0=;
 b=EwLXKO608FplwSM1T7orfWZEILlbVfk23Ryo9KWZ4DJM2595YearD6LPCgZO1saHHaaK
 3bzFMTMjOG3E9NgZWkL9t7v7/8qQ6FFghYau09ElGIoyaxCzQXW6KxLBZ6pkGlXpNZ13
 rwHqaDQxv5CJuSOeCPUQ9a7bAQwcZk9ZvsnvE7aVdJHIHclE1lDI6v1dNCwObxs3U6zw
 AsVAJsjUtq+bdpO3CdFpAEHkNXr4mnitCcX2CODUgQExDUSXbwzRw2U4BX8MaY3rZbZN
 o6Ue+n/F4akrIh0S/UiE1WIOQ1q251lSS4f2uQDj80unYF8ahloqrau6MYV9i8K/K+Ki +g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5eu61q5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Nov 2023 08:09:14 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A589DiG005098
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 Nov 2023 08:09:13 GMT
Received: from [10.253.39.47] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 5 Nov
 2023 01:09:10 -0700
Message-ID: <eac5ec9c-3157-1f7d-c092-1098c96d129a@quicinc.com>
Date:   Sun, 5 Nov 2023 16:09:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] net: phy: at803x: add QCA8084 ethernet phy support
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231103123538.15735-1-quic_luoj@quicinc.com>
 <ZUadBJQLFA4f/gQY@shell.armlinux.org.uk>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZUadBJQLFA4f/gQY@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pgnU5yyWZM7y-7i72xw5AMpxI5ZOpNqQ
X-Proofpoint-ORIG-GUID: pgnU5yyWZM7y-7i72xw5AMpxI5ZOpNqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-05_05,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311050068
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/2023 3:35 AM, Russell King (Oracle) wrote:
> On Fri, Nov 03, 2023 at 08:35:37PM +0800, Luo Jie wrote:
>> Add qca8084 PHY support, which is four-port PHY with maximum
>> link capability 2.5G, the features of each port is almost same
>> as QCA8081 and slave seed config is not needed.
>>
>> There are some initialization configurations needed.
>> 1. Configuring qca8084 related initializations including
>> MSE detect threshold and ADC clock edge invert.
>> 2. Add the additional configurations for the CDT feature.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   drivers/net/phy/at803x.c | 40 +++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
>> index 37fb033e1c29..4124eb76d835 100644
>> --- a/drivers/net/phy/at803x.c
>> +++ b/drivers/net/phy/at803x.c
>> @@ -176,6 +176,8 @@
>>   #define AT8030_PHY_ID_MASK			0xffffffef
>>   
>>   #define QCA8081_PHY_ID				0x004dd101
>> +#define QCA8081_PHY_MASK			0xffffff00
>> +#define QCA8084_PHY_ID				0x004dd180
> ...
>> @@ -2207,8 +2240,9 @@ static struct phy_driver at803x_driver[] = {
>>   	.resume			= qca83xx_resume,
>>   }, {
>>   	/* Qualcomm QCA8081 */
>> -	PHY_ID_MATCH_EXACT(QCA8081_PHY_ID),
>> -	.name			= "Qualcomm QCA8081",
>> +	.phy_id			= QCA8081_PHY_ID,
>> +	.phy_id_mask		= QCA8081_PHY_MASK,
>> +	.name			= "Qualcomm QCA808X",
> ...
>> @@ -2241,7 +2275,7 @@ static struct mdio_device_id __maybe_unused atheros_tbl[] = {
>>   	{ PHY_ID_MATCH_EXACT(QCA8327_A_PHY_ID) },
>>   	{ PHY_ID_MATCH_EXACT(QCA8327_B_PHY_ID) },
>>   	{ PHY_ID_MATCH_EXACT(QCA9561_PHY_ID) },
>> -	{ PHY_ID_MATCH_EXACT(QCA8081_PHY_ID) },
>> +	{ QCA8081_PHY_ID, QCA8081_PHY_MASK},
> 
> So, in summary from the above, what you're doing is using the pair of
> QCA8081_PHY_ID, QCA8081_PHY_MASK to match not only QCA8081 but also
> QCA8084. This is confusing.

Yes, Russell.
qca8084 is the different PHY model compared with the existed qca8081, 
qca8084 needs the extra PCS configuration and clock configuration, which 
will be pushed to the PCS driver.

I will update to use PHY_ID_MATCH_MODEL for the new added entry of 
qca8084 to distinguish qca8081.

> 
> Are there any other parts that QCA808X would correspond with which
> would not be compatible with the above? E.g. QCA8082, QCA8083, QCA8088
> etc.

The new added PHY chip qca8082, qca8084 and qca8085 use the same PHY ID, 
so the PHY_ID_MATCH_MODEL should be able to cover the new added entry.

> 
> If there are, then the correct approach would be to list them
> separately in atheros_tbl, and also have separate driver entries in
> at803x_driver so it's unambiguous.
> 
> If we keep this approach, then I would suggest:
> 
> #define QCA808X_PHY_ID		0x004dd100
> #define QCA808X_PHY_MASK	GENMASK(31, 8)
> 
> to make it explicit that this phy ID/mask pair is matching several
> devices, rather than re-using the QCA8081_PHY_ID definition.

Thanks for the suggestion. the PHY_ID_MATCH_MODEL should match the new 
added PHY devices.

> 
> 
> The next point - what about the revision field which occupies bits 3:0
> in these:

bits[3:0] is for the revision number, currently there is only one PHY ID 
(revision number is 0)used for the new added series PHY chip.

> 
>>   static bool qca808x_has_fast_retrain_or_slave_seed(struct phy_device *phydev)
>>   {
>> +	if (phydev->phy_id == QCA8084_PHY_ID)
>> +		return false;
>> +
> ...
>> @@ -1767,6 +1781,20 @@ static int qca808x_config_init(struct phy_device *phydev)
>>   {
>>   	int ret;
>>   
>> +	if (phydev->phy_id == QCA8084_PHY_ID) {
>> +		/* Invert ADC clock edge */
> ...
>> @@ -1958,6 +1986,11 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
>>   	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807a, 0xc060);
>>   	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807e, 0xb060);
>>   
>> +	if (phydev->phy_id == QCA8084_PHY_ID) {
> 
> Do these need to be exact matches, or should the revision field be
> ignored? If so, consider using phy_id_compare(), or if you end up with
> separate driver entries, consider using phydev_id_compare().
> 
> Thanks.
> 
Ok, i will double check this configuration to consider to use the 
suggested API in the next updated patch. Thanks Russell for the review.
