Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71027AD853
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjIYM4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYM4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:56:31 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D9FC6;
        Mon, 25 Sep 2023 05:56:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0064D5C26F7;
        Mon, 25 Sep 2023 08:56:24 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Mon, 25 Sep 2023 08:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695646584; x=1695732984; bh=Gu
        YaxQnJLWNAfmB5LaJ/NWEiM96TNXNxEIYmi/0fQfA=; b=PqZbUoiAyGkzFKLha3
        Psvg7JkD+vdeOtZsc+v2Qtv5fzlZFsgi/RiWmOQabYiP7AzDSxvjC+NN3w9SVy45
        /Ck0yHNVq0kmP9Zj6ZxoADe4ETOIf1gBbgmdUJdEKs/EYHY3UukpfsbZZHtBC8qc
        1SWC48hL0qesGSlX/PB53rV1GOfI/27m12q9G8oNBJnqhI1gexDCAEB/acEfIhqp
        hV07Aq1gKn47czQTGlrIpURiNUWAuqIES3dEJudEajVfgVbccw1iuR4FMrMx8Z2U
        ChkQvhunKUpXApOs/KwGd0zenlfldjOmd+wGaVYHMsIUln3xYB3wWTMRzPJG1rRl
        ClOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695646584; x=1695732984; bh=GuYaxQnJLWNAf
        mB5LaJ/NWEiM96TNXNxEIYmi/0fQfA=; b=YizDOkAcYDPJNJIKsg0K5Xa5pYa3F
        6MvMQDB12OFvC8DDmu2Tmie4kerF2y6wpyyyxXt0wh5/TVyc5Wrouhcj/mSudzjG
        jmpA36KMdV4PkS0gSj9R05u9U9mS4hWebpMPqEPYK9458DIvaBnERdpF4jd8sNMl
        d/0vNSt/1eB6ni8ddjTe6SUWCDWuly7Aao2cxuMyZbroRt4HG3tRSRU9is+uYRLl
        UyPatJIbT8+Aj9mfa133KZf/KvNpn86Oc3V3CPNr7lxWLNAum354HOI5iuvxmbPL
        iBHYETn8evveD5HYqOm69tQdRfmxqBUPsW//Lw4/oEBzZjWWb5dVwu2Qg==
X-ME-Sender: <xms:eIMRZc188YaI18If8_Qi0hYPJBOurGH-1f4svv21vjCxeTDHHfu1HA>
    <xme:eIMRZXFt5IXq1MxSu01uk3IfDih-IM5az3pTX1XL3w-8AQKqVBtRcE8N7M2zEmsPb
    kpJSY2auUO4eMPouYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeivedtkeeftdefhfdugfelgeehieeivdefffek
    jeetuddvueeijefgjeekudevtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhs
    ohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:eIMRZU53IhaB_TWRcOGvjRTJGadg-HQHeLtDdNuC3hpildY0fACE8w>
    <xmx:eIMRZV1MqEjvvSVTqacPFM3Lh1nbeR7ZJPKTb3JmsGh7iHHhfyiiXQ>
    <xmx:eIMRZfHVQ2w-HVNxjSu2qd0c55A3N58R3Tqit6uHDQgXsRt2bG3GyQ>
    <xmx:eIMRZU6vmz7suZuPg1Oh-DggHz2EcWQgVuZhVHsxZ6QS-c0GdrBSzg>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 75C14C6008B; Mon, 25 Sep 2023 08:56:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <de3914ef-6f35-47c2-b2da-a509c775ebd8@app.fastmail.com>
In-Reply-To: <e86b094a-f55a-4bdd-9d98-5710567c54cb@kernel.org>
References: <047d3c51-0a9e-4c3e-beef-625a7aa4f3c3@kernel.org>
 <505264f5-cbbb-4ffe-a3e4-93d2397e80da@kernel.org>
 <beeab87b-820a-475a-b0c6-99b1b8e491ea@kernel.org>
 <207922c7-7a56-499b-bbfd-9e8d6a0a06df@kernel.org>
 <74ad10fa-f0f6-f80f-7db3-fb01aae6f2d5@redhat.com>
 <e86b094a-f55a-4bdd-9d98-5710567c54cb@kernel.org>
Date:   Mon, 25 Sep 2023 08:56:04 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Jiri Slaby" <jirislaby@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: Re: WARNING at drivers/acpi/platform_profile.c:74 in platform_profile_show()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Hans & Jiri,

On Mon, Sep 25, 2023, at 5:15 AM, Jiri Slaby wrote:
> Hi,
>
> On 25. 09. 23, 10:57, Hans de Goede wrote:
>> Jiri, Thank you for all the debugging you have done on this. Can you please file
>> a bug with the details / summary here:
>> 
>> https://bugzilla.kernel.org/enter_bug.cgi?product=Drivers
>> 
>> Using Platform_x86 as component so that Mark has all the info in one place ?
>
> Done:
> https://bugzilla.kernel.org/show_bug.cgi?id=217947
>
Ack - replied to the ticket with details. 

We'll need to debug what is going on and I think I need a patch to improve the PSC vs AMT mode detection (and handling the error to....)

Mark
