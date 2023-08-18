Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FFE780D90
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377647AbjHROIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377696AbjHROHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:07:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0CE4487;
        Fri, 18 Aug 2023 07:07:20 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IDOtsg016744;
        Fri, 18 Aug 2023 14:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=djR5RlFv7R1h1hwEf8N9N+qufd/Avkm+BvhWAbtRuYE=;
 b=l1tGI0Qs6Usb/G3InH4GnULSBkUHJPKlkEzjq/agiR7PwmXuFW+vRkkV6ZIQywoZF28/
 /APw9vUwsbTVIRbWoUm91gCUXpwvfQAIiwrk09UBBmti0tW+uzFquvNpnnW17k7G4wTU
 +lVhJZxmKgzHbaBd3YIcL622010GhzUcCQOt8OaMHYKsLSdFLGhP9EGNAv7pHtvnBN+A
 YhOpSEjtIPqHqkYMRcbspEsx15dwAwVMnbmfdNiT7soEI+QKnyKYgvv7z+v8qheeMs8N
 AqeISBhcWf5etbuqofaeiVeJW8LgrqD3jAtJTivqhklN4xzSmc4OuGWrxXlE/ldUOKBR ew== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sj6320f2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 14:07:02 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37IE72HH011476
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 14:07:02 GMT
Received: from [10.253.34.149] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 18 Aug
 2023 07:06:57 -0700
Message-ID: <bcabc26b-d4b8-69b8-3453-2ae67aeb2568@quicinc.com>
Date:   Fri, 18 Aug 2023 22:06:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 4/4] clk: qcom: add clock controller driver for
 qca8386/qca8084
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230815085205.9868-1-quic_luoj@quicinc.com>
 <20230815085205.9868-5-quic_luoj@quicinc.com>
 <nk7o2fb6to26zt5fnbvfqhx2xg4rzmoeko2wfj5azh2ns4hisr@s76c3m33s774>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <nk7o2fb6to26zt5fnbvfqhx2xg4rzmoeko2wfj5azh2ns4hisr@s76c3m33s774>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: idjsRt-y4ZB3aT2KBwimMjnQOLNFZ1NB
X-Proofpoint-ORIG-GUID: idjsRt-y4ZB3aT2KBwimMjnQOLNFZ1NB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_17,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180129
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2023 11:55 AM, Bjorn Andersson wrote:
> On Tue, Aug 15, 2023 at 04:52:05PM +0800, Luo Jie wrote:
>> Add clock & reset controller driver for qca8386/qca8084.
> 
> Not everyone is familiar with the QCA components, or the mdiobus dance.
> Please do take the opportunity to educate us here.

Thanks Bjorn for the comments, i will add the detail message here in the 
next patch set.

This clock controller driver is for the device where register is 
accessed by MDIO bus, the framework of clock is same as the existed 
clock controller of QCA driver such gcc-ipq9574.

The MDIO bus is for accessing the PHY device by ieee802.3-c45 or 
ieee802.3-c22, the clock register of qca8386/qca8084 is also accessed by 
the MDIO bus, which has the special sequence to access the register with 
multiple MDIO read/write operations.

> 
>>
>> Change-Id: Ic4b768626b47f28073332885ae62972640821709
> 
> No Change-Id upstream, please.
okay, will remove this.

> 
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig       |    8 +
>>   drivers/clk/qcom/Makefile      |    1 +
>>   drivers/clk/qcom/nsscc-qca8k.c | 2118 ++++++++++++++++++++++++++++++++
>>   3 files changed, 2127 insertions(+)
>>   create mode 100644 drivers/clk/qcom/nsscc-qca8k.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 263e55d75e3f..d84705ff920d 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -195,6 +195,14 @@ config IPQ_GCC_9574
>>   	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>>   	  of ipq9574.
>>   
>> +config IPQ_NSSCC_QCA8K
>> +	tristate "QCA8K(QCA8386 or QCA8084) NSS Clock Controller"
>> +	help
>> +	  Support for NSS(Network SubSystem) clock controller on
>> +	  qca8386/qca8084 chip.
>> +	  Say Y if you want to use network features of switch or PHY
>> +	  device. Select this for the root clock of qca8k.
> 
> Please make sure that this works as 'm' as well, and if it already does,
> please loosen the language.
> 
thanks for the comments, i will update this in the next patch set.

>> +
>>   config MSM_GCC_8660
>>   	tristate "MSM8660 Global Clock Controller"
>>   	depends on ARM || COMPILE_TEST
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index e6e294274c35..17238177c39d 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -29,6 +29,7 @@ obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
>>   obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
>>   obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
>>   obj-$(CONFIG_IPQ_GCC_9574) += gcc-ipq9574.o
>> +obj-$(CONFIG_IPQ_NSSCC_QCA8K) += nsscc-qca8k.o
> 
> 'N' > 'L'

