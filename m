Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6164A7747F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbjHHTWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbjHHTWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A53C10F230
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:46:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9086623E2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 07:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F554C433C8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 07:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691478991;
        bh=up16RXyyZBwP5yRPc98CmAEJ6Vw7daUD5jnAUW1A1nk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dPc9u2+ftIntBXeQ/G/iFz0OZh8fmLeuLRkaF//kyCJHdfaajjTiK/RgnVodt/UAG
         TG1WZM5OLN49O62f8BWr9cSL4JGcuPetiMjieC3YKC3I57XX419PaAKyOyHZl5sCav
         i7dQMt8j0vgt3lZeibl9ukRpYdKcFBrEFIR5oZTYhZLxvm31q5X7kbTEozEhz62HKf
         X9oIYR7R721H64UK14DYt5IqrbLRGSj9I4nqkmhPfTZ4leWXEsdUuVZy50bpePhLLa
         LcKaTcVEN8cXJ8AQFmMgYSM9hrt3T/fJB12EqY6Pargk3t8odJ+gQH6up66PfzsGgb
         B/agY/uavwrrw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so13408951a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 00:16:31 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw6/lkbgiPeoPiv1cu29A+SZxds5pdMS9K410mzG/L71p/eq7YT
        x/8iJziZn/RELKYL+6kn5ZNUmh9GOvxolBNeUoM=
X-Google-Smtp-Source: AGHT+IG6Tq8NX0vBcna1c8tYYNYOuSSocyTGwpQCzh4u+BX6Zm9k5AscPm2jzl+rCgoDS6+AHYQW0/J+A23/8I41/qI=
X-Received: by 2002:a05:6402:5249:b0:51e:588b:20ca with SMTP id
 t9-20020a056402524900b0051e588b20camr10774580edd.8.1691478989598; Tue, 08 Aug
 2023 00:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230808034836.418485-1-xry111@xry111.site>
In-Reply-To: <20230808034836.418485-1-xry111@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 8 Aug 2023 15:16:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5=FJqx3FcR71LXuMB51PBAKXMO-t7DqJj_dr2BD-JtZw@mail.gmail.com>
Message-ID: <CAAhV-H5=FJqx3FcR71LXuMB51PBAKXMO-t7DqJj_dr2BD-JtZw@mail.gmail.com>
Subject: Re: [PATCH] loongarch: Remove spurious "source drivers/firmware/Kconfig"
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, WANG Xuerui <kernel@xen0n.name>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

I think the title should be "LoongArch: Remove redundant "source
drivers/firmware/Kconfig""?

Huacai

On Tue, Aug 8, 2023 at 11:49=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> In drivers/Kconfig, drivers/firmware/Kconfig is sourced for all ports so
> there is no need to source it in the port-specific Kconfig file.  And
> sourcing it here also caused the "Firmware Drivers" menu appeared two
> times: once in the "Device Drivers" menu, another time in the toplevel
> menu.  This was really puzzling.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index e71d5bf2cee0..465759f6b0ed 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -662,5 +662,3 @@ source "kernel/power/Kconfig"
>  source "drivers/acpi/Kconfig"
>
>  endmenu
> -
> -source "drivers/firmware/Kconfig"
> --
> 2.41.0
>
