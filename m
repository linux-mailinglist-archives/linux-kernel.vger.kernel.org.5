Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9AD7FB9F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbjK1MT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344302AbjK1MT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:19:26 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65829A3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:19:29 -0800 (PST)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 82C073F179
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701173967;
        bh=uYedx1kMhUbEA+kuU9UITe5MKMdsTFO44y0m5L3etwk=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=MWL0UUoBPU1CjgVnx8hXY8UMawBiK/VYSljvGu7PRI09t1cKAh6bufouxxjYt70gT
         4oMJ7XYr5ddLPKRuw8OKMhEecVeR0xSLsPaUyvq+6zQWICoqQrNnduB2r36NL4IrAi
         PIgfSHuzUHRYXeEB+1nQvYhajtpdWg4Pf0AVk7qPbbrY+VMxDKo+YgFkL2+HU13mxv
         G6dKBJhLu03Z+HJyGLV9vXxb5859OhnqvgSOXxbYBfH8rczIt6xSPmfGOFNAYJoHWo
         eMqMyoudBfHHDG3yaIFfnFOSBtGkjDNm6lDlESIs6GfMfmV+qtyL/g6lRHLsg25gYJ
         KPTwnitrqswPw==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4239047911bso60814061cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701173966; x=1701778766;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYedx1kMhUbEA+kuU9UITe5MKMdsTFO44y0m5L3etwk=;
        b=rOS+Ec6PT+ALy7dnWVeyRQvKBSVo4yZXyEmlG0e8wJFO0rnmOQIqXnyLvWI9rdJ5Sn
         ni2ZmBFXjw4oLzMUmgmU+EVu9qCZKMedcgg7tTH/vtOkEUF0f6Y4kFdBI/4/5TqNnhnR
         NbXsNM5+yAasTc/ZiH/UD7NfHjKPhuEwslsZ2tS2978kldpAnuxKwmUcdiqeVaS8tiuT
         czSPN4prrNKG5Zg5uzYPbwpkZ/Muu59g5icsfSoN3hwlebvHcOqKZfCuETsb75jFx0QQ
         NFvonFNplti+aVK5Fg8CoQUXfvfsNXR/q2oZN470TKrivzZTubUq6NYtoMF4JG0JOIq7
         vSfA==
X-Gm-Message-State: AOJu0YxY4wzSZHDI4Ea23sTpbkxf4iVY+lNc1GMEmQ4qJNhdPfm7ZMSf
        U+lbWcC17CajX5roiq8f03RkVitRe6V0srgsAtHrySgSg6iM1uZnLuwB8Bi3fQ1riw2Kbi3bSgl
        dQg/CBTZ6U7PrONqtpXvGUF2osH8Y02HhLhvfpX7Rn/7PSUrNHJ9mtYukyg==
X-Received: by 2002:a05:622a:1822:b0:423:8b9f:3a03 with SMTP id t34-20020a05622a182200b004238b9f3a03mr17334979qtc.26.1701173966522;
        Tue, 28 Nov 2023 04:19:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJjoyHA1G7hnpvnK0Yo2j5wPzeLGKzyoXlUzlcjPEbCIr1AWDnb7cMjq2gi5zvUeuWdkCX9ZH/CjM2tNtpp/M=
X-Received: by 2002:a05:622a:1822:b0:423:8b9f:3a03 with SMTP id
 t34-20020a05622a182200b004238b9f3a03mr17334960qtc.26.1701173966287; Tue, 28
 Nov 2023 04:19:26 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Nov 2023 13:19:25 +0100
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231126151739.1557369-1-masahiroy@kernel.org>
References: <20231126151739.1557369-1-masahiroy@kernel.org>
Mime-Version: 1.0
Date:   Tue, 28 Nov 2023 13:19:25 +0100
Message-ID: <CAJM55Z80u-0kmMkZDXxiiSOxktSHcSU_7CC6BwnK+3O2P-4=QQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: remove unneeded #include <asm-generic/export.h>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada wrote:
> There is no EXPORT_SYMBOL() line there, hence
> "#include <asm-generic/export.h>" is unneeded.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Thanks!
/Emil

> ---
>
>  arch/riscv/kernel/mcount-dyn.S | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> index 58dd96a2a153..952233aa273a 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -8,7 +8,6 @@
>  #include <asm/unistd.h>
>  #include <asm/thread_info.h>
>  #include <asm/asm-offsets.h>
> -#include <asm-generic/export.h>
>  #include <asm/ftrace.h>
>
>  	.text
> --
> 2.40.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
