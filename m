Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B087CE1A9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjJRPt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjJRPty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:49:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ABB118;
        Wed, 18 Oct 2023 08:49:45 -0700 (PDT)
Received: from leknes.fjasle.eu ([94.134.20.103]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MsI8Y-1rgyEM38Ru-00tiyo; Wed, 18 Oct 2023 17:49:20 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 517AF3F8DD; Wed, 18 Oct 2023 17:49:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1697644159; bh=OH+EicPc7UzPOZaWyDPdScV+4OFzA+p27aCYY2OdDVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TDhaXrLVKs6Z73PEcsZiScLBFOKbK3T2aAS5GNhPUaOXRB/yHkF1npRH2+wD2qh75
         lLuF+dJVqiXlc2iPX+mvlKhqm+VvOb2cVZasXoZ7mlDSIM42UH+CwKnWvboFOMHH5O
         pRsRVpa5lnsARqIeuLBqMi6j1ZRBCW3oXJml9Z7s=
Date:   Wed, 18 Oct 2023 17:49:19 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, bpf@vger.kernel.org
Subject: Re: [bpf-next PATCH v2 4/4] kbuild: refactor module BTF rule
Message-ID: <ZS/+f1B049Z03ibU@fjasle.eu>
References: <20231018151950.205265-1-masahiroy@kernel.org>
 <20231018151950.205265-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018151950.205265-4-masahiroy@kernel.org>
X-Provags-ID: V03:K1:B4LQ7Ajm1gUh2v3KsatjhnDxISg3jTEx6iRLsNOe1KCfA0f33Je
 k7sYIst9yV21BPxNZHntNYoCfMfBn9JJ7u7RJb1MlDLUBJRKI9QHHG/+Qdt8GrCelKyrfoT
 jAaqgNcSyA5D0JtiGfbjKZ8PsxAMMrdWescAdP2w8NPlurLEVthJ35I8ul18GzB7Jp4SHGi
 cEOs6JCOLKzpjMHCAIHZA==
UI-OutboundReport: notjunk:1;M01:P0:7LyupFVRajo=;HaG9fJQ0BTCv8elAj/oujRlVEed
 H0bsNRk9itF5/r8Z7MKQZ5nkkke+8lKX2mNGRimNJyjPj2+wb4kmr9soUVJ7EGraPNULJhB5S
 33TbPpaXZ3MrwhO4ndFg6MCPlkP6kbUHRxCKGMBQLAjlpYRri/+98/BiNnEdzvRO6549foUe7
 vYHqrZjzobHfDTxKgOPWqlMzPcztS4UlrK5UDe0h+4H65TL481xSs+7qp0LWpAuEt7IQZvqsS
 vwwv420UzQaor0EoL448LgY4bkrxnNZ/sRXrV/45xec068hK6WXjrLtcUoYhDzKTIBUTmYrxG
 wdD7HhEKjjaOLZyXF4bHHwYFqinUVtqnI4YSBHEI4jDVc5plFaXjI/Fd/j0z9f3yBsw29ZyKQ
 HGfH55Se24rOl8BPiNO0Y9HI0CcAPT9FmoRjWw5wcysXQchLlCIv7vONUa7KtIUHbcG3rTE2J
 heNjHMu2BEDeGfrQj45/1XOQ89K7swRlWArL4nlUfDlqAjUloVkGvLWgxsoeRCgQ7HCbtj0B0
 T5j/Zqdl6wuk8xjRE6dAJ27jcd6AP38w7q9avWbhRBmIAFSmD0Tskbo4+6SftVWVddIIipmKi
 djyogVgs0xacZw6hT1l7nmHcLMipiIGVMYWAD2uFuHpeNTm0J0QPU+tC/v/DuxSEbAq6IIRuM
 lkLbkHb5mmQy6Sh/DvbJvGteEx8SPt5n62yTmQTj+3XVo3ihQmAhJ+9cQAz3ehFvrgRQsaZ6r
 QX3/VudGlm8FD+otBBmuyD+Vmxq3/j9d2iHRlPBXmw0P7BamYAUvZgMdgwaw+Z/mVfT2pMLU/
 vrLnuOZ3u1IykRj7QJ1vzm2lC3lDZmG//7y15JIM4BYATN3gBOM6QTDhHlMoJpljWb8CPNqZ9
 1RixvbBQ+Wgzb5w==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 12:19:50AM +0900 Masahiro Yamada wrote:
> newer_prereqs_except and if_changed_except are ugly hacks of the
> newer-prereqs and if_changed in scripts/Kbuild.include.
> 
> Remove.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v2:
>   - Fix if_changed_except to if_changed

thanks

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>



>  scripts/Makefile.modfinal | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 9fd7a26e4fe9..fc07854bb7b9 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -19,6 +19,9 @@ vmlinux :=
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>  ifneq ($(wildcard vmlinux),)
>  vmlinux := vmlinux
> +cmd_btf = ; \
> +	LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
> +	$(RESOLVE_BTFIDS) -b vmlinux $@
>  else
>  $(warning Skipping BTF generation due to unavailability of vmlinux)
>  endif
> @@ -41,27 +44,11 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>        cmd_ld_ko_o +=							\
>  	$(LD) -r $(KBUILD_LDFLAGS)					\
>  		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
> -		-T scripts/module.lds -o $@ $(filter %.o, $^)
> +		-T scripts/module.lds -o $@ $(filter %.o, $^)		\
> +	$(cmd_btf)
>  
> -quiet_cmd_btf_ko = BTF [M] $@
> -      cmd_btf_ko = 							\
> -		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
> -		$(RESOLVE_BTFIDS) -b vmlinux $@
> -
> -# Same as newer-prereqs, but allows to exclude specified extra dependencies
> -newer_prereqs_except = $(filter-out $(PHONY) $(1),$?)
> -
> -# Same as if_changed, but allows to exclude specified extra dependencies
> -if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
> -	$(cmd);                                                              \
> -	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
> -
> -# Re-generate module BTFs if either module's .ko or vmlinux changed
>  %.ko: %.o %.mod.o scripts/module.lds $(vmlinux) FORCE
> -	+$(call if_changed_except,ld_ko_o,vmlinux)
> -ifdef vmlinux
> -	+$(if $(newer-prereqs),$(call cmd,btf_ko))
> -endif
> +	+$(call if_changed,ld_ko_o)
>  
>  targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o)
>  
> -- 
> 2.40.1

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
