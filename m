Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113C97C9491
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 14:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjJNMUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 08:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjJNMUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 08:20:49 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA3CA9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 05:20:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D9E165C0288;
        Sat, 14 Oct 2023 08:20:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 14 Oct 2023 08:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697286043; x=1697372443; bh=nZ
        iSaf+2rKUZmRmaI+hHKAfBctJh+V32I+xRn4B5yaM=; b=DMW+athuAfhfxrMpLC
        q6fqoed/7uX/mQHSbMR9RebUkAwQN8SRxLbcbUb9TCfjETOaCz1UcuQzyfkjupCG
        37vWO7Gj3ZM6I7OgNerhAR3bdD+2qyfgzOoe/KSTp9oaTrdWOX4dzr3pFAOC+Tyn
        HIk+1hKIyyKnf9saGXX0+NEEvehgAbSmzhlj8IJ/n0kWlxJuuqQ0aJDOi6Gu6PSd
        vxCpdLpLRBYHLiY4mKgljlkkE0YuCFfMCOsVUuAWBHU9izSeLKs4xhdYt0T3eEJ/
        KvoS5zH7X/7H39WfjkVkGacluJRYX6+2FytfyFCO9YvgBUmoeDmAoFg6eIjLXOje
        oY3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697286043; x=1697372443; bh=nZiSaf+2rKUZm
        RmaI+hHKAfBctJh+V32I+xRn4B5yaM=; b=XmVc3oRK5xPIG+LC89BayxU//H3dA
        15HdljrBlx5vfugHwIgHCZ81WuegEXJri7T/ACzuyzUcsRHaEI7DB5bm3N+jM+jt
        jThIUfClB+A5Dc+MD01TuRpZC+3Li6gB9/DC5zQBc7L/3wPMbIqR0zaVWPe7aOGp
        z1A+dyo9LhOXdncC2ZoxOWvmdvGPgYwiO3kUyGS9m3bwUNdkJi8C6Be6jlC/7XsG
        StGUotCR1e12EVsdSGrfqkm19lUDtkIKDC5x24TCnNftg2m27LlEljRQKYEKRmy1
        Yh3oaNNHlWeQUlomoQayDHiMP/H7Tm4CsBbq9MGEBhnb3RhHUwxeHSW5A==
X-ME-Sender: <xms:m4cqZdSeswWWvO027zq8PS0N9IfdsxN0i8f4d_HHUzLWN0qCFWkXWA>
    <xme:m4cqZWw0k1kGXAc4iu6z2-ja-hPSLRVLK3hpx5tVkMpG2dEgIqsZ_VtTcM2Goj_AB
    5suOAUDdeZLtGVidNU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieehgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:m4cqZS2ytldwAXeJP2PaXElU6rm5WO4IqLfA8v6jj1_1ewCRt4HR1w>
    <xmx:m4cqZVC3PQlDUr3F-AZaImYU3DG_Jle3dFQxnD-KUyRnkNjlvgmdbg>
    <xmx:m4cqZWix_PsRLPtMETcHcLKMTGronhRIV_Zi0OpkHtHMjwwp6H0fHA>
    <xmx:m4cqZRVhVv0aNDlcqNSdu3vGQn6-thVaJ6om4XZj63ZJ931YmzZWUQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6EC65B6008D; Sat, 14 Oct 2023 08:20:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <268a2031-63b8-4c7d-b1e5-8ab83ca80b4a@app.fastmail.com>
In-Reply-To: <52b07a3861a34fb0deb6251bae8bd885815c6944.1693311370.git.viresh.kumar@linaro.org>
References: <cover.1693311370.git.viresh.kumar@linaro.org>
 <52b07a3861a34fb0deb6251bae8bd885815c6944.1693311370.git.viresh.kumar@linaro.org>
Date:   Sat, 14 Oct 2023 14:19:52 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Viresh Kumar" <viresh.kumar@linaro.org>,
        "Juergen Gross" <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>
Cc:     "Stratos Mailing List" <stratos-dev@op-lists.linaro.org>,
        "Erik Schilling" <erik.schilling@linaro.org>,
        "Manos Pitsidianakis" <manos.pitsidianakis@linaro.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [Stratos-dev] [PATCH 2/2] xen: privcmd: Add support for ioeventfd
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023, at 14:29, Viresh Kumar via Stratos-dev wrote:

> +/* For privcmd_ioeventfd::flags */
> +#define PRIVCMD_IOEVENTFD_FLAG_DEASSIGN (1 << 0)
> +
> +struct privcmd_ioeventfd {
> +	void __user *ioreq;
> +	unsigned int __user *ports;
> +	__u64 addr;
> +	__u32 addr_len;
> +	__u32 event_fd;
> +	__u32 vcpus;
> +	__u32 vq;
> +	__u32 flags;
> +	domid_t dom;
> +	__u8 pad[2];
> +};

Using indirect pointers in an ioctl command argument means that
the layout is architecture specific, in particular you can't
use the same one from 32-bit compat tasks. The general recommendation
is to have __u64 members and use u64_to_user_ptr() to access it
from the kernel if you are unable to avoid the pointers altogether.

>  /*
>   * @cmd: IOCTL_PRIVCMD_HYPERCALL
>   * @arg: &privcmd_hypercall_t
> @@ -139,5 +155,7 @@ struct privcmd_irqfd {
>  	_IOC(_IOC_NONE, 'P', 7, sizeof(struct privcmd_mmap_resource))
>  #define IOCTL_PRIVCMD_IRQFD					\
>  	_IOC(_IOC_NONE, 'P', 8, sizeof(struct privcmd_irqfd))
> +#define IOCTL_PRIVCMD_IOEVENTFD					\
> +	_IOC(_IOC_NONE, 'P', 9, sizeof(struct privcmd_ioeventfd))

_IOC() an internal helper that you should not use in driver code.
In particular, you go the data direction wrong here, which breaks
a number of tools, as having "_IOC_NONE" should never be paired with
a nonzero size.

Instead, you should use the existing _IOWR() or _IOR() macros without
the 'sizeof()' like

#define IOCTL_PRIVCMD_IOEVENTFD _IOWR('P', 9, struct privcmd_ioeventfd)

You clearly copied this from the other ioctl command definitions in
the same file that we can't easily fix without breaking the user
ABI, but I still think you should try to do it correctly for new
commands.

     Arnd
