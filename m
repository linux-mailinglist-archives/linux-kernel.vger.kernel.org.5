Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB9D780BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359798AbjHRMjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376967AbjHRMix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:38:53 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6563AA4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:38:50 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 84F162B00192;
        Fri, 18 Aug 2023 08:38:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 18 Aug 2023 08:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1692362326; x=1692369526; bh=VR
        Eevf5qPO8COed4/oy026pPJB7NxKFdDGSXwKxHqf0=; b=d+bwoWlht+7ouoS/7J
        AhxzevDyh+g/uq5Kqt7iTZpMVfiisxGrCgzCzQk7UHxbx6IHyoOWiIdbtmWk6iet
        GGrcDZuqAhp7jQX1PIDrldMHvYQdQwpBpvhBvLrfWjARX6m4dq0k0qXijDYxWx+O
        1GaVMw7ieXDsRrGrp+MJsTHK7IXt76Dx8Tn3PcIlgipmqDnPsR2slSZyf6h4XlBd
        A3DkVKM7pdSh+XeE66f7gba1ipuksmri4nYAqq3SdroDyHcMa5dAzQWfYjBhgwr0
        uN2fZjk8N0pmQNOHj8CkCOYShaxvMtkTZZ1wZUnnKLZ3h5g2VhG0I4fItsK8A4v3
        70wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692362326; x=1692369526; bh=VREevf5qPO8CO
        ed4/oy026pPJB7NxKFdDGSXwKxHqf0=; b=ggAWAxVjraT1rHERwpEPLrJWBXiX5
        jChRWcMsiX+/E8cuvXyF80WM/CSbxFBRmM/k1Vre9TjA9OaWN1UacrDECX3k4xFS
        ze54UvpfJHraV0ui2P6xykunXtVpF9clvtgn5KNTuIW05pdFbsyZhDt5VWAhA8y4
        72Lud6dLrIXuhK+wfZRlkL8ZO8Fa/mwXPTvD0H5JloeZoDb2BgAY444/mWKabtGC
        UXagx98erOo9EHtgFpvGmp5QAp67BGOb0d7w3v/PVgUjApTMp3QQ2wzR1aTVCu5c
        Jqve3hXeA9JBYQBSRqcjVVW+qDN+Y7KOzvAsLCQXrTmYMIkvzhER9vD6w==
X-ME-Sender: <xms:VmbfZGxZHtWL2hA8NOocNgxaSWw68Ztap9HrKupd_1XWvWJrbhnJGw>
    <xme:VmbfZCQ3yWHNjUpQwVOzK2xFKd7HDCUT3BJd6bDvYWdL1tM9yc90kcxby8baj6SPg
    vOIcMqWFDEr6EFMRkk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddufedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:VmbfZIUqx27iRLZmO1UnoC5gOcDoLOdq32mkyYaFhYFBYh88bycIlA>
    <xmx:VmbfZMgEgOgqLselMUkYb5bHUttOu_WwUCrxSQkf2l-CKnA4NwCVLA>
    <xmx:VmbfZIB9cRfYyvqRSphs0qQdqPbgVGBYOuVFVOFHrsU3NhJMzGjoHA>
    <xmx:VmbfZK3xxAmtYNh_lxnyRtXHM1aeGSwGHfvwfNrrqidR-EJWHPVyhIh6oGI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2374AB60089; Fri, 18 Aug 2023 08:38:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <156fec7b-1a9f-4660-b1c3-65a8b9cd1405@app.fastmail.com>
In-Reply-To: <008c4b0a118d37abac6b1ec89b5677b1c6e347ae.1692345210.git.christophe.leroy@csgroup.eu>
References: <008c4b0a118d37abac6b1ec89b5677b1c6e347ae.1692345210.git.christophe.leroy@csgroup.eu>
Date:   Fri, 18 Aug 2023 14:38:23 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH] dma-mapping, powerpc: Move arch_dma_set_mask() prototype into
 dma-map-ops.h
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023, at 09:55, Christophe Leroy wrote:
> To fix the following error,
>
>   CC      arch/powerpc/kernel/dma-mask.o
> arch/powerpc/kernel/dma-mask.c:7:6: error: no previous prototype for 
> 'arch_dma_set_mask' [-Werror=missing-prototypes]
>     7 | void arch_dma_set_mask(struct device *dev, u64 dma_mask)
>       |      ^~~~~~~~~~~~~~~~~
>
> Move arch_dma_set_mask() definition into dma-map-ops.h and
> include it in arch/powerpc/kernel/dma-mask.c
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---

I sent the same patch, and this is already in linux-next as
3d6f126b15d9 ("dma-mapping: move arch_dma_set_mask() declaration
to header")

      Arnd
