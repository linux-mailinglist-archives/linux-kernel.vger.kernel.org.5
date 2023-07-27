Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1F87650CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjG0KTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjG0KTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:19:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3527173F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5921C61E13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D395BC433CA;
        Thu, 27 Jul 2023 10:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690453171;
        bh=v9Xz5riwIR0HgvyWvbGHeuPbkWh6R0cVzSMB6uqSUOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q14nCng3maaQb3B4kymY8Nii/P1N6qN0ySyiGJNUnx3UK2wiPK4XSOhvCmhRnMb6i
         Xk3R5sA0yufNmXdPN6IY34bO2WkaXWdRSqA899vmRvJ8jGl7AuTDetRW9pnSpu2lQp
         cXwV+d+JcQ6FGBhUj7fpWRTTxq02scG/Cl5Z2QCAbmG46dE8PvWVA+Q/6eCh3KRytO
         IjHUxjsAPgn6+moV1yZg6OLVd1U7CidIIX9R+EG73TeV1plwV/IxlcucBWo1zTyFoS
         wNHf3225gLS2iNwg6cAQwyxC9Semces9zy22EHiIKCajKpofWjV1VGsG+jZSeV3KJC
         lz1glQo0GL4WQ==
Date:   Thu, 27 Jul 2023 11:19:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: vdso: remove two .altinstructions related symbols
Message-ID: <20230727101926.GB18721@willie-the-truck>
References: <20230726173619.3732-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726173619.3732-1-jszhang@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:36:19AM +0800, Jisheng Zhang wrote:
> The two symbols __alt_instructions and __alt_instructions_end are not
> used, remove them.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/arm64/kernel/vdso/vdso.lds.S | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> index 6028f1fe2d1c..45354f2ddf70 100644
> --- a/arch/arm64/kernel/vdso/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> @@ -50,9 +50,7 @@ SECTIONS
>  
>  	. = ALIGN(4);
>  	.altinstructions : {
> -		__alt_instructions = .;
>  		*(.altinstructions)
> -		__alt_instructions_end = .;
>  	}

If we don't need the symbols, then why do we need this section at all?

Will
