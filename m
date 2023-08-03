Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DB776EB13
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbjHCNqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjHCNqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:46:30 -0400
X-Greylist: delayed 432 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 06:45:06 PDT
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5B4211B;
        Thu,  3 Aug 2023 06:45:06 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 96C6440E020D;
        Thu,  3 Aug 2023 13:37:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FnnYKYTeQsxm; Thu,  3 Aug 2023 13:37:19 +0000 (UTC)
Received: by mail.alien8.de (SuperMail on ZX Spectrum 128k, from userid 117)
        id 731B340E020B; Thu,  3 Aug 2023 14:02:22 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 645D740E0207;
        Thu,  3 Aug 2023 10:28:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AvEqVEFY10xg; Thu,  3 Aug 2023 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691058493; bh=q4S72/JMuWqMuG2QY64Nyis/Y58+yArPPZhr5Bmy248=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y2ZbJV3aP5rssvb9WJi3OM5yvT6iDlIkCuvTFAYyVNpoVrD6Yf76dIKHnry+XLNom
         FHEgN6RK/S8zY9tmXnG8xO6CD7nOU7hDqiUrV3yTsrUoeZHs7WsUKJU4HlNxPaRRtT
         yZquMQjnOwIZK7/b/jN6yWfSqW7ms99XBx+60lI0rU3ZaumnUDwznEGUFnUzqmsmbm
         +5wps+YsqO6zetSkI24+Sl+evx5y43EpXEgKiu+W7OhGP9mD3CM6xqOR+ggLdxQ4Ha
         n1ZGY1ilatC2NoyhkR1rm8gymFJkiNcDokUYhwcMH2WVCr2xSQAn3CEHQJgR6o1LbJ
         JZjVA5knGy5SolqwhTqqJQXzXvMfeynTGO/kgkGdEZUad8yCHZbWoAgI0HQruEDSim
         VJDj2Gk9EsN2H36dsXhNXEDe5WJs5PogKvvP0ZTpfPFBnrpNr0mQMgpdl3FmkWdryb
         slO7hNnaBmOr+sfLMFHz/K21aLqH5KjRWeypR/xR5PsrvzF2RMx1qNJESD8+ksTuUH
         8ZgXI9qmC+mmqsjWe1WJFdYFcZAJ0E3g8I8xkoOfP8pNlqF6t3aKS01qxg8x6MdMNJ
         tQVGxQa928/oBo8sRYNRQUKOZqnJU9b5s/xePETm6XrGUqxdf1TRvwU5ChjGdeyiaK
         GuJRYXaaUu9W7FVrb2AEB4aM=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63CF540E00B2;
        Thu,  3 Aug 2023 10:28:04 +0000 (UTC)
Date:   Thu, 3 Aug 2023 12:27:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Muralidhara M K <muralimk@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        nchatrad@amd.com, yazen.ghannam@amd.com,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH 4/7] EDAC/mc: Add new HBM3 memory type
Message-ID: <20230803102757.GJZMuBLb88I8n97oKN@fat_crate.local>
References: <20230720125425.3735538-1-muralimk@amd.com>
 <20230720125425.3735538-5-muralimk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720125425.3735538-5-muralimk@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 12:54:22PM +0000, Muralidhara M K wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> Add a new entry to 'enum mem_type' and a new string to 'edac_mem_types[]'

Do not talk about *what* the patch is doing in the commit message - that
should be obvious from the diff itself. Rather, concentrate on the *why*
it needs to be done.

> for HBM3 (High Bandwidth Memory Gen 3) new memory type.
> 
> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> ---
>  drivers/edac/edac_mc.c | 1 +
>  include/linux/edac.h   | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 6faeb2ab3960..d6eed727b0cd 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -166,6 +166,7 @@ const char * const edac_mem_types[] = {
>  	[MEM_NVDIMM]	= "Non-volatile-RAM",
>  	[MEM_WIO2]	= "Wide-IO-2",
>  	[MEM_HBM2]	= "High-bandwidth-memory-Gen2",
> +	[MEM_HBM3]	= "High-bandwidth-memory-Gen3",
>  };
>  EXPORT_SYMBOL_GPL(edac_mem_types);
>  
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index fa4bda2a70f6..1174beb94ab6 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -187,6 +187,7 @@ static inline char *mc_event_error_type(const unsigned int err_type)
>   * @MEM_NVDIMM:		Non-volatile RAM
>   * @MEM_WIO2:		Wide I/O 2.
>   * @MEM_HBM2:		High bandwidth Memory Gen 2.
> + * @MEM_HBM3:		High bandwidth Memory Gen 3.

s/bandwidth/Bandwidth/g

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
