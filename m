Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7987D2C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjJWII5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjJWII4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:08:56 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F4FA6;
        Mon, 23 Oct 2023 01:08:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B2FC45C0290;
        Mon, 23 Oct 2023 04:08:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 23 Oct 2023 04:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698048533; x=1698134933; bh=CO
        pt03Eh0fEEnCE5W21Vph3o8D+rTTaPmsSG2cQhMKM=; b=BkUqBezm7JcPV3K9Lu
        Wy+OacQyNYe0wCPzOGauv/L0seeMFHf4+xskSnHZqCFvzclTRy+iSt285XafKqVn
        CUxKz6RCuOqlxcPCDcLi94dtwSRFOOFj2+yb1VyOwKqIF7rSafdQcQBHZJbHpLdf
        zdZBcrHKFlCSfcvZ7kTapsFd4t7+X6wkViw/Ysvef8FldaHailfA/zR30RJyWp8X
        gEPIDWwwB6k9J6y0dKXhEJfSFJazwuGLS9SXSlL6NAr2gGUamxe8OeAnj/C1k/e9
        f4h3I8/tYwMloX1JEfyfEkWSp197+TFJdmYfpKzNqEtIm4H82LGPzZ0STw7JZy+7
        1ZHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698048533; x=1698134933; bh=COpt03Eh0fEEn
        CE5W21Vph3o8D+rTTaPmsSG2cQhMKM=; b=O+m18wVj4mkJV37R6uPel8zayuhyN
        +mbwrgqyTiBzBngipKf583Gjf9LLGk0T0nmt2j/OjbfUp18wRd69f4NC5IH8+8gL
        omiv/+g/IebNPTDwsUnMAatcMp6E5/wjqJ0DAfudz5dkOs6jL8z6/P0+kjEHrCI2
        vOOzZ8yNN9Zhzg9WRwXoP86+WbZK9NiPZzgX4j/R08IkuUn+1hMJftPIrJwo5DwU
        T4OOw01Hlh7gFddMfwNE+gGspjg5sY3AYMcpTDdfAGBsDnatDv57zHBcwRazBFG/
        0OcMzH78+VoYtjO7/jhKXn1hs/vlAAgTtH7JzynwKFZCbC0jau+/qPOIw==
X-ME-Sender: <xms:FSo2ZdlYG-VKMSTk7Un2OI2CFw79ChZj2-zOJsCV2kpOiheMo4uoOg>
    <xme:FSo2ZY3meXy79UfoqcwEFfPsEni-ZdzsFNQlgKvXTePUbFRDH9EP5Ycfxcr6wfu_d
    tc18iHcB5VPgD2WRLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeiucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdekteffnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvg
X-ME-Proxy: <xmx:FSo2ZTowZkzzfDOhWPrhcdYZsDcJbtQSF-DM51LQYK6E1TOPjv_Clg>
    <xmx:FSo2ZdkQMl2DBaqkBqLvbUXotq75RkSetU4_KTjz-b0j5nwb6K6yew>
    <xmx:FSo2Zb3mw5t2f4gT0E-pnQJJH1aszufa0kliKx0I5-zuXZz6cJyLXA>
    <xmx:FSo2Zb_6VKVMz8SRQ4_jisgO-NyEmApKYmPitRDvMxjQAYXMd2TptA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 56F06B60089; Mon, 23 Oct 2023 04:08:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <56c2d30b-2f25-4613-aab1-00fccbd2fa05@app.fastmail.com>
In-Reply-To: <20231023075714.21672-1-quic_aiquny@quicinc.com>
References: <20231023075714.21672-1-quic_aiquny@quicinc.com>
Date:   Mon, 23 Oct 2023 10:08:33 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Maria Yu" <quic_aiquny@quicinc.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH] arm64: module: PLT allowed even !RANDOM_BASE
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023, at 09:57, Maria Yu wrote:
> Module PLT feature can be enabled even when RANDOM_BASE is disabled.
> Break BLT entry counts of relocation types will make module plt entry
> allocation fail and finally exec format error for even correct and plt
> allocation available modules.
>
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>

Adding Ard Biesheuvel to Cc, as he added the check in commit
a257e02579e42 ("arm64/kernel: don't ban ADRP to work around
Cortex-A53 erratum #843419")

>  arch/arm64/kernel/module-plts.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/module-plts.c 
> b/arch/arm64/kernel/module-plts.c
> index bd69a4e7cd60..21a67d52d7a0 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -167,9 +167,6 @@ static unsigned int count_plts(Elf64_Sym *syms, 
> Elf64_Rela *rela, int num,
>  		switch (ELF64_R_TYPE(rela[i].r_info)) {
>  		case R_AARCH64_JUMP26:
>  		case R_AARCH64_CALL26:
> -			if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> -				break;
> -
>  			/*
>  			 * We only have to consider branch targets that resolve
>  			 * to symbols that are defined in a different section.

I see there are two such checks (in partition_branch_plt_relas()
and in count_plts()), can you explain in more detail how you
concluded that one of them is correct but the other one is not?

     Arnd
