Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8097748E3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjHHToS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbjHHToB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:44:01 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92D4112450;
        Tue,  8 Aug 2023 09:46:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C629A5C00A8;
        Tue,  8 Aug 2023 04:02:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 08 Aug 2023 04:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691481770; x=1691568170; bh=Sp
        DaR7i7R4jir2nSPb/IHojOH5Ejtlxz8VTxnsIiQQk=; b=u1WnBMVQOTf7j2DlqH
        /nYYDrjfRUTMffWJ8BIV7YS24zwiW9W0RRF3o3CL4JKi2qGC8rvLgRvMRd9/fHzF
        uYd2g9YO1XEnHdE2xeCbytYU0FMD6ubMau7/vUPlZZv4Oa1Hja81+lFmfG8a+pfc
        pOqL4ZBI/0+Uv6M+JyC0OViuEcP8GD1x+S+qm4jZDdE58CUw4FTxl27AtFn1HwxP
        2jxIDy54npwmdEnmzo6GPH8RwKcRUZKr3dKq+N5vsNP5Ljuw1SY96wjCCqkbIR+B
        9DtOGa5deMfh1drSGYrFh0//dR+6TSQHpqi3DYH4uupn1ejCZCB6jR9H9PNX5Xne
        GyYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691481770; x=1691568170; bh=SpDaR7i7R4jir
        2nSPb/IHojOH5Ejtlxz8VTxnsIiQQk=; b=zWLIdpSZsxtisBULh8uXVlRFlu6qp
        XXrfhIYdOxptbOZWeZ7AyNSw9jHHPqXxaWnRfp69spGesEh1f+VPfyu1Gu+K+e0x
        bx4dEm6RLNxRxgAMQmnKcXkcilesOhgr2GrTGPXoPE50cacPXjgo2sJ7anCsPO5V
        qqONvsaKfA6SeFQecwJMY3bO0wJmliqH46TYlVDcxWZyIcI8RJnbSSc5KRPlOqkP
        jplqfzih/6UAwsWXM2KhnkCVKsVlUJmIL1qAaj1uPlimIxGVE7P/4kn55LI5vIO1
        tJ/qt8hRtYi3YvhKRKkeGhWpu8P5P9huq/T5aXCnPE5DgrtGvU9DJVpeg==
X-ME-Sender: <xms:qfbRZAN7Xzc2QVQNe3RR9hkT5kntAlldaYM19biukw0ctjUkGyMH1g>
    <xme:qfbRZG8u5qSny_ilsAUiJpx_Qura8bPrx7u6_RmSDTG5apIveOjryu6UINn6GBmNM
    E8u7bmLxqoteOILyFI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledvucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdekteffnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvg
X-ME-Proxy: <xmx:qfbRZHTXbQtlGgZHHSSK2s1fBItgMX9sBz9bDdqBFDuuCsvSib8_2w>
    <xmx:qfbRZItgKgnv6MUZLnvBCMPoRMpbaS_dUvNzUEZhhQiExf1TzmH36g>
    <xmx:qfbRZIfBL8Ba75mhLTIwVS-UyRe-0yPKfnobdC0-u4TeVp8Rqz1uDQ>
    <xmx:qvbRZH9CKXpnY4c2xq1_9N_PKt94GE6ipExDqivnjuKReWBxgaHFcA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1DCE8B60089; Tue,  8 Aug 2023 04:02:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <487477f3-9708-4a28-a4fa-0c652353467b@app.fastmail.com>
In-Reply-To: <20230808072501.3393-1-Wenhua.Lin@unisoc.com>
References: <20230808072501.3393-1-Wenhua.Lin@unisoc.com>
Date:   Tue, 08 Aug 2023 10:02:28 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Wenhua Lin" <Wenhua.Lin@unisoc.com>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Mattijs Korpershoek" <mkorpershoek@baylibre.com>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Orson Zhai" <orsonzhai@gmail.com>,
        "Baolin Wang" <baolin.wang@linux.alibaba.com>,
        "Chunyan Zhang" <zhang.lyra@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "wenhua lin" <wenhua.lin1994@gmail.com>,
        "Xiongpeng Wu" <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH] input: keyboard: Add sprd-keypad driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023, at 09:25, Wenhua Lin wrote:
> Add matrix keypad driver, support matrix keypad function.
>
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>

Looks fine to me, just one minor thing to remember:

> +static int __maybe_unused sprd_keypad_resume(struct device *dev)
> +{
> +	struct sprd_keypad_data *data = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (!device_may_wakeup(dev)) {
> +		ret = sprd_keypad_enable(data);
> +		if (ret)
> +			return ret;
> +		ret = sprd_keypad_hw_init(data);
> +	}
> +
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(sprd_keypad_pm_ops,
> +			sprd_keypad_suspend, sprd_keypad_resume);
> +

SIMPLE_DEV_PM_OPS() is deprecated, please use the new
DEFINE_SIMPLE_DEV_PM_OPS() for all new drivers, and
remove the __maybe_unused annotation that is no longer
needed with that.

With that addressed (for the driver in general, I know nothing
about the drivers/input specifics)

Acked-by: Arnd Bergmann <arnd@arndb.de>

     Arnd
