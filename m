Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD387B1F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjI1OUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjI1OUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:20:02 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0828136;
        Thu, 28 Sep 2023 07:20:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 180EB5C264B;
        Thu, 28 Sep 2023 10:20:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 28 Sep 2023 10:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695910800; x=1695997200; bh=LT
        jY8R1KsCPH5v7l6L2qHRvoQTAX3pDp6IhjNv9gzM4=; b=dUXAl7juNQlKwrOADW
        zYzEhPHyVPkkZHnHghOe4DNYw8cXbbNx1dOAKAN/FCWU8xjI4kbLZHFHSD5kRdbC
        xKZvA9urr345a4dUpzirwiy7OSNIqbq7l1EG3nveyhWVenI5yZVBESeDizY3q8AB
        c5Q2lg0Iuokzq8fYqnUKWng2Doe5Y+XE7VtKnLEhwzwxXyYS8Yf1GVTZjAu7p4fY
        UtuRPpBrT9sWUjv0sNRwrWJmwJlhDPESk2rJBinpVjhpsDC9c7vjlM687Retmfyc
        UuOnFTKgtk7T3bmaQ78meTOjP4IgBDuPLVtv1Z5AbvuNYJd1o8sLPR5mMPTETELy
        /21A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695910800; x=1695997200; bh=LTjY8R1KsCPH5
        v7l6L2qHRvoQTAX3pDp6IhjNv9gzM4=; b=HlTxOEOnVFZqd1tvjp5dkyx9z7Zhk
        3KpMpj3KnNVZsMcEaZvh4lRoW/SKriv5ZihGUcs+3u8Hw7tvvoHGe/DyGgC5pAL4
        /JOnVeP9x2grSYbQiPzPumrdHxyBV4OcAe5o72HCEqRXAZxQhhqwqMs+bk9T/cVp
        TcsB7bW4CNmLXEl2AtDiu5yvjQDd3XIW0DqyNCJ5SEQoMy8xz+Srx9kjz1hsQmDY
        jT1shxhtQ596SwnCijQL8fan0kjr8Xrajk6ugkjR8rzqIScXGoHIOBanrAoUxRvK
        uzDb/LkSEUR6Zv+e2Xuzw7hVx44FQIWv2gU2mREnDID1hkaZ53Z2+BqIQ==
X-ME-Sender: <xms:j4sVZRuh9Vzhh_Ew0pvLJOhdMgDHlDyBXuW2aSYKGp54R0LZ4Vtcnw>
    <xme:j4sVZaf2LXpBD5XqjmeN17Z8bkMr7MvgADHIBoyWHdoD-mXNRlG1A321_O2KTozS6
    qLJcpUS-_w65W_nmwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddtgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeejvddvvdduleduheejiedtheehiedvjefgleelffeigfevhffhueduhfegfeef
    heenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:j4sVZUxngHyQ7yTpgcckvr0vbXwzmPDZQcm1rPyEKiGY4k2a1hnj3A>
    <xmx:j4sVZYOvbcav9d53WhzPGMNL6mgADxxyx_dUeIVU0VqIOOt7Ta1anQ>
    <xmx:j4sVZR8xa6uxk4byBuFoHoJog-xO3WYHim5Nt3ljdclIR-kzGJ-1LA>
    <xmx:kIsVZRyDSVEc_gQKITZ9eE7rxDrj9XuE_rT4Vc-haUo-9gCyusw-zw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C492BB60089; Thu, 28 Sep 2023 10:19:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <94110af1-2b32-4eb2-81be-2a79fc6973d8@app.fastmail.com>
In-Reply-To: <BN7PR03MB4545DC903A0D62639085591697C1A@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20230928092804.22612-1-eliza.balas@analog.com>
 <20230928092804.22612-3-eliza.balas@analog.com>
 <839638d2-7502-4925-8b7f-6b15779a6840@app.fastmail.com>
 <BN7PR03MB4545DC903A0D62639085591697C1A@BN7PR03MB4545.namprd03.prod.outlook.com>
Date:   Thu, 28 Sep 2023 10:19:38 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Eliza Balas" <Eliza.Balas@analog.com>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
        "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023, at 06:54, Balas, Eliza wrote:
>> <conor+dt@kernel.org>; derek.kiernan@amd.com; dragan.cvetic@amd.com; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
>> Subject: Re: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
>> 
>> [External]
>> 
>> On Thu, Sep 28, 2023, at 11:28, Eliza Balas wrote:
>> > This patch introduces the driver for the new ADI TDD engine HDL.
>> > The generic TDD controller is in essence a waveform generator
>> > capable of addressing RF applications which require Time Division
>> > Duplexing, as well as controlling other modules of general
>> > applications through its dedicated 32 channel outputs.
>> >
>> > The reason of creating the generic TDD controller was to reduce
>> > the naming confusion around the existing repurposed TDD core
>> > built for AD9361, as well as expanding its number of output
>> > channels for systems which require more than six controlling signals.
>> >
>> > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
>> 
>> Thanks for your submission, I've had a first look at the driver
>> and the implementation of the interface you have chosen looks
>> all good to me, so I have no detailed comments on that.
>> 
>> It would however help to explain the ideas you had for the
>> user-space interface design and summarize them in the changelog
>> text.
>> 
>> You have chosen a low-level interface that wraps the individual
>> device registers and gives user space direct control over them.
>> The risk here is to lock yourself into the first design,
>> giving you less flexibility for future extensions, so it would
>> help to understand what the usage model is here.
>> 
>> One risk is that there may be an in-kernel user in the future
>> when the TDD engine interacts with another device, so you
>> need a driver level interface, which would in turn break
>> if any user pokes the registers directly.
>> 
>> Another possible problem I see is that an application written
>> for this driver would be incompatible with similar hardware
>> that has the same functionality but a different register-level
>> interface, or even a minor revision of the device that ends up
>> breaking one of the assumptions about the hardware design.
>> 
>> In both cases, the likely answer is to have a higher-level
>> interface of some sort, but the downside of that would be
>> that it is much harder to come up with a good interface that
>> covers all possible use cases.
>> 
>> Another question is whether you could fit into some
>> existing subsystem instead of creating a single-driver
>> interface. drivers/iio/ might be a good choice, as
>> it already handles both in-kernel and userspace users,
>> and provides a common abstraction for multiple classes
>> of devices that (without any domain knowledge in my case)
>> look similar enough that this could be added there.
>> 
>
> We are using this driver with an iio-fake device 
> https://github.com/analogdevicesinc/linux/blob/master/Documentation/devicetree/bindings/iio/jesd204/adi%2Ciio-fakedev.yaml 
>  so we can take advantage of the iio user-space interface.

I don't understand how that works yet: Do you mean that there
is  user-space application that uses the tdd sysfs interface to
export an IIO device back into the kernel, or do you mean there
is a regular IIO device in with a kernel driver that is used
as the back-end for the tdd device, or something else?

> We talked in the previous v1 patch emails about adding this driver to 
> an existing subsystem, and I raised the question if we should add it to 
> the iio subsystem, but the driver is not registered into the IIO device 
> tree, and does not rely on IIO kernel APIs, so I concluded that misc is 
> a better choice.
> What do you think?

My feeling is that if you can make it fit into IIO, then this is
likely the better choice, unless you can guarantee that this is
a one-off driver with a single hardware implementation and
a single userspace. If you need the flexibility later to do
more things, the risk is that you end up duplicating a lot of
functionality that already exists in IIO.

This would of course mean using the interfaces provided by the
IIO core, with the addition of a tdd device type rather than
just having a standalone driver with just the sysfs interface
you have here.

      Arnd
