Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34BE7B0B01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjI0RYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjI0RY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:24:29 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45FCB4;
        Wed, 27 Sep 2023 10:24:27 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 25B0932009AA;
        Wed, 27 Sep 2023 13:24:26 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute1.internal (MEProxy); Wed, 27 Sep 2023 13:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1695835465; x=1695921865; bh=K/
        ewG/yXBbEUDAmhfynepdxPpgrjBJdtiyC79s1NooQ=; b=htGQQB0pMZC3x4/8hV
        bePIRfRov3FjMqZ4AZ6mHs3vfjq0NEpyNxtSsXVeC7B4LgGSNZcVdv0VXE1Jtcrz
        MyuGxpc3pQvIHFsyY1VeRmgKD6x/YcnAfeaeUdXEYG+KcBqIuzkIXJjGQfxzIunI
        2x/JTkMuPiIgX2x8EXSDqCFQpBib/l2BEPabf+/nlpi0Zm4ozt11oXOfCiIv6782
        zAa7OWNgT4UdJ9CC2jtwb3HPWAzv0DDeyr9uPdD0GkdYgLyS3KeSSFeLj5/iH0v6
        F9MG2xdUKYGUYJ67SQ5+a+RAQFgoxQQduXtzpZv5Ag9PUoy9N0SwJsDyCmTPldJu
        GRZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695835465; x=1695921865; bh=K/ewG/yXBbEUD
        AmhfynepdxPpgrjBJdtiyC79s1NooQ=; b=VnrJcJgityZNO22WpidDgzOvZINiB
        nCsOCaFfgzPioxY9MUnT8Sobdheq6DPNxd1VfcxjF/vD6q81WFiP8/LFntO0x8Xb
        NSn3q9otNdQ/Zz0TYRCacPSLhGRRdKspt9DK0lpZyPvqNRHU33iv03GoA1IfigGH
        NtYP2oP+Y/Gp1H+wFmJnmfEJ0yJKtEk6Qsx8RSWakwv9fYwfiMqpIxebMaFiJ/Fg
        nXC1ySr0xuuZIylqMlc9r3f2F+5zasextgBPKv3p1RztKdueBfDQyM37Pg/kl5wT
        wKuVLDTpWHe247lz20rTv6L8Jt9Fw7R6IGM+KKMJ+EvVFPIyjV4hpVNNg==
X-ME-Sender: <xms:SWUUZZ9tG7K410qt_kJ6cTWte6O4loFooALS6DRlI6GAmkfY3aqpKA>
    <xme:SWUUZduitLIG7TleSLo-2vOG2oxZ-MI8udKOetDUw2GPTGO0ipZK8ks6Va6bEXEAu
    DBIvSNhxSeM221Flg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeggdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuthgv
    fhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeejueehgedtueetgefhheejjeeigffhieefjeehuddvueegtdfh
    heevgfeggfektdenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsohhrvggrrhesfhgr
    shhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:SWUUZXBxfmRTZkFFbJjtYjb_X5OGpKnn5-ZMUdEhe8PfINmgLr2U3Q>
    <xmx:SWUUZddY5FsbixhMZQgxp4K_oJ-aZiSPECMMkpdAhgCGT5GQN9cFZg>
    <xmx:SWUUZePBgtxR_Rp1lzeknKtUIbadQvZarki81K1cJRa5eD13GpUmfw>
    <xmx:SWUUZalpQYRowv2snnXJKfG9E8wlD_McP0sZ7gTskMacutUljh8m0Q>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E9FB51700089; Wed, 27 Sep 2023 13:24:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <d141062b-e3e0-45ce-bc61-3404417c7d7c@app.fastmail.com>
In-Reply-To: <20230922085701.3164-3-yongxuan.wang@sifive.com>
References: <20230922085701.3164-1-yongxuan.wang@sifive.com>
 <20230922085701.3164-3-yongxuan.wang@sifive.com>
Date:   Wed, 27 Sep 2023 13:24:03 -0400
From:   "Stefan O'Rear" <sorear@fastmail.com>
To:     "Yong-Xuan Wang" <yongxuan.wang@sifive.com>,
        linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     greentime.hu@sifive.com, vincent.chen@sifive.com, tjytimi@163.com,
        alex@ghiti.fr, "Conor Dooley" <conor@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: riscv: Add Svadu Entry
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023, at 4:56 AM, Yong-Xuan Wang wrote:
> Add an entry for the Svadu extension to the riscv,isa-extensions property.
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml 
> b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index cc1f546fdbdc..b5a0aed0165b 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -147,6 +147,12 @@ properties:
>              ratified at commit 3f9ed34 ("Add ability to manually 
> trigger
>              workflow. (#2)") of riscv-time-compare.
> 
> +        - const: svadu
> +          description: |
> +            The standard Svadu supervisor-level extension for hardware updating
> +            of PTE A/D bits as frozen at commit b65e07c ("move to Frozen
> +            state") of riscv-svadu.
> +

This is incomplete without a specification of the behavior of the HADE bit implied
by svadu being present.

The ratified RVA20 requires page table accesses with A/D = 0 to trap, in other
words HADE = 0 for RVA20 conformance.  If we are serious about compatibility,
I think that we need platforms to be able to conform to both RVA20 and RVA23,
which requires HADE = 0 at kernel entry with a SBI call to set HADE = 1.  For
the same reason KVM should probably default to HADE = 0 so that the default
configuration remains conformant to RVA20.

-s

>          - const: svinval
>            description:
>              The standard Svinval supervisor-level extension for fine-grained
> -- 
> 2.17.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
