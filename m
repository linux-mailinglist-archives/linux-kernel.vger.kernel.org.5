Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7027771C04
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjHGIIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjHGIIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:08:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EDA1732
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:08:34 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686ea67195dso2961495b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 01:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691395714; x=1692000514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0S9B3el32amvm9+DJNBCQia8deJK384PYhU/huyTME=;
        b=h0NoadxuAU1egLmizFA7Kj4VsvEQkarLzW0z/S83hFOat1+1P7tsX2/j3OEpiIOoIq
         4vMApLtbJWddTNBrCVncTIqvR1Rt5oYF8A24OFfrAgB4LHhGtCvKE/vIHwzw3L5Cw0tr
         RGm2D+CvuFOBhvNllxYO1nVBKiGV3Lzeuf8QMTbG2OzOfkZkwiV9Bk9PHPi4FTZGMauo
         cb7EUFm/j6WfXCwZviqxVLOJ8GQ8A1juOvLANbtt7XGc2vZbFzRZGHnDNzeJGd2LGwG6
         8UeMH8pO/34pPvKUCCrDXJiCXbv5xneV4o3RP1iLkRIr1ZWufgZvUGWlR7pTRtMpQfU5
         Qw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691395714; x=1692000514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0S9B3el32amvm9+DJNBCQia8deJK384PYhU/huyTME=;
        b=E2PXxT72ZKVblRrXm7Uwfnl+bjdf/ereNmbSmHWhXpVx8yjESqplX8VtMR3dPI/JBZ
         YqNE3Hz+YkdSHtzJi/HGdY7jrowbzIU23Z/uLMAVcmJDNw2CD/QHy+m4eC0MdclwnrY6
         evFHDurhgRq6NkkCe8rOhvEjm9AVnf9d+oM19jUj3T2esH7wmqlAmZCj2W0AYVG79YtY
         vxmSh1eqCRwmUJolQXaqJHy44bjy2sn1xk4BPd/opN9CsWuB36MDw69lZYtinDGD+yPQ
         FDNuLUnDdOd6OCfhvpjQ2trS4sEstei/XlDCVcv9XAVRTE7Euw1zIqqq79IbkQYW5PQK
         8umQ==
X-Gm-Message-State: AOJu0Yz+EsiAifpDvVS3AByEp07Zc6cVqH69B2WJgtIKkjFEU7f5kmve
        +gtCam/ZQtrfHHeHLBGppGY=
X-Google-Smtp-Source: AGHT+IEZt6o3YTY9hNxtkUonfFu2YPRHASomV3dhtmND4K83V8FK8zx/H6HakwTRu7TG2VCHzWhNzQ==
X-Received: by 2002:a05:6a20:4328:b0:13e:2080:aba2 with SMTP id h40-20020a056a20432800b0013e2080aba2mr11005654pzk.38.1691395714325;
        Mon, 07 Aug 2023 01:08:34 -0700 (PDT)
Received: from [192.168.0.101] ([49.207.242.210])
        by smtp.gmail.com with ESMTPSA id fm21-20020a056a002f9500b0068709861cb6sm5549741pfb.137.2023.08.07.01.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 01:08:34 -0700 (PDT)
Message-ID: <c98ffcdc-1e2f-4496-99a3-3b590002e5b1@gmail.com>
Date:   Mon, 7 Aug 2023 13:38:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] kbuild: modinst: do modules_install step by step
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
References: <20230623145358.568971-1-yesshedi@gmail.com>
 <20230623145358.568971-9-yesshedi@gmail.com>
 <CAK7LNARnuaOi-GwW0qnFgH5styuUTtmjSNWV92PEO6VgpqNvQg@mail.gmail.com>
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <CAK7LNARnuaOi-GwW0qnFgH5styuUTtmjSNWV92PEO6VgpqNvQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/23 01:02, Masahiro Yamada wrote:
> On Fri, Jun 23, 2023 at 11:54 PM Shreenidhi Shedi <yesshedi@gmail.com> wrote:
>>
>> Currently Makefile.modinst does three tasks on each module built:
>> - Install modules
>> - Sign modules
>> - Compress modules
>>
>> All the above tasks happen from a single place.
>>
>> This patch divides this task further and uses a different makefile for
>> each task.
>> Signing module logic is completely refactored and everything happens
>> from a shell script now.
>>
>> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
> 
> 
> This patch is bad in multiple ways.
> 
> 1. Break "make modules_sign"

Correct, somehow I missed it. I will fix it.
I'm using below command to test sign only option. Please let me know if 
I should use something else.

make modules_sign modules_sign_only=1 INSTALL_MOD_PATH=$PWD/tmp -j8

> 2.   Serialize the installation steps, that is, works less efficiently

Even in the existing system it happens in serially. And the existing 
method takes more time than the proposed version.

