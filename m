Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568D97B7043
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjJCRtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjJCRtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:49:22 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766E7B0;
        Tue,  3 Oct 2023 10:49:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 529C43200BC6;
        Tue,  3 Oct 2023 13:49:15 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 03 Oct 2023 13:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696355354; x=1696441754; bh=Kh
        U8FZX6a94VRpVV3R0AIWZs9L8DDC+rTN+A4Q9Ni2M=; b=CBfxHyn0Y0n9/4Q2m0
        MpJk3DC3pCD8MWcskDr0l74B8xiGE5HNXTbs9ncC1w3h98ajRJchHcoj2J5SYVGu
        j1UsKrTn3oi+RdUour70e0ruEFBs/rdw0uUkvP3fmw4wVjUXDkN6VaMXK37laAsb
        Ose7IOGBlrvMni9YyLCgqQ+7cXAtGJtT3UBizYotBVpgJsEEQbGLij2VoYgTOCf6
        eIPL6jYFqC7IPvs7MD23e2GM31h8CrI9hTnoB8i1Hd6KFLheP008egM0RtLUYA2s
        f5WuP3ZAG6OOzfYqcCo3teV1KCQak79rhO4gPYK5Cuz0GXK/B18rElNIQxRAfSN1
        zjEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696355354; x=1696441754; bh=KhU8FZX6a94VR
        pVV3R0AIWZs9L8DDC+rTN+A4Q9Ni2M=; b=rrz9e7KCXn6jsF6jZjL4416+o2cWf
        ieDGeEw+2wO1MX0vVKh7WdCYZn0wr4GuAOTJXsMNi0iJn6Sk5cs7YTzKknJQzMcZ
        kZ0AweTGnn4uxNPpMLHtA0S/PqMNVQcKYJTU2HHkryKz1pf5ATgq2i7bLCcrV73+
        2V6Pfuxq4vw8QBgm1fhY16pOuy2RaeND2l50Cw3HE5DbsvToaIUvofEwj3dn31WR
        JhLj3ffLlmCaCy4cgFRH05J4QBoJE8xhZqU9CuDhY0qiuevDGc8BVKrMbRxthT90
        nwBmn0VK0tbx9IHPXv2TEYuzpICIVLfQEepeliaUsONTuaFBE9JTq1Dfw==
X-ME-Sender: <xms:GVQcZWEKZeG_IktCqKf1oR-ZojFC6PVfs64FKCHD4kGtVB0ov1ClfQ>
    <xme:GVQcZXWtura6beOzvtgult2aya8K46TplvlpVepqV2aVPnSQzJB2X_By1dH-G5PKa
    NH-CLWOyCl537FPHIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeejgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:GVQcZQJRj9rxA1cvNKnxJqbR-Am0dgzoVvWdE3IP3dw_oxmKY6cASA>
    <xmx:GVQcZQG2iIADelu8gLhg0Jg-c5On6cAtWInY0bQsiHBjXeUHLQPIng>
    <xmx:GVQcZcUo6nB8R6RSN35NDaRM2VIZFLzS7PxurL2Y_ddCsjUOoA-Org>
    <xmx:GlQcZVN2cGmuJanyzr49r4NPHE91JaEUXrGHl3AAnJFG9JBt5qyZkg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 106C8B6008F; Tue,  3 Oct 2023 13:49:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <527e3b5d-2bed-4cd9-b722-7b468ad4e477@app.fastmail.com>
In-Reply-To: <a44a2df0-beb9-4a43-ade4-267ad819729e@amazon.com>
References: <20230929133320.74848-1-graf@amazon.com>
 <20230929133320.74848-2-graf@amazon.com>
 <74b2d869-0d96-46f9-a180-b405992e6c51@app.fastmail.com>
 <a44a2df0-beb9-4a43-ade4-267ad819729e@amazon.com>
Date:   Tue, 03 Oct 2023 19:48:52 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexander Graf" <graf@amazon.com>, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
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

On Fri, Sep 29, 2023, at 21:26, Alexander Graf wrote:
> On 29.09.23 19:28, Arnd Bergmann wrote:
>> On Fri, Sep 29, 2023, at 09:33, Alexander Graf wrote:

>>
>>> +int nsm_register_hwrng(struct nsm_hwrng *_nsm_hwrng)
>>> +{
>>> +     if (nsm_hwrng)
>>> +             return -EEXIST;
>>> +
>>> +     nsm_hwrng = _nsm_hwrng;
>>> +     if (nsm_vdev)
>>> +             nsm_hwrng->probe(nsm_vdev);
>>> +
>>> +     return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(nsm_register_hwrng);
>> This should get easier of you reverse the dependency between
>> the two drivers and just call into the nsm_hwrng_probe()
>> function from the main driver's probe.
>
>
> I don't understand what you mean by reversing the dependency. Nsm_rng is 
> a downstream of Nsm, because Nsm is the virtio device that owns the channel.

To clarify: I don't really consider Nsm_rng as a downstream driver,
since the main driver does not have a bus model or device detection
below it that would allow probing any function specific drivers.

I would remove the dynamic registration entirely and just merge both
parts into a single file that happens to expose an rng interface.

     Arnd
