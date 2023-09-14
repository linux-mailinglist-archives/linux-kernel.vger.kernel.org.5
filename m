Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD4F7A0827
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbjINO5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjINO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:57:39 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23221FC4;
        Thu, 14 Sep 2023 07:57:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CBC0B5C0038;
        Thu, 14 Sep 2023 10:57:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 14 Sep 2023 10:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694703454; x=1694789854; bh=b3
        xpuzvbHNjxv61zz3MVlBvBWyOKTXmINDDHRQ8CTMw=; b=wb2p03v9aPPh87+rBv
        pkGpIB7l4Xml1K0FHgKkh37lUL9/v6cQcKA7g9ypZrRBXUim1zo8PCoOuULcD/N7
        mwefwBlIRNY0Ja68qrRtLqR6F0QiUvUzX74exPQ6JxX7tM3hbELfw4Qg2+H6MId9
        WiPIW2HoH0s0RweSnqYeUixe5yRdfuAVlveGn3I5cA1eT2qlQOeEe5xz+K3uAnIe
        Pql2swbl77acKsNbk+4xfethYJ6KfPE/UBxDG+Ij5VkzzWSptUBGJfE/CnCVVbm9
        rstykJpUbNkGI860P2e0ZjlEPxS8e1K5bAWDrNor0w753ANyybp4TnGBW+HEToPU
        BB5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694703454; x=1694789854; bh=b3xpuzvbHNjxv
        61zz3MVlBvBWyOKTXmINDDHRQ8CTMw=; b=CvgV8kN7zHzmHV/Zb83J1b/+TEPnT
        iEcl5uMo5f6duukYRJrUa8EL8LiY0ngC4mG8RqTkCnVBzczCWGUGzmkvxBwbHubY
        L5SpbFN6whqz5wrMz7Ri2fiStOraLyne4akkGVnpQWAgmhd3iGPN43uJ4ncNt2qV
        eZKrBidbfyXhN/lhK+i0pPVNd+LjZdbiofujB8HBi37KzM9aTwyIPtCT4Qu2cM9p
        IBi9gcNJ1f/POIsMs/vJG84Y2NTarlIvHp5Y5/fah9lsLQ/A7UW6F6d9g1ogby/V
        Bgtnjipo5T+SXTLwDeM7Y1eCYSDoiRd3VrzxtiMe5RvaxiJropQ1giQEw==
X-ME-Sender: <xms:XB8DZW5R_OYERRrnaFgYLt1BHSJdmiwsEDh4tpOxXT2JGzF5PZAmFw>
    <xme:XB8DZf6b9cd4czfkb4T4-5OCE7O_62nMpJlrJy-545H2mieARtW4M4bLRi-gilSx7
    VT0sS1Wl4l-8D-9Ses>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejtddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:XB8DZVf3QdfhC5zkMs11YhiZ1FfQmSgEhmCdwHlh7rCXOi6PqLOkoA>
    <xmx:XB8DZTLmZabo_639GOt-q4V76iWmRnW7lw238bw0jEktRGEiuSnOWQ>
    <xmx:XB8DZaKzjzTMQTnCtulmglnr6sqn5UgPPciekVoqboadmI4cIyNDEQ>
    <xmx:Xh8DZXX3aDcG3MWG6pPOxZk2vDyCums_G75Dr-koq_iRkbc3I6nk7Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 61884B60089; Thu, 14 Sep 2023 10:57:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <b2723c56-e2b0-4871-afbc-73cf6335ddca@app.fastmail.com>
In-Reply-To: <874jjwx44g.fsf@intel.com>
References: <20230913113801.1901152-1-arnd@kernel.org>
 <874jjwx44g.fsf@intel.com>
Date:   Thu, 14 Sep 2023 16:57:12 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>
Cc:     "Sakari Ailus" <sakari.ailus@iki.fi>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional dependencies
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023, at 15:42, Jani Nikula wrote:
> On Wed, 13 Sep 2023, Arnd Bergmann <arnd@kernel.org> wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
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
>> +
>> +  config FOO
>> +	bool "Support for foo hardware"
>> +	depends on BAR || !BAR
>
> 	depends on BAR || BAR=n
>
> seems to be an alternative that's about as common:
>
> $ git grep "depends on \([A-Z0-9_]\+\) || \!\1" | wc -l
> 109
> $ git grep "depends on \([A-Z0-9_]\+\) || \1=n" | wc -l
> 107
>
> Maybe worth mentioning both?

I fear that would add more confusion than it avoids:
"!BAR" is actually different from "BAR=n", but
"BAR || !BAR" is the same as "BAR || BAR=n" here, and
trying to explain this in the documentation would either
make it incorrect or unhelpfully complicated.

      Arnd
