Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD467CC2B7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjJQMOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbjJQMNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:13:51 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CAA93E2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:11:47 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue, 17 Oct 2023 14:09:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1697544572; bh=KD3DEtP5d6DCBHOitoR8vzNgmhwKZ20ThM66mmXaQDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3xiTCRTfXo07q+mWSyekXKERZRHw8/lwaQcPG8H37jzuclELv0P1eZcewRqi9xfm
         4FjwkD5E/CAI7Jsf1jt27JdGi4xolHrKm534XM7mLulgUbh3foeFQbVeHZrkGEgsx3
         6NcIgfurfJnD3rsiwm/mEe1Iw8nhHG8j82oJD9DM=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id CFCFB81EAD;
        Tue, 17 Oct 2023 14:09:31 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id B9EFA1819D1; Tue, 17 Oct 2023 14:09:31 +0200 (CEST)
Date:   Tue, 17 Oct 2023 14:09:31 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH 1/4] kbuild: remove ARCH_POSTLINK from module builds
Message-ID: <ZS55e3ZyzoNDchD+@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>, Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
References: <20231017103742.130927-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231017103742.130927-1-masahiroy@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1697544571-C3E340EE-41584499/0/0
X-purgate-type: clean
X-purgate-size: 585
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 07:37:39PM +0900, Masahiro Yamada wrote:
> The '%.ko' rule in arch/*/Makefile.postlink does nothing but call the
> 'true' command.
> 
> Remove the meaningless code.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/mips/Makefile.postlink    | 3 ---
>  arch/powerpc/Makefile.postlink | 3 ---
>  arch/riscv/Makefile.postlink   | 3 ---
>  arch/x86/Makefile.postlink     | 3 ---
>  scripts/Makefile.modfinal      | 5 +----
>  5 files changed, 1 insertion(+), 16 deletions(-)

Reviewed-by: Nicolas Schier <n.schier@avm.de>
