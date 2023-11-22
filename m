Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6F27F50B1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344414AbjKVTfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjKVTfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:35:30 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B942118E;
        Wed, 22 Nov 2023 11:35:25 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 983C35C0231;
        Wed, 22 Nov 2023 14:35:22 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 22 Nov 2023 14:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1700681722; x=1700768122; bh=lx
        3Gf8Ml5YHZ79DEZBtfhV6TJngHlrEmAjf3G2BUG5I=; b=u2TiS0xIOQsffzBAVU
        JSTs2mGFfVTuQMlgIJgHNPnrhs78q46sLtXDhRnurDbnCTVctxhViklKISCbXqPJ
        4zklquNGsoexd+vDTADrs5yNRWdE8cNDhrKrQPrcT6KxgF80yzbPKqc3Aowq1yJ8
        EmU0xsb04QOXaRiCBNSDVlt+k9fXanRUneRaXg4Llmo3gShROyoFwVzU6nAAzkH8
        VPvMLjauYd75oxdJ3jmOOLieuJYh8o4TJgz8XRtQ7uh/AQbSS4681JPFeJau9SKu
        CdMal+gFwVhzjafLGclkZ1iOcuQOb7AmNjZg9/LWbHPI8hSH3qKTzmm4BHs/DOZ4
        Wgkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700681722; x=1700768122; bh=lx3Gf8Ml5YHZ7
        9DEZBtfhV6TJngHlrEmAjf3G2BUG5I=; b=HktlyKuM6aaLQ6S2eyF6AyJosR+pQ
        GNgRH40Ywg+gkZwQdn7moY7Y+59ZLJYiZXNuMHoNwYQeMNA+AznC17pC/OVohdY5
        VjgrTYOHShDNF32knHfLUxlcUM7NrzSiR1BgduQrFf7RMpQUYSoS6ltoKwZxrj/K
        bot0k9SLRayF03N1tB7c29RBqOR0UpnXva1ckBwYUDFsBiwgSmdDF7GAoMo+Y24k
        KBfpTDhZpMIY6HZTVCG+3WfB9BUsk+Mpi9k4E5orXrkaCSgQOD0fkYVjnrhQnGo/
        UqA6hynC/XUYcwf7kxAWekWr21Q5GLcWMiQItvhrcbaNMV0G7Wj+tLfNw==
X-ME-Sender: <xms:-VdeZXTQDoj04OGydyU_tsLVOIngFCFZgrFY9eh_f0ejBuzlpcKokQ>
    <xme:-VdeZYwVfUiZlaozz7Ei8iAf4N0ApBmCBHI9rs7qzU_q68qQejS-CuxYbF8Y2pSJH
    Bm8RUHP4sNN78BExvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:-VdeZc1MDnsssALlgVh0DSsi9KVGIi8mJSEsShVn5VZDPvB0xY-dCA>
    <xmx:-VdeZXBN9hUryZPJ7XhsUt-aFrPAtmEATvvtFZUwmSiikBbunwAvcg>
    <xmx:-VdeZQhd9WJc2trzfd8cr4zx7_HBYqyk0C8pbLkqsPKk1WLx_Lu7iw>
    <xmx:-ldeZcy3EllNCPOB08Eq1u1DCV9iGLuZEJAiiU4rIy-olCaheuZ-4A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6E100B60089; Wed, 22 Nov 2023 14:35:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <b996b542-4cd3-4f9d-b221-00b2d5ef224e@app.fastmail.com>
In-Reply-To: <20231122182419.30633-2-fancer.lancer@gmail.com>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
 <20231122182419.30633-2-fancer.lancer@gmail.com>
Date:   Wed, 22 Nov 2023 20:35:01 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Serge Semin" <fancer.lancer@gmail.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Yinglu Yang" <yangyinglu@loongson.cn>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>
Cc:     "Alexey Malahov" <Alexey.Malahov@baikalelectronics.ru>,
        "Aleksandar Rikalo" <aleksandar.rikalo@syrmia.com>,
        "Aleksandar Rikalo" <arikalo@gmail.com>,
        "Dragan Mladjenovic" <dragan.mladjenovic@syrmia.com>,
        "Chao-ying Fu" <cfu@wavecomp.com>, "Marc Zyngier" <maz@kernel.org>,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mips: dmi: Fix early remap on MIPS32
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023, at 19:23, Serge Semin wrote:
> dmi_early_remap() has been defined as ioremap_cache() which on MIPS32 gets
> to be converted to the VM-based mapping. DMI early remapping is performed
> at the setup_arch() stage with no VM available. So calling the
> dmi_early_remap() for MIPS32 causes the system to crash at the early boot
> time. Fix that by converting dmi_early_remap() to the uncached remapping
> which is always available on both 32 and 64-bits MIPS systems.
>
> Fixes: be8fa1cb444c ("MIPS: Add support for Desktop Management Interface (DMI)")
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  arch/mips/include/asm/dmi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/dmi.h b/arch/mips/include/asm/dmi.h
> index 27415a288adf..525aad1572d1 100644
> --- a/arch/mips/include/asm/dmi.h
> +++ b/arch/mips/include/asm/dmi.h
> @@ -5,7 +5,7 @@
>  #include <linux/io.h>
>  #include <linux/memblock.h>
> 
> -#define dmi_early_remap(x, l)		ioremap_cache(x, l)
> +#define dmi_early_remap(x, l)		ioremap_uc(x, l)

Please don't use ioremap_uc() in new code, we are in the (long)
process of removing it from the kernel for everything except
x86-32, and it already returns NULL on most of them.

Would the normal ioremap() work for you here? It seems to
do the same thing as ioremap_uc() on mips and a couple of 
other architectures that have not yet killed it off.

   Arnd