will update this, thanks.
> 
>>   obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
>>   obj-$(CONFIG_MDM_GCC_9607) += gcc-mdm9607.o
>>   obj-$(CONFIG_MDM_GCC_9615) += gcc-mdm9615.o
>> diff --git a/drivers/clk/qcom/nsscc-qca8k.c b/drivers/clk/qcom/nsscc-qca8k.c
> [..]
>> +static inline void split_addr(u32 regaddr, u16 *r1, u16 *r2, u16 *page)
>> +{
>> +	*r1 = regaddr & 0x1c;
>> +
>> +	regaddr >>= 5;
>> +	*r2 = regaddr & 0x7;
>> +
>> +	regaddr >>= 3;
>> +	*page = regaddr & 0xffff;
> 
> Perhaps it's just me not knowing the details of the mdiobus, but it
> would be really nice to have a comment with a detailed description of
> the addressing scheme here.
> 
Thanks for the review comments, i will explain the detail information 
for the sequence of accessing the switch register here in the next patch 
set.

>> +}
>> +
>> +int qca8k_mii_read(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u32 *val)
>> +{
>> +	int ret;
>> +
>> +	ret = bus->read(bus, switch_phy_id, reg);
>> +	if (ret >= 0) {
>> +		*val = ret;
>> +		ret = bus->read(bus, switch_phy_id, (reg | BIT(1)));
>> +		*val |= ret << 16;
>> +	}
>> +
>> +	if (ret < 0) {
>> +		dev_err_ratelimited(&bus->dev, "fail to read qca8k mii register\n");
>> +
>> +		*val = 0;
> 
> It's good practice not to touch the return-by-reference parameter unless
> you're returning success.
> 
okay, will remove this in the next patch set.

>> +		return ret;
>> +	}
>> +
>> +	return 0;
> 
> Afaict ret is 0 here, so a single return ret; should be fine?

Yes, i will update to use the singel return ret here, thanks for the 
comments.

> 
>> +}
>> +
>> +void qca8k_mii_write(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u32 val)
>> +{
>> +	int ret;
>> +	u16 lo, hi;
>> +
>> +	lo = val & 0xffff;
> 
> lower_16_bits(val);
> 
will update to use this in the next patch set.

>> +	hi = (u16)(val >> 16);
> 
> upper_16_bits(val);

will update to use this in the next patch set.
> 
>> +
>> +	ret = bus->write(bus, switch_phy_id, reg, lo);
>> +	if (ret >= 0)
>> +		ret = bus->write(bus, switch_phy_id, (reg | BIT(1)), hi);
>> +
>> +	if (ret < 0)
>> +		dev_err_ratelimited(&bus->dev, "fail to write qca8k mii register\n");
>> +}
>> +
>> +int qca8k_mii_page_set(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u16 page)
>> +{
>> +	int ret;
>> +
>> +	ret = bus->write(bus, switch_phy_id, reg, page);
>> +	if (ret < 0)
>> +		dev_err_ratelimited(&bus->dev, "fail to set page\n");
>> +
>> +	return ret;
>> +}
>> +
>> +int qca8k_regmap_read(void *context, unsigned int reg, unsigned int *val)
>> +{
>> +	struct mii_bus *bus = context;
>> +	u16 r1, r2, page;
>> +	int ret;
>> +
>> +	reg += QCA8K_CLK_REG_BASE;
>> +	split_addr(reg, &r1, &r2, &page);
>> +
>> +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
>> +	ret = qca8k_mii_page_set(bus, QCA8K_HIGH_ADDR_PREFIX, QCA8K_CFG_PAGE_REG, page);
>> +	if (ret < 0)
>> +		goto qca8k_read_exit;
>> +
>> +	ret = qca8k_mii_read(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, val);
>> +
>> +qca8k_read_exit:
>> +	mutex_unlock(&bus->mdio_lock);
>> +	return ret;
>> +};
>> +
>> +int qca8k_regmap_write(void *context, unsigned int reg, unsigned int val)
>> +{
>> +	struct mii_bus *bus = context;
>> +	u16 r1, r2, page;
>> +	int ret;
>> +
>> +	reg += QCA8K_CLK_REG_BASE;
>> +	split_addr(reg, &r1, &r2, &page);
>> +
>> +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
>> +	ret = qca8k_mii_page_set(bus, QCA8K_HIGH_ADDR_PREFIX, QCA8K_CFG_PAGE_REG, page);
>> +	if (ret < 0)
>> +		goto qca8k_write_exit;
>> +
>> +	qca8k_mii_write(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, val);
>> +
>> +qca8k_write_exit:
>> +	mutex_unlock(&bus->mdio_lock);
>> +	return ret;
>> +};
>> +
>> +int qca8k_regmap_update_bits(void *context, unsigned int reg, unsigned int mask, unsigned int value)
>> +{
>> +	struct mii_bus *bus = context;
>> +	u16 r1, r2, page;
>> +	int ret;
>> +	u32 val;
>> +
>> +	reg += QCA8K_CLK_REG_BASE;
>> +	split_addr(reg, &r1, &r2, &page);
>> +
>> +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> 
> Why is this lock nested?
> 
Thanks for the comments, i will update to use the normal lock 
mutex_lock() here.

>> +	ret = qca8k_mii_page_set(bus, QCA8K_HIGH_ADDR_PREFIX, QCA8K_CFG_PAGE_REG, page);
>> +	if (ret < 0)
>> +		goto qca8k_update_exit;
>> +
>> +	ret = qca8k_mii_read(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, &val);
>> +	if (ret < 0)
>> +		goto qca8k_update_exit;
>> +
>> +	val &= ~mask;
>> +	val |= value;
>> +	qca8k_mii_write(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, val);
>> +
>> +qca8k_update_exit:
>> +	mutex_unlock(&bus->mdio_lock);
>> +	return ret;
>> +}
>> +
>> +static const struct regmap_config nss_cc_qca8k_regmap_config = {
>> +	.reg_bits = 12,
>> +	.reg_stride = 4,
>> +	.val_bits = 32,
>> +	.max_register = 0x30C,
>> +	.reg_read = qca8k_regmap_read,
>> +	.reg_write = qca8k_regmap_write,
>> +	.reg_update_bits = qca8k_regmap_update_bits,
>> +	.disable_locking = true,
> 
> Why do you disable_locking and then provide your own locking? Why not
> specify fast_io = false, use mdiobus_read() and mdiobus_write() and let
> the regmap framework implement update_bits for you?
> 
> Regards,
> Bjorn

Hi Bjorn,
when we read/write the clock hardware register by MDIO bus, there are 
multiple MDIO operations where configuring page is needed before 
reading/writing the converted register, as the sequence mentioned in 
qca8k_regmap_read, and this sequence should be completed during the 
mutex_lock, that is why we can't use regmap mutex lock, which only 
protects single register access, but the clock register access needs 
multiple register access.

In addition, we also need to use the MDIO bus lock mii_bus->mdio_lock,
since this MDIO bus is also used by the PHY register accessed.

thanks,
Jie.

> 
>> +	.cache_type = REGCACHE_NONE,
>> +};
>> +
>> +static const struct qcom_cc_desc nss_cc_qca8k_desc = {
>> +	.config = &nss_cc_qca8k_regmap_config,
>> +	.clks = nss_cc_qca8k_clocks,
>> +	.num_clks = ARRAY_SIZE(nss_cc_qca8k_clocks),
>> +	.resets = nss_cc_qca8k_resets,
>> +	.num_resets = ARRAY_SIZE(nss_cc_qca8k_resets),
>> +};
>> +
>> +static int nss_cc_qca8k_probe(struct mdio_device *mdiodev)
>> +{
>> +	struct regmap *regmap;
>> +
>> +	regmap = devm_regmap_init(&mdiodev->dev, NULL, mdiodev->bus, nss_cc_qca8k_desc.config);
>> +	if (IS_ERR(regmap))
>> +		return dev_err_probe(&mdiodev->dev, PTR_ERR(regmap), "Failed to init regmap\n");
>> +
>> +	return _qcom_cc_really_probe(&mdiodev->dev, &nss_cc_qca8k_desc, regmap);
>> +}
>> +
>> +static const struct of_device_id nss_cc_qca8k_match_table[] = {
>> +	{ .compatible = "qcom,qca8084-nsscc" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, nss_cc_qca8k_match_table);
>> +
>> +static struct mdio_driver nss_cc_qca8k_driver = {
>> +	.mdiodrv.driver = {
>> +		.name = "qcom,qca8k-nsscc",
>> +		.of_match_table	= nss_cc_qca8k_match_table,
>> +	},
>> +	.probe = nss_cc_qca8k_probe,
>> +};
>> +
>> +mdio_module_driver(nss_cc_qca8k_driver);
>> +
>> +MODULE_DESCRIPTION("QCOM NSS_CC QCA8K Driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.17.1
>>
