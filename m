Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC8D7B6820
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbjJCLjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjJCLjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:39:46 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D57EC4;
        Tue,  3 Oct 2023 04:39:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9AB853200B1A;
        Tue,  3 Oct 2023 07:39:37 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 03 Oct 2023 07:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1696333177; x=1696419577; bh=kKBDfEdMScFcAuwDpyffQFKC/EUrt05ORh8
        xaLZ4kMs=; b=STTPjkZ1OqHY+g//EzBvYnhJNosmbgal7jU5JWIt+bJ4FizqInS
        Xcv4zamWksjgS+WzmV3JBNxVcdAOx3RQ+Uy2h5uDWop388Dh0kXSNeTimR0KCoIF
        jgJ8S79baFse7fMAfoc/5o2SBCWp2lybWeArlbFqZbvj1G5SqmoVReIYSICDdCD8
        AzP/y7OVD4H00sv8bWgLhf6MFTTewiotMvPz51fxcmRt//k0Ck7g0I4Wk4fUl2gr
        yZyKcW+QyVyixAw6+W+GIWvzv5NIDHZjzJws6LcQ0q7rOrgWcVWQz86ZoH6Lt4A7
        o7IzOjYZ0uK90xDchGFb2+f2YYQ78X+IyxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696333177; x=1696419577; bh=kKBDfEdMScFcAuwDpyffQFKC/EUrt05ORh8
        xaLZ4kMs=; b=jdvYjG2AvrEHQnWG3RN02gPfya5gLqb2ZnpZZVh2pTt8fnDezem
        zvoXRphnlnBoR5ko5xivtl5iac8vtUcmyg2X/S8hOghoncnGWxT26k4v1O5x2TCd
        fbU+2SYEnRd1636ywF4t4kS9qZyF5GlWCJ/HgDgmwUWCQLmWa4SBZbB0D0feSoPE
        Jpj5wtO7dEI3NSDIthy6t8E4M8Rkmey5juw/DWi0o+tRLHOuftf0j43oix+1nZEt
        fso5ucxRLwboSa6mVJaalTiBKwYEEuJKr71cnKwbyb9g8PnkIgDHmjTakO9mIjLQ
        22thQtIP32R01kL2SGzDYW+JmPsOTuAeG/Q==
X-ME-Sender: <xms:d_0bZdDNDZa-TPDrdJc6EalD0z8DztDvlMmUFP3IA9LUgQZvqfDotQ>
    <xme:d_0bZbidf65jQvvMHJJU1v6uNvEXgYiU1CRr1k_me1_iHodio7T8NN8cCUotY0ZiY
    nivhPtFB4E8BfI4Lf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeeigdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:d_0bZYnPCeEgZ9i_W0Nn8Q6m6Kcs0pAWtZvTjJUZE1rxXMDycT7lwA>
    <xmx:d_0bZXzf0Qbc2CEZUA8e_sErOS7692t_42l20torhI27Qe3aF1AnOA>
    <xmx:d_0bZSRUuUDymyURrtyA8hAg-aQgPVC0LlKyFgbeFjQoHbHPryTyXw>
    <xmx:ef0bZQm4P5vh4Hh7u3LHqxCAVdSJd8ZVGse9-ndhpYLaQ5Pg41Xwyw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D5708B60089; Tue,  3 Oct 2023 07:39:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <00b5fa05-5dfd-4e79-a46a-b72915e03608@app.fastmail.com>
In-Reply-To: <CAHp75Veu3Dewg9QR30bXs_2Too1b0FBR5Vze+AXXd9rX4dE1Xw@mail.gmail.com>
References: <20230928125443.615006-1-mitrutzceclan@gmail.com>
 <20230928125443.615006-2-mitrutzceclan@gmail.com>
 <20230930150531.083c51d4@jic23-huawei>
 <c52afe87-eaa0-eb7f-090f-b22aec95e49d@gmail.com>
 <ZRvwrDcT770sJXkd@smile.fi.intel.com>
 <303d2869-2273-f643-e8ff-e27675f929dc@gmail.com>
 <CAHp75Veu3Dewg9QR30bXs_2Too1b0FBR5Vze+AXXd9rX4dE1Xw@mail.gmail.com>
