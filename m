Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578D876CFE5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjHBOTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjHBOT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:19:29 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96910272A;
        Wed,  2 Aug 2023 07:19:27 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 09D8D5C0089;
        Wed,  2 Aug 2023 10:19:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 02 Aug 2023 10:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690985967; x=1691072367; bh=BU
        dHhNhEjX4ngx2jtG/4TPbrPOMxx6nkx3T9LDhPRYo=; b=mx5MMhewIy2oFRXKKw
        wvhEueAMLBzedVFA5Hmi2B8U7uRIDJxC679m4oZbq/hdkvHaoWBFDiEIeswdPiH/
        huIRfA3oKq0SZmbumzCEOJv/HiwpA7+dhvvY0SXNMRq8uHrANY7BpbMSl36yx73U
        cGVNQdwaqKQROZPWfqSo2LZhV/l01HV/aTuXIKsqGtMhdZVAfusTlcHiRax+TEJ9
        0muhBW3pRv8x3Q8tTpDYqhYYAODnd5WGu4W0Q1+WVHYiPQAAQTMpSEVa9JPV3uZf
        tmMQazYaAsLtfzCWSN3hnLZ/bETPj2a6LrEjSTshUJoZ1K6nTk3x03hd3khsn8QI
        9aVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690985967; x=1691072367; bh=BUdHhNhEjX4ng
        x2jtG/4TPbrPOMxx6nkx3T9LDhPRYo=; b=tCqdEg34aM0lFWczPyq3c9sPPcLut
        VPm17vo7WVHPJjF2pkDv5z0ecScCQtyazhuKad1Bt2DfVJUYexrzgHfOBaZHZIam
        F++AX77tbOwojiBH3nAk9nG2kUf2mcBrPkCbgMlOtxX3TV70XY7OVJCISS9GG/dk
        zLV4VQMwQtBZ1yGCuJmX7Dw8rQsMl+T1WUIkI5fAqHdo+mTNGRQMut5TAd0hbvy0
        AONIKCrS2hULXURdIKm41ESUE0ouNwVkMp/qPLYnQOgD8sSQ/zwrjPf5EXvrn7F8
        wKtlaqtXB03TGSLe1QajXMHFyNbs/GGaP3cJpvWV8gfLNUoYmJRoJDghg==
X-ME-Sender: <xms:7GXKZCdwLfUemzGe_EP5hor1BJUfvMXU8ZRCXTADvKQJqfQ1fwS-aA>
    <xme:7GXKZMPmBbX0Xlp4jUXFxIVDXcytP3LiHuyjZv1R4shBg-XQOIAKlc3TT5i4Rylgt
    Qi3delCyOzHn-xfj1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeekgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:7GXKZDjL-i0B1kkvbWppm5sVdxBk0wgnWR5ejlXyPERSn2O46KJ9Xg>
    <xmx:7GXKZP9C4BL-B1HfXPPc0D_GGJGe8P9mCvtTneNekgK487HERx1P3A>
    <xmx:7GXKZOtkBafA77K2BTCJNlPYMgeYxm_i-8_bBrJBK3x5M2mrOAvxog>
    <xmx:72XKZJmfIagEXMHBV391U4wB9ZMGdsv2kEx7GvYCVHgTA2ZwDvG3xQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7FA53B60089; Wed,  2 Aug 2023 10:19:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <39c79971-12fc-41fc-8cae-b2a0089ed034@app.fastmail.com>
In-Reply-To: <c48f6f3c742eaf35e35882064ccf4ed07d4e63fe.camel@physik.fu-berlin.de>
References: <20230706154520.11257-1-bhe@redhat.com>
 <20230706154520.11257-12-bhe@redhat.com>
 <CAMuHMdWmv-Jdvi7a04JGXuA2QARj8c8mpUvY7TOcetPkG4pW7A@mail.gmail.com>
 <0f771b11539d5a3871691af901315ee2034b577c.camel@physik.fu-berlin.de>
 <09094baf-dadf-4bce-9f63-f2a1f255f9a8@app.fastmail.com>
 <c48f6f3c742eaf35e35882064ccf4ed07d4e63fe.camel@physik.fu-berlin.de>
Date:   Wed, 02 Aug 2023 16:19:04 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Baoquan He" <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Christoph Hellwig" <hch@lst.de>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Stafford Horne" <shorne@gmail.com>,
        "David Laight" <David.Laight@aculab.com>,
        "Helge Deller" <deller@gmx.de>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>, linux-sh@vger.kernel.org,
        "Guenter Roeck" <linux@roeck-us.net>
Subject: Re: [PATCH v8 11/19] sh: add <asm-generic/io.h> including
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023, at 21:21, John Paul Adrian Glaubitz wrote:

>> I think ideally all the I/O port stuff in arch/sh/ could just be
>> removed after the conversion to asm-generic/io.h, but the
>> microdev_ioport_map() function oddity gets in the way of that,
>> unless someone wants to clean up that platform. As far as I
>> can tell, the ethernet, display, USB and PCI devices on it already
>> broke at some point (afbb9d8d5266b, 46bc85872040a), so it might
>> be easier to remove it entirely.
>
> I don't have this particular hardware, so I cannot comment on this.

Sure, as I explained, I'm pretty sure that nobody has
tried to boot this hardware in a long time, so I did not
expect you to have one.

I'll try to follow up with a patch to remove the platform
later on, based on the explations above.

>> Having the series go into linux-next sounds appropriate like this,
>> the entire purpose of that is to find such bugs and Andrew can jus
>> fold the fixup into the broken patch. 
>> 
>> Let me know if you prefer the simple version with the extra
>> #defines or if we should just use the generic inb/outb implementation
>> immediately and drop microdev in a separate patch.
>
> Please go ahead with the simple version.

Done,

     Arnd
