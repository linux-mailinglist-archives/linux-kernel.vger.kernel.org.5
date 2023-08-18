Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAAA7804F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357776AbjHRDxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357763AbjHRDxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E766535BE;
        Thu, 17 Aug 2023 20:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 630EE622AC;
        Fri, 18 Aug 2023 03:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E853C433C8;
        Fri, 18 Aug 2023 03:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692330783;
        bh=diizcXG7NJQX3wS1cgo0OqsgS/u57WE0WI0HWRSrxRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gN3cDP7hxqWjUKQX9x1Pks7z+FwS2vUMgWjnFnqOW5h3H64c5QNC21brsaz48igSv
         NqK5mWyqZrMsjbWA9cREHgjAm2oJIPhFvA050Yi0MsDFgUbI5cXJ67EMGLzhN0Tyfq
         BOdM+/ZGr58J815SxhXXwwMW1oeaZfCc2+mMWA6HLxkvvpI1H3y4Vx4/P0WFjojd7A
         2RnVHPjqAuJsV0rPsWYf5ZhDRlcJkOPOR3xMtY3w/xQGh8PsuK7/gEgd8oU9LXm9lB
         cxuk1FvSlW35E97qmPEzhCr/K0EoEvlZ+rQa8amGd0ZChjr57k068Aril5y4TAaZX/
         J78whoHzfeOjg==
Date:   Thu, 17 Aug 2023 20:55:44 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
Subject: Re: [PATCH v4 4/4] clk: qcom: add clock controller driver for
 qca8386/qca8084
Message-ID: <nk7o2fb6to26zt5fnbvfqhx2xg4rzmoeko2wfj5azh2ns4hisr@s76c3m33s774>
References: <20230815085205.9868-1-quic_luoj@quicinc.com>
 <20230815085205.9868-5-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815085205.9868-5-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 04:52:05PM +0800, Luo Jie wrote:
> Add clock & reset controller driver for qca8386/qca8084.

Not everyone is familiar with the QCA components, or the mdiobus dance.
Please do take the opportunity to educate us here.

> 
> Change-Id: Ic4b768626b47f28073332885ae62972640821709

No Change-Id upstream, please.

> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig       |    8 +
>  drivers/clk/qcom/Makefile      |    1 +
>  drivers/clk/qcom/nsscc-qca8k.c | 2118 ++++++++++++++++++++++++++++++++
>  3 files changed, 2127 insertions(+)
>  create mode 100644 drivers/clk/qcom/nsscc-qca8k.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 263e55d75e3f..d84705ff920d 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -195,6 +195,14 @@ config IPQ_GCC_9574
>  	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>  	  of ipq9574.
>  
> +config IPQ_NSSCC_QCA8K
> +	tristate "QCA8K(QCA8386 or QCA8084) NSS Clock Controller"
> +	help
> +	  Support for NSS(Network SubSystem) clock controller on
> +	  qca8386/qca8084 chip.
> +	  Say Y if you want to use network features of switch or PHY
> +	  device. Select this for the root clock of qca8k.

Please make sure that this works as 'm' as well, and if it already does,
please loosen the language.

> +
>  config MSM_GCC_8660
>  	tristate "MSM8660 Global Clock Controller"
>  	depends on ARM || COMPILE_TEST
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index e6e294274c35..17238177c39d 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
>  obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
>  obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
>  obj-$(CONFIG_IPQ_GCC_9574) += gcc-ipq9574.o
> +obj-$(CONFIG_IPQ_NSSCC_QCA8K) += nsscc-qca8k.o

'N' > 'L'