root@ph5dev:~/linux-6.3.5 # ./test.sh orig

real	0m14.699s
user	0m55.519s
sys	0m9.036s

root@ph5dev:~/linux-6.3.5 # ./test.sh new

real	0m13.327s
user	0m46.885s
sys	0m6.770s

Here is my test script.
```
#!/bin/bash

set -e

if [ "$1" != "new" ] && [ "$1" != "orig" ]; then
   echo "invalid arg, ($0 [orig|new])" >&2
   exit 1
fi

rm -rf $PWD/tmp

s="scripts/sign-file.c"
m="scripts/Makefile.modinst"
fns=($s $m)

for f in ${fns[@]}; do
     cp $f.$1 $f
done

cd scripts
gcc -o sign-file sign-file.c -lcrypto
cd -

time make modules_install INSTALL_MOD_PATH=$PWD/tmp -s -j$(nproc)
```

> 3.   Increase code without adding any benefits.
>Agree with increased code but this change is one step closer to Unix 
philosophy, do one thing well wrt modules_install.

> 
> There is no good reason to do these chang >I hope the data I provided above to your 2nd point provides evidence 
that this fix is improving existing system. Please take a look again.

> NACK.

Hi Masahiro Yamada,

Replies inline above.

Please correct me if my understanding is wrong. Thanks a lot for your 
time and patience. Have a nice time ahead.

