Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080C47BD359
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345228AbjJIG1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbjJIG1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:27:14 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39AAA4
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 23:27:12 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7a7e11a53c3so3554400241.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 23:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696832832; x=1697437632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H2fxCUSPL89877g5I8VIeATWezF+t3F3yjBwJkxQ/GY=;
        b=OFgJ68XmziJUX3RXCZnLMAjcLe7TuG6xSpg20meNsf+7h8IKj1FIvXEY3quFRinjuC
         XuDkfeszFUOOCIjMWYUQ7YvOeiaT7/eVxB/TwVVO1l9PZAvhZ82H4YxasJrHV2mACXNj
         Inli+K8fmUERGnPUw7HWDgK+Yz0lsP3xYYgPRw/TGZDnbgKOT1AuGjihxDo80kUMvkEn
         71GiI9g7HzRVBg8rL91do+OJQNAZHRH4uOJ9et1g58mb1z3jWJO6l7zz8tWjdhA9IIGT
         Rxkf7lQsPCBOr7KIarWD11RUQ3p28sjxUOwlR5DygNsWIw05E0n8rYEKjh8rMqRY5ow/
         21oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696832832; x=1697437632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2fxCUSPL89877g5I8VIeATWezF+t3F3yjBwJkxQ/GY=;
        b=b5SFW3tpxG7iBgXM+/E0esns4uGYRnzWUlCqOb5+Mf1ZzyBDuw4jgN4aPX8YYDWDK3
         E1x3mIk3L0IaL6Zl47MNtCXZvWEH9xEZz+H35YPbJmiGPgfSaGJl/4dmWmvj37Z/2Q0e
         //wjG5tJYCxWH630QEhT3HdKbsDbeAwNt8vQxGPAsNmj6TFmsQNl2vrI1HsujKBPkhMV
         NVBJs1ecz/MJimm4CicHxIBOAbp0iqIFc/V6Q9m6EI/f2CqyiqmSgmvVMNnbQRHIVrMA
         IKinM9p73g7Zw1jlAeYNC7Z2OEC4KfEBbFjDmKDXSsxTeoPicqjiia2j1ETkgDqyPL35
         s7Aw==
X-Gm-Message-State: AOJu0YxTbPVkRkfcVfuGFWDoyAf54JVB99FVbtggeA/fMMw2N0qWVn2j
        gBGiW1mn3bIfU7TCW3QrFnBJWaK+j8myJ12YKzjA6w==
X-Google-Smtp-Source: AGHT+IHFuxIhjnW/F72VTuEWd0kd22F+rcKApMM/YlpphAXb/O+8udGUreXU3bqh1QrPTD1qFcFbPYCafuFoSOTuE2c=
X-Received: by 2002:a67:f656:0:b0:452:61fa:1e04 with SMTP id
 u22-20020a67f656000000b0045261fa1e04mr5510020vso.9.1696832831704; Sun, 08 Oct
 2023 23:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231007170448.505487-1-masahiroy@kernel.org>
In-Reply-To: <20231007170448.505487-1-masahiroy@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 9 Oct 2023 11:57:00 +0530
Message-ID: <CAFA6WYNqe-e_ZqbxXW5BcmMOxQr42mdJV-o4W4U4XcOsPe0P+Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] modpost: fix tee MODULE_DEVICE_TABLE built on big
 endian host
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Sat, 7 Oct 2023 at 22:34, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> When MODULE_DEVICE_TABLE(tee, ) is built on a host with a different
> endianness from the target architecture, it results in an incorrect
> MODULE_ALIAS().
>
> For example, see a case where drivers/char/hw_random/optee-rng.c
> is built as a module.
>
> If you build it on a little endian host, you will get the correct
> MODULE_ALIAS:
>
>     $ grep MODULE_ALIAS drivers/char/hw_random/optee-rng.mod.c
>     MODULE_ALIAS("tee:ab7a617c-b8e7-4d8f-8301-d09b61036b64*");
>
> However, if you build it on a big endian host, you will get a wrong
> MODULE_ALIAS:
>
>     $ grep MODULE_ALIAS drivers/char/hw_random/optee-rng.mod.c
>     MODULE_ALIAS("tee:646b0361-9bd0-0183-8f4d-e7b87c617aab*");
>
> This issue has been unnoticed because the ARM kernel is most likely built
> on a little endian host (cross-build on x86 or native-build on ARM).
>
> The uuid field must not be reversed because uuid_t is an array of __u8.
>

To me it wasn't obvious that DEF_FIELD() has certain endianness limitations.

> Fixes: 0fc1db9d1059 ("tee: add bus driver framework for TEE based devices")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/file2alias.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 7056751c29b1..70bf6a2f585c 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -1348,13 +1348,13 @@ static int do_typec_entry(const char *filename, void *symval, char *alias)
>  /* Looks like: tee:uuid */
>  static int do_tee_entry(const char *filename, void *symval, char *alias)
>  {
> -       DEF_FIELD(symval, tee_client_device_id, uuid);

As you have mentioned in patch #3: the limitations of TO_NATIVE(), if
you can update comments for DEF_FIELD() as well to make it clear that
it doesn't support byte arrays/strings would be helpful. I think the
following check that you have introduced in patch #3 can still be
bypassed for byte arrays/strings.

+ _Static_assert(sizeof(x) == 1 || sizeof(x) == 2 || \
+       sizeof(x) == 4 || sizeof(x) == 8, "bug");

BTW, for this fix feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> +       DEF_FIELD_ADDR(symval, tee_client_device_id, uuid);
>
>         sprintf(alias, "tee:%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
> -               uuid.b[0], uuid.b[1], uuid.b[2], uuid.b[3], uuid.b[4],
> -               uuid.b[5], uuid.b[6], uuid.b[7], uuid.b[8], uuid.b[9],
> -               uuid.b[10], uuid.b[11], uuid.b[12], uuid.b[13], uuid.b[14],
> -               uuid.b[15]);
> +               uuid->b[0], uuid->b[1], uuid->b[2], uuid->b[3], uuid->b[4],
> +               uuid->b[5], uuid->b[6], uuid->b[7], uuid->b[8], uuid->b[9],
> +               uuid->b[10], uuid->b[11], uuid->b[12], uuid->b[13], uuid->b[14],
> +               uuid->b[15]);
>
>         add_wildcard(alias);
>         return 1;
> --
> 2.39.2
>
