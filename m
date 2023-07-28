Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A73076633F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjG1EiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjG1Eh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:37:59 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945D83A89;
        Thu, 27 Jul 2023 21:37:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id AD30D2B00094;
        Fri, 28 Jul 2023 00:37:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 28 Jul 2023 00:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690519071; x=1690526271; bh=mC
        HEdnL0T3Kpk63KalD/dwpA1NDmMHVN2+cu3heDxgU=; b=OPReg3IA8PGot5tU7u
        VEFTMdPQVyGCJdbHwagH6RTCQmO2TDnWHPFck8osBQstdii6OdMKyxId6BJ4FAA2
        Vbs4UDcihOu684LpjzrzNGL1gqgPJOzb1jPvME3VC8+U//m0jHBvV4iybZ0+44I5
        b2vK3J7ggPHUHF5KiLV6uLa0lK7Pph068mcGA6+Jld9mj7hB18bEXhYaqvjx7lYm
        4TvaMAJ77brVU6lYTZCbuqMO+pSUs/1IkdO/JzE/SESX5aVA9GDXrmhlKW0FJZ1T
        QFdoTLbQB0mIhrsHNphAa2PUYmMaW7qQklr9zMLDX2GF4bRElLqZiQ3phCItBm/u
        On1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690519071; x=1690526271; bh=mCHEdnL0T3Kpk
        63KalD/dwpA1NDmMHVN2+cu3heDxgU=; b=B7+4PSEy8zTkt5sy02FcnsCzC7OHs
        ZxGkklFd0DrBu7sWUQoqZRwrZr6QI8NygFUhNujg9X4dLeSbD0M3MGbFTqpYESoe
        Ec++QZDk+aZm1QR4VGs7RRSMfmxOj1RdrTJj3BL3obVB1iAUnB9nwfsfXPt8eTff
        DAQp1rEWXX7WoQoo6cxsS+wm5d6T+Y4Ly7w5aEbUvsa/E5RZ1JzKXQ9HULIHzyi9
        DAr+rhZ1iMX99lCtchxlJ8zPtSwYA/Hoc98WGey1Bs/kqJlc5jRrpgk1Y1R2qHWN
        oYRUSTDKJiHgePgInIWZVwtgVdNgKK45DryvIRxfIzw0SMirlEW4avq1A==
X-ME-Sender: <xms:HkbDZOBN9TEHzKvHK_qHu6hWfitdsT-A7jJq39o899CwEc3J_4S41w>
    <xme:HkbDZIiE3_sYMNAysS_VFGV9BpN9XTuCZOv_UAxfh6nhtckJmIDzdUiRd6f1FT9UT
    ch8WTd0AFGdb3_mHA>
X-ME-Received: <xmr:HkbDZBn2_SPIosFWa52z89Fk4DcdYWz2eAAI2RetbucVLse7r-K1Spz_f1bFJWze9e2NTnzg3of7qfIDQDJhrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffffgfeg
    iedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:HkbDZMyqK1AHE_X9ppW_KvHmdG2vVeUuXFx4gXyo_ylfZlBihndlMQ>
    <xmx:HkbDZDTFXvayGrXCkikk3zr3LowHaOqMc_qaA7Y8QPghfHyam_rnSw>
    <xmx:HkbDZHZLXXDILADjfrzGzCDd5wj3iliL3vb67wWCnUdk21mIEW_Okw>
    <xmx:H0bDZIBYqWhVsLdw8WOvGGYGtK8OEg_39w02Na4U3BgSuyKPj4DmGJ3FoO0>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Jul 2023 00:37:48 -0400 (EDT)
Date:   Thu, 27 Jul 2023 22:37:47 -0600
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     daniel@iogearbox.net, kadlec@netfilter.org, edumazet@google.com,
        ast@kernel.org, fw@strlen.de, kuba@kernel.org, pabeni@redhat.com,
        pablo@netfilter.org, andrii@kernel.org, davem@davemloft.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH bpf-next v6 2/5] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Message-ID: <c4w6rbxdciu27uzzdc2cpncxhdn2lkba2ekfuwzk6gmz7bdhdh@ymyq6b5wfkqf>
