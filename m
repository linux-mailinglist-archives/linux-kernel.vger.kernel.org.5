Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597A9783DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjHVKMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjHVKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:12:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F3CE71;
        Tue, 22 Aug 2023 03:12:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A79BF6513E;
        Tue, 22 Aug 2023 10:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CD5C433C7;
        Tue, 22 Aug 2023 10:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692699118;
        bh=3TY7RlrbpvnWC+Bk/YuKNMm0OSj5WN4fV3WLVHMV7Hw=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Eb1lAaQbde0YeF+H8QAmV5iIFEzV2b2u4nTDJf7qQKKhyBBesep+qljS/8e8etj3e
         ZYjHku1SUooTf15g3V/m9YK7IiKLi3zrQk9GmBbr+RnVHlxfJncYlAHkyd8qoiBNLz
         EKjYGQSc6uThUD5cfuAkXL6NKNi/QzrFYUGvn1ZJn8BFIST0B9Issy6iyFjqkEZ2Hd
         GarHVjrtz5JU1zmJhmCQjOcZJbO2PXWgYqMVVrvM4nTrUjbRvOyrcrmiNxUAe1t7/h
         hGN0OMIOJcG6BQtdkjEHm5OcdJ7m1V34ZQLHeC90Uk9Uz0r1HtyQQgXC/E9Nli7R4Q
         pdrCpOuwOW4JQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 13:11:56 +0300
Message-Id: <CUYZRAU5D4UV.MSTZCT24FHV7@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 8/9] selftests/sgx: Separate linker options
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
 <20230819094332.8535-9-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230819094332.8535-9-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Aug 19, 2023 at 12:43 PM EEST, Jo Van Bulck wrote:
> Fixes "'linker' input unused [-Wunused-command-line-argument]" errors whe=
n
> compiling with clang.
>
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  tools/testing/selftests/sgx/Makefile | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftes=
ts/sgx/Makefile
> index 1d6315a2e..2de970f72 100644
> --- a/tools/testing/selftests/sgx/Makefile
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -12,9 +12,11 @@ OBJCOPY :=3D $(CROSS_COMPILE)objcopy
>  endif
> =20
>  INCLUDES :=3D -I$(top_srcdir)/tools/include
> -HOST_CFLAGS :=3D -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack
> +HOST_CFLAGS :=3D -Wall -Werror -g $(INCLUDES) -fPIC
> +HOST_LDFLAGS :=3D -z noexecstack -lcrypto
>  ENCL_CFLAGS :=3D -Wall -Werror -static-pie -nostdlib -nostartfiles -fPIE=
 \
>  	       -fno-stack-protector -mrdrnd $(INCLUDES)
> +ENCL_LDFLAGS :=3D -Wl,-T,test_encl.lds,--build-id=3Dnone
> =20
>  TEST_CUSTOM_PROGS :=3D $(OUTPUT)/test_sgx
>  TEST_FILES :=3D $(OUTPUT)/test_encl.elf
> @@ -28,7 +30,7 @@ $(OUTPUT)/test_sgx: $(OUTPUT)/main.o \
>  		    $(OUTPUT)/sigstruct.o \
>  		    $(OUTPUT)/call.o \
>  		    $(OUTPUT)/sign_key.o
> -	$(CC) $(HOST_CFLAGS) -o $@ $^ -lcrypto
> +	$(CC) $(HOST_CFLAGS) -o $@ $^ $(HOST_LDFLAGS)
> =20
>  $(OUTPUT)/main.o: main.c
>  	$(CC) $(HOST_CFLAGS) -c $< -o $@
> @@ -45,8 +47,8 @@ $(OUTPUT)/call.o: call.S
>  $(OUTPUT)/sign_key.o: sign_key.S
>  	$(CC) $(HOST_CFLAGS) -c $< -o $@
> =20
> -$(OUTPUT)/test_encl.elf: test_encl.lds test_encl.c test_encl_bootstrap.S
> -	$(CC) $(ENCL_CFLAGS) -T $^ -o $@ -Wl,--build-id=3Dnone
> +$(OUTPUT)/test_encl.elf: test_encl.c test_encl_bootstrap.S
> +	$(CC) $(ENCL_CFLAGS) $^ -o $@ $(ENCL_LDFLAGS)
> =20
>  EXTRA_CLEAN :=3D \
>  	$(OUTPUT)/test_encl.elf \
> --=20
> 2.25.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
