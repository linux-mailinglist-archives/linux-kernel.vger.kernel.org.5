Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D1D79D304
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbjILN6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjILN6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:58:17 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2FC10CE;
        Tue, 12 Sep 2023 06:58:13 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E6A0D32009C5;
        Tue, 12 Sep 2023 09:58:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 12 Sep 2023 09:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694527091; x=1694613491; bh=u0
        LOjV4/r68tFCzvM24Co/ozHIjAyz4zQfSkl0FLEBg=; b=d+mGQw1Ly9T9uLz2Vk
        hZEOBfxMOs77+4b2CmBmbQu9P7hkvg7dNcuSTWa7THLIQwmzuUDiG5T2xIJk15Cv
        +ohb3UfGpf2HPMTIMx+/WhxsQwln4CRft+Ggwu9LpcKVmJzzTJj9mQfjMGRrfF2X
        k7YIXe5IOBuyfhNa7wH/Vko3QPPgXlhfJZlDW49mSEtfJHLyjXGIR9QeD/sxqvqB
        GzQc9mfTGEIv4nvO+j8tsT1K4kWWHQfQEyxEAs2jx4Q82M4LBJcgDqR57FwrhaAX
        BXv+GQMCxcNRcs0+x5aw5BnpRvtZqRX6abppA8w7ms5Ax9ww+LyH3IRxA8tnpPxF
        NX9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694527091; x=1694613491; bh=u0LOjV4/r68tF
        CzvM24Co/ozHIjAyz4zQfSkl0FLEBg=; b=lbstYHqx8k/ON7HV0MEVFi6KSOd4/
        FAELQBdu55FiiEfsWpJJNUXE4Sp1CjQZnO9lH6c+pPH7DR4dz9vPhfULva2p7QEM
        F/KPwPrdCbyGvVFrKg46rcSIPt2m3T+wWCZT2bJkZUw0PLX0g664EuWtLAJgnFAE
        b0VxvpnjwNAIrEKf7Cj24cqFFOvN4la6HfZVQI9MDhDK2qTKdtiFXNTog7i/mDjs
        Bbj4ZnF/kaQykI5NDn0jpjyfC7aW0j60OkftrIu7KvHm+j8WscezB9EIPpa3chAZ
        ZD+emIkUnGG9f8LcjXYdY9knmw9gbQkdr6t8tNj5akmhKeQFarZxM77xw==
X-ME-Sender: <xms:cm4AZXNcNZxGdLemgdGCkpdXaAH55WiFlYiGwhTXPDVGOjqTHcN4PQ>
    <xme:cm4AZR_Lwa8tcLAPUUOp-zb6sabtqN4985a6igUKRu0AnRPGPTSiGxoWRSXm2h01-
    FCnT81pnevg-b3pNbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cm4AZWSu9QuNfjfEalDzd50gXloFGHZ6ZWgmRK_HbxqUhG0NdlfR_w>
    <xmx:cm4AZbuEXJM_plfWeLiZ5CzCzj8uUqero9SyOfcVflHJ2oGLHXjMHQ>
    <xmx:cm4AZfdJTKAfkIEuCLk3BawiFSLtRpc-rhMIcJEDVd9Km_PhDuZoyA>
    <xmx:c24AZRtbQMCxqZAR51QznL-ueGVQmCgn9ihaA-r8Bzn9S9g893o26g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 55F2EB60089; Tue, 12 Sep 2023 09:58:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <d1d6b2a2-8be1-4269-a504-5762b94df77a@app.fastmail.com>
In-Reply-To: <CAPDyKFpUUJeGD77GTYCk59cvW=SdGTkOEXH4dap1JQWekAa0Eg@mail.gmail.com>
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
 <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com>
 <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
 <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
 <CAJZ5v0hqWYnkNXVju3U3n-9i8eqtjs197tLLNWv8Qa_N9T=KEw@mail.gmail.com>
 <CAPDyKFpXLj_2HAgyV_VJf+GPQVmxb_iiDe77Q2MY17MDNqy9fA@mail.gmail.com>
 <CAMuHMdVxLkxN0bmSRXW74R_dGNDSRDB4Z=zE0DoiXDOuweSM0A@mail.gmail.com>
 <CAPDyKFpUUJeGD77GTYCk59cvW=SdGTkOEXH4dap1JQWekAa0Eg@mail.gmail.com>
Date:   Tue, 12 Sep 2023 15:57:49 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Olof Johansson" <olof@lixom.net>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Sebastian Reichel" <sebastian.reichel@collabora.com>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023, at 13:28, Ulf Hansson wrote:
> On Mon, 11 Sept 2023 at 09:52, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>> And I just realized you moved the code and Makefiles to drivers/genpd/,
>> but not the Kconfig symbols and logic, which still lives under
>> drivers/soc/.  So resolving that (and the name) is something that
>> should be resolved sooner rather than later...
>
> In regards to the name, I am relying on input from Linus to make a
> final decision before I send a patch. In regards to this, I have also
> started working on a documentation patch for genpd. It needs some more
> polishing before I can send it though.

I'm fairly sure that Linus was instead waiting for you to send
a patch or pull request for the rename. Please just pick a name
that you like and that Linus hasn't already objected to and send
it so the rename makes it into -rc2 for others to base on.

If anyone has objections to the new name, you'll find out about
it then, but I think we trust your judgement here.

     Arnd
