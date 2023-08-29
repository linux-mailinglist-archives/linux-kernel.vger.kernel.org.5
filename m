Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A025C78CC4A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbjH2Si5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbjH2Sim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:38:42 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B935C1A3;
        Tue, 29 Aug 2023 11:38:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C669932005BC;
        Tue, 29 Aug 2023 14:38:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 29 Aug 2023 14:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1693334316; x=1693420716; bh=CAWsIypx0TY0UMQV9vU8AQzRqsAv1DpcyRv
        Hl2mMQgE=; b=HsjvMByVL1iz7yHe0DjJP45B5iT/tMpAYlpQJW6a4qlguMc1JMg
        42/dIFNb+bC2vHH8mIIjWqZWS+y7q6NGbTzyEkE+tofqvlTDk1SfK3+xCFuvOD07
        acYYpQNkv1S8jQAssRO63+1iBXRTVoqZwAebNUPMmAVAArkzs0Z8KA00RzpDxj2I
        nx3GvZZUFQcRVNjfM/egQR+DOaaVVXx0T4W07W4bBBPC7aw+6RNTslmJtF2QVpM+
        vjFyPZqzbiAUaI5pcPVck/8p79249lMlWq0xYBIeyDjROfYFEXm5Q5izXlTdXjcc
        DUQ6cSJ8x85dxxE7W28AWpolXqHyF7vDN9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693334316; x=1693420716; bh=CAWsIypx0TY0UMQV9vU8AQzRqsAv1DpcyRv
        Hl2mMQgE=; b=H5xDt7imC/5eWQgMkyYCerYVVivMTwQxYF1FaPcCiYZhCCAu5MP
        4cb0jBvaPc0ztXQ2eBEeFo3rOc5mTcr6eKwpdmxGrd6f+rn9Rfj0xddR9QVoTmlC
        AHOaaKOZZ+LsWa2jyFy1Vd8tHidXUrZNShudk0poBXUyCimq1NKmXc7iQjS7BduO
        DKhli5Yq/nGJMmrxaAOJhvw76R/M4bQ2nQf+oaBDgZXe351yilECye/JkPWgYcmL
        URAIGVamP8Xorw3cPKaLdmhLrxZufxPkpUj3p5k+21tEXq40QVu4xk+kr8r31yt0
        2xLsgwBul5/oA2dDMYmgLLDvaVgB4IUwTzw==
X-ME-Sender: <xms:KjvuZBAc2n1JkRF3fI006C0nLWIYTUK6EudymfjTdNbibfG1RsJ5Iw>
    <xme:KjvuZPhuypFznPc6tbyvddGSOFzc28jNVIxPJPUrCz42XWCZoAOHh0oiwaS-VkSiX
    h_Z3cBKknTuf88skrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefiedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:KjvuZMln5EYF9nh0acOzfRqSLwCq-32Th1V8iifCzcojrRurBSKkqg>
    <xmx:KjvuZLwyrqQtFlqWcuNkn60Vco0KvG6O64dq2SMcW85A23P2RyiasQ>
    <xmx:KjvuZGRGVKk9Jc72lTwhiD265leLnnT38LYHEU_NJ6XY7JWF_AAKCQ>
    <xmx:LDvuZBms-ozOLwx7Q5r8bzpL9zUy5CXMDz6EKu5Be-LGVXTQB6vLwA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4108EB60089; Tue, 29 Aug 2023 14:38:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <8e87875b-5be1-4d82-bcbf-bd6c8d36370f@app.fastmail.com>
In-Reply-To: <ZO3zLKrZNGekV7Co@smile.fi.intel.com>
References: <20230810093322.593259-1-mitrutzceclan@gmail.com>
 <20230810093322.593259-2-mitrutzceclan@gmail.com>
 <34f5e2118a4714048231e6ee9a8f244248616bd0.camel@gmail.com>
 <ZNUEBDsMg6UfeOtl@smile.fi.intel.com>
 <5a31871d0e0322b9704633bd2dca2503c554c358.camel@gmail.com>
 <ZO3zLKrZNGekV7Co@smile.fi.intel.com>
Date:   Tue, 29 Aug 2023 14:38:03 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>
Cc:     "Dumitru Ceclan" <mitrutzceclan@gmail.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Cosmin Tanislav" <demonsingur@gmail.com>,
        "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
        "Hugo Villeneuve" <hvilleneuve@dimonoff.com>,
        "Okan Sahin" <okan.sahin@analog.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "ChiYuan Huang" <cy_huang@richtek.com>,
        "Ramona Bolboaca" <ramona.bolboaca@analog.com>,
        "Ibrahim Tilki" <Ibrahim.Tilki@analog.com>,
        "ChiaEn Wu" <chiaen_wu@richtek.com>,
        "William Breathitt Gray" <william.gray@linaro.org>,
        "Lee Jones" <lee@kernel.org>, "Haibo Chen" <haibo.chen@nxp.com>,
        "Mike Looijmans" <mike.looijmans@topic.nl>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        "Ceclan Dumitru" <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad717x: add AD717X driver
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023, at 09:31, Andy Shevchenko wrote:
> On Tue, Aug 29, 2023 at 11:14:31AM +0200, Nuno S=C3=A1 wrote:
>> On Thu, 2023-08-10 at 18:36 +0300, Andy Shevchenko wrote:
>> > On Thu, Aug 10, 2023 at 01:57:02PM +0200, Nuno S=C3=A1 wrote:
>> > > On Thu, 2023-08-10 at 12:33 +0300, Dumitru Ceclan wrote:
>
>> > > Is ad717x_gpio_cleanup() being used anywhere? Moreover I would ma=
ybe just
>> > > get rid of
>> > > the #ifdef wrapper and just select GPIOLIB. How often will it be =
disabled
>> > > anyways?
>> >=20
>> > The agreement is that users are depend on and not selecting GPIOLIB.
>> > Any news in these agreement terms?
>>=20
>> Hmm no idea about that. If you say so, it's just one new thing I'm le=
arning :)
>Based outside of the U.S.? Some titles might be unavailable in your cur=
rent location. Go to amazon.de to see the video catalog available in Ger=
many.
> That's the last I know.
> Cc'ing to GPIOLIB maintainers...

From a Kconfig perspective, any user-visible symbol ideally only uses
'depends on', while hidden symbols usually use 'select'.

For the GPIOLIB symbol specifically, we have a mix of both, but the
overall usage is that gpio consumers only use 'depends on',
while some of the providers use 'select'. This risks causing build
breakage from a dependency loop when combined with other symbols
that have the same problem (e.g. I2C), but it tends to work out
as long as a strong hierarchy is kept. In particular, using 'select'
from an arch/*/Kconfig platform option is generally harmless as
long as those don't depend on anything else.

The new driver is a gpio provider and at least ad4130 and
ad5592r uses 'select' here, but then again ad74115 and
ad74113 use 'depends on' and ads7950 uses neither.

I think the best way to handle these is to remove both
the 'select' and the #ifdef in the driver and instead use
'if (IS_ENABLED(CONFIG_GPIOLIB))' to handle optional gpio
providers in the code.

       Arnd
