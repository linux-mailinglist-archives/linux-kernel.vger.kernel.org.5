Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B7F7E6E6E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjKIQRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKIQRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:17:04 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F5B327D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:17:02 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8A4273200B55;
        Thu,  9 Nov 2023 11:17:01 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 09 Nov 2023 11:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1699546621; x=1699633021; bh=PQ
        f1IjlBiaWTXL/MSmgJ4R3niRo5KcteWPLIEhuZV4Y=; b=zgpeD2JYMc5SPwUHzu
        Pof7jAo/5gN9bcc1pDpZJA0qB9GEiXv3CEp4nM9THNYymda7c8+/4Tjr9w602DxV
        4iRB0wLTUBQY77BcoykGGg44OjY1nUZcvVMPWfUngAy7x8H28T8Rbo42DYkloHIR
        5eguTP/5I+G8GxgtP5SfASJUIDIIO8cfSNNtFRHlyMeDB61CCQBb0MAhRnsEYYTn
        h1BAUQ0gKOVkVpAxMRR8HTsj4FlZlYr9w4S3Nm3Jz41Wn8Y5b0j4bpPkB0dtZjVy
        vGC/zcCp5NNhIxl/z6wypjJYGvd4OtCbV6tqLN9eHEWwQhHIYM6yXMhZSXTKoffG
        0v0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1699546621; x=1699633021; bh=PQf1IjlBiaWTX
        L/MSmgJ4R3niRo5KcteWPLIEhuZV4Y=; b=NJin3/PQTv2Wn5RwRP/E+qY7EsQF1
        NHPTnXzyqFJDVF2eZrUWJyN9BHuM1WXWYHD+l4IY6gNhOKlErRimzO1uC92UsPMv
        i55uL1Vza5fVH9PLoM/Fcf7T4KLH1jZLjDGhtTQqodRZHYAGDijAHu4BifGqTijx
        SWCgcsVOiijmixYKK0i6HE1ZzGP7lpzK/VxZIUYlBBS8kkWQxxY0hQ5cmRs1j3tt
        50A077uhQ76osOqmmqst0KalWUlqftr4vE4PJZkC+V2k4fjLtHieE12cnCtheGHP
        LxBsD5LUGgAzvrnuwWY9MjeMskp4SuAjNWtkuaxjkqydDtfroa28KnqXA==
X-ME-Sender: <xms:_AVNZcYNYtBa9jc18A3uagMXdd4TfUR8T2x15sRxm8of1r-q55iEaQ>
    <xme:_AVNZXbdnYAKIcaghggSUHl5ptpsGLexRCor6wbbWpZxwRlSMIwqGnPIzTtykzecK
    6md80p_B2GGjj8Otgk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvuddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:_AVNZW-nVwzhwt4ntxzySIDvKUQ2JyfdH5dc6ABgGKoKeN_OA4xy9Q>
    <xmx:_AVNZWpw9-LUbJDTWp9qfX_bQtGSraU0qE4X-eY2pBsgZcmzHW_5og>
    <xmx:_AVNZXrdVbwx8nMfaqnYkIwAgeYnDasifW61yvsrOwUBlxaccxZtAw>
    <xmx:_QVNZWXPWxpB4bIqn9jgZ1t5uvPlvnXjq9Sb_EBxxUn6LolIcciVvw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9EF65B60089; Thu,  9 Nov 2023 11:17:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <99645251-1ab1-45ce-ae6f-806a966a26fa@app.fastmail.com>
In-Reply-To: <20231109141153.250046-1-kevin.brodsky@arm.com>
References: <20231109141153.250046-1-kevin.brodsky@arm.com>
Date:   Thu, 09 Nov 2023 17:16:32 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kevin Brodsky" <kevin.brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v2] arm64/syscall: Remove duplicate declaration
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023, at 15:11, Kevin Brodsky wrote:
> Commit 6ac19f96515e ("arm64: avoid prototype warnings for syscalls")
> added missing declarations to various syscall wrapper macros. It
> however proved a little too zealous in __SYSCALL_DEFINEx(), as a
> declaration for __arm64_sys##name was already present. A declaration
> is required before the call to ALLOW_ERROR_INJECTION(), so keep
> the original one and remove the new one.
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>
