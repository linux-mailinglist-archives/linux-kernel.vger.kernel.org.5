Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAEC792D0A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbjIESFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbjIESFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:05:39 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DC49008;
        Tue,  5 Sep 2023 09:53:07 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 174B732001AB;
        Tue,  5 Sep 2023 12:38:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 05 Sep 2023 12:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1693931884; x=1694018284; bh=21
        1jhUVDutOPYWl/TUpiZdIjCc0S5zbUfDCJu+M5WtQ=; b=gDMHhI6eKdFawWqdov
        3iCOnAADb0iEyR+A2dTtKMs5yNoi+R820jDShvv1fyT2HGWad8pQiEwCWhlaNWoQ
        GlGwMXnlBsPIP8kqNcM8oULek0UG/Q3CLUmxhQHLVYcaTuoFmP75L6jjygOP72Di
        6O5D879awH1Br8hMG5HPobqiyG7pzbkdfhFpv7HVe+uaqTc2mD8U1O6uzgpmjPuY
        easeFu9rMFPeqerD3XbHiqQYDS6iQ7GBbE4rbnAEau5Gy1P4L+xN1vK6Rwejaiqi
        twjpJqqfenH96ohjladwkiSeqpD77GoSaD0939XC69O/XipC85iuw7RIUhbA0yjI
        N7Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693931884; x=1694018284; bh=211jhUVDutOPY
        Wl/TUpiZdIjCc0S5zbUfDCJu+M5WtQ=; b=ISEKd62joyIdwKbrd5C8utIydRrzJ
        syzxlsH6i2ic6TT+fsBTvJNKdf9Vplpe1+e7sP6x0Ov0GJZiiYZAyr410kUO71HO
        wchOeOdyQ5DeCaATg2Od7iz7CROszj56IW5Er5kI0ICLqYWJZvEBHL+aF31YgzHO
        Lxr7ZR5Q14ruTElgWuog86gq8cG4oIUhim/itWAFitoP1DUo0qTic503Yj+cr110
        /092egBYW903nS7hKItlWfYuOgA0THPMtKXFcilVxJr1zB3rp1TyV5FPU83PEnBB
        WqaveDOy2JDgwGgA9gj/msR1XEhZ3/BHiaZ2puMAY434VWd72ocwyKsfw==
X-ME-Sender: <xms:bFn3ZL-aV8hTm7XsLdLTp4Dn3mHMsSEP6ovGEgszee4hEkboN9JLfg>
    <xme:bFn3ZHuZXpQhuY5IGdjXfJaTgnYOwrZV4SwwAbqhS0ay0T5jQq6rY4yobF9s4cLr4
    2ljJkzmG8f5SCiA7g>
X-ME-Received: <xmr:bFn3ZJAz8Egxu7gzyLJNTszuD6nHzhofkcF68ymds5kcDVaPOXaeP-Nc0JvWCPOqeNDEDoN5J9Naf9C6YB-L82vkeC-2_Z6a2EFJRKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehuddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:bFn3ZHfAPIp0Lnej5eB6PeOofxboA1HmGJo8HzBSbzlcvpH5IY8fuQ>
    <xmx:bFn3ZAOhwExOvcbwdNdRdvW_vB3vswyVteirryymvt2BtuUI9cjvDw>
    <xmx:bFn3ZJncV0gQxRVw-y9uqss9Z72bh5OZFvHv1HF-FqbED18RpS4d1g>
    <xmx:bFn3ZMAtbfd8GVfs_yiKUQZk7W6VVtCp8J4yCGFFV94ib-YtqOomoQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Sep 2023 12:38:03 -0400 (EDT)
Date:   Tue, 5 Sep 2023 10:38:02 -0600
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     David Wang <00107082@163.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] uapi/netfilter: Change netfilter hook verdict code
 definition from macro to enum
Message-ID: <cc6e3tukgqhi5y4uhepntrpf272o652pytuynj4nijsf5bkgjq@rgnbhckr3p4w>
References: <20230904130201.14632-1-00107082@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904130201.14632-1-00107082@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Mon, Sep 04, 2023 at 09:02:02PM +0800, David Wang wrote:
> As BPF_PROG_TYPE_NETFILTER was added in 6.4, a netfilter
> bpf program can attach to netfilter hooks, process package
> and return verdict back to netfilter. But those verdict
> codes are defined as macro, which could not be compiled
> into BTF with btf.c. libbpf, and maybe other bpf tools,
> would extract information from BTF and generate a
> common header "vmlinux.h". With macro definition, netfilter
> bpf program would have to redefine those macro again,
> besides including "vmlinux.h".
> 
> This code change netfilter hook verdict code definition to
> enum, this way,  make it into BTF.
> 
> Signed-off-by: David Wang <00107082@163.com>
> ---
>  include/uapi/linux/netfilter.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/netfilter.h b/include/uapi/linux/netfilter.h
> index 5a79ccb76701..d2f5dfab20dc 100644
> --- a/include/uapi/linux/netfilter.h
> +++ b/include/uapi/linux/netfilter.h
> @@ -8,13 +8,15 @@
>  #include <linux/in6.h>
>  
>  /* Responses from hook functions. */
> -#define NF_DROP 0
> -#define NF_ACCEPT 1
> -#define NF_STOLEN 2
> -#define NF_QUEUE 3
> -#define NF_REPEAT 4
> -#define NF_STOP 5	/* Deprecated, for userspace nf_queue compatibility. */
> -#define NF_MAX_VERDICT NF_STOP
> +enum {
> +	NF_DROP        = 0,
> +	NF_ACCEPT      = 1,
> +	NF_STOLEN      = 2,
> +	NF_QUEUE       = 3,
> +	NF_REPEAT      = 4,
> +	NF_STOP        = 5,	/* Deprecated, for userspace nf_queue compatibility. */
> +	NF_MAX_VERDICT = NF_STOP,
> +};

Switching from macro to enum works for almost all use cases, but not
all. If someone if #ifdefing the symbols (which is plausible) this
change would break them.

I think I've seen some other networking code define both enums and
macros. But it was a little ugly. Not sure if that is acceptable here or
not.

[...]

Thanks,
Daniel
