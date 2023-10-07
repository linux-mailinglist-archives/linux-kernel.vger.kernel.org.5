Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7307BC9B5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 22:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbjJGUO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 16:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbjJGUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:14:56 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217F9C5;
        Sat,  7 Oct 2023 13:14:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B11963200AFB;
        Sat,  7 Oct 2023 16:14:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sat, 07 Oct 2023 16:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1696709691; x=1696796091; bh=HAd1G1CE8pMJy+IQqhNmJgcfkB8TtDe7tK8
        J8WflhKQ=; b=A1lblkpKm1sih/Lz24VdS7Kqa27QIOHQxeLLmg8DW3ZhnJOsvYg
        X0Kzqog/j1RGX+Ag3jyXUisBGhU4xvevkxSPpfVfFl/L9jRVZoCxSDL64W/BOTOK
        PVhjzdg96Ohnnr6u/r8lpKvtXoC5jjDDrF+tefaY2nvuKep/RIfmndRXWpnec9Ko
        WHLSBxpSN+OClSXW8SfUxwZKQYKQK4o6h598Ax9lkSJTbB7K47qqn+k/DZIUKlus
        xqsn+sCyj8wf4qKTTy7pLzMiWisINlYFbMTT2Ngw2Va3NPSG2kTIODDGYvhYlGxz
        WEp5us7/Vmzee2HxghnXI8giqwtmkykgOUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696709691; x=1696796091; bh=HAd1G1CE8pMJy+IQqhNmJgcfkB8TtDe7tK8
        J8WflhKQ=; b=MyYd0mb0piU10gXi8GuZntCd+O9GcH7SazJXKah19uzTqldK11i
        Pc88fUtnls7jXyw+3GZxcemfk2gxYwouFiXs15LFaTrgKTpekpP5yKrV94oKDIbf
        TRpn0JSEoSu/X7ndo72Bl9jOgPr5aHF8Ww3ABb/SgCyxdUgT5zAvEIBJbVe2oODb
        FxK3Qj4NtajUXHOzNKPPIGmZkrhWwtdX96myNbaJzufV9R2BXOfg6QWTOqjrZHlf
        JwlGeMkMxOC+w7VaxmUKLOasEchr/oK0xOEum73rdGqL8km5XIcmxoJc92mrVq1G
        tng6l0Xkpkr73nGmMOPEKWziRo+04NX9ZMA==
X-ME-Sender: <xms:OrwhZRAPlNhx_Bvd-XO17N_zoRlfdORCB5MDks69NG2Bj-aQcUwwiw>
    <xme:OrwhZfjlSEcq07lAWr3TCJf8ZPBe7p5v_2qtS2jis65AZ7uC_ZRPta1anNjpuFtF3
    m5iquGjkyxQ8z6HNi8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeelgddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:OrwhZckSp-A9biPxEJktOQlu4jPHjgc7ZJ2VnylTeQGSw2VfWRV74w>
    <xmx:OrwhZbwBM6auAYtjcxGFWXgjsKZDhi2aRtneDrSgeMn43F7laynBDQ>
    <xmx:OrwhZWRp2nSlaAyP_Yad9U-rM_D4KIDhznsD4XYeACoJ22EqZAvyDA>
    <xmx:O7whZbIc_jFD4cQA8GYruD9tMo5TIrxpJ3Cmi_iLTlznhWkJl_20fg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 07853B60089; Sat,  7 Oct 2023 16:14:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <f98d0cf9-6339-4cb1-8019-56bc71bfb822@app.fastmail.com>
In-Reply-To: <20231004161038.2818327-4-gregory.clement@bootlin.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-4-gregory.clement@bootlin.com>
Date:   Sat, 07 Oct 2023 21:14:29 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Vladimir Kondratiev" <vladimir.kondratiev@intel.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 03/11] MIPS: support RAM beyond 32-bit
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



=E5=9C=A82023=E5=B9=B410=E6=9C=884=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=E5=
=8D=885:10=EF=BC=8CGregory CLEMENT=E5=86=99=E9=81=93=EF=BC=9A
> From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
>
> Support platforms where RAM is mapped beyond 32-bit.
>
> The kernel parameter ddr32_alias allows to setup the alias to point
> outside the first 4 GB of memory.

Are you trying to fix the problem that if kernel text is loaded in
XKPHYS there is no way to to set EBASE to that region?

The common practice for other 64bit MIPS system is to load kernel
in KSEG0 and add low 4G mirror with rest of the high memory to buddy
system. By doing this Kernel still have access to all memory beyond
32 bit, the only draw back is Kernel's text and data can't be relocted
beyond 32-bit.

Loading kernel into KSEG0 (i.e. with KBUILD_SYM32) have significant bene=
fit
on performance, so I think you shouldn't try to load kernel into XKPHYS
without a good reason, but it might be helpful to add a BUG_ON at
CPS driver to handle such situation.

Btw: Is your target hardware publicly available? Folks at CIP United
are looking for EyeQ5 boards for a while, they are supporting MIPS R6
support at various projects.

Thanks
Jiaxun

>
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  arch/mips/kernel/smp-cps.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
> index 47e76722a306..fcfb19487612 100644
> --- a/arch/mips/kernel/smp-cps.c
> +++ b/arch/mips/kernel/smp-cps.c
> @@ -34,6 +34,16 @@ static unsigned __init core_vpe_count(unsigned int=20
> cluster, unsigned core)
>  	return min(smp_max_threads, mips_cps_numvps(cluster, core));
>  }
>=20
> +static int ddr32_alias;
> +
> +static int __init ddr32_alias_setup(char *str)
> +{
> +	get_option(&str, &ddr32_alias);
> +
> +	return 0;
> +}
> +early_param("ddr32_alias", ddr32_alias_setup);
> +
>  /**
>   * plat_core_entry - query reset vector for NMI/reset
>   *
> @@ -52,7 +62,7 @@ static u32 plat_core_entry(void)
>  {
>  #if defined(CONFIG_USE_XKPHYS)
>  	return (UNCAC_ADDR(mips_cps_core_entry) & 0xffffffff)
> -			| CM_GCR_Cx_RESET_BASE_MODE;
> +			| ddr32_alias | CM_GCR_Cx_RESET_BASE_MODE;
>  #else
>  	return CKSEG1ADDR((unsigned long)mips_cps_core_entry);
>  #endif
> --=20
> 2.40.1

--=20
- Jiaxun
