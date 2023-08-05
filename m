Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E5C770F2E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 12:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjHEKEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 06:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHEKEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 06:04:52 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C503944A0;
        Sat,  5 Aug 2023 03:04:50 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1C35532000E5;
        Sat,  5 Aug 2023 06:04:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 05 Aug 2023 06:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691229886; x=1691316286; bh=Oa
        pval07/RcASiQ/IjJUx0o7BkKn8DpbMkWvORW7A8o=; b=eBHBQgrzlgEGha23yE
        h5XJ2UnnCtSgKAdVywiCqrIXT7eiiwagNJSYM6a+iYskE1Ko1fTdSk5hV/Vg24B4
        B4t8N6gdxumkv4DqvbyhbF6VzuAVkcW5sxTb/MNk0MaoEn8wTSErq1mpxBkp89TD
        WIYWfPfLJ4eqXSHGmUYTtJY1S+dYIGVetVM4+eLM/EQiOsnPbXCGl5GL3hMsGIR4
        2M6TUI+x3R0FTDwSsRuO71JhvIeqEDsOmt4L70kEdKdgCyed75Xdpj5y5rd9bD/R
        YElL4mX73KfeHx31ZJg30G2uSuVegTaJAg0QVRKuvnMK9mcTc7Tw+Irr/KSg15PU
        jvCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691229886; x=1691316286; bh=Oapval07/RcAS
        iQ/IjJUx0o7BkKn8DpbMkWvORW7A8o=; b=TSgMlRz1CsGhs6m9vx1Bmst5QKQK/
        HINKKyr8vp1FXUbZPJjNg81NU7gPXJtB2yZ07Xu+jiwX70t1RLOj/GrF4XsaD7W3
        oelakMM301Skew51tkrrA7VbhrRYKnvjWBIlDztSt/Y11DYUNJZVytgRxXcwXPse
        VBTwYxquFnJKXlhyMJOGrl6O+CPIjjomzq3IOaBOlw4fvWUkiGurjrcmSrjRH300
        rft6r4zzTAZengp8Uo0ABDhzA9Ou8wWOhx2sDOTRTXLo1/tavDr4tdvzNtx3h6fO
        y2JjUSFWmSTK8R9gEv6Y5hj5Amzc3jRg2uuIYlAt6B8C5IfiaTlHMU89g==
X-ME-Sender: <xms:vh7OZFJ8M6yWCgiLqWf5rThS1X9jF5KySyX6rdZ4PFAaquMsJ_Pq7A>
    <xme:vh7OZBK3K5OdiDgXwTDndsYnYT7UFTXaXqTSuhTWaxtougZGj6DLoizSgGPh5tJwc
    a2AgxIWcqJX_9U3Ajw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeeigddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:vh7OZNt2D0gUEC-zoXNSBJiDVLfgMy86LMgHM6tohOkZeksp4py-5A>
    <xmx:vh7OZGbJJVTAE7oDryhtPSuo7oEYzcERZwMFiKvsnVutQK3ytM5lHg>
    <xmx:vh7OZMYoVCFHUHEc5_aVcOI7ACJiiWHeiuTtceJbA_397COu51S1jw>
    <xmx:vh7OZBOaoOC8RPgkis_6hKh5yG9znHF5Fepxjc2jvDXWRbHuE2S_LA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3DCB6B60089; Sat,  5 Aug 2023 06:04:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <9b8abe84-80be-4e16-8792-92ae101187f3@app.fastmail.com>
In-Reply-To: <2023080514-mothball-chaps-2b42@gregkh>
References: <20230805095157.3459892-1-arnd@kernel.org>
 <2023080514-mothball-chaps-2b42@gregkh>
Date:   Sat, 05 Aug 2023 12:04:24 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        "Rajat Khandelwal" <rajat.khandelwal@linux.intel.com>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: intel_pmc_mux: select CONFIG_USB_COMMON
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 5, 2023, at 11:59, Greg Kroah-Hartman wrote:
> On Sat, Aug 05, 2023 at 11:51:53AM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> It is possible to configure the typec drivers to be built-in while the
>> actual USB host and device support is in loadable modules, but that now
>> causes a link failure because the usb debugfs support is then not
>> available to built-in code.
>> 
>> x86_64-linux-ld: drivers/usb/typec/mux/intel_pmc_mux.o: in function `pmc_usb_init':
>> intel_pmc_mux.c:(.init.text+0x3): undefined reference to `usb_debug_root'
>> 
>> Select CONFIG_USB_COMMON to get it to build again, as we do for
>> other drivers that require the core usb functionality.
>> 
>> Fixes: 0a453dc9f2602 ("usb: typec: intel_pmc_mux: Expose IOM port status to debugfs")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/usb/typec/mux/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
>> index 784b9d8107e9b..65da61150ba78 100644
>> --- a/drivers/usb/typec/mux/Kconfig
>> +++ b/drivers/usb/typec/mux/Kconfig
>> @@ -29,6 +29,7 @@ config TYPEC_MUX_INTEL_PMC
>>  	tristate "Intel PMC mux control"
>>  	depends on ACPI
>>  	depends on INTEL_SCU_IPC
>> +	select USB_COMMON
>>  	select USB_ROLE_SWITCH
>>  	help
>>  	  Driver for USB muxes controlled by Intel PMC FW. Intel PMC FW can
>> -- 
>> 2.39.2
>> 
>
> I think this is already fixed by commit ef7c4d8a90c6 ("usb: typec: mux:
> intel: Add dependency on USB_COMMON") in my tree and will be in the next
> linux-next release on Monday.

Right, adding a dependency also works.

I tried to avoid mixing 'depends on' with 'select' here, and
(almost) all the other users of USB_COMMON use select since
this is a hidden symbol, but practically speaking there is
very little difference since you wouldn't actually want to
have the typec support builtin without also having USB builtin.

      Arnd
