Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A1879F9BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjINFGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjINFF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:05:57 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50A798;
        Wed, 13 Sep 2023 22:05:53 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DFAAA5C0261;
        Thu, 14 Sep 2023 01:05:52 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 14 Sep 2023 01:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694667952; x=1694754352; bh=r+
        8a9VVUj2+14lVyHMEam/cUuRe70jim+0p47BeFLEo=; b=Z+7/WfF47uX4rMiGTP
        BKb5hgzeV8oSsQZXaP9YScBOcQQSRMJU5zaMimcqYwGFzGYSOhUo0UNIpR4IDdic
        DU7vdcKaGttl7h3PVaZGUvlS1s9pgoMiKaeeeHue20FuaBbPV2kyFIWdYGMf5S6s
        zZ/2TIB+wZqdlEsv9PrRq3iUQanKCcnHUOdpzbkW4AFi8z8GtID5J+A1GQjd8int
        owBpw09EKPYQ3FpgV+/B7JpVq18h4l6zBg1CUf0M+bBR7AaJzk1kwFCilk4b/DnY
        DnYHmdF6qMdOI3BWSEPKB+2lT2Fb+wJvXRrcFXhI44JkImI6GRaAJb4dEaXkAGw4
        Nymg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694667952; x=1694754352; bh=r+8a9VVUj2+14
        lVyHMEam/cUuRe70jim+0p47BeFLEo=; b=Tqvu/v3f27xMzAX2a3I635BaKPhVm
        XxB0STDguy2nwdAKjrj6PC4bTMsDnWwJGOnBZIZFfZhpP4+AeRN1ZuGm1lS5KU5A
        5i7Gv0R1g6NDtsMiqMNduPN5XlvhBq7t9lJ7JK8BBGN4BkvEYefL4GD2luuWgHAB
        hZwG4C3lGXKVUDZoK2BTKyFnwWfFUcrWx0JIAUxI1hBTItpes8ZslN8ElI2k13ph
        f4BSB/rp3s0eX2wvZteO1KxiP2asuwWCnI6IdnXeVH6KDl4OEYNEHTUU2QXwkpGM
        1DGe7FDdCCEt/X7+0V1t9UIGv8NN57UCrd2bl7T0/OUZWAA2erQshbd0w==
X-ME-Sender: <xms:sJQCZbVjdHvnk_y5ZhCNzItfpRkrlaRFR7juq1dVnIekICAOcn5Ulg>
    <xme:sJQCZTku9Up6M9Xy8VuMzF8L9JSEhMeG8Cxu4JM-5tcKmq4-3tsp0VrqdyHlZhmit
    mvkVjYpnYyViWsysFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiledgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:sJQCZXY82DOye0Fvun6cebJSaGPrTcRqlFXXy1wy0BNxwjANoAyY9A>
    <xmx:sJQCZWUuD6-If8jHENHwGXPz9681UYFjnEo4GUH0ThBWrZB90kP1_A>
    <xmx:sJQCZVlDhcS3p7JtF8sxq55vZniiP9tCeGcr1IHMFMFcWv55SiOUyQ>
    <xmx:sJQCZX4uh7fgGWKnss4HJWk2Xy-hUQSRBm5eSW5h_lqjY_0jDj1DFg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 09712B60089; Thu, 14 Sep 2023 01:05:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <82dfa2eb-1867-4cdc-b7b8-918d426575ed@app.fastmail.com>
In-Reply-To: <ZQKDRANlIWGqTA/9@bergen.fjasle.eu>
References: <20230913113801.1901152-1-arnd@kernel.org>
 <ZQISGujwlH00B8KJ@fjasle.eu>
 <b234530c-88fe-4a2a-993c-f1733fe4d0c1@app.fastmail.com>
 <ZQIcuVgaDmA+VdV0@fjasle.eu>
 <c7c6de7b-4adf-4625-8f09-8f419869161d@app.fastmail.com>
 <ZQKDRANlIWGqTA/9@bergen.fjasle.eu>
Date:   Thu, 14 Sep 2023 07:05:31 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nicolas Schier" <nicolas@fjasle.eu>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Sakari Ailus" <sakari.ailus@iki.fi>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional dependencies
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023, at 05:51, Nicolas Schier wrote:
> On Wed 13 Sep 2023 23:16:47 GMT, Arnd Bergmann wrote:
>> On Wed, Sep 13, 2023, at 22:34, Nicolas Schier wrote:
>> >
>> > BAR=y  => FOO={N/m/y}
>> > BAR=m  => FOO is not selectable
>> > BAR=n  => FOO={N/m/y}
>> 
>> That is indeed the point: if BAR=m, we want to be able to pick FOO=m
>> here, otherwise it is impossible to enabled everything as modules.
>
> oh, I misinterpreted your very first sentence; thanks for clarifying it to me
> and sorry for the noise.
> With the minor fixes:
>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>

Ok, thanks!

I understand that the text is still confusing, so if anyone has an
idea for how to improve it further, let me know, otherwise
I'll send what I have now with type fixes as v2.

     Arnd
