Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C367A4302
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbjIRHlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240344AbjIRHkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:40:45 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB1F1713;
        Mon, 18 Sep 2023 00:38:16 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 8B276320092C;
        Mon, 18 Sep 2023 03:38:15 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Mon, 18 Sep 2023 03:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695022695; x=1695109095; bh=mz
        jY251qQhhC38PIPkqsYuoZfhugwdU5Aanf/NUjZMA=; b=9dZCYBj5Z4w0C9//JP
        vB3j7sYybiuEA/YtcLv0AhTtutckycWp5kHzidkvpLqG10pcQb2jrzvNBiFpduSu
        uCus77hf9gyHUNlQMcVyZPyz4IAvWaZPK91rmiDk6otiXmsJnukmGdap7eFzrQ7e
        C0qh8eauLDPlTaHKF3wb43KeeTjsb0ouC6CZJ4MziuNkmZrS/ssZ935tRayi0lLr
        luTQKxwZTiS5FKRMeSfSQproJSpE+HoEGxH6Ai9IjMR9YiDXPV+AS53Q2Jb1mQVS
        CkazXJmwwz/Lsy8NhlO8kzLr0coi/OHWTsRFn9HlxtdWNyzAbKg2cNo9jc+MJZ2z
        6LUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695022695; x=1695109095; bh=mzjY251qQhhC3
        8PIPkqsYuoZfhugwdU5Aanf/NUjZMA=; b=C2ZNl+a4id8r4/2AF6binaQOMlK8G
        2e37UBF6naQkJIqauc/c8svaiaMPWxvPWuFIvzLStfgLoSnLBU45dKGOXFZl55Sp
        PBAjR21OWf8ZWWRlquwVKNc/akSEPkkVZ1dfODbDuB45ewx7zux40Oj7Olav4C6y
        TUXYVVuyImoIue2LIHxLq0ned+LoHqSItEBROhOYn0Gq9/hcs3qPpCTT2jUETG3Z
        Zmk6Q0HAMo2tPa2u1WZEcdly1v2BioZt3c6L2HeUSW3+xUDnRzU6n5ITsSDrdS0D
        uLOhDNCQn5VVgSPSf8wzgNd8npHmmYCZ+xVEy2YINHrHR5qFTow+ZRkeg==
X-ME-Sender: <xms:Zv4HZeIk9iTnjvOIFb49UEsyjMMOnu6bwgj5mAKs_p8o-qsEu1Cd9w>
    <xme:Zv4HZWLcPiYFYkzx0-QcA0cqWMzp6m_E92cwxlSaSUMT0J5JO20dVwc8wRA11hrqN
    VTP3SnibJeCgfX1rBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejjedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdff
    rghvihguucfthhgvihhnshgsvghrghdfuceouggrvhhiugesrhgvrggurghhvggrugdrvg
    huqeenucggtffrrghtthgvrhhnpeekkedvffetudduhffhfeefveethfejjeevuefhleef
    ieeigfefieekgeegvdekgeenucffohhmrghinheptghrvggrthgvvddrnhgrmhgvnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggrvhhiuges
    rhgvrggurghhvggrugdrvghu
X-ME-Proxy: <xmx:Zv4HZes5fOAA9D-2nWUsv22WUFDDUCp4dkVBx8DGN9OW8Ddw223Utw>
    <xmx:Zv4HZTY3daSCzMhbWR2zPtuJ5Sc2AWBGoCeYrcrcfu3fReJvz6IxEA>
    <xmx:Zv4HZVbKjktcWsC2NQsSpVR292gjCjycsOGAifObyZ3AIdEP1DqWZg>
    <xmx:Z_4HZYzispTMLqmtoYlbWA5GiqzMred1VMW-3fppCavHbIsBGNQPPQ>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8499B1700089; Mon, 18 Sep 2023 03:38:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <72b7c13a-5f82-498b-84a3-b6e9b61c0e3a@app.fastmail.com>
In-Reply-To: <202309151342.DFA6CA5C7@keescook>
References: <20230914-strncpy-drivers-hid-uhid-c-v1-1-18a190060d8d@google.com>
 <202309142206.60836CE@keescook>
 <98d981a1-4e4c-4173-b8eb-09b4245bca60@app.fastmail.com>
 <202309151342.DFA6CA5C7@keescook>
Date:   Mon, 18 Sep 2023 09:37:53 +0200
From:   "David Rheinsberg" <david@readahead.eu>
To:     "Kees Cook" <keescook@chromium.org>
Cc:     "Justin Stitt" <justinstitt@google.com>,
        "Jiri Kosina" <jikos@kernel.org>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "David Herrmann" <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: uhid: refactor deprecated strncpy
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

On Fri, Sep 15, 2023, at 10:48 PM, Kees Cook wrote:
> On Fri, Sep 15, 2023 at 09:36:23AM +0200, David Rheinsberg wrote:
>> Hi
>> 
>> On Fri, Sep 15, 2023, at 7:13 AM, Kees Cook wrote:
>> >> -	/* @hid is zero-initialized, strncpy() is correct, strlcpy() not */
>> >> -	len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
>> >> -	strncpy(hid->name, ev->u.create2.name, len);
>> >> -	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys)) - 1;
>> >> -	strncpy(hid->phys, ev->u.create2.phys, len);
>> >> -	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq)) - 1;
>> >> -	strncpy(hid->uniq, ev->u.create2.uniq, len);
>> >
>> > ev->u.create2 is:
>> > struct uhid_create2_req {
>> >         __u8 name[128];
>> >         __u8 phys[64];
>> >         __u8 uniq[64];
>> > 	...
>> >
>> > hid is:
>> > struct hid_device { /* device report descriptor */
>> > 	...
>> >         char name[128]; /* Device name */
>> >         char phys[64]; /* Device physical location */
>> >         char uniq[64]; /* Device unique identifier (serial #) */
>> >
>> > So these "min" calls are redundant -- it wants to copy at most 1 less so
>> > it can be %NUL terminated. Which is what strscpy() already does. And
>> > source and dest are the same size, so we can't over-read source if it
>> > weren't terminated (since strscpy won't overread like strlcpy).
>> 
>> I *really* think we should keep the `min` calls. The compiler
>> should already optimize them away, as both arguments are compile-time
>> constants. There is no inherent reason why source and target are equal in
>> size. Yes, it is unlikely to change, but I don't understand why we would
>> want to implicitly rely on it, rather than make the compiler verify it for
>> us. And `struct hid_device` is very much allowed to change in the future.
>> 
>> As an alternative, you can use BUILD_BUG_ON() and verify both are equal in length.
>
> If we can't depend on ev->u.create2.name/phys/uniq being %NUL-terminated,
> we've already done the "min" calculations, and we've already got the
> dest zeroed, then I suspect the thing to do is just use memcpy instead
> of strncpy (or strscpy).

If you use memcpy, you might copy garbage trailing the terminating zero. This is not particularly wrong, but also not really nice if user-space relies on the kernel to treat it as a string. You don't know whether a query of the string returns trailing bytes, and thus might expose data that user-space did not intend to share.

I mean, this is why the code uses strncpy().

Thanks
David
