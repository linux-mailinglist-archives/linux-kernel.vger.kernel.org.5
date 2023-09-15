Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234777A1795
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjIOHg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjIOHgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:36:54 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843C898;
        Fri, 15 Sep 2023 00:36:47 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E6F25C018C;
        Fri, 15 Sep 2023 03:36:45 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Fri, 15 Sep 2023 03:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694763405; x=1694849805; bh=7S
        H3zYoN2Ax+klrjdlOOfj5svSwICPVNWO4zsQhoym4=; b=ET1TBQajKbzDSQjROa
        XtMz+qtASe0uqJMMVLsRm6SX79KvWZ5sS09WJUdRrmorMzlVv0bSNhITjA6Ed354
        ILlm99jH91nVBKq5fo4SEcXqDH0Do8NUzp3I6aIj52/pi08yayBmigYon7wq2oT7
        jMGlki0Pd8OlDTN5KUEKFqVjYsv2NZ/LZ/jr23rqfTlW5Amcut9316BIT6Zsnz+a
        VUiW0oLzUhWSggL3JUqglOjOXJn55GuNRGztZIEjt0Ur4AAEiy9qpPcBjCe6AYeN
        lAxVnWXqNU0CLsQyx6zjd0H+dUgEE0cMN5fAMz+xq+NhpW7SPP89CJVY7lXItUr4
        tniQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694763405; x=1694849805; bh=7SH3zYoN2Ax+k
        lrjdlOOfj5svSwICPVNWO4zsQhoym4=; b=dS2Ekw7GSf3E+vDw8IdsLeH/B7VBf
        4R8qJaBw0xsKoHBTtKsftRTDgBJ1ehXTzJ39sJzuIHBDfR7S7PeoOdQSO0F8g5UH
        o67Yv2w/4y6pWiWgHcvBws1vMGaR+4q4+WjIH7OOYVBZOq4ILxFbGMMLRHYklPTx
        dQvpmPsMQyVxnJRn0zV7pcOoYcDZXh6jbFT5CeTVX3Fd9QDcfw/nY1GoB8ja3QLb
        j9eMOXh9bH/9jMCuHWFRufzeSXEBxbPQjetdiq4QgOCYFQiEh+CY3cYKTmsCeIes
        PDgkFaT9BdEqtnWA4BTOYoQm2A2SkE/CwdPegAckU1uxJFWkQvsyWpXfw==
X-ME-Sender: <xms:jAkEZe6AFuEV2ECKsypVBmJKgtvXOEjcNPEKaiCb551jUenpQbm-WQ>
    <xme:jAkEZX7VyJXl31I7-PgxFKtZ9JuTbAfRTs4PRaR4wFNpHrShEGzC7V8McfTsODtpm
    9mZ7iwLF2MXJcrL_aI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdff
    rghvihguucfthhgvihhnshgsvghrghdfuceouggrvhhiugesrhgvrggurghhvggrugdrvg
    huqeenucggtffrrghtthgvrhhnpeekkedvffetudduhffhfeefveethfejjeevuefhleef
    ieeigfefieekgeegvdekgeenucffohhmrghinheptghrvggrthgvvddrnhgrmhgvnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggrvhhiuges
    rhgvrggurghhvggrugdrvghu
X-ME-Proxy: <xmx:jAkEZddy2kGyxQxeEf-hdOyG2IiJX4vtWuaUch-h5ClZZgddZVJOpw>
    <xmx:jAkEZbJ7R-I_y3HUaD8jVix-vamR3paeDac4oaG3T_PXNcGweqJ9WQ>
    <xmx:jAkEZSJb7TGhQetpeqlXgYKD8em4bevOcGF2N-rfrGiOUD8RgFkDAg>
    <xmx:jQkEZUi-tlwerD1z0yYvvgE5rf1tAxq7YJIK2v8sK2Ar3v5EvAbYsw>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 76E641700089; Fri, 15 Sep 2023 03:36:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <98d981a1-4e4c-4173-b8eb-09b4245bca60@app.fastmail.com>
In-Reply-To: <202309142206.60836CE@keescook>
References: <20230914-strncpy-drivers-hid-uhid-c-v1-1-18a190060d8d@google.com>
 <202309142206.60836CE@keescook>
Date:   Fri, 15 Sep 2023 09:36:23 +0200
From:   "David Rheinsberg" <david@readahead.eu>
To:     "Kees Cook" <keescook@chromium.org>,
        "Justin Stitt" <justinstitt@google.com>
Cc:     "Jiri Kosina" <jikos@kernel.org>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "David Herrmann" <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: uhid: refactor deprecated strncpy
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, Sep 15, 2023, at 7:13 AM, Kees Cook wrote:
>> -	/* @hid is zero-initialized, strncpy() is correct, strlcpy() not */
>> -	len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
>> -	strncpy(hid->name, ev->u.create2.name, len);
>> -	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys)) - 1;
>> -	strncpy(hid->phys, ev->u.create2.phys, len);
>> -	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq)) - 1;
>> -	strncpy(hid->uniq, ev->u.create2.uniq, len);
>
> ev->u.create2 is:
> struct uhid_create2_req {
>         __u8 name[128];
>         __u8 phys[64];
>         __u8 uniq[64];
> 	...
>
> hid is:
> struct hid_device { /* device report descriptor */
> 	...
>         char name[128]; /* Device name */
>         char phys[64]; /* Device physical location */
>         char uniq[64]; /* Device unique identifier (serial #) */
>
> So these "min" calls are redundant -- it wants to copy at most 1 less so
> it can be %NUL terminated. Which is what strscpy() already does. And
> source and dest are the same size, so we can't over-read source if it
> weren't terminated (since strscpy won't overread like strlcpy).

I *really* think we should keep the `min` calls. The compiler should already optimize them away, as both arguments are compile-time constants. There is no inherent reason why source and target are equal in size. Yes, it is unlikely to change, but I don't understand why we would want to implicitly rely on it, rather than make the compiler verify it for us. And `struct hid_device` is very much allowed to change in the future.

As an alternative, you can use BUILD_BUG_ON() and verify both are equal in length.

Thanks
David
