Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBF87B745D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 00:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjJCW5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 18:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjJCW5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:57:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFCFB0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 15:57:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so2640912a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 15:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696373829; x=1696978629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNJ4V21M91PAJnutJlU6BdqwkvAfNI28YR+w3lb7qz0=;
        b=FlzORDkkg7tyvRYrDZ31U0Z2lEs+wu93DA5sSpR2UV3YqRfU5BRcG3bUoaydaox5ki
         lTp9WJrTlPrzX1OuW2vzeqqnIKtowcXcVGKipKR6nwNR2prDZbD3n4ENwL+VJb6F/jih
         YkExgjBcMYKpnNkrpqbXLfR+jEthWcX+BoMtLNoQWzRz9Srptk8gSH3x9ptCz5p/WB8b
         s8hKuw6eI91+WkUxEZ8QuhptZEVOmhV7Bu0ai428Ia0oupD7fCF+XqBGDX2RW+qza25R
         MNG9VmV4vM5W9m0FekxDmhxd75maou7o+7TgfI8Wv935k+O4i3eRFNIg6G05HRrBY4sG
         P3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696373829; x=1696978629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNJ4V21M91PAJnutJlU6BdqwkvAfNI28YR+w3lb7qz0=;
        b=T3eVXUOsmggw0ZUfUJFtHPDBX67kCpctHaANktY3CN0cI5Gq8Eaqil9vdfwAkbS107
         NV3NY6YubpSTpGXaAuEHekGRb2Qrp9hC03n3xlrds8Cuz0o93vVtRGBPVP1K1MMxHUHf
         p5d6bOzcC61bbacWg7sHePbd+YbWPWtVwz0/4Sk8yz0QWTjFK8aQF56Jen8Z2o6GJeNS
         7tSJTgDm4BKFEF8JsaYO1oUODzxFSxIRpKc/Z3i2Yu8Ih3S0kk5lNTvp9mNeHGlWPvAK
         BddLUZJgIvFFRj0dcjEcpwZh47tM7azDENeWC0Lyu2NBvmERP8TXzU3yjCpizJqb+b2A
         3GwA==
X-Gm-Message-State: AOJu0YySK0feQdg5Jy7nGMZRCXlQOdQsIVZN9TSaiGShzaHFNE4NJbG4
        ZrNYpHJckhreYhAoHSAfG5TWOUij6LyAddQOL+jt+w==
X-Google-Smtp-Source: AGHT+IGU3gyaT977jvt9iRD1Ew9XlWTiuArkryKIRq2HRhld6gv/M4qSWfTxLUS5n5K9yVhjHJogubJlzCAW0Ey3Gyk=
X-Received: by 2002:a17:906:210a:b0:9ae:56da:6068 with SMTP id
 10-20020a170906210a00b009ae56da6068mr563304ejt.57.1696373829597; Tue, 03 Oct
 2023 15:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175351.work.018-kees@kernel.org>
In-Reply-To: <20230922175351.work.018-kees@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 3 Oct 2023 15:56:57 -0700
Message-ID: <CAFhGd8pHzbdcSaxjJHVHTAVrsxVPptn+OfwNjQ0RMEsOS3xRiw@mail.gmail.com>
Subject: Re: [PATCH] mailbox: zynqmp: Annotate struct zynqmp_ipi_pdata with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:54=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct zynqmp_ipi_pdata=
.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Great patch! Crucially, the count is _correctly_ assigned
to before the flexible array member is accessed.

Reviewed-by: Justin Stitt <justinstitt@google.com>

>  drivers/mailbox/zynqmp-ipi-mailbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqm=
p-ipi-mailbox.c
> index e4fcac97dbfa..7fa533e80dd9 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -108,7 +108,7 @@ struct zynqmp_ipi_pdata {
>         unsigned int method;
>         u32 local_id;
>         int num_mboxes;
> -       struct zynqmp_ipi_mbox ipi_mboxes[];
> +       struct zynqmp_ipi_mbox ipi_mboxes[] __counted_by(num_mboxes);
>  };
>
>  static struct device_driver zynqmp_ipi_mbox_driver =3D {
> --
> 2.34.1
>
>
Thanks
Justin
