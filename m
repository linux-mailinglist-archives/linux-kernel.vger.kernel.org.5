Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F227531E7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjGNGZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbjGNGZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:25:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE432D63;
        Thu, 13 Jul 2023 23:25:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE3611F8B5;
        Fri, 14 Jul 2023 06:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689315931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B3nAJuGCjw43YPM8SKsPn8dm0PlKgr4q3ZnmQ4SFZgM=;
        b=ZYSxeZB7aB06jUg/vb9HeZAuoK+2JDnT8etNz8sz0/fxvK5GUxhQ7m74iKeqWJaJQ9yCD/
        /pEaWr/8ttDMVvKD98JNE5y+voF52RwnY2u+zZtZddni43J9grW+uq4thMofOKO0KlnG3O
        wfpFUHahHJ5XMb9yPxGl1z4mjOOt/08=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79514138F8;
        Fri, 14 Jul 2023 06:25:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QAmTHFvqsGTWGQAAMHmgww
        (envelope-from <jslaby@suse.com>); Fri, 14 Jul 2023 06:25:31 +0000
Message-ID: <30d8c675-e769-e567-a81f-c1b59c66ad67@suse.com>
Date:   Fri, 14 Jul 2023 08:25:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] depmod: Handle installing modules under a prefix
Content-Language: en-US
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
References: <da2fdd15-fae1-2bf6-04e7-568c715372ce@kernel.org>
 <20230712134533.4419-1-msuchanek@suse.de>
From:   Jiri Slaby <jslaby@suse.com>
In-Reply-To: <20230712134533.4419-1-msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 07. 23, 15:45, Michal Suchanek wrote:
> Some distributions aim at not shipping any files in / ustside of usr.

"outside".

> The path under which kernel modules are instaleld is hardcoded to /lib

"installed"

> which conflicts with this goal.
> 
> When kmod provides the config command use it to determine the correct
> module installation prefix.
> 
> On kmod that does not provide the command / is used as before.

Can you spice it with more commas? While the text is understandable 
after a while of staring, it's hard to parse.

Like:
When kmod provides the config command, use it to determine the correct 
module installation prefix.

On kmod that does not provide the command, / is used as before.





I would also argue here in the commit log on what Masahiro already 
pointed out. I.e. that INSTALL_MOD_PATH is useless in this case and why.

> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v2: Avoid error on systems with kmod that does not support config
> command
> ---
>   Makefile          | 4 +++-
>   scripts/depmod.sh | 8 ++++----
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 47690c28456a..b1fea135bdec 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?= $(INSTALL_PATH)/dtbs/$(KERNELRELEASE)
>   # makefile but the argument can be passed to make if needed.
>   #
>   
> -MODLIB	= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> +export KERNEL_MODULE_PREFIX := $(shell kmod config &> /dev/null && kmod config | jq -r .module_prefix)
> +
> +MODLIB	= $(INSTALL_MOD_PATH)$(KERNEL_MODULE_PREFIX)/lib/modules/$(KERNELRELEASE)
>   export MODLIB
>   
>   PHONY += prepare0
> diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> index 3643b4f896ed..88ac79056153 100755
> --- a/scripts/depmod.sh
> +++ b/scripts/depmod.sh
> @@ -27,16 +27,16 @@ fi
>   # numbers, so we cheat with a symlink here
>   depmod_hack_needed=true
>   tmp_dir=$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
> -mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
> +mkdir -p "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE"
>   if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
> -	if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o \
> -		-e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
> +	if test -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/modules.dep" -o \
> +		-e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
>   		depmod_hack_needed=false
>   	fi
>   fi
>   rm -rf "$tmp_dir"
>   if $depmod_hack_needed; then
> -	symlink="$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
> +	symlink="$INSTALL_MOD_PATH$KERNEL_MODULE_PREFIX/lib/modules/99.98.$KERNELRELEASE"
>   	ln -s "$KERNELRELEASE" "$symlink"
>   	KERNELRELEASE=99.98.$KERNELRELEASE
>   fi

-- 
js
suse labs

