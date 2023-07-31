Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CB0768B51
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjGaFkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjGaFj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:39:58 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1597010F5;
        Sun, 30 Jul 2023 22:39:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F2155C0103;
        Mon, 31 Jul 2023 01:39:52 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 31 Jul 2023 01:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1690781992; x=1690868392; bh=UrQ44egSsYKrgrC8lXSaEIOM2nJnUB+IsN4
        O98912zA=; b=db2uzzxQtgivo508fRTO8f4XT0UETH9ryLw+9yH+LWGIeJWJsCJ
        HyAkf5A99D/hyoKbJOko/ceLBuwZp2QtRooFcET2ZSJwaqbE4XTiUv+2ML8KaYYr
        tt8Ij6oLz9J3q18bAAOJaYnkH6yKUrILmwSFmfJM13iSYvenRqhyQQqGJh7PJCgB
        Kk6ktQNggVLNepXFQkg9hrbSvPSYoyF9eAs0xMuHa3xVMrzH5dMfaQUjEpSG2CHo
        mZKgUWbVbnZpTXQCcByWUxXsR5+0RmMUIfNBtlHVn4/qTnbVbb6vHbK6G5qFeXe9
        dlcwt1USgct6rxxQiGj/1DBjCiZXcngSYUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690781992; x=1690868392; bh=UrQ44egSsYKrgrC8lXSaEIOM2nJnUB+IsN4
        O98912zA=; b=SfnVnfPXXL3mwHIIIuxPP6P+wTbpKu+T6nwkEpJpH+uTqi10iQl
        lD6rkBhcUmKB0he2oTsKCEaftfGrtSaqsYJM+K8d3W2oSMvoD56zpeUQ3WlPSzr3
        4MWl9xiznEpkINcxm8BeUmkGejh123fEjEY9a9Q6EiELNqwX+K5H0uNMTMXeMi1b
        JnnccxzQVYFYS79Uib2hmQXRRlKzYLqdciQvM7zVwq/JtGNDe1MqWdreZGZw1elt
        XNvMJ+M7dCsV1mGGKcvWo/CJ+pU39XDBGqIImYfqgc4OBunU2MmKSzOG8UxRRUhU
        MhYl+QjUDC6CfSnaepOeCe5ZcXCZKyfmNrg==
X-ME-Sender: <xms:JknHZOMr2B4otX3Whv5p7QD31LWKZOV1ZByR19K3gtbtUbPwFhNm7g>
    <xme:JknHZM-9svD2oW6dTXmKjS-jUEVrQ_rqiGBAenlNEiBElmdzYvvw6omz1MiwHqp_3
    4_celspL1uzJzMXq0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjedvgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:JknHZFQj14YdLw_Py2F6LCjGho0W-InNWUSUf3BIsHyO6kNrRQGrag>
    <xmx:JknHZOvuqmGJScNtxpxYPB1lJNKlYCo_xghCmtbd94kWOGCl2Sv2fA>
    <xmx:JknHZGegVm_0iakLrtjFQGm0TP735QzgOq6DLHfE1nSsO160ldBXew>
    <xmx:KEnHZJUFsthMA4fissNqKUiT-ALEs3M42gkkAfH9V-DqtYFiAL0ZOw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CC613B60089; Mon, 31 Jul 2023 01:39:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <8b3466e4-a295-4249-bd05-2edbf7b3f6e3@app.fastmail.com>
In-Reply-To: <CAJF2gTTRHzT+CEtb1LVYdfCorVUdLvCh_eMxrmC=xjdQ_JS6Sg@mail.gmail.com>
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230702203429.237615-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZMZ6XB6gX2kFd/Nt@xhacker>
 <CAJM55Z8vF8_xq0QyByLUGM2W-8m6R-_6SdOFdLETV7J-yo5DMQ@mail.gmail.com>
 <92c00ddb-e956-4861-af80-5f5558c9a8f5@app.fastmail.com>
 <CAJF2gTTRHzT+CEtb1LVYdfCorVUdLvCh_eMxrmC=xjdQ_JS6Sg@mail.gmail.com>
Date:   Mon, 31 Jul 2023 07:39:30 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     guoren <guoren@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Samuel Holland" <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        "Christoph Hellwig" <hch@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v10 3/6] riscv: mm: dma-noncoherent: nonstandard cache operations
 support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023, at 02:49, Guo Ren wrote:
> On Mon, Jul 31, 2023 at 4:36=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
>>
>> On Sun, Jul 30, 2023, at 17:42, Emil Renner Berthing wrote:
>> > On Sun, 30 Jul 2023 at 17:11, Jisheng Zhang <jszhang@kernel.org> wr=
ote:
>>
>> >> > +
>> >> >  static inline void arch_dma_cache_wback(phys_addr_t paddr, size=
_t size)
>> >> >  {
>> >> >       void *vaddr =3D phys_to_virt(paddr);
>> >> >
>> >> > +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
>> >> > +     if (unlikely(noncoherent_cache_ops.wback)) {
>> >>
>> >> I'm worried about the performance impact here.
>> >> For unified kernel Image reason, RISCV_NONSTANDARD_CACHE_OPS will =
be
>> >> enabled by default, so standard CMO and T-HEAD's CMO platform's
>> >> performance will be impacted, because even an unlikely is put
>> >> here, the check action still needs to be done.
>> >
>> > On IRC I asked why not use a static key so the overhead is just a
>> > single nop when the standard CMO ops are available, but the consens=
us
>> > seemed to be that the flushing would completely dominate this branc=
h.
>> > And on platforms with the standard CMO ops the branch be correctly
>> > predicted anyway.
>>
>> Not just the flushing, but also loading back the invalidated
>> cache lines afterwards is just very expensive. I don't think
>> you would be able to measure a difference between the static
>> key and a correctly predicted branch on any relevant usecase here.
> Maybe we should move CMO & THEAD ops to the noncoherent_cache_ops, and
> only keep one of them.
>
> I prefer noncoherent_cache_ops, it's more maintance than ALTERNATIVE.

I think moving the THEAD ops at the same level as all nonstandard
operations makes sense, but I'd still leave CMO as an explicit
fast path that avoids the indirect branch. This seems like the right
thing to do both for readability and for platforms on which the
indirect branch has a noticeable overhead.

    Arnd