> 
> 
> 
> 
> 
>> ---
>>   scripts/Makefile.compress |  53 ++++++++++++++++++
>>   scripts/Makefile.install  |  66 +++++++++++++++++++++++
>>   scripts/Makefile.modinst  | 111 +++-----------------------------------
>>   scripts/Makefile.sign     |  37 +++++++++++++
>>   scripts/signfile.sh       |  24 +++++++++
>>   5 files changed, 186 insertions(+), 105 deletions(-)
>>   create mode 100644 scripts/Makefile.compress
>>   create mode 100644 scripts/Makefile.install
>>   create mode 100644 scripts/Makefile.sign
>>   create mode 100755 scripts/signfile.sh
>>
>> diff --git a/scripts/Makefile.compress b/scripts/Makefile.compress
>> new file mode 100644
>> index 000000000000..35d337ac9b6c
>> --- /dev/null
>> +++ b/scripts/Makefile.compress
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# ==========================================================================
>> +# Compressing modules
>> +# ==========================================================================
>> +
>> +PHONY := __modcompress
>> +__modcompress:
>> +
>> +include include/config/auto.conf
>> +include $(srctree)/scripts/Kbuild.include
>> +
>> +modules := $(call read-file, $(MODORDER))
>> +
>> +ifeq ($(KBUILD_EXTMOD),)
>> +dst := $(MODLIB)/kernel
>> +else
>> +INSTALL_MOD_DIR ?= updates
>> +dst := $(MODLIB)/$(INSTALL_MOD_DIR)
>> +endif
>> +
>> +suffix-y                               :=
>> +suffix-$(CONFIG_MODULE_COMPRESS_GZIP)  := .gz
>> +suffix-$(CONFIG_MODULE_COMPRESS_XZ)    := .xz
>> +suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)  := .zst
>> +
>> +modules := $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(modules))
>> +
>> +__modcompress: $(modules)
>> +       @:
>> +
>> +#
>> +# Compression
>> +#
>> +quiet_cmd_gzip = GZIP    $@
>> +      cmd_gzip = $(KGZIP) -n -f $<
>> +quiet_cmd_xz = XZ      $@
>> +      cmd_xz = $(XZ) --lzma2=dict=2MiB -f $<
>> +quiet_cmd_zstd = ZSTD    $@
>> +      cmd_zstd = $(ZSTD) -T0 --rm -f -q $<
>> +
>> +$(dst)/%.ko.gz: $(dst)/%.ko FORCE
>> +       $(call cmd,gzip)
>> +
>> +$(dst)/%.ko.xz: $(dst)/%.ko FORCE
>> +       $(call cmd,xz)
>> +
>> +$(dst)/%.ko.zst: $(dst)/%.ko FORCE
>> +       $(call cmd,zstd)
>> +
>> +PHONY += FORCE
>> +FORCE:
>> +
>> +.PHONY: $(PHONY)
>> diff --git a/scripts/Makefile.install b/scripts/Makefile.install
>> new file mode 100644
>> index 000000000000..40c496cb99dc
>> --- /dev/null
>> +++ b/scripts/Makefile.install
>> @@ -0,0 +1,66 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# ==========================================================================
>> +# Installing modules
>> +# ==========================================================================
>> +
>> +PHONY := __modinstall
>> +__modinstall:
>> +
>> +include include/config/auto.conf
>> +include $(srctree)/scripts/Kbuild.include
>> +
>> +modules := $(call read-file, $(MODORDER))
>> +
>> +ifeq ($(KBUILD_EXTMOD),)
>> +dst := $(MODLIB)/kernel
>> +else
>> +INSTALL_MOD_DIR ?= updates
>> +dst := $(MODLIB)/$(INSTALL_MOD_DIR)
>> +endif
>> +
>> +$(foreach x, % :, $(if $(findstring $x, $(dst)), \
>> +       $(error module installation path cannot contain '$x')))
>> +
>> +modules := $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(modules))
>> +
>> +__modinstall: $(modules)
>> +       @:
>> +
>> +#
>> +# Installation
>> +#
>> +quiet_cmd_install = INSTALL $@
>> +      cmd_install = mkdir -p $(dir $@); cp $< $@
>> +
>> +# Strip
>> +#
>> +# INSTALL_MOD_STRIP, if defined, will cause modules to be stripped after they
>> +# are installed. If INSTALL_MOD_STRIP is '1', then the default option
>> +# --strip-debug will be used. Otherwise, INSTALL_MOD_STRIP value will be used
>> +# as the options to the strip command.
>> +ifdef INSTALL_MOD_STRIP
>> +
>> +ifeq ($(INSTALL_MOD_STRIP),1)
>> +strip-option := --strip-debug
>> +else
>> +strip-option := $(INSTALL_MOD_STRIP)
>> +endif
>> +
>> +quiet_cmd_strip = STRIP   $@
>> +      cmd_strip = $(STRIP) $(strip-option) $@
>> +
>> +else
>> +
>> +quiet_cmd_strip =
>> +      cmd_strip = :
>> +
>> +endif
>> +
>> +$(dst)/%.ko: $(extmod_prefix)%.ko FORCE
>> +       $(call cmd,install)
>> +       $(call cmd,strip)
>> +
>> +PHONY += FORCE
>> +FORCE:
>> +
>> +.PHONY: $(PHONY)
>> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
>> index ab0c5bd1a60f..d87e09e57963 100644
>> --- a/scripts/Makefile.modinst
>> +++ b/scripts/Makefile.modinst
>> @@ -1,116 +1,17 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   # ==========================================================================
>> -# Installing modules
>> +# Install, Sign & Compress modules
>>   # ==========================================================================
>>
>> -PHONY := __modinst
>> -__modinst:
>> -
>>   include include/config/auto.conf
>>   include $(srctree)/scripts/Kbuild.include
>>
>> -modules := $(call read-file, $(MODORDER))
>> -
>> -ifeq ($(KBUILD_EXTMOD),)
>> -dst := $(MODLIB)/kernel
>> -else
>> -INSTALL_MOD_DIR ?= updates
>> -dst := $(MODLIB)/$(INSTALL_MOD_DIR)
>> -endif
>> -
>> -$(foreach x, % :, $(if $(findstring $x, $(dst)), \
>> -       $(error module installation path cannot contain '$x')))
>> -
>> -suffix-y                               :=
>> -suffix-$(CONFIG_MODULE_COMPRESS_GZIP)  := .gz
>> -suffix-$(CONFIG_MODULE_COMPRESS_XZ)    := .xz
>> -suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)  := .zst
>> -
>> -modules := $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(modules))
>> -
>> -__modinst: $(modules)
>> -       @:
>> -
>> -#
>> -# Installation
>> -#
>> -quiet_cmd_install = INSTALL $@
>> -      cmd_install = mkdir -p $(dir $@); cp $< $@
>> -
>> -# Strip
>> -#
>> -# INSTALL_MOD_STRIP, if defined, will cause modules to be stripped after they
>> -# are installed. If INSTALL_MOD_STRIP is '1', then the default option
>> -# --strip-debug will be used. Otherwise, INSTALL_MOD_STRIP value will be used
>> -# as the options to the strip command.
>> -ifdef INSTALL_MOD_STRIP
>> -
>> -ifeq ($(INSTALL_MOD_STRIP),1)
>> -strip-option := --strip-debug
>> -else
>> -strip-option := $(INSTALL_MOD_STRIP)
>> -endif
>> -
>> -quiet_cmd_strip = STRIP   $@
>> -      cmd_strip = $(STRIP) $(strip-option) $@
>> -
>> -else
>> -
>> -quiet_cmd_strip =
>> -      cmd_strip = :
>> -
>> -endif
>> -
>> -#
>> -# Signing
>> -# Don't stop modules_install even if we can't sign external modules.
>> -#
>> -ifeq ($(CONFIG_MODULE_SIG_ALL),y)
>> -ifeq ($(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
>> -sig-key := $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CONFIG_MODULE_SIG_KEY)
>> -else
>> -sig-key := $(CONFIG_MODULE_SIG_KEY)
>> -endif
>> -quiet_cmd_sign = SIGN    $@
>> -      cmd_sign = scripts/sign-file $(CONFIG_MODULE_SIG_HASH) "$(sig-key)" certs/signing_key.x509 $@ \
>> -                 $(if $(KBUILD_EXTMOD),|| true)
>> -else
>> -quiet_cmd_sign :=
>> -      cmd_sign := :
>> -endif
>> -
>> -ifeq ($(modules_sign_only),)
>> -
>> -$(dst)/%.ko: $(extmod_prefix)%.ko FORCE
>> -       $(call cmd,install)
>> -       $(call cmd,strip)
>> -       $(call cmd,sign)
>> -
>> -else
>> -
>> -$(dst)/%.ko: FORCE
>> -       $(call cmd,sign)
>> -
>> -endif
>> -
>> -#
>> -# Compression
>> -#
>> -quiet_cmd_gzip = GZIP    $@
>> -      cmd_gzip = $(KGZIP) -n -f $<
>> -quiet_cmd_xz = XZ      $@
>> -      cmd_xz = $(XZ) --lzma2=dict=2MiB -f $<
>> -quiet_cmd_zstd = ZSTD    $@
>> -      cmd_zstd = $(ZSTD) -T0 --rm -f -q $<
>> -
>> -$(dst)/%.ko.gz: $(dst)/%.ko FORCE
>> -       $(call cmd,gzip)
>> -
>> -$(dst)/%.ko.xz: $(dst)/%.ko FORCE
>> -       $(call cmd,xz)
>> +PHONY := __modinst
>>
>> -$(dst)/%.ko.zst: $(dst)/%.ko FORCE
>> -       $(call cmd,zstd)
>> +__modinst: FORCE
>> +       $(MAKE) -f scripts/Makefile.install
>> +       $(MAKE) -f scripts/Makefile.sign
>> +       $(MAKE) -f scripts/Makefile.compress
>>
>>   PHONY += FORCE
>>   FORCE:
>> diff --git a/scripts/Makefile.sign b/scripts/Makefile.sign
>> new file mode 100644
>> index 000000000000..d6b242b16657
>> --- /dev/null
>> +++ b/scripts/Makefile.sign
>> @@ -0,0 +1,37 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# ==========================================================================
>> +# Signing modules
>> +# ==========================================================================
>> +
>> +PHONY := __modsign
>> +__modsign:
>> +
>> +include include/config/auto.conf
>> +include $(srctree)/scripts/Kbuild.include
>> +
>> +#
>> +# Signing
>> +# Don't stop modules_install even if we can't sign external modules.
>> +#
>> +ifeq ($(CONFIG_MODULE_SIG_ALL),y)
>> +ifeq ($(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
>> +sig-key := $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CONFIG_MODULE_SIG_KEY)
>> +else
>> +sig-key := $(CONFIG_MODULE_SIG_KEY)
>> +endif
>> +quiet_cmd_sign = SIGNING ALL MODULES ...
>> +      cmd_sign = $(CONFIG_SHELL) $(srctree)/scripts/signfile.sh \
>> +                                        "$(CONFIG_MODULE_SIG_HASH)" \
>> +                                        "$(sig-key)"
>> +else
>> +quiet_cmd_sign :=
>> +      cmd_sign := :
>> +endif
>> +
>> +__modsign: FORCE
>> +       $(call cmd,sign)
>> +
>> +PHONY += FORCE
>> +FORCE:
>> +
>> +.PHONY: $(PHONY)
>> diff --git a/scripts/signfile.sh b/scripts/signfile.sh
>> new file mode 100755
>> index 000000000000..b2b58bfbd5ba
>> --- /dev/null
>> +++ b/scripts/signfile.sh
>> @@ -0,0 +1,24 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# A sign-file wrapper used by scripts/Makefile.sign
>> +
>> +#set -x
>> +
>> +if test $# -ne 2; then
>> +       echo "Usage: $0 <hash-algo> <sign-key>" >&2
>> +       exit 1
>> +fi
>> +
>> +SIG_HASH="$1"
>> +SIG_KEY="$2"
>> +
>> +MODULES_PATH="${INSTALL_MOD_PATH}/lib/modules/${KERNELRELEASE}"
>> +
>> +find "${MODULES_PATH}" -name *.ko -type f -print0 | \
>> +       xargs -r -0 -P$(nproc) -x -n32 sh -c "\
>> +${srctree}/scripts/sign-file \
>> +-a \"${SIG_HASH}\" \
>> +-i \"${SIG_KEY}\" \
>> +-x ${srctree}/certs/signing_key.x509 \
>> +-b \$@ \$0"
>> --
>> 2.41.0
>>
> 
> 

-- 
Shedi

