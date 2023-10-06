Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64467BB5A3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjJFKsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjJFKsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:48:51 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F97CE;
        Fri,  6 Oct 2023 03:48:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 46D433200A9D;
        Fri,  6 Oct 2023 06:48:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 06 Oct 2023 06:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696589325; x=1696675725; bh=le
        yFjl8HS70GWzN5CT67TcqvaCI0kPyY068isyY4OnY=; b=ZpK7ASyHutJAVMo+u4
        ZPGe9MPqhFWhEm32ALLsXHRWeWO3qHQqrX1KSJt2dzfFZZylzd0G+WekMZayYgGK
        YjOxdW0NJFpPtq/6USwI+Wi92Kz632j+eM62wHFKaIs2py1Y2MqBTZBg/uvWU+Gm
        lvowDYUFkt2/rYvQ7aMkqLu0G4PuTehws1uaaY5ZmuG9VFbY1sLh08vgU6l4KHfZ
        mfkXwEyXRA6oaEM2dCwuKRHapu1FoTATr56yHY4yDofrQX8Q6S2QZUyFU7GwnYoC
        V1r79cb/UprMDcjqBKxzW9rsDxQgk/hTS+TLzp7ITTInSko6kVmqWXouzB8sgmYa
        TzJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696589325; x=1696675725; bh=leyFjl8HS70GW
        zN5CT67TcqvaCI0kPyY068isyY4OnY=; b=cqpH9J5ux2sLwhmOTde1ABpq289EL
        289XreMdwlJ7MNgHmmRLOcw1zlNk7TWpDLWKWVnuiMlSk94yHcEQ9BApOnBaAlBp
        ct1RC8W2Zi7+6tPwZ1nFkwNokUz2/ggRKUIe5VUg2JblkNFVNdvCXY6WR5q5QukK
        mUsSnfBqNPDd8Pbqe7EouBUAhHuz3ke237l0X7WAErw8J8HrOwXDYq2KWPRh0o0J
        +aGRFS8mjzW5BXl5kcjrzb8/Fw/rdtntuDlJQ0bLcKIlEnOGWyWw+tMoTIBS6DI7
        8fxJur0qkaGXSHVnDmH4fIhxI3wbwi5ltRJVLeCLbAizOhf1v2Z3GCesw==
X-ME-Sender: <xms:DOYfZfpCxTrUuBUFqm1Ku1nBlj7vrGMaJIg8wW3zzDNX6lQ6JJEJTA>
    <xme:DOYfZZo8mBISdAOCKw8Lsy5QGyj_5IR2ghXJGrTENreLJDc9P8b2YrU_XVr-lw6xH
    VNEknUseaPQ_8lzyKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:DeYfZcOBnBLXRjS0QEM81DIuGU9x2FmDvsflXlepFR97_JxK6jF9_Q>
    <xmx:DeYfZS7e34dC7rm3TBFmJ6rxQZS0jc5l4Uu_UTk-X5xzAw4e7_9_8w>
    <xmx:DeYfZe6xmu6SSfKDPUD1BqcjFUYVxYNgn2-et_F0p7g_OI6hBQOy9A>
    <xmx:DeYfZezyLNuK8LieZiRh_YMVEvL-syL89bDDQ9ud25kFDe6PFRzKyg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D564FB6008D; Fri,  6 Oct 2023 06:48:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <53050bbd-6a46-470d-9764-c83b8588698e@app.fastmail.com>
In-Reply-To: <87sf6pcebd.fsf@BL-laptop>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-6-gregory.clement@bootlin.com>
 <hu5ksk2gw7zbbeiwi4unfo242qm2wfn36bpgea5inlamn4kqrf@magwi4w7gp3x>
 <87sf6pcebd.fsf@BL-laptop>
Date:   Fri, 06 Oct 2023 12:48:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Gregory Clement" <gregory.clement@bootlin.com>,
        "Serge Semin" <fancer.lancer@gmail.com>
Cc:     =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        "Paul Burton" <paulburton@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Vladimir Kondratiev" <vladimir.kondratiev@intel.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 05/11] dt-bindings: mips: cpu: Add I-Class I6500 Multiprocessor
 Core
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023, at 16:51, Gregory CLEMENT wrote:
>> On Wed, Oct 04, 2023 at 06:10:32PM +0200, Gregory CLEMENT wrote:
>>> The MIPS Warrior I-class I6500 was announced by Imagination
>>> Technologies in 2016 and is used in the Mobileye SoC EyeQ5.
>>> 
>>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>>> ---
>>>  Documentation/devicetree/bindings/mips/cpus.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>> 
>>> diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
>>> index cf382dea3922..87fd2842ba68 100644
>>> --- a/Documentation/devicetree/bindings/mips/cpus.yaml
>>> +++ b/Documentation/devicetree/bindings/mips/cpus.yaml
>>> @@ -39,6 +39,7 @@ properties:
>>>        - mti,mips24KEc
>>>        - mti,mips14KEc
>>>        - mti,mips14Kc
>>
>>> +      - mti,i6500
>>
>> Since the CPU core vendor is Imagination Technologies thus it would
>> be more appropriate to have the "img," prefix. Wouldn't it?
>
> According to Documentation/devicetree/bindings/vendor-prefixes.yaml
>
> "^mti,.*":
>     description: Imagination Technologies Ltd. (formerly MIPS
>     Technologies Inc.)
>
> So I think it's OK.

I don't see any good solution, they changed their name and
ownership too many times. I would actually revert back the
description here to "MIPS Technologies Inc" instead of trying
to keep track of what they currently call themselves.

Since we already have both the 'mips,' and 'mti,' vendow
names for the 14Kc, 14KEc and 24KEc parts, maybe we can
just go back to 'mips,' for all cores past the mti era
rather than trying to date and geolocate each of the
classic cores as one of 'mti', 'img', 'wavecomp', 'tallwood',
'mips' 'cipunited' etc.

   Arnd
