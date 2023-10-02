Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F6D7B52C7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbjJBMQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbjJBMQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:16:01 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B766AB7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:15:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 56F283201213;
        Mon,  2 Oct 2023 08:15:52 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 02 Oct 2023 08:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1696248951; x=1696335351; bh=N+N+eDyJwbmWM7IQgkOKLUE0MMGHc0rbju4
        i4SQwITA=; b=o1r4Xi4XRpANR4t1+OSUZfhXOPXLnO41r7vbPsDeVb/+vEdcfs3
        zx9fvT7d+ZpTFILgo8Br49VSu2yNjOWgIxiJW0O0mJLm/ZZjDiGVmLptlj3HHluo
        XGm68ltfM2SCPAXIpdnaQISeHqmUVplVIaTRcVbnArlMegzun52FL9S82F6njxMh
        Iq9ANq67K6qxE2UURxTUDFAS+d6xiFxLOKbUMYUGagxumDKUbI9HEOTFnPYbNryA
        qOqvasYQvCjQqhrFMV0ordePTlyfR32JaQm0KO9HVByox2u0UTRBvh+5Q9qoh3Bj
        qySzLUgikjMWIETztxXmiRrSNQyPOqf8eDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696248951; x=1696335351; bh=N+N+eDyJwbmWM7IQgkOKLUE0MMGHc0rbju4
        i4SQwITA=; b=NrBhK+tHsuOJycJmvBrNcCCel/68YdBEklbH/JyGT7hXxWa16xC
        czCJStwi5e8nArlvM/ewzEIKUS4UVAJNVmc4DUBO/dsun5xbgiUcY/gsE8Cy+Pr4
        Lgpnf+Ir5sgwq+BLKeyVMQUg0YtFwQo+NVep3rPvqESpa3NyCt5zreALGqgAKzu4
        eLRPRWDSBa+n3EUfUjqZ/KmoC49DDRjmT/bx1sA8EawdKSbT6cWNowbjWTwdfEW9
        F2GT285uHFbooZ5PC+fEbk/FXEhqgeXCkxwKp3aC/1M40QjOfkSDgTo/N37Fvsj8
        BKh/gyHN1Quz4+/Or/eC09BKTUJLSJTkGZA==
X-ME-Sender: <xms:d7QaZeWFVYs20Nl_qN0f7CdeVrFqdlAO92yZFvTQJPRayR62H2GMWA>
    <xme:d7QaZancx3bwzBHCuBO4YKYURkF8V9woI9322MzBlcmhSa6U8wxWJh833TqNLRWkg
    wuiYxmk35KQfP30wjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:d7QaZSYihRTIFf6A5I-dGGesd0g8gQggnjw-QoPM-Gou5MrjFvEOWA>
    <xmx:d7QaZVUaSQ3ST3wrq9ie91ubp-XFxCKEB5wHUNeFCo-yBCJBPaq2bQ>
    <xmx:d7QaZYlYaI4USvJRuw5lFz9gvwkb6ByrB0FQBQiRAtmdtJ7dbSdXAA>
    <xmx:d7QaZXuLkkQ0D3Ess4e_3_rHpxdfCUqB16XOlWIE3Hoj9j5gNz4USg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5578EB60089; Mon,  2 Oct 2023 08:15:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <ccf08724-7b70-4a59-950e-eb56bbfe7df0@app.fastmail.com>
In-Reply-To: <CAJF2gTTB3dghWivn6HwL8d8L7w5apU6rjYp_fvut1AeybZVe1w@mail.gmail.com>
References: <20230912072740.2544-1-jszhang@kernel.org>
 <ZQBDFa0fGNiaqAgh@gmail.com>
 <C1EDD7DE-A0A9-4F43-9EC1-1C5A212A7033@jrtc27.com>
 <CAJF2gTTB3dghWivn6HwL8d8L7w5apU6rjYp_fvut1AeybZVe1w@mail.gmail.com>
Date:   Mon, 02 Oct 2023 14:15:30 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     guoren <guoren@kernel.org>, "Jessica Clarke" <jrtc27@jrtc27.com>
Cc:     "Jisheng Zhang" <jszhang@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: errata: thead: use riscv_nonstd_cache_ops for CMO
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, at 02:06, Guo Ren wrote:
> On Wed, Sep 13, 2023 at 3:00=E2=80=AFAM Jessica Clarke <jrtc27@jrtc27.=
com> wrote:
>>
>> On 12 Sep 2023, at 11:53, Guo Ren <guoren@kernel.org> wrote:
>> > Please remove the thead_errata_cache_wback because T-HEAD processors
>> > would prioritize using an invalid cacheline instead of evicting an
>> > existing cacheline. When we do dcache clean, the following operatio=
ns
>> > are to let other interconnect masters read. So, keeping wback_inv f=
or
>> > T-HEAD processors is the best choice, and maybe some other processo=
rs'
>> > vendor has a different idea, but please use the wback_inv instead of
>> > wback_only for the T-HEAD processors.
>>
>> Unless you can demonstrate that your cores have significantly worse
>> performance when using wback instead of wback_inv I do not think the
>> non-standard implementation should deviate from the semantics of the
>> standard one. There are efforts to unify the implemented semantics of
>> the operations across architectures and this would obstruct those.
>
> I'm afraid I have to disagree with the view that this obstructs
> "unifying the implemented semantics of the operations across
> architectures."
>
> static const struct riscv_nonstd_cache_ops thead_errata_cmo_ops =3D {
> -       .wback =3D &thead_errata_cache_wback,
> +      .wback =3D &thead_errata_cache_wback_inv,
>        .inv =3D &thead_errata_cache_inv,
>        .wback_inv =3D &thead_errata_cache_wback_inv,
>
> I don't see how the above patch obstructs unifying. On the contrary,
> it decreases the custom function, which could help unify. Could you
> give the least respect for the vendor's choice?

Since the email thread popped up after the latest replies, I saw
that I had not replied yet. I agree with Jessica here: we need to
ensure that the callback functions do what the interface requires,
across all architectures and CPU implementations. The choice to
call wback or wback_inv is a matter of optimization in the caller,
and we may well end up calling .wback_inv() for cases that currently
rely on ,wback(), if we can show this to be faster on certain
CPUs, and other cases (e.g. repeatedly writing and flushing
individual bytes to single DMA buffer) clearly rely on keeping
the cache line.

Other policy questions like whether to use .wback or .inv before
a DMA from device also still need a better answer, which we must
decide globally rather than per CPU implementation.

      Arnd
