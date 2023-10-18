Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27707CDC27
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjJRMpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjJRMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:45:03 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5AC98
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:45:01 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0795F5C02E2;
        Wed, 18 Oct 2023 08:44:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 18 Oct 2023 08:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697633098; x=1697719498; bh=L/
        /WJax4brKzE8K7jlKJOqfsX92u6DaWmDWFcr+tAL8=; b=qYyY873Dt2zfjzazma
        nNumniuOGs+QnE66R8Qw7LXa1+z9SCRvo+dMkr17AHe+reNoSTFV3yo3/TcyH75E
        qDgQZDtsM008s8kQyV4qV1NuHEC8//U96z/HedW/G78+IMf7sl8dXbWswjhsZELG
        nebAjcMP8GI8M56Dx0OeC3Nb/HW4Tsi716ecclcRVvRNRTqNFPUt/E9ZtlLmNTCx
        NGjy3H7ZKZkeEVHBC6NCY2BwIdsacEBM7lKEKYNGAYc+SqRsW1Tw38/k+BARVAQG
        /A84IRDVI8iKvLnpcJqAV2rexGBogHbezzFIs0Nkt2aXL7+nJyNqSMu6uabRXEA6
        Hhiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697633098; x=1697719498; bh=L//WJax4brKzE
        8K7jlKJOqfsX92u6DaWmDWFcr+tAL8=; b=A/NkEeWRcrtfFAAUpsMK5GrpinDVT
        eIAmNsl60iPZ2tWGKUnQSriCq3Sg7iRDOpYMnUU5pFR346syIDPWEq6ITbZGDAkb
        0oBmatvLu5A39KsvTbEPlt1zJzTaBJF92fMazM15k6IkLWEEUbP1/hk6NNuj1ZcM
        KHookJ8wMYcnXEYhO9F0eGX+36DvChIhaRd+boLeHfN1ucbaiTHkf0+i32vy1w26
        KnsNW0VVCiRlbCIPKIWfPCIoBfudWQNDhJknaoN6mqxu/2JWj+DIm1FPc1BscGzb
        cb4lnmxXSxqdqqS50gU4l1GD4Py3OQ4OrLA+4qp68lVMAEko1WlVJWykg==
X-ME-Sender: <xms:SdMvZVTEat_lgSzFjC6-pQ0aZwl9hHop8KdyWNVp9DKMTs8_CHoLLQ>
    <xme:SdMvZewrPypTt6AY3bBLyM6BWPhzZbD7tYhoff6xqG12clNy3CRYqr_4FNk9jvsDp
    cZe2y5w0ZyESylFGbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:SdMvZa0TTNu8XS1hAfOu2EmlSofw3fX370cbiIYmQZH53dwtF66Rng>
    <xmx:SdMvZdA6cScNXFeIa4WPTvjXQADBwE8dlDYWZqodJGJdAobdrH47JA>
    <xmx:SdMvZeiuEFoA5v5z2tmMzjW4UUQiDHUGjJp4-yvm7OM22Y_Ubvs2KQ>
    <xmx:StMvZWfDZsdz_fKuzeJtFAkqNa1kVKtlxakAAULe7J_N_ZCwPAJcaQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A1D67B60089; Wed, 18 Oct 2023 08:44:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <da4985cd-43db-4957-b841-7b8f6bf8f885@app.fastmail.com>
In-Reply-To: <20231018122729.GA18556@willie-the-truck>
References: <cover.1697614386.git.andrea.porta@suse.com>
 <20231018122729.GA18556@willie-the-truck>
Date:   Wed, 18 Oct 2023 14:44:37 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Will Deacon" <will@kernel.org>,
        "Andrea della Porta" <andrea.porta@suse.com>
Cc:     "Catalin Marinas" <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com, "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH 0/4] arm64: Make Aarch32 compatibility enablement optional at boot
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

On Wed, Oct 18, 2023, at 14:27, Will Deacon wrote:
> Hi,
>
> On Wed, Oct 18, 2023 at 01:13:18PM +0200, Andrea della Porta wrote:
>> Aarch32 compatibility mode is enabled at compile time through
>> CONFIG_COMPAT Kconfig option. This patchset lets 32-bit support
>> (for both processes and syscalls) be enabled at boot time using
>> a kernel parameter. Also, it provides a mean for distributions 
>> to set their own default without sacrificing compatibility support,
>> that is users can override default behaviour through the kernel
>> parameter.
>
> I proposed something similar in the past:
>
> https://lkml.kernel.org/linux-fsdevel/20210916131816.8841-1-will@kernel.org/
>
> bu the conclusion there (see the reply from Kees) was that it was better
> to either use existing seccomp mechanisms or add something to control
> which binfmts can be loaded.

Right, I was going to reply along the same lines here: x86 is
a bit of a special case that needs this, but I believe all the
other architectures already guard the compat syscall execution
on test_thread_flag(TIF_32BIT) that is only set by the compat
binfmt loader.

Doing the reverse is something that has however come up in the
past several times and that could be interesting: In order to
run userspace emulation (qemu-user, fex, ...) we may want to
allow calling syscalls and ioctls for foreign ABIs in a native
task, and at that point having a mechanism to control this
capability globally or per task would be useful as well.

The compat mode (arm32 on arm64) is the easiest case here, but the
same thing could be done for emulating the very subtle architecture
differences (x86-64 on arm64, arm64 on x86_64, arm32 on x86-compat,
or any of the above on riscv or  loongarch).

     Arnd