Date:   Tue, 03 Oct 2023 13:39:15 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        "Dumitru Ceclan" <mitrutzceclan@gmail.com>
Cc:     "Andy Shevchenko" <andy@kernel.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Michael Walle" <michael@walle.cc>,
        "ChiaEn Wu" <chiaen_wu@richtek.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        "Mike Looijmans" <mike.looijmans@topic.nl>,
        "Haibo Chen" <haibo.chen@nxp.com>,
        "Hugo Villeneuve" <hvilleneuve@dimonoff.com>,
        "Ceclan Dumitru" <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add AD7173 driver
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023, at 13:02, Andy Shevchenko wrote:
> On Tue, Oct 3, 2023 at 1:57=E2=80=AFPM Ceclan Dumitru-Ioan
> <mitrutzceclan@gmail.com> wrote:
>> On 10/3/23 13:45, Andy Shevchenko wrote:
>> > On Tue, Oct 03, 2023 at 01:33:36PM +0300, Ceclan Dumitru-Ioan wrote:
>> >> On 9/30/23 17:05, Jonathan Cameron wrote:
>> >>>>
>> >>>> +  select GPIO_REGMAP
>> >>> If you are selecting it, why does it have if guards in the driver.
>> >>> I prefer the select here, so drop this if guards.
>> >> From what i checked, selecting GPIO_REGMAP does not select GPIOLIB=
 but only REGMAP.

I think the correct solution for this is to use

      select GPIO_REGMAP if GPIOLIB

which matches what the driver does.=20

>> >> Also, in the thread from V1 Arnd Bergmann suggested:
>> >>      " I think the best way to handle these is to remove both
>> >>       the 'select' and the #ifdef in the driver and instead use
>> >>       'if (IS_ENABLED(CONFIG_GPIOLIB))' to handle optional gpio
>> >>       providers in the code. "
>> > Why not simply to be dependent on GPIOLIB like other drivers do in =
this folder?

Some (possibly all) of the other drivers are gpiolib users that do not
function without gpiolib. This one is only a provider and not a consumer,
and the gpiolib functionality in it is optional, so I think there is
technically no dependency, even if in practice gpiolib is always there.

>> I followed the suggestion given by Arnd. The full argument:
>>
>> "From a Kconfig perspective, any user-visible symbol ideally only uses
>> 'depends on', while hidden symbols usually use 'select'.
>>
>> For the GPIOLIB symbol specifically, we have a mix of both, but the
>> overall usage is that gpio consumers only use 'depends on',
>> while some of the providers use 'select'. This risks causing build
>> breakage from a dependency loop when combined with other symbols
>> that have the same problem (e.g. I2C), but it tends to work out
>> as long as a strong hierarchy is kept. In particular, using 'select'
>> from an arch/*/Kconfig platform option is generally harmless as
>> long as those don't depend on anything else.
>>
>> The new driver is a gpio provider and at least ad4130 and
>> ad5592r uses 'select' here, but then again ad74115 and
>> ad74113 use 'depends on' and ads7950 uses neither.
>>
>> I think the best way to handle these is to remove both
>> the 'select' and the #ifdef in the driver and instead use
>> 'if (IS_ENABLED(CONFIG_GPIOLIB))' to handle optional gpio
>> providers in the code."
>>
>> I do not have a lot of experience with this subject.
>> As such, if you consider the argument invalid, mention it and i will
>> change to 'depends on'.
>
> I see, I would ask GPIOLIB maintainers about this.
> I don't know if there is any plan to fix this through the entire
> kernel and which way has been chosen for that.

I think the way we have handled it in the past is to not touch
existing drivers unless there is a problem with circular dependencies,
and then we change a bunch of 'select' to 'depends on' to make
it work again.

Changing all the wrong ones at once would be nice, but likely
cause introduce other dependency problems, but circular dependencies
and incorrect defaults in defconfig builds.

In the long run, we might decide to make gpiolib unconditional
all architectures, but for the moment that causes bloat on
small memory configurations like most m68k or armv7-m.

     Arnd
