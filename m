Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E217C53CE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346360AbjJKM0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbjJKMZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:25:46 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6AB114;
        Wed, 11 Oct 2023 05:25:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BAD4C3200AB2;
        Wed, 11 Oct 2023 08:25:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 11 Oct 2023 08:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697027110; x=1697113510; bh=Pd
        51UpbLBT1+psPf2hnTIMJii3++EO4IjWT1009ZizA=; b=ej8XsMTNC0PzZr0SLt
        Vxa8LG+z1KAY34ZtDIIgqluCZbO8g7xLh/cPaOaGM0fFh/piB7NQVz+et6hYqsdl
        4iWTa1AKKbTDe01R7M8Kypyp0+6mSsCxwuoUQJPlpmfEWVKD83fpArYYgcAP3QCf
        K8EvCp37GG8ObTHtjPXXrI5ie7XtSX+zdUQ+kzstQ+ECrRPHadQa3FpZ+snhyQkQ
        HhhHzIHRevNtIOR+1ufeHTNEPJReDdw58m75O4RZGNHB/rfR/uK0rIQOiRYjmoOL
        1CvrXi8rLBewAYr+5Wwzndwv9HYIqkhvztkp5klwTm4B1DAgVjN6XZyqk9EssiZT
        dpXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697027110; x=1697113510; bh=Pd51UpbLBT1+p
        sPf2hnTIMJii3++EO4IjWT1009ZizA=; b=rFhfZzkPaTpgzosrMFMaXjj6yP0Xp
        gz1X7dE7GSFTfIKHP6yg89i0A/UBCVx1T8Xa+aQXBn3qKbhRKcV18VAqy0uEqWzr
        35rma5PX6e437BWoUD3xHEF3arcEAWtLG0Nk92DWqEqLwoTNiyWTTISXxEwwEUoy
        /4O8vfF+lhBio/GYIcOYQ+qrcUy9OP5b0qFJu+qWizNgDUngNwBlxy/ZJjrNU/ay
        wSEameGH5UgHcwevlY3nLUgtbCmhEwgezEE/UQG0bxbgKbXZ90etB0H9d/Yx7dgl
        9+aYUuBbxqBF0X7DWiZymjbaOl6jcSAVgUfMjmIlX/onu4xX/fjNHKsSw==
X-ME-Sender: <xms:JZQmZbww_AU8iViRbjSlI9CQXj0z2Fkiov0K5SQutqwSCwLdHV88lA>
    <xme:JZQmZTTEb12Nwen7gNUd7wm58Yr2zMPw5ipSntCUldo8KIyRnTmcI-bPq9h9gZqAd
    BKsQhAKwdRxzeFLf4Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheekgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:JZQmZVWaLSLvCDgX_0mdA2y4083oXu9QtuLYfHkucaoMvbmfoRAR8Q>
    <xmx:JZQmZViAUseJdxTh9_3yzxIwWwZG3VdQ-18HlJr_wxCUHaJVYdGJrw>
    <xmx:JZQmZdB509oyX1gMGWaE2gKlIx_jvMAhGt_46MMHrEiGtzxYizKA4w>
    <xmx:JpQmZSKpal6eQjoZbmJkF0D7vZl5-dmDm-7wlopeqNpVivZtOuYndA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8CE30B6008F; Wed, 11 Oct 2023 08:25:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <2339287b-8b17-413b-aa86-f618ea7fc3fa@app.fastmail.com>
In-Reply-To: <2023101001-ocelot-veteran-10db@gregkh>
References: <20231009212053.2007-1-graf@amazon.com>
 <20231009212053.2007-2-graf@amazon.com>
 <2023101010-overwrite-parakeet-91d5@gregkh>
 <0ee221bc-ea99-4724-9ebd-436e91417e4b@amazon.com>
 <2023101009-accustom-manifesto-8bdb@gregkh>
 <b3a8c722-c0e2-4c8c-aef0-29af0a93572d@amazon.com>
 <2023101001-ocelot-veteran-10db@gregkh>
Date:   Wed, 11 Oct 2023 14:24:48 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Alexander Graf" <graf@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Olivia Mackall" <olivia@selenic.com>,
        "Petre Eftime" <petre.eftime@gmail.com>,
        "Erdem Meydanlli" <meydanli@amazon.nl>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowang@redhat.com>,
        "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
        "Kyunghwan Kwon" <k@mononn.com>
Subject: Re: [PATCH v4 1/2] Import CBOR library
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023, at 10:27, Greg Kroah-Hartman wrote:
> On Tue, Oct 10, 2023 at 10:08:43AM +0200, Alexander Graf wrote:
>> On 10.10.23 10:03, Greg Kroah-Hartman wrote:
>>
>> > > Out of these, the NSM communication protocol uses all except Semantic tags
>> > > and Floats. The CBOR library that this patch imports does not have special
>> > > handling for Semantic tags, which leaves only floats which are already
>> > > #ifdef'ed out. That means there is not much to trim.
>> > > 
>> > > What you see here is what's needed to parse CBOR in kernel - if that's what
>> > > we want to do. I'm happy to rip it out again and make it a pure user space
>> > > problem to do CBOR :).
>> > Yes, why are we parsing this in the kernel?  What could go wrong with
>> > adding yet-another-parser in privileged context?  :)
>> > 
>> > Why does this have to be in the kernel, the data sent/recieved is over
>> > virtio, so why does the kernel have to parse it?  I couldn't figure that
>> > out from the driver, yet the driver seems to have a lot of hard-coded
>> > parsing logic in it to assume specific message formats?
>> 
>> 
>> The parsing doesn't have to be in kernel and it probably shouldn't be
>> either. V3 of the patch was punting all the parsing to user space, at which
>> point you and Arnd said I should give it a try to do the protocol parsing in
>> kernel space instead. That's why the parser is here.
>
> Arnd said that, not me :)
>
>> If we conclude that all this in-kernel parsing is not worth it, I'm very
>> happy to just go back to the the v3 ioctl interface and post v5 with hwrng
>> merged into misc, but remove all CBOR logic again :)
>
> I think the less parsers we have in the kernel, the safer we are for
> obvious reasons.  Unless you have a parser for this in rust?  :)
>
> I don't really know, having a generic interface is good, but at the
> expense of this api is probably not good.  individual ioctls might be
> better if there are not going to be any other drivers for this type of
> thing?

I was definitely expecting something simpler than what was possible
in the v4 patch. I had another look now, and it's clear that the
ioctl interface is still not great because the variable data structures
shine through for some of the calls, and even to get to this point,
a whole lot of complexity is required underneath.

To get anything better, one would probably have to redesign the entire
interface stack (hypervisor, kernel and userland) to use regular
fixed data structures, and this seems unlikely to happen.

     Arnd
