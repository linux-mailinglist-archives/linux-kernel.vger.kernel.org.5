Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48F576E0C5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjHCHEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjHCHDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:03:53 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC212D65;
        Thu,  3 Aug 2023 00:03:14 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 55D1C320099A;
        Thu,  3 Aug 2023 03:03:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 03 Aug 2023 03:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1691046189; x=1691132589; bh=5S
        kTpiwI76j0iv1Bz8lF8A+JaMZXfVN77EuT9JyTy+A=; b=jU6TSIhH7ZrRg1PEA0
        qzNVnEaJWGbrFhZmrmv5OR71Sm79X1rE5hNEfGohLjsolv+gLVAef8nmzMvRKYUd
        0R1YLra8Mpe4jaYd6QdFO8WC0NDkbNe+vkxtXr11EvrfmM1UQ38zqH0dCBGLqfhX
        Cbs7ZM+Jxrf61cKvw+kBp1SXL0ujiFUCELGAwxqDU9xlk4Mcru3cgZSgF0LAk2R7
        WCsPJ0a5Ub3PqGAag3QmngLFwfEZn67K4t5jSylXzeJbuOVeGT6+UsR+Nw92m2B9
        TEiRW6uH8Talm4MDK6jW8MMFSijvExJKJ/GbuhVRfYphnN3r1IjQoFqdGm21+BY3
        IBKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691046189; x=1691132589; bh=5SkTpiwI76j0i
        v1Bz8lF8A+JaMZXfVN77EuT9JyTy+A=; b=kjDsUJGzVeWOqS09TcFWWuLXwGgGl
        llB92w3a7K9vbrG+pLOTqu5eaVkACxGVUcFU5N6N9KiIrkzLQtEdrlt7skPw/FRT
        0E7MwI+MRmEfkNxU8tv3ETa/9h4eRNWaICvV9dMHILnl4/YsPXDzSLApygmEZloy
        3Gig6ZUplmHR/O5MMRxL5qZIVSVAZOfTZpp9hBnaKDO+LDfTj8bHMl5lQP6L00S5
        eyzjXtQHv9y8LE0M/0PVnrtk2cQdnLR1Cg359SP3r+fjZ/z3cXtk9lU0u27RRMTI
        qCo3DN7Jn6dNAJxH+Ab7uopkknZNs/L8vKsm5T5g2lDC6sZs3vg0cZKYQ==
X-ME-Sender: <xms:LFHLZJGtQm9EYLlFp8H6fbRp1nNmnG-reMyDxsav0NnrK1E5l6FKnw>
    <xme:LFHLZOVI9k7Z2gyoR3Qhb_c9x7Tbg7EsyxPeR-DxLFkgiIGjIr_HLbUERJYkYd65e
    NDiHiyopNeaIl-ZVCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedugdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:LFHLZLIf16Rgi6v0w8j3MNlzrCwjPRNy9NDtczmH5M76-thA7r4zNw>
    <xmx:LFHLZPHWDU-rbReG3H666yKM391Qbd5NZtNvaINcv99zUhrQ2IETHQ>
    <xmx:LFHLZPXOcHjAnQScHt4zWRhf5XGL5Eeni2NYOB0CDmXQ5YGM0Fng-w>
    <xmx:LVHLZItWNEY2hx1vkfcMKjiluOjOFRGuyb4CupRgRs1HOKV3ftTaNQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B3955B60089; Thu,  3 Aug 2023 03:03:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <4fef9725-7aea-43fb-b8ef-d20a4c6d9a68@app.fastmail.com>
In-Reply-To: <20230803063703.5659-3-zhuyinbo@loongson.cn>
References: <20230803063703.5659-1-zhuyinbo@loongson.cn>
 <20230803063703.5659-3-zhuyinbo@loongson.cn>
Date:   Thu, 03 Aug 2023 09:02:47 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Yinbo Zhu" <zhuyinbo@loongson.cn>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     "Jianmin Lv" <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        "Liu Peibao" <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev,
        "Liu Yun" <liuyun@loongson.cn>
Subject: Re: [PATCH v6 2/2] soc: loongson2_pm: add power management support
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023, at 08:37, Yinbo Zhu wrote:
> The Loongson-2's power management controller was ACPI, supports ACPI
> S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
> Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
> (USB, GMAC, PWRBTN, etc.). This driver was to add power management
> controller support that base on dts for Loongson-2 series SoCs.
>
> Co-developed-by: Liu Yun <liuyun@loongson.cn>
> Signed-off-by: Liu Yun <liuyun@loongson.cn>
> Co-developed-by: Liu Peibao <liupeibao@loongson.cn>
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> Cc: soc@kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

I'm still waiting for Ulf to take a look here to see whether
this should be in drivers/genpd instead, but he might still
be on vacation.

A few minor comments from me in the meantime:

> +#define loongson2_pm_readw(reg)		readw(loongson2_pm.base + reg)
> +#define loongson2_pm_readl(reg)		readl(loongson2_pm.base + reg)
> +#define loongson2_pm_writew(val, reg)	writew(val, loongson2_pm.base + 
> reg)
> +#define loongson2_pm_writel(val, reg)	writel(val, loongson2_pm.base + 
> reg)

I would prefer these to be 'static inline' functions rather than
macros, or you can just open-code them, as each macro is only
used once at the moment.

> +static irqreturn_t loongson2_pm_irq_handler(int irq, void *dev_id)
> +{
> +	u16 status = loongson2_pm_readw(LOONGSON2_PM1_STS_REG);
> +
> +	if (!loongson2_pm.suspended && (status & LOONGSON2_PM1_PWRBTN_STS)) {
> +		pr_info("Power Button pressed...\n");

The message is probably more appropriate as a pr_debug() than
pr_info().

> +static int __maybe_unused loongson2_pm_suspend(struct device *dev)
> +{
> +	loongson2_pm.suspended = true;
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused loongson2_pm_resume(struct device *dev)
> +{
> +	loongson2_pm.suspended = false;
> +
> +	return 0;
> +}
> +static SIMPLE_DEV_PM_OPS(loongson2_pm_ops, loongson2_pm_suspend, 
> loongson2_pm_resume);

Please change this to DEFINE_SIMPLE_DEV_PM_OPS() and remove the
__maybe_unused, this is what all drivers should have these days.

> +
> +static int loongson2_pm_probe(struct platform_device *pdev)
> +{
> +	int irq, retval;
> +	u64 suspend_addr;
> +	struct device *dev = &pdev->dev;
> +
> +	loongson2_pm.base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(loongson2_pm.base))
> +		return PTR_ERR(loongson2_pm.base);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	if (!device_property_read_u64(dev, "loongson,suspend-address", 
> &suspend_addr))
> +		loongson_sysconf.suspend_addr = (u64)phys_to_virt(suspend_addr);
> +	else

Having a custom "loongson,suspend-address" property here feels wrong
to me. Can't this be moved into the "regs" property that holds
the other mmio registers?

    Arnd
