Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFDC7F33F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjKUQjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbjKUQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:39:15 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C6F18C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:39:11 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 40A145C0E58;
        Tue, 21 Nov 2023 11:39:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 21 Nov 2023 11:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1700584748; x=1700671148; bh=Ji
        UVdlrEvaHu0sHmihfH835MAMKCNCUpHv52O2V7y1c=; b=i+WUtg4vSQahMn7z09
        kzlnh4K6aoM4poxACv9qhNsnpNDlisCSiMJl0IwrRzp9GznTg/ic08o5n6fUW2H5
        ihUmw4PbOW3CEj0c0QY7y04YlQ1Q//k3wMKDz+yGMLzlPD/Pq0zFLWHo/DXBJzf7
        WXAQ/lh/hpz3T/Z3s1NP9Dx7ZYVj+cA7j9nH5rOYYNCIoO/6juRWGNfhfcME4kgo
        b/jpS1YpY79iS6LmCVDU0iI8zSFRe1Jw02sNIY559u5lZAgT8TqeDoxMa0lDJAsj
        2ThHFPWqFlffi9Bk2onlQxkDStBZrzo9lHi14JjFNZvl6nC1y28QkadQKAF4MXFG
        CNiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700584748; x=1700671148; bh=JiUVdlrEvaHu0
        sHmihfH835MAMKCNCUpHv52O2V7y1c=; b=KKhrQzhtw1x++z2fRxXKOnmdGKphq
        DtdqA9kcGDdR7zUZH/82eiYRBVSb1iio28btFz7+ynxo4NyqCf9LsuqFMqGSxLTc
        VtRDXAn6UlPM7yCdrgwZbkZoaxMDB++GepcDtY0emnPeoA5SnnElbfrh8CON/7Iv
        yzImx6F5ZD54ltqeA+prCS90xApgbTWoruFtidk1513LDbx0V/R2H7yUPA6OHGnJ
        NOb5if0ZuFHbEUs/0pE2RnF3R8Abb7T/dGXKCOgsyBT5qjXzNzCh4ILOM9LWzsua
        lzqZaPkiqAbKt4objCEM5G0gEa2fmNXMLN3F2YdNqoqn7rsZxqnh8ugiQ==
X-ME-Sender: <xms:K91cZVFDT3-4JJYWuFx0xQdk9zewAkRhsS1WGQxDgP0H7EeD5t4MXA>
    <xme:K91cZaWL3P919SW72Wa3CZ0Uw5YRfTr3jogfNSYyyfg_AVZV-PTvErm311TaRAQqM
    fWoNSLQJAvgVt0LNpM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:K91cZXIL2t_7g4i-UQUDh2WwHSwg_Cew-qmw586QTgP3-xw9hcvKeg>
    <xmx:K91cZbG3GuRdgFt0nuJcsZSp4CNKCElZOT7ZXudOGMzdCdKz_SMkvQ>
    <xmx:K91cZbUA2TH0v7MB2zKk_RtVdFbDne8uV2JyOW6qKHCToWHBwyefMQ>
    <xmx:LN1cZRdqrD4U_R7jrq6ZdSHnQjH9vmiGwyF4TuHqdJ0oVlIIlAYH4g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 619FEB60089; Tue, 21 Nov 2023 11:39:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <0e298e03-9793-414b-b666-85030023fabd@app.fastmail.com>
In-Reply-To: <20231116133638.1636277-1-hca@linux.ibm.com>
References: <20231116133638.1636277-1-hca@linux.ibm.com>
Date:   Tue, 21 Nov 2023 17:38:47 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Heiko Carstens" <hca@linux.ibm.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Remove unused code after IA-64 removal
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023, at 14:36, Heiko Carstens wrote:
> While looking into something different I noticed that there are a couple of
> Kconfig options which were only selected by IA-64 and which are now unused.
>
> So remove them and simplify the code a bit.
>
> Heiko Carstens (3):
>   arch: remove ARCH_THREAD_STACK_ALLOCATOR
>   arch: remove ARCH_TASK_STRUCT_ALLOCATOR
>   arch: remove ARCH_TASK_STRUCT_ON_STACK

Nice cleanup!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
