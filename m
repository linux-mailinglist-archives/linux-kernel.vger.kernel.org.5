Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4856180F6AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjLLT37 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 14:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjLLT36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:29:58 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D3C94;
        Tue, 12 Dec 2023 11:30:04 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5908b15f43eso479541eaf.1;
        Tue, 12 Dec 2023 11:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409404; x=1703014204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRKkCewynBnoUEfEV1iQ0hY5piRTK7NxRZDv0HhmpCk=;
        b=dQb/cj4EOFndEDhRh9D8+UjgGnQD8Mkn8NVkZH+s/SX7MbuxqY0/58NJF31R/Uogw4
         voswYVcCGNA5L+eA6D08WPm3EP8T2iPy2TSVBMDuKw9CSXtB2Gh/3lPGJ4kcYJ/My0O2
         5L7PdmHPFUHaYSAiwPNkqKPT/rBqap/1TEp1xA4zO/6TU3n/huejIFIH9O6Jku2+fHdc
         PJj+d7ImqWbtRXdgrXGD03ggjk4+JuG89fT4DzTjQBsc/UnIuk6HJ+lPAljlgeG20Lyc
         pcxd0HfhhDK3f6G/SOixcqU5nMpZYmZRX99qcnZSYYczMkDnL3M5Gp+fh/uzQKB2OlBO
         zsLg==
X-Gm-Message-State: AOJu0YyioZma9kGsKCOmRaRxFkcLkmHcDCupWhtHkqpuKZD7YLdPStBa
        yaY53XlM0vM8VJKlf4UPC9u9wwInCbXjmDyvirqaOEap
X-Google-Smtp-Source: AGHT+IG1h2jd1fJkxMNnyA+yoJj/GniGrfHBuQzNL3e1bAlKa4hQQp4/DofaVdGmYKGvNSlIT2Bc/414S7c0IUN6IQI=
X-Received: by 2002:a05:6820:220d:b0:58d:5302:5b18 with SMTP id
 cj13-20020a056820220d00b0058d53025b18mr13870325oob.1.1702409404156; Tue, 12
 Dec 2023 11:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20231205225045.32121-1-rdunlap@infradead.org>
In-Reply-To: <20231205225045.32121-1-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Dec 2023 20:29:52 +0100
Message-ID: <CAJZ5v0g6mZkhm84AU_LahCfKixRTj5AutFZfuCnLE0kcGxPGxg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: watchdog: fix kernel-doc warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 11:50 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix kernel-doc warnings found when using "W=1".
>
> acpi_watchdog.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> acpi_watchdog.c:85: warning: missing initial short description on line:
>  * Returns true if this system should prefer ACPI based watchdog instead of
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
>  drivers/acpi/acpi_watchdog.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
> --- a/drivers/acpi/acpi_watchdog.c
> +++ b/drivers/acpi/acpi_watchdog.c
> @@ -81,7 +81,7 @@ static const struct acpi_table_wdat *acp
>         return wdat;
>  }
>
> -/**
> +/*
>   * Returns true if this system should prefer ACPI based watchdog instead of
>   * the native one (which are typically the same hardware).
>   */

Applied as 6.8 material, thanks!
