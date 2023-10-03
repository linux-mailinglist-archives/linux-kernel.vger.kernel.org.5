Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBC27B6EE5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjJCQrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjJCQrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:47:51 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E220CA1;
        Tue,  3 Oct 2023 09:47:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 856D23200BF0;
        Tue,  3 Oct 2023 12:47:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 03 Oct 2023 12:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696351663; x=1696438063; bh=/A
        cUWjTSxiGYvvx3hpMz+UmO53K8sD6TSugZV8H5nNk=; b=jH8Of65NO+r977XfHL
        KZLs5+y/ELN3BkKZxRs5CiH9faDp+dV0zZ88VCLBbM0jFVplnCu8kKtdJBOMC682
        2tbtWnjBCby31YDhY8bhMUrJtQvDn3DNB9iEG70uhzy5geSgdk3O7Q3D3GutUIT4
        IhjGV9WnAtBbeJGdAVYC3FyAmuVIUPGJSSjwX/fuS+Pf1fQ+zt4dk6cQiLgMfJKi
        7FwLeFCocFa2ZNL5nmdNSFflqDW8a8lC6jY3nRLsnjMnPyQeRuH46p07sbbf/+Yf
        mAPbGwCAtF/7stzj2HSM9fPjF8ThS9DGg+ON/Gli+v4B1TwMCVGiIwVzIulkHN/4
        /JtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696351663; x=1696438063; bh=/AcUWjTSxiGYv
        vx3hpMz+UmO53K8sD6TSugZV8H5nNk=; b=eojre1JZ+lZ+ew9DxONZLEz3DxjSL
        ZMgUky+lHP38raceViiwlidgvKKVL6etU06vTxm/gPTz+QPITUG1HbFFYNyV3Xpy
        iPCq1UWGkiChkaiTYvN9yiu5KJWTou5E76mhxmWDFaxPMYNIbXkNKtDbxs9Wzbqt
        8QjJah5ecky/IIxngJjMuRWGujRCjLCX3SprxGhWd9k5PClevgxfRZSwUysWqO4B
        Y8cZq29GLoYOQ2IurrsgD1B+x/wmbWq3+Exo6Lg1wnlNG7yGnD4xJWoIIA725qFX
        hpYEaMCk/8hg6jY09WGBUHTL0qvUSKTAj9w6nruZwF/FTxO7CC9A4iceQ==
X-ME-Sender: <xms:rUUcZZ1p8E6DMAvzzu_Ij1-y4it2s-BZboZfDQEyQlmZG-J_ruBupg>
    <xme:rUUcZQEi8mVAc48Hn4GOklpm4tQnAu5cs-9tSY-Hqw7RXAX1YOI2a4feYjNPtL3OI
    JN2s3Z7zcRyg5JLoCc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeejgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:rUUcZZ648SAMyQDwsS5ftK3NG2yySCj_iIjgLDpx2pHci8ypk9H3jw>
    <xmx:rUUcZW37VK2JQTK8FzcBq0xvXowCPovRYdy7CPoPqRGF-TiOqvgAeA>
    <xmx:rUUcZcG_0rHmhyQ_TXxA1Ut0VbWvi5igsXEjwEgRKs2_SrdqB_fWsA>
    <xmx:r0UcZU_E3J9Kv9tAG2hWzb2skYW5FiWtCvLiIYofAUuJF6eMpWzpqw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A3CA2B6008F; Tue,  3 Oct 2023 12:47:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <d84002c9-60a5-4a02-a65d-329e18403ddd@app.fastmail.com>
In-Reply-To: <8fee7a04-cee2-4b99-8ec5-63af940c3198@amazon.com>
References: <20230929133320.74848-1-graf@amazon.com>
 <20230929133320.74848-2-graf@amazon.com>
 <74b2d869-0d96-46f9-a180-b405992e6c51@app.fastmail.com>
 <a44a2df0-beb9-4a43-ade4-267ad819729e@amazon.com>
 <2023093054-swimming-whoopee-7ef8@gregkh>
 <8fee7a04-cee2-4b99-8ec5-63af940c3198@amazon.com>
Date:   Tue, 03 Oct 2023 18:47:11 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexander Graf" <graf@amazon.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Olivia Mackall" <olivia@selenic.com>,
        "Petre Eftime" <petre.eftime@gmail.com>,
        "Erdem Meydanlli" <meydanli@amazon.nl>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowang@redhat.com>,
        "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] misc: Add Nitro Secure Module driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023, at 14:28, Alexander Graf wrote:
> On 30.09.23 08:20, Greg Kroah-Hartman wrote:
>> On Fri, Sep 29, 2023 at 09:26:16PM +0200, Alexander Graf wrote:
>>> On 29.09.23 19:28, Arnd Bergmann wrote:

>>> All of these use the (downstream) ioctl that this patch also implements. We
>>> could change it, but instead of making it easier for user space to adapt the
>>> device node, it would probably hurt more.
>>>
>>> I agree that this is not a great place to be in. This driver absolutely
>>> should have been upstreamed 3 years ago. But I can't turn back time (yet)
>>> :).
>> As you know, this is no excuse to put an api in the kernel that isn't
>> correct or good for the long-term.  Just because people do foolish
>> things outside of the kernel tree never means we have to accept them in
>> our tree.  Instead we can ask them to fix them properly as part of us
>> taking the code.
>>
>> So please, work on doing this right.
>
>
> Sorry if my message above came over as a push to put an "incorrect api" 
> into the kernel.
>
> In situations like this where you can either give user space full access 
> to the device's command space through a generic API or you can create 
> command awareness in the kernel and make it the kernel's task to learn 
> about each command, IMHO it's never a clear cut on which one is better. 
> Especially in virtual environments where the set of commands can change 
> quickly over time.
>
> So what I was trying to say above is that *if* we consider both paths 
> equally viable, I'd err on the one that enables the existing ecosystem. 
> However if there are good reasons to not do command pass-through, I'm 
> all for abstracting it away :)
>
> Looking at prior art, the most similar implementations to this are TPMs 
> and virtio-vsock. With virtio-vsock, kernel space has no idea what it 
> talks to on the other hand and makes it 100% user space's problem. With 
> TPMs, you typically use /dev/tpm0 to gain raw command access to the 
> target device. So while we could engineer something smarter here, I'm 
> not convinced yet it's a net win.

Generally speaking, I can see a number of advantages to using an
in-kernel abstraction:

- if there are both in-kernel and userspace API users, or multiple
  concurrent userspace clients, an abstraction layer helps to serialize
  between any stateful commands.

- in an abstract interface, the kernel can enforce command specific
  permission checks, rather than allowing access either to all or none
  of the commands.

- having the actual commands created by the kernel means that a bug
  in the virtio device implementation parsing the commands is less
  likely to be exploitable from user space.

- An explicit set of defined ioctl commands is easier to review and
  audit for kernel developers as we try to ensure that this is a
  sensible kernel interface

I don't know enough about your use cases or the specific
command set to tell if any of those points actually matter
here. In the python implementation you linked to, there are
only a handful of commands that actually get passed through.
It should be fairly easy to prototype a kernel driver that
implements them as individual ioctl commands, to give us a
better idea of how this compares to the current code.

     Arnd
