Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2537D3930
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjJWOT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjJWOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:19:56 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC950100;
        Mon, 23 Oct 2023 07:19:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 319375C033F;
        Mon, 23 Oct 2023 10:19:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 23 Oct 2023 10:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698070794; x=1698157194; bh=bs
        mBsb2C4biRFAK90R3YGndrC+6bsEOQQxqfzZ99ePQ=; b=lYc+ZBHk7xNLUtCtBW
        SW8wU5/knar6IJPqYjl2CJlJp3v6LY9kHkC/0Zfhp+3PTywtBVWdAqtC05b7Pbzr
        U0hz2+5uHYYsZS0NY32+N1gtTXo4aD7GNYc1rbazGdO0kyURlMQBaEirGbvxkG9d
        SIAW0ZhuyzLDXAtskzdjRZxeHE7ttbI9ALKzJf0d6CeVwc9wvatHsle+gWRH4fVb
        55FuhknZOFv5PHK4IK8rzARimnoff+PJPTeyjyIM0mWIRxMmzFwWahsJ2ZRGVauV
        bOxKJuyw7zaSXKFAOCRJlzcHn9kWaL7DG1uRb2N9IQr83vl3yqUJiLntZnkFkXjF
        tfTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698070794; x=1698157194; bh=bsmBsb2C4biRF
        AK90R3YGndrC+6bsEOQQxqfzZ99ePQ=; b=niRJqeL+BF+kNPZQvaQPd/1+q2SwC
        69sqEW1ElhXcqkiS2L7UGVNTaxU+nsD5f0wrk/AX8LHVxxVBnJnQSNwuKytXPxt2
        z7m3Hg++LJW/fAsDZj01KzRe4fZNimddMbymzw69rCMe5pVjfRD1VGtoqXlhUwYX
        M82mbZRNauf5OBlCi9+V9Bbao1ZWLMekUgh7l1pUm6uKWjtg6u2JhkNnfvOiBkE1
        8YioQ8s2B9pAvNmz5GZwg5JALdw67TAToo8hKHBX58mE4e6httVe8fqF3V9uNVde
        xEQskAu0dFh408H21biJ8MxBRlaRvv0kmYld0GqBk3mKPnBHvJORtg9Rw==
X-ME-Sender: <xms:CYE2ZU6h5o3AkFhd4qe-eFIxvZEUjYvLbfwcW4WGXBK3K-PsQTRkcQ>
    <xme:CYE2ZV7e_D95Qufz1UVDxew2mQ-3zZrG04n_OxWOQt_VxIJeVMtUPQ7jfOdnnLapy
    _tz_-BoCs3Ep7ShLgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:CoE2ZTd6e-iqyuzsZkMtdUeVlyibjgocKeAvVmwIt8yQZycGQhSUvg>
    <xmx:CoE2ZZLf943EmtbrTJ9opSX9KHiXy-IqgACy1quGrRuG3IlaRUtLkw>
    <xmx:CoE2ZYIhQxg_-d026fnfbeqRlwAXDB712lhngTpCP5fPmgyfVVHe6A>
    <xmx:CoE2ZdUI7CZ4zJBij_i-AoyZBN_gMqojPy_Q-e-0n3S3UOkxBO9BTQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DCB18B60089; Mon, 23 Oct 2023 10:19:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <15f25d73-32d5-4809-8096-32c856559d66@app.fastmail.com>
In-Reply-To: <BN7PR03MB4545DA4A9404F349170CBA1097D8A@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20231019125646.14236-1-eliza.balas@analog.com>
 <20231019125646.14236-3-eliza.balas@analog.com>
 <2023101917-cork-numeric-dab8@gregkh>
 <BN7PR03MB4545E7EAB2D72B9098C30C6797DBA@BN7PR03MB4545.namprd03.prod.outlook.com>
 <2023102030-resort-glance-57ef@gregkh>
 <BN7PR03MB4545FF54B96514EC9F41887E97D8A@BN7PR03MB4545.namprd03.prod.outlook.com>
 <2023102339-outcast-scone-5a63@gregkh>
 <BN7PR03MB4545DA4A9404F349170CBA1097D8A@BN7PR03MB4545.namprd03.prod.outlook.com>
Date:   Mon, 23 Oct 2023 16:19:32 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Eliza Balas" <Eliza.Balas@analog.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
        "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023, at 15:30, Balas, Eliza wrote:
>> -----Original Message-----
>> Cvetic <dragan.cvetic@amd.com>; Arnd Bergmann <arnd@arndb.de>
>> Subject: Re: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine

>> > > > Since the device is not an iio device, using an iio function would be confusing.
>> > >
>> > > Why isn't this an iio device?
>> >
>> > The device is not registered into the IIO device tree,
>> > and does not rely on IIO kernel APIs.
>> > Even though there are a few attributes that resemble the
>> > ones from iio, and the sysfs structure is similar,
>> > this is not an IIO device.
>> > In the previous patch versions 1 and 2 we concluded
>> > that this device fits better in the misc subsystem.
>> 
>> Ok, can you point to that in the changelog where the IIO maintainer
>> agreed that this doesn't fit into that subsystem?
>> 
> This was one of the discussions from previous v2 : 
> https://lore.kernel.org/all/5b6318f16799e6e2575fe541e83e42e0afebe6cf.camel@gmail.com/
>
> I will add it to the changelog the next time I submit the patches.

It sounds like Jonathan wasn't quite sure either here, and I would
still argue (as I did in that thread), that drivers/iio is probably
a better option than drivers/misc.

In particular, you mention that you actually make this device
appear as an IIO device to user space using the "iio-fake" hack.

I can see that IIO is not a perfect fit if this is the only
device of its kind, but going that way anyway avoids a number
of problems by reusing infrastructure for the IIO ABI and
serialization with in-kernel users, as well as giving you
the option of adding other compatible drivers later.

     Arnd