>  obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
>  obj-$(CONFIG_MDM_GCC_9607) += gcc-mdm9607.o
>  obj-$(CONFIG_MDM_GCC_9615) += gcc-mdm9615.o
> diff --git a/drivers/clk/qcom/nsscc-qca8k.c b/drivers/clk/qcom/nsscc-qca8k.c
[..]
> +static inline void split_addr(u32 regaddr, u16 *r1, u16 *r2, u16 *page)
> +{
> +	*r1 = regaddr & 0x1c;
> +
> +	regaddr >>= 5;
> +	*r2 = regaddr & 0x7;
> +
> +	regaddr >>= 3;
> +	*page = regaddr & 0xffff;

Perhaps it's just me not knowing the details of the mdiobus, but it
would be really nice to have a comment with a detailed description of
the addressing scheme here.

> +}
> +
> +int qca8k_mii_read(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u32 *val)
> +{
> +	int ret;
> +
> +	ret = bus->read(bus, switch_phy_id, reg);
> +	if (ret >= 0) {
> +		*val = ret;
> +		ret = bus->read(bus, switch_phy_id, (reg | BIT(1)));
> +		*val |= ret << 16;
> +	}
> +
> +	if (ret < 0) {
> +		dev_err_ratelimited(&bus->dev, "fail to read qca8k mii register\n");
> +
> +		*val = 0;

It's good practice not to touch the return-by-reference parameter unless
you're returning success.

> +		return ret;
> +	}
> +
> +	return 0;

Afaict ret is 0 here, so a single return ret; should be fine?

> +}
> +
> +void qca8k_mii_write(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u32 val)
> +{
> +	int ret;
> +	u16 lo, hi;
> +
> +	lo = val & 0xffff;

lower_16_bits(val);

> +	hi = (u16)(val >> 16);

upper_16_bits(val);

> +
> +	ret = bus->write(bus, switch_phy_id, reg, lo);
> +	if (ret >= 0)
> +		ret = bus->write(bus, switch_phy_id, (reg | BIT(1)), hi);
> +
> +	if (ret < 0)
> +		dev_err_ratelimited(&bus->dev, "fail to write qca8k mii register\n");
> +}
> +
> +int qca8k_mii_page_set(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u16 page)
> +{
> +	int ret;
> +
> +	ret = bus->write(bus, switch_phy_id, reg, page);
> +	if (ret < 0)
> +		dev_err_ratelimited(&bus->dev, "fail to set page\n");
> +
> +	return ret;
> +}
> +
> +int qca8k_regmap_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct mii_bus *bus = context;
> +	u16 r1, r2, page;
> +	int ret;
> +
> +	reg += QCA8K_CLK_REG_BASE;
> +	split_addr(reg, &r1, &r2, &page);
> +
> +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> +	ret = qca8k_mii_page_set(bus, QCA8K_HIGH_ADDR_PREFIX, QCA8K_CFG_PAGE_REG, page);
> +	if (ret < 0)
> +		goto qca8k_read_exit;
> +
> +	ret = qca8k_mii_read(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, val);
> +
> +qca8k_read_exit:
> +	mutex_unlock(&bus->mdio_lock);
> +	return ret;
> +};
> +
> +int qca8k_regmap_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct mii_bus *bus = context;
> +	u16 r1, r2, page;
> +	int ret;
> +
> +	reg += QCA8K_CLK_REG_BASE;
> +	split_addr(reg, &r1, &r2, &page);
> +
> +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> +	ret = qca8k_mii_page_set(bus, QCA8K_HIGH_ADDR_PREFIX, QCA8K_CFG_PAGE_REG, page);
> +	if (ret < 0)
> +		goto qca8k_write_exit;
> +
> +	qca8k_mii_write(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, val);
> +
> +qca8k_write_exit:
> +	mutex_unlock(&bus->mdio_lock);
> +	return ret;
> +};
> +
> +int qca8k_regmap_update_bits(void *context, unsigned int reg, unsigned int mask, unsigned int value)
> +{
> +	struct mii_bus *bus = context;
> +	u16 r1, r2, page;
> +	int ret;
> +	u32 val;
> +
> +	reg += QCA8K_CLK_REG_BASE;
> +	split_addr(reg, &r1, &r2, &page);
> +
> +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);

Why is this lock nested?

> +	ret = qca8k_mii_page_set(bus, QCA8K_HIGH_ADDR_PREFIX, QCA8K_CFG_PAGE_REG, page);
> +	if (ret < 0)
> +		goto qca8k_update_exit;
> +
> +	ret = qca8k_mii_read(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, &val);
> +	if (ret < 0)
> +		goto qca8k_update_exit;
> +
> +	val &= ~mask;
> +	val |= value;
> +	qca8k_mii_write(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, val);
> +
> +qca8k_update_exit:
> +	mutex_unlock(&bus->mdio_lock);
> +	return ret;
> +}
> +
> +static const struct regmap_config nss_cc_qca8k_regmap_config = {
> +	.reg_bits = 12,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x30C,
> +	.reg_read = qca8k_regmap_read,
> +	.reg_write = qca8k_regmap_write,
> +	.reg_update_bits = qca8k_regmap_update_bits,
> +	.disable_locking = true,

Why do you disable_locking and then provide your own locking? Why not
specify fast_io = false, use mdiobus_read() and mdiobus_write() and let
the regmap framework implement update_bits for you?

Regards,
Bjorn

> +	.cache_type = REGCACHE_NONE,
> +};
> +
> +static const struct qcom_cc_desc nss_cc_qca8k_desc = {
> +	.config = &nss_cc_qca8k_regmap_config,
> +	.clks = nss_cc_qca8k_clocks,
> +	.num_clks = ARRAY_SIZE(nss_cc_qca8k_clocks),
> +	.resets = nss_cc_qca8k_resets,
> +	.num_resets = ARRAY_SIZE(nss_cc_qca8k_resets),
> +};
> +
> +static int nss_cc_qca8k_probe(struct mdio_device *mdiodev)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init(&mdiodev->dev, NULL, mdiodev->bus, nss_cc_qca8k_desc.config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&mdiodev->dev, PTR_ERR(regmap), "Failed to init regmap\n");
> +
> +	return _qcom_cc_really_probe(&mdiodev->dev, &nss_cc_qca8k_desc, regmap);
> +}
> +
> +static const struct of_device_id nss_cc_qca8k_match_table[] = {
> +	{ .compatible = "qcom,qca8084-nsscc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, nss_cc_qca8k_match_table);
> +
> +static struct mdio_driver nss_cc_qca8k_driver = {
> +	.mdiodrv.driver = {
> +		.name = "qcom,qca8k-nsscc",
> +		.of_match_table	= nss_cc_qca8k_match_table,
> +	},
> +	.probe = nss_cc_qca8k_probe,
> +};
> +
> +mdio_module_driver(nss_cc_qca8k_driver);
> +
> +MODULE_DESCRIPTION("QCOM NSS_CC QCA8K Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.17.1
> 
