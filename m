Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B678114F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442068AbjLMOmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442070AbjLMOma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:42:30 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F9F110
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:42:35 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 28F255C0390;
        Wed, 13 Dec 2023 09:42:35 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 13 Dec 2023 09:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :subject:to:to; s=fm1; t=1702478555; x=1702564955; bh=OVSNA+BdZu
        m4Tz3TYCIfm1qENk2cCEW0De/bPxDKBSQ=; b=ovNt2DU65SkVLlXZztVipu6UmY
        tDczggpBOk509ofkcBZ2OZx6xUNj+2tsuWr0L/tQeqp0e77CQxuewyaz4tvYOQON
        /cwShgwKYypRiNkUtDMXeURp8yqSsMT3e2UOJc/IoQSchqGIi3oGBt3ps6XYfJ1+
        FEz/Zi0vqBvY8lSvQYqfDZpX17YMaQTPBL045lVrHPfQlSd7nAtd0tI6FuoAfXXX
        vQ5yq7AXhgL/4ssEBop3C/6kZ7WSBv8cfflWMCy0jXTXNg/FIIToRRN6Rpj+hN9w
        QoRUi94/n/+Vp1bF0eo0PS69NIGqjTsjx+ltS4exeBjRPDohrlGPZ37bImww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:subject:subject:to
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1702478555; x=1702564955; bh=OVSNA+BdZum4Tz3TYCIfm1qENk2c
        CEW0De/bPxDKBSQ=; b=Eu3l7oh5QM5SbASWbINGgegMqCVBo7mwcg9c/Ta9cwdc
        fs7ORaAHR/FCNorfFQXIJPJc8KIH4NiKrZRIi6HLMlDEltIbVjsCYFP7t7GUuqRq
        lSqLsskYKckcMSm2KIwV6AhmRmTFN7uXMUuv0N9nWuXoBmOpEGozDSVrDZW+uwhN
        8NqIXIl/zO+JbK9qCVZKEWvm0gTdkGd6HOprpWYWrIOynpAv/LIKWgiKrBcmWPDb
        bwLDvvjI1TS/QIjaInyKzYCsQpBeVxEQMnigGJ79x7N1np6mNCD7KVkk0K7mN3fJ
        e8cdiU4aOQFeN8PWkcHBJGiX+YrVZIhBf7DzTjY6+Q==
X-ME-Sender: <xms:2sJ5ZcrakutNjnPLeiA7OCU14gm7sxVQZVEAqc9F2YqeOFHBdJ3rZQ>
    <xme:2sJ5ZSrARmRrEP1b-Xd-p1LkErRFWINmRLbTluLudLR0y7QySPFtFPnYFWYenHHgR
    8i-1Yerc0S_WV2LbnI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeljedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:2sJ5ZRPm3cwKgis1NhmWnPT6_ZtFCUVS9iDa5UWXvfEZjXdNrJCeqg>
    <xmx:2sJ5ZT50l2-xv2OTqIQmpA7pHne9_IS2G7tc5reAXZmX6_bK1mf4Ng>
    <xmx:2sJ5Zb72V79aDk_z-XsVcpsMGORyD4BKAHJYgIX3TpT-7n-oTn4k1A>
    <xmx:28J5Ze3oktVHQgIaNKa9dBeV1l7UJVjKPCpoi_Wide4ZxxvJ7XfAnQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BD050B6008F; Wed, 13 Dec 2023 09:42:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
MIME-Version: 1.0
Message-Id: <af1f937b-37e0-466d-ac94-4f57e086f326@app.fastmail.com>
In-Reply-To: <ZXmtqc7fTeZbRW5B@kekkonen.localdomain>
References: <20231213124310.761638-1-arnd@kernel.org>
 <ZXmtqc7fTeZbRW5B@kekkonen.localdomain>
Date:   Wed, 13 Dec 2023 15:42:08 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Tomas Winkler" <tomas.winkler@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Wentong Wu" <wentong.wu@intel.com>,
        "Alexander Usyskin" <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mei: fix vsc dependency
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023, at 14:12, Sakari Ailus wrote:
> On Wed, Dec 13, 2023 at 01:43:05PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The Kconfig dependency in the new module is reversed from the dependency
>> on the exported symbols, so it fails to link with CONFIG_INTEL_MEI_VSC
>> disabled and CONFIG_INTEL_MEI_VSC_HW enabled:
>> @@ -64,6 +64,7 @@ config INTEL_MEI_VSC_HW
>>  	tristate "Intel visual sensing controller device transport driver"
>>  	depends on ACPI && SPI
>>  	depends on GPIOLIB || COMPILE_TEST
>> +	depends on INTEL_MEI_VSC
>
> Oops. The dependency indeed seems to have been reversed.
>
> Could you also reorder the entries so the one that depends on the other
> would be below?

Update: I actually misread the code and the original dependency
appears to have been correct. Instead there is a different bug,
so I'll send a new patch after I have done enough testing on
the new version.

      Armd
