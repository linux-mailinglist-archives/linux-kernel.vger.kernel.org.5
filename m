Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15FA7FB8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344082AbjK1Kxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344188AbjK1Kxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:53:36 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0A3D4B;
        Tue, 28 Nov 2023 02:53:42 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 303F03200AD4;
        Tue, 28 Nov 2023 05:53:37 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 28 Nov 2023 05:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701168816; x=1701255216; bh=de
        ujBW49xIg4FWRLoDbae8+tD+YBI5tyJUGVOFWc1Ks=; b=uQI6GapiQMe6Hnopgt
        8Kiup3r0xYvvDKyg3h3msdwC7QtfVjT7XDt3ddURo2LC79JmY0UZTph10T6qGT14
        N1ZjqJBM1jrNf54paVb/bzomh11XPcCGnMnNB9g1VB8ZLQxg6WCbRmpKlYPMrHJf
        ng8Vtpes1lJrhaOcNKlnR+K7woG3NlD5lkL7IvwPU3/rtAGufpzgzUCCwGJTglSe
        4HzBBSS7cSIluloTD9cYleiGsjSgu+5X6srfs+JJx6MRkxi3N8oG1bugQC6vrQKu
        nisMZAbaQvRPIuu8upJMcqxnPjonshhu5m2mSiTO6V5D9LYyUtKrIhwG3A44aCBJ
        pC4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701168816; x=1701255216; bh=deujBW49xIg4F
        WRLoDbae8+tD+YBI5tyJUGVOFWc1Ks=; b=As1CexskTDECzC0Lps503ToibCtw1
        ltQ3h0imB92EL2eCy/4DcT+pv4u96loKTX4IWW/m4jBslNtxIpPCLjtyL83P2u0c
        R2UrSdzgg3eZIZRTS+whhau0y+OlLM2SL29rYe/l2iLAfxmQnq9WdQ7LZqCXQlpg
        exwn3luBvwWZK94rxquByyto5Nedta52+VVoNMEZTZ8uM7u50K5AAk3QctxyB88l
        ipbHWuFbw846X4e3LcnbCena6lDhAT/SlcWAcVxiqTNWWmtbpqmY5fHedwE0oQyW
        VioKwD9wfG7U6HtpJWdgAmDXEWTPgEg61PmGbGva7NCPuKaVCVcfyhfGw==
X-ME-Sender: <xms:r8ZlZQgHSqwGKPKL3nhFGAhcam4JDzWlYnWeZBJwjU-0OiBs0qFDFA>
    <xme:r8ZlZZBKLJHErSyWAhsFIdhrvlegSaibzuNe0YdZJX0s47m-Embfkbcdh5p0t1g-E
    xvG2SR2cm8u4wptHhY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:r8ZlZYF3-S4aGYw5_oR6ptcl8S0cfvVvehTktk7VC-yaRZZpL6ZLXw>
    <xmx:r8ZlZRQ0ZW8fwQVk8HpoKhiRMSilB2AFQ6toxEsMylcZxWjbnhlinw>
    <xmx:r8ZlZdzolPGJ86UeZt76v8-9ylhuY1zMoRJBgGEiR6ljdm53ccVUoQ>
    <xmx:sMZlZVBycdOU7JeGfOzCzonwWbarikrNKQrBbOzKo6IIjNsX3jduIA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 37DA4B60089; Tue, 28 Nov 2023 05:53:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <cf23b3a9-54cb-4c48-923e-8a05a8d4bc27@app.fastmail.com>
In-Reply-To: <23011695aafca595c3c8722fda2a8e194c5318df.camel@pengutronix.de>
References: <20231121091101.5540-1-jyanchou@realtek.com>
 <20231121091101.5540-3-jyanchou@realtek.com>
 <23011695aafca595c3c8722fda2a8e194c5318df.camel@pengutronix.de>
Date:   Tue, 28 Nov 2023 11:53:13 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Jyan Chou" <jyanchou@realtek.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>, jh80.chung@samsung.com,
        riteshh@codeaurora.org, "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     "Conor Dooley" <conor+dt@kernel.org>, asutoshd@codeaurora.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Brian Norris" <briannorris@chromium.org>,
        "Doug Brown" <doug@schmorgal.com>,
        "Tony Huang" <tonyhuang.sunplus@gmail.com>,
        "Abel Vesa" <abel.vesa@linaro.org>, william.qiu@starfivetech.com
Subject: Re: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
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

On Mon, Nov 27, 2023, at 13:51, Philipp Zabel wrote:
> On Di, 2023-11-21 at 17:10 +0800, Jyan Chou wrote:
>> diff --git a/drivers/mmc/host/dw_mmc_cqe.c b/drivers/mmc/host/dw_mmc_cqe.c
>> new file mode 100644
>> index 000000000000..eb00d6a474b2
>> --- /dev/null
>> +++ b/drivers/mmc/host/dw_mmc_cqe.c
>> @@ -0,0 +1,1467 @@
> [...]
>> +#ifdef CONFIG_OF
>> +static struct dw_mci_board *dw_mci_cqe_parse_dt(struct dw_mci *host)
>> +{
>> +	struct dw_mci_board *pdata;
>> +	struct device *dev = host->dev;
>> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
>> +	int ret;
>> +
>> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +	if (!pdata)
>> +		return ERR_PTR(-ENOMEM);
>> +
>
> There is no reason to hide device tree parsing errors here, and I'd
> argue pdata should not be returned with rstc set to an error value.
> devm_reset_control_get_optional_exclusive() returns NULL if there are
> no errors and no reset is specified in the device tree.
>
> Then you can just use dev_err_probe() at the call site in
> dw_mci_cqe_probe().

I think ideally the dw_mci_board should be merged into the dw_mci
structure, avoiding the extra kzalloc() step. Having separate
structures here is likely an artifact from an old version of the
driver that predates the use of devicetree, but since everything
now uses DT, there is no point in the extra abstraction.

     Arnd
