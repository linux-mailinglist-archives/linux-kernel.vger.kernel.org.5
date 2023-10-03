Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B5C7B610A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjJCGxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJCGxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:53:14 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF5EAC;
        Mon,  2 Oct 2023 23:53:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 116305C02F9;
        Tue,  3 Oct 2023 02:53:08 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute4.internal (MEProxy); Tue, 03 Oct 2023 02:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696315988; x=1696402388; bh=DQ
        9fnka5ezD2MosoIlfkv7KgG/vCuTqTaE7p+egKu68=; b=eN2KXjNHIYJbQgWGle
        rlLQ7w3kLGnQyjyLU/OByRNITYptT+q/ecOtOeoMHSt/IYM6Ml7nMyXXfnQwKzB2
        4OWQDI+0xrY455eK8tEEWntyOgHDGhhQZEtV7e9IZOHi26Wwrfr05KDiGkX6bBu0
        MnI6jh1024OucjBiqF0xJcmYsN4W5mTkJHenVaE0A2L3JdEjPtvJg4H9bR1S6V81
        2Q5XWxZDityvc54+joXw66sSHq0MgJdN05hLBpsJ2SqJuTf/kOJq1pD4aLZdDGOo
        zvc32xd9qIkt2KB7J2m0Cwb4B9lF1Xivfk6V3ymPqQ/5+BMVoZc5aZvKFwOJFsIj
        rNyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696315988; x=1696402388; bh=DQ9fnka5ezD2M
        osoIlfkv7KgG/vCuTqTaE7p+egKu68=; b=Xfm66XNf66JzisjrpSREKJpPTffZ9
        0BJDDCF7HeFd0JQgVt0EksolRz9oaXTaCOli1Au2qC9Vaz763j4lfXBqZKTOv0UM
        dyxj0xjGLzBUd1+pd1FipUIG+8T03CiFaO4xJX6FO1E6sgjVcX/5tB0Jgi7v4qOP
        Z50ZeTdXX7dzvuiUHH9tQpfXmcCbwc+LHblD/OQ9C5QmkZB2Q+vfaEE1ifD+0N73
        v91cHlQ0MnzgCdd1Skg0fXop7cm0LwiT6/eEaZZlmWtpzeNrxnGYwXNS/uMtWxIW
        0ImfeZ+zniypvEZOJLj5TRb2+TRiJkIRevte9EIlkm3SSOMYxX9XTSrYg==
X-ME-Sender: <xms:UrobZSPogWQZp4XvkklxNgta43YSMuij42Y557ew1W8leDREAUrYnw>
    <xme:UrobZQ9lGSTNF5QWcuIw6pANwVl-qlmAtX5xU1O1Vf9Nc_uO4HmaVvUfUKBQijFvi
    0_KEzgbulZuY6Ojeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpeehhfefkefgkeduveehffehieehudejfeejveejfedugfefuedtuedvhefh
    veeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:UrobZZTZz1Kri7_9m83dhS-pbB2hBr_MkiYMhCK821-K0C0aPwvumg>
    <xmx:UrobZSsITjFDf-6sfVp1OVXge8Av-fQnSE2PZ1t83qU5n6NfldJ-BA>
    <xmx:UrobZafgdyfD6QHIxz3qiAAssdgxDSHA3HOxLNBJHPufQqHD4YFZwA>
    <xmx:VLobZQtRcrrazDs0uBaxrEJ0pEMJBuIfNb8Nr9pm-w-8Nggp6Cm5AQ>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AFA081700089; Tue,  3 Oct 2023 02:53:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <4bee3205-212b-4032-a105-9b8f1fb1fa22@app.fastmail.com>
In-Reply-To: <SG2PR06MB336555C2C52E24FCCDE72C748BC5A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230925081845.4147424-1-billy_tsai@aspeedtech.com>
 <a310aba3-0f04-4549-a776-36ff8cef736e@app.fastmail.com>
 <SG2PR06MB336555C2C52E24FCCDE72C748BC5A@SG2PR06MB3365.apcprd06.prod.outlook.com>
