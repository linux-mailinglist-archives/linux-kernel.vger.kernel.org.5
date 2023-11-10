Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B317E7F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbjKJR4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjKJRzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:35 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EB22E5F4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:20:06 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 77FD53200A7D;
        Fri, 10 Nov 2023 06:20:03 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 Nov 2023 06:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1699615202; x=1699701602; bh=od
        rwaD2WbWl9QIXV6S63xcSUQgU7RAQjz3aDEgQNnQA=; b=S9xHaNbE7zd/i1/hCm
        RraRG57Kfe0Kx1dI3w4MIVQcmupgWSnGJZ3lFtBwvvxjwU4RKcxrHmZWsmvf20fn
        oQ1+sLvnCzGku+ClQ2NcjzqH41FGhHigruCMdHL7sm4ndlIGbO/85TC1XtxTJLuW
        //YjHpk4ww18ZIc7SNf0Z+h63865fcoeqNCIK7zWZpeGgAfvymNmZ3owcMvLvOc2
        ZzbSf1QQXq/PMiiJgyc4eCqtJDYnXBjsHqMXdfXjjHPRlQL0LXYHJv63kiFXbiyj
        0iT2yBqk0BecmaST5S2lwLQIxA2p3sHakk2QfoUsqLcr3wLt/xeJesHx3HVpAujk
        WyeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1699615202; x=1699701602; bh=odrwaD2WbWl9Q
        IXV6S63xcSUQgU7RAQjz3aDEgQNnQA=; b=g3Ln4oWW9qoFZeKtM8x57cEtirJRe
        7yv/U4SczJmaK4mkx/UArXatjDqrEwnHUKe/MhCecPvLsROzKCgAuFT5YwsglHzy
        Z0d/EkqY18bSrNGU3InSAw7KVOcPoA00wHK7QJ+tySNe09c+46zXCzmayBN99UCV
        13a3tE3UKLLbhz7c93EGF5+z7XRFfAUGdnftf9b8dBexldqkDCwYKzXVitbTzuz3
        gsPeROblHKpaanvqlPCybAo09X32iLcBw+plvVsbQRS3wEN/bvv7Bc/5BpiEq80J
        jQdt8AGQ4usJx1EVjiuD9DXQWTQxALAQCtFK1aZ/BM5lRq6lIonP+OAUg==
X-ME-Sender: <xms:4hFOZRmxD8JJtuaYTT6hgXwMuoooBmoHZQ4_lRZOdKmZO4TtI77ucA>
    <xme:4hFOZc35zPJhKnpWVJ1d5tNdCVZxGlhHCbLGgKU5HukPAs2xIKaWVsitTSs_b0te9
    -HLZhKeW2SWlrZXT4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvfedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4hFOZXriEJChqxzA1M1AhJd3QLuPo93t7Q0MuQVmrbi88yW7ubutpQ>
    <xmx:4hFOZRl2BVyXcpsR6vRYf7Ecd6z1GcicX_4v7uxPrOI4TJVJvDMisw>
    <xmx:4hFOZf2Cvd_UQjL6GnWY3pFDGisWdVYyFHeazwDw6zVTBBxtji_Htg>
    <xmx:4hFOZdASJVr6eKirQysMZWjNDGkjLeNCnZQi2PmA18JmvxV2KPwKaQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 65624B60089; Fri, 10 Nov 2023 06:20:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <571ed28a-9690-4f85-9122-4b0f76975cb3@app.fastmail.com>
In-Reply-To: <20231110103120.387517-1-thuth@redhat.com>
References: <20231110103120.387517-1-thuth@redhat.com>
Date:   Fri, 10 Nov 2023 12:19:42 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Huth" <thuth@redhat.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        "Greg Ungerer" <gerg@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] m68k: Avoid CONFIG_COLDFIRE switch in uapi header
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023, at 11:31, Thomas Huth wrote:
> We should not use any CONFIG switches in uapi headers since
> these only work during kernel compilation. They are not defined
> for userspace. Let's use the __mcoldfire__ switch from the
> compiler here instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Marked as RFC since I didn't test it - I'd appreciate if someone
>  could give it a try on a real system.
>
>  arch/m68k/include/uapi/asm/ptrace.h | 2 +-
>  scripts/headers_install.sh          | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/m68k/include/uapi/asm/ptrace.h 
> b/arch/m68k/include/uapi/asm/ptrace.h
> index 5b50ea592e00..ebd9fccb3d11 100644
> --- a/arch/m68k/include/uapi/asm/ptrace.h
> +++ b/arch/m68k/include/uapi/asm/ptrace.h
> @@ -39,7 +39,7 @@ struct pt_regs {
>    long     d0;
>    long     orig_d0;
>    long     stkadj;
> -#ifdef CONFIG_COLDFIRE
> +#ifdef __mcoldfire__
>    unsigned format :  4; /* frame format specifier */
>    unsigned vector : 12; /* vector offset */
>    unsigned short sr;

I think this should be harmless, but I'm not sure we even
need the structure in a uapi header: about half the architectures
define this in a user-visible way, while the others don't.

On csky, powerpc and microblaze, pt_regs is used inside
of the 'struct sigcontext' definition, but I don't think
this was ever the case on m68k.

The other one that is accessed in userspace is 'struct
user_regs_struct', but this one is actually not in the
uapi headers on m68k or x86.

     Arnd
