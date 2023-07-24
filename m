Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5058075FF12
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGXSaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjGXSa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDDF10F4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB56F6137C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 18:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACAFC433CA;
        Mon, 24 Jul 2023 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690223424;
        bh=3OLBTMSOJRIwQEOVOkXhMXAkKS9fIT/wK5Tbk1j9iKc=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=tGePP/KJI1UFlPXqU57Xltzypihz8jeqTQdwaxFF3MzEJeerl8IA6+0Mad2lKzn2n
         kN1rGG09/F6cbJejkHLgQezYjUB14cJKUuRYmOdZLWQQmr+CCSOR3id1BNZl6Xjlus
         3ff7X1R0Hffnj+1v9l9uu/OTeiUaSSrKwyzg0SCtgA0rA9qIk1B2/mFTD8VwfDWzDL
         4N1/7bcoBlYHIZE8IARGR3xBf8c7agG7Pny6lF9vF/7aHVe+vWO5iUsS08sRLxQEUM
         +qOkjlVxSXy4yA1QxESRJsniki0NY2a925ddjSkACtmVDTA2DCYyEVRYREHNv2mQbb
         ZKueaOaqEAy3w==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4CDF227C0054;
        Mon, 24 Jul 2023 14:30:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 24 Jul 2023 14:30:22 -0400
X-ME-Sender: <xms:PcO-ZGvz6JGwtYZFzQeuDp67pJfzzB-d9XkTKW_Vaq1VD10Xbaulmg>
    <xme:PcO-ZLfie-P9__RpvnV-IRD_kWaTzvWnvU29oXhH79R05ABYj82EP-OT6ezPmY8sQ
    FB8ZDSnjTEAOf3DEjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheekgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnheptedtvdehheduhfejuedukeekfefgfedtgeekveeujefhvdfgleeuffeh
    ueettdegnecuffhomhgrihhnpehgohgusgholhhtrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnh
    gupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:PcO-ZBxKhNNLPmVRxpNu8XsEomV702tn3K8xZ-hVRZ6MWOffzP0ePw>
    <xmx:PcO-ZBMinMhiXCgNBDg_aFeuLcZrrV5oko106-69EmaRIiMpkG7qCw>
    <xmx:PcO-ZG9Y39Bh2XRaAAaWdsmGyNn51yFq8-sFSf0HpO99O91S84MoHA>
    <xmx:PsO-ZBfYJBYt4CL2WfWYTzZxA-t7-GLZrNkMvq4GW996MPQrbSPRRw>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 227CCB60089; Mon, 24 Jul 2023 14:30:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <39444a4e-70da-4d17-a40a-b51e05236d23@app.fastmail.com>
In-Reply-To: <679d8d63-ce92-4294-8620-e98c82365b2c@app.fastmail.com>
References: <20230722074753.568696-1-arnd@kernel.org>
 <CALOAHbCV2v3X7g1TD42yve0juhRD2vhq=DMtDz9P6+mX8Dae_w@mail.gmail.com>
 <CAADnVQKGe8DN+Zs387UVwpij3ROGqNEnc5r940h5ueqQYHTYCA@mail.gmail.com>
 <fa5e9098-d6f9-48a2-bb77-2620b6bb6556@app.fastmail.com>
 <CAADnVQ+p4wpd=tKJAiwB34O1y5vv4mibtkt9D-F7sG=rQapcew@mail.gmail.com>
 <679d8d63-ce92-4294-8620-e98c82365b2c@app.fastmail.com>
Date:   Mon, 24 Jul 2023 20:29:59 +0200
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Arnd Bergmann" <arnd@arndb.de>,
        "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc:     "Yafang Shao" <laoar.shao@gmail.com>,
        "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Hou Tao" <houtao1@huawei.com>,
        "Martin KaFai Lau" <martin.lau@linux.dev>,
        "Song Liu" <song@kernel.org>, "Yonghong Song" <yhs@fb.com>,
        "John Fastabend" <john.fastabend@gmail.com>,
        "KP Singh" <kpsingh@kernel.org>,
        "Stanislav Fomichev" <sdf@google.com>,
        "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
        "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: force inc_active()/dec_active() to be inline functions
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023, at 20:13, Arnd Bergmann wrote:

>>> One difference between gcc and clang is that gcc tries to
>>> be smart about warnings by using information from inlining
>>> to produce better warnings, while clang never uses information
>>> across function boundaries for generated warnings, so it won't
>>> find this one, but also would ignore an unconditional use
>>> of the uninitialized variable.
>>>
>>> >> If we have to change the kernel, what about the change below?
>>> >
>>> > To workaround the compiler bug we can simply init flag=0 to silence
>>> > the warn, but even that is silly. Passing flag=0 into irqrestore is buggy.
>>>
>>> Maybe inc_active() could return the flags instead of modifying
>>> the stack variable? that would also result in slightly better
>>> code when it's not inlined.
>>
>> Which gcc are we talking about here that is so buggy?
>
> I think I only tried versions 8 through 13 for this one, but
> can check others as well.

I have a minimized test case at https://godbolt.org/z/hK4ev17fv
that shows the problem happening with all versions of gcc
(4.1 through 14.0) if I force the dec_active() function to be
inline and force inc_active() to be non-inline.

With clang, I only see the warning if I turn dec_active() into
a macro instead of an inline function. This is the expected
behavior in clang.

     Arnd
