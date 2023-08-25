Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB9D788E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjHYSXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjHYSXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:23:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523AB270B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:23:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf092a16c9so10316175ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692987798; x=1693592598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ9zjJeALE62O4cw5IYTaJTtY+w53cmCJ0tqcg+cbfo=;
        b=HnyXQbm8I0wncS7q6bqpL+84nVc+SRO3gOlr6HSanLhtlUGqe3qLtjl9NoeWnceonY
         Wszkh9DExW9bToZKm+r3bfPJgD20l6FVa29cqrrXaEROEvs3vo6ecpcyMCQpnRom2zMm
         0cq8MEdGxeVtq9mis1PNV+itkvcfNqdyC6/XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692987798; x=1693592598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJ9zjJeALE62O4cw5IYTaJTtY+w53cmCJ0tqcg+cbfo=;
        b=WAXVk+IMMZrV7znC5ZhenOKBdf3LlSqZPnKZLY9rajbusMxHKA0L1nkAFQMo6SkQWz
         7XJWolpZu6U5+/cUZdrHE4Mpx5uTx57jeL7ynkruiyfZ/RtR4KLt/YIgmi4snzliCA4C
         gkJaiau0pxO3zVrqsmc9WAd8FQiL6g34GfYWqubnPj6DkXiS2RaXHUEm7uMmPwsjpfc/
         HQlOTGMt7kHVnjaaWCOIFFfGwkDrg+TQw/0M48GrKds0DQGFgkOVhDB3oqYo2T2lXXZ7
         nVsXgjN/Oq/Jkc6e/7v4uUicMrnvoKZ6xSpokmnnv6+ahBKXs5vyQ9S1Jjr6HvZeH2sf
         zEeQ==
X-Gm-Message-State: AOJu0YwVHYc/5fHvpWHxQT+AbWG+GsJ3x7NzKNE59jGVznjPkv7L+z0I
        yQrBSwIS3TyYs7jxretpkr9KVw==
X-Google-Smtp-Source: AGHT+IF5mGfC+hpo4uDUVvE34Zd1neo+8AiXRx90NzQv5YAzJzW8HNQDHc63LgGceQ+tSuoW87RpyA==
X-Received: by 2002:a17:903:24f:b0:1bf:4833:9c25 with SMTP id j15-20020a170903024f00b001bf48339c25mr22325045plh.36.1692987798689;
        Fri, 25 Aug 2023 11:23:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b001bc930d4517sm2078150pln.42.2023.08.25.11.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 11:23:18 -0700 (PDT)
Date:   Fri, 25 Aug 2023 11:23:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nicolas Schier <n.schier@avm.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kbuild: Show Kconfig fragments in "help"
Message-ID: <202308251121.23BAF46E@keescook>
References: <20230824223606.never.762-kees@kernel.org>
 <ZOg/pqoqhp/3rerZ@buildd.core.avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOg/pqoqhp/3rerZ@buildd.core.avm.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 07:44:06AM +0200, Nicolas Schier wrote:
> On Thu, Aug 24, 2023 at 03:36:10PM -0700, Kees Cook wrote:
> > Doing a "make help" would show only hard-coded Kconfig targets and
> > depended on the archhelp target to include ".config" targets. There was
> > nothing showing global kernel/configs/ targets. Solve this by walking
> > the wildcard list and include them in the output, using the first comment
> > line as the help text.
> > [...]
> 
> Thanks for that patch!  Several times I found myself searching the tree
> to find a specific kconfig fragment; I think you found a nice solution.
> Two minor things below.
> 
> [...]
> > diff --git a/kernel/configs/tiny-base.config b/kernel/configs/tiny-base.config
> > index 2f0e6bf6db2c..ac4d254abc3f 100644
> > --- a/kernel/configs/tiny-base.config
> > +++ b/kernel/configs/tiny-base.config
> > @@ -1 +1,2 @@
> > +# Minimal options for tiny systems
> >  CONFIG_EMBEDDED=y
> 
> (just a note: Randy prepared a patch for removing CONFIG_EMBEDDED:
> https://lore.kernel.org/linux-kbuild/20230816055010.31534-1-rdunlap@infradead.org/)

Ah yeah, I'll rebase this after the merge window, I guess...

> > diff --git a/kernel/configs/tiny.config b/kernel/configs/tiny.config
> > index 00009f7d0835..ea643e8f7f14 100644
> > --- a/kernel/configs/tiny.config
> > +++ b/kernel/configs/tiny.config
> > @@ -1,3 +1,5 @@
> > +# Smallest possible kernel image
> 
> For this fragment alone (not within 'tinyconfig'), "Size-optimize kernel
> image" possibly fits better?

Sounds good to me!

> > diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> > index af1c96198f49..c523f24b504a 100644
> > --- a/scripts/kconfig/Makefile
> > +++ b/scripts/kconfig/Makefile
> > @@ -93,11 +93,11 @@ endif
> >  %_defconfig: $(obj)/conf
> >  	$(Q)$< $(silent) --defconfig=arch/$(SRCARCH)/configs/$@ $(Kconfig)
> >  
> > -configfiles=$(wildcard $(srctree)/kernel/configs/$@ $(srctree)/arch/$(SRCARCH)/configs/$@)
> > +configfiles=$(wildcard $(srctree)/kernel/configs/$(1) $(srctree)/arch/$(SRCARCH)/configs/$(1))
> >  
> >  %.config: $(obj)/conf
> > -	$(if $(call configfiles),, $(error No configuration exists for this target on this architecture))
> > -	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m .config $(configfiles)
> > +	$(if $(call configfiles,$@),, $(error No configuration exists for this target on this architecture))
> > +	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m .config $(call configfiles,$@)
> >  	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> >  
> >  PHONY += tinyconfig
> > @@ -115,6 +115,7 @@ clean-files += tests/.cache
> >  
> >  # Help text used by make help
> >  help:
> > +	@echo  'Configuration targets:'
> >  	@echo  '  config	  - Update current config utilising a line-oriented program'
> >  	@echo  '  nconfig         - Update current config utilising a ncurses menu based program'
> >  	@echo  '  menuconfig	  - Update current config utilising a menu based program'
> > @@ -141,6 +142,12 @@ help:
> >  	@echo  '                    default value without prompting'
> >  	@echo  '  tinyconfig	  - Configure the tiniest possible kernel'
> >  	@echo  '  testconfig	  - Run Kconfig unit tests (requires python3 and pytest)'
> > +	@echo  ''
> > +	@echo  'Configuration fragment targets (for enabling various Kconfig items):'
> > +	@$(foreach c, $(call configfiles,*.config), \
> > +		printf "  %-20s - %s\\n" \
> > +			$(shell basename $(c)) \
> > +			"$(subst # ,,$(shell grep -m1 '^# ' $(c)))";)
> 
> Better use '$(notdir $(c))` instead of forking a shell with
> '$(shell basename $(c))'.

Ah! Thank you. I *knew* there was a function for this but couldn't find
it for some reason. :)

-- 
Kees Cook