References: <cover.1689970773.git.dxu@dxuuu.xyz>
 <5cff26f97e55161b7d56b09ddcf5f8888a5add1d.1689970773.git.dxu@dxuuu.xyz>
 <20230728011620.psvselzqdm7ku5e4@macbook-pro-8.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728011620.psvselzqdm7ku5e4@macbook-pro-8.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexei,

On Thu, Jul 27, 2023 at 06:16:20PM -0700, Alexei Starovoitov wrote:
> On Fri, Jul 21, 2023 at 02:22:46PM -0600, Daniel Xu wrote:
> > This commit adds support for enabling IP defrag using pre-existing
> > netfilter defrag support. Basically all the flag does is bump a refcnt
> > while the link the active. Checks are also added to ensure the prog
> > requesting defrag support is run _after_ netfilter defrag hooks.
> > 
> > We also take care to avoid any issues w.r.t. module unloading -- while
> > defrag is active on a link, the module is prevented from unloading.
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  include/uapi/linux/bpf.h       |   5 ++
> >  net/netfilter/nf_bpf_link.c    | 123 +++++++++++++++++++++++++++++----
> >  tools/include/uapi/linux/bpf.h |   5 ++
> >  3 files changed, 118 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 739c15906a65..12a5480314a2 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1187,6 +1187,11 @@ enum bpf_perf_event_type {
> >   */
> >  #define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
> >  
> > +/* link_create.netfilter.flags used in LINK_CREATE command for
> > + * BPF_PROG_TYPE_NETFILTER to enable IP packet defragmentation.
> > + */
> > +#define BPF_F_NETFILTER_IP_DEFRAG (1U << 0)
> > +
> >  /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
> >   * the following extensions:
> >   *
> > diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
> > index c36da56d756f..8fe594bbc7e2 100644
> > --- a/net/netfilter/nf_bpf_link.c
> > +++ b/net/netfilter/nf_bpf_link.c
> > @@ -1,6 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/bpf.h>
> >  #include <linux/filter.h>
> > +#include <linux/kmod.h>
> > +#include <linux/module.h>
> >  #include <linux/netfilter.h>
> >  
> >  #include <net/netfilter/nf_bpf_link.h>
> > @@ -23,8 +25,88 @@ struct bpf_nf_link {
> >  	struct nf_hook_ops hook_ops;
> >  	struct net *net;
> >  	u32 dead;
> > +	const struct nf_defrag_hook *defrag_hook;
> >  };
> >  
> > +static const struct nf_defrag_hook *
> > +get_proto_defrag_hook(struct bpf_nf_link *link,
> > +		      const struct nf_defrag_hook __rcu *global_hook,
> > +		      const char *mod)
> > +{
> > +	const struct nf_defrag_hook *hook;
> > +	int err;
> > +
> > +	/* RCU protects us from races against module unloading */
> > +	rcu_read_lock();
> > +	hook = rcu_dereference(global_hook);
> > +	if (!hook) {
> > +		rcu_read_unlock();
> > +		err = request_module(mod);
> > +		if (err)
> > +			return ERR_PTR(err < 0 ? err : -EINVAL);
> > +
> > +		rcu_read_lock();
> > +		hook = rcu_dereference(global_hook);
> > +	}
> > +
> > +	if (hook && try_module_get(hook->owner)) {
> > +		/* Once we have a refcnt on the module, we no longer need RCU */
> > +		hook = rcu_pointer_handoff(hook);
> > +	} else {
> > +		WARN_ONCE(!hook, "%s has bad registration", mod);
> > +		hook = ERR_PTR(-ENOENT);
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	if (!IS_ERR(hook)) {
> > +		err = hook->enable(link->net);
> > +		if (err) {
> > +			module_put(hook->owner);
> > +			hook = ERR_PTR(err);
> > +		}
> > +	}
> > +
> > +	return hook;
> 
> The rcu + module_get logic looks correct to me, but you've dropped all Florian's acks.
> What's going on?
> 
> We need explicit acks to merge this through bpf-next.

I understood acked-by tags to be a lighter form of reviewed-by tag. So
b/c the patches changed so much I dropped the tag. It sounds like maybe
I misunderstand -- I'll keep it in mind the next time around.

Thanks,
Daniel
