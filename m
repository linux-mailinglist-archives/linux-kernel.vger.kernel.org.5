Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D479F278
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjIMT4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjIMT4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:56:06 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443749E;
        Wed, 13 Sep 2023 12:56:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C58285C00B9;
        Wed, 13 Sep 2023 15:55:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 13 Sep 2023 15:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694634959; x=1694721359; bh=Au
        7S+bvrJ+d82vNO8PIJNGeQjEr+YOnnXolYnyp87ig=; b=vf8n/0qzqaslYWD9Vb
        6zNsurOT7DroUO9m7Jq5tAM/GigHtH+prTFOGjDSsTbBuVqdLk0egPJ6o+w0FHjI
        RjaT/sp2jJFlWDUzpXjYyiz5huGcB/yTDnUZfPQPrGzIabWI1cpOi0O877Xt6Ts3
        6PLBpImePKmOmnCVzBt5KK29at/q9RzQJolZ/mTH1V86fmRcXx5/TWiFggKmFCXD
        JCVaEFEKhTpI0v5HU28dZyHuMiIWLIVETal1ag7K+b4uvuLsg2VEUQSXDQGlh4BM
        SeDHcfXvs/aBjehs6CuW9v84eRME+k+HiglcZg3FmzKE14eX67NDtYf73dZtPXCf
        u6vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694634959; x=1694721359; bh=Au7S+bvrJ+d82
        vNO8PIJNGeQjEr+YOnnXolYnyp87ig=; b=BtNjaCcIv+UHLvC69+cXZP27nTpn1
        FnS9Q6ca3vnZrGquga7rh+07xJZtsfhcrjwvU6P0KoffhIDa/xjRPh4KKePkIaze
        dcgG5/jzk7svTHHECmB9WoSLuisz0lLFFOkwTxIFSP6CGc5G9rrt37BeO2Q9STD9
        WROJQNa9QrL3LaNk2tOiVRnB2uYlpbkuGgmk+E3bBKUqNFGGU+tPxnC1WZq+/DUZ
        +S6eiBq9JJq3eC0PN+F/HF8HNAbZmFuSyvCLkI1C5Fn8NGIYOHtCJEVtuP5+Yrnu
        WcJ3iR8KsjoAqvDi0+ZtMScKeT0y8XSNWQA6cZf5Q+A0BJhkIXlYZEo+w==
X-ME-Sender: <xms:zhMCZSHYdNdTHJo7y2It8_tS7yEE51cPfW43WrSwygLUETNVhhSPRw>
    <xme:zhMCZTXIT9sGL-k0ygf9epOzqUKQJNrVhOAddQJ1B66vp5F2-SAnKqR0l15FqSJez
    wqDgIDXpNSW1WtpQ2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:zhMCZcI0FI25NjPGne0n_A5_BOzFAm_0wj2U6geaVsBjXx-NHaBjHg>
    <xmx:zhMCZcEuvFxaH1r6seUzp9TpsD7GEJnAMCYY8HeRmR_iO89gWo_Pyg>
    <xmx:zhMCZYUSUUJqepWmZibFTGhbObxzSY_6wBSzDjTqi3y77ZvpNvutoQ>
    <xmx:zxMCZcrRIdr9vEbpVQLQBbePJZvV1e-Z5cFFM4-cw512zYJ2Hhi3XQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 58DBBB60089; Wed, 13 Sep 2023 15:55:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <b234530c-88fe-4a2a-993c-f1733fe4d0c1@app.fastmail.com>
In-Reply-To: <ZQISGujwlH00B8KJ@fjasle.eu>
References: <20230913113801.1901152-1-arnd@kernel.org>
 <ZQISGujwlH00B8KJ@fjasle.eu>
Date:   Wed, 13 Sep 2023 21:55:36 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nicolas Schier" <nicolas@fjasle.eu>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Masahiro Yamada" <masahiroy@kernel.org>,
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

On Wed, Sep 13, 2023, at 21:48, Nicolas Schier wrote:
> On Wed, Sep 13, 2023 at 01:37:52PM +0200 Arnd Bergmann wrote:
>
>>  Documentation/kbuild/kconfig-language.rst | 26 +++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>> 
>> diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
>> index 858ed5d80defe..89dea587a469a 100644
>> --- a/Documentation/kbuild/kconfig-language.rst
>> +++ b/Documentation/kbuild/kconfig-language.rst
>> @@ -573,6 +573,32 @@ above, leading to:
>>  	bool "Support for foo hardware"
>>  	depends on ARCH_FOO_VENDOR || COMPILE_TEST
>>  
>> +Optional dependencies
>> +~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Some drivers are able to optionally use a feature from another module
>> +or build cleanly with that module disabled, but cause a link failure
>> +when trying to use that loadable module from a built-in driver.
>> +
>> +The most common way to express this optional dependency in Kconfig logic
>> +uses the slighly counterintuitive
>
> slighly -> slightly

Fixed, thanks

> For better RST compliance: could you explicitly start the code block e.g. by
> appending '::' as in "... counterintuitive::"?

Ok, done.

>> +
>> +  config FOO
>> +	bool "Support for foo hardware"
>> +	depends on BAR || !BAR
>
> are you sure that this is enough?  While testing, I needed to explicitly use
> =y|=n:
>
>     depends on BAR=y || BAR=n
>
> to prevent FOO to be selectable iff BAR=m.

I see my problem, I made a different mistake here. Your version
is correct for a 'bool' symbol as I had here, but the intention
of this was to make it work for tristate symbols, which are the
interesting case. I've fixed it up this way now, hope it now makes
sense to you:

--- a/Documentation/kbuild/kconfig-language.rst
+++ b/Documentation/kbuild/kconfig-language.rst
@@ -581,19 +581,19 @@ or build cleanly with that module disabled, but cause a link failure
 when trying to use that loadable module from a built-in driver.
 
 The most common way to express this optional dependency in Kconfig logic
-uses the slighly counterintuitive
+uses the slightly counterintuitive::
 
   config FOO
-       bool "Support for foo hardware"
+       tristate "Support for foo hardware"
        depends on BAR || !BAR
 
 This means that there is either a dependency on BAR that disallows
 the combination of FOO=y with BAR=m, or BAR is completely disabled.
 For a more formalized approach if there are multiple drivers that have
-the same dependency, a helper symbol can be used, like
+the same dependency, a helper symbol can be used, like::
 
   config FOO
-       bool "Support for foo hardware"
+       tristate "Support for foo hardware"
        depends on BAR_OPTIONAL
 
   config BAR_OPTIONAL

>> +This means that there is either a dependency on BAR that disallows
>> +the combination of FOO=y with BAR=m, or BAR is completely disabled.
>
> For me, this sentence is hard to parse (but I am not a native speaker); what
> about something like this:
>
> This means that FOO can only be enabled, iff BAR is either built-in or
> completely disabled.  If BAR is built as a module, FOO cannot be enabled.

That would describe the version you suggested, but that's a
different issue. Let me know if you still think it needs
clarification after fixing the example.

      Arnd