Date:   Tue, 03 Oct 2023 17:22:45 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Billy Tsai" <billy_tsai@aspeedtech.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Joel Stanley" <joel@jms.id.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Potin Lai" <Potin.Lai@quantatw.com>,
        "patrickw3@meta.com" <patrickw3@meta.com>
Subject: Re: [PATCH v1] iio: adc: aspeed: Support deglitch feature.
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Billy,

On Mon, 2 Oct 2023, at 19:20, Billy Tsai wrote:
> On Mon, 25 Sep 2023, at 17:48, Billy Tsai wrote:
>> > Create event sysfs for applying the deglitch condition. When
>> > in_voltageY_thresh_rising_en/in_voltageY_thresh_falling_en is set to true,
>> > the driver will use the in_voltageY_thresh_rising_value and
>> > in_voltageY_thresh_falling_value as threshold values. If the ADC value
>> > falls outside this threshold, the driver will wait for the ADC sampling
>> > period and perform an additional read once to achieve the deglitching
>> > purpose.
>> >
>> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
>> > ---
>> >  drivers/iio/adc/aspeed_adc.c | 193 ++++++++++++++++++++++++++++++++++-
>> >  1 file changed, 189 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
>> > index 998e8bcc06e1..9e746c81d916 100644
>> > --- a/drivers/iio/adc/aspeed_adc.c
>> > +++ b/drivers/iio/adc/aspeed_adc.c
>> > @@ -95,6 +95,7 @@ struct aspeed_adc_model_data {
>> >       bool wait_init_sequence;
>> >       bool need_prescaler;
>> >       bool bat_sense_sup;
>> > +     bool require_extra_eoc;
>
>> What is "eoc"? Can we use a better name or add an explanatory comment?
>
> Hi Andrew,
> This is the signal name for our ADC controller, it means "End Of 
> Conversion".
> The appearance of this signal period indicates that the ADC value is 
> valid and being updated to the register.

Okay, searching for "conversion" in the datasheet didn't turn up anything like this. It seems I wasn't off-track with asking. If you go forward with the patch in some manner, can you add a comment to the code documenting the meaning of 'eoc'?

>
>> >       /* Register ADC clock prescaler with source specified by device tree.
>> > */
>> >       spin_lock_init(&data->clk_lock);
>> >       snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name), "%s",
>> > @@ -632,7 +806,14 @@ static int aspeed_adc_probe(struct platform_device
>> > *pdev)
>> >       adc_engine_control_reg_val |= ASPEED_ADC_CTRL_CHANNEL;
>> >       writel(adc_engine_control_reg_val,
>> >              data->base + ASPEED_REG_ENGINE_CONTROL);
>> > -
>> > +     adc_engine_control_reg_val =
>> > +             FIELD_GET(ASPEED_ADC_CTRL_CHANNEL,
>> > +                       readl(data->base + ASPEED_REG_ENGINE_CONTROL));
>> > +     data->required_eoc_num = hweight_long(adc_engine_control_reg_val);
>> > +     if (data->model_data->require_extra_eoc &&
>> > +         (adc_engine_control_reg_val &
>> > +          BIT(data->model_data->num_channels - 1)))
>> > +             data->required_eoc_num += 12;
>
>> Why 12? Why add a value to the number of engines enabled? Have I misunderstood?
>
> This behavior is specified by the hardware. In our ADC, it requires 12 
> dummy sampling
> periods to switch the sampling channel from CH7 to CH0. Hence, this 
> condition checks
> the enable status of channel 7 to determine the necessary delay period 
> for obtaining the
> updated ADC values for each channel.

Okay, I feel using a magic value '12' with what you wrote above as an explanation is asking a bit much of the reader. Again, if you go forward with this patch in some fashion, can you document the meaning of 12 in a comment (and possibly use a macro to name it)?

Cheers,

Andrew
