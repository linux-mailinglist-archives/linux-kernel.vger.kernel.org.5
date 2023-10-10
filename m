Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A4D7BFF3E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjJJO2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjJJO2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:28:07 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE67B8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:05 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59e88a28b98so49552487b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696948085; x=1697552885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bEBYkWJqyT1UB0SUDPKF0kO0LYp7pOrEpPcCWpROQAI=;
        b=bHFQC3K0pq8QkHwcilC0BSoURI1vl7F7RIC/qGqxTJa15H0Q5+uOBB6UASFBOYymj0
         nyzz7P+Rw5TLQriXZNHP7Ej0VEtETWE4axpyMpo8E/nRt3vN6jZcjDNrAumuaieioJMS
         DLPUCgchX6lDHcHneJQfmkQr2McFzFw/78OdTOaS2ckyynqBOu3VKVg/NXpvueZIMbYq
         77dZ/Jw3jYM5whoLeASbBliSJO6j6MJiucXNWan74kYgiffce2OmPaFfe0m2rHkN075O
         ajcYwKYBXebWkjAbfOhmE3iVtDbiVWVlefU0r/aH6hfoTj3r+6WHE7DuP1eG4fYlOIOX
         K1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696948085; x=1697552885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEBYkWJqyT1UB0SUDPKF0kO0LYp7pOrEpPcCWpROQAI=;
        b=LVKSQfXkTMPwf2g3X06OEs2pi8klzz73u2usbFadhBDtM83cxap9tFjKjDWTac45wM
         DP0PDnCNF6zIlwLWC2sf4NhKzFmfIkxSwaxKYf79j8zWBmW7taWoQhk0Dph3YChyp/r0
         gSBuz/RppwAKuPg+vPQ3NGr3QUat4mmR9Tb9zX/GwE3n8MJ1oZor7dZptytHiiZiUyQt
         7ON7d3VGWCXQW+Iuw4o8NjD6+wDrRnf3jSi/kC+X1kpInoIKvs5dRaYPgAk0S+UNrp9b
         tMIIIsSzgE15SIJNG5HKsuAfdIerFl4/ktp7ZutrCPmq7kMVZQn2clExT455qJtyLvH4
         6Vzg==
X-Gm-Message-State: AOJu0YxagdMDZu1ZAzaiweaMZ37JRcF+Mkd7VNoJYmycvyIWF2Xd15Fz
        z/l5u4eC2gUsZ96n1fsZ8hH977EzP/yaLXlnoBNDjw==
X-Google-Smtp-Source: AGHT+IHrWbjPLELmkNwp7W9iKkSyj+EE2nybNhoYkJ+P1NG/GU9IoFGT770jKLo2O/lkhDKBpvscA2KHnxHZ64JowSo=
X-Received: by 2002:a81:49d7:0:b0:59b:5255:4882 with SMTP id
 w206-20020a8149d7000000b0059b52554882mr8379974ywa.20.1696948084806; Tue, 10
 Oct 2023 07:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231002135103.2602847-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231002135103.2602847-1-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 16:27:29 +0200
Message-ID: <CAPDyKFqfdNWhECFeO3PeTPnXkTJZY+BQ1+7OmU1O4osrSHr3+g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-pci: Switch to use acpi_evaluate_dsm_typed()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2023 at 15:51, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 7c14feb5db77..025b31aa712c 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -483,11 +483,12 @@ static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
>         int err = 0;
>         size_t len;
>
> -       obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &intel_dsm_guid, 0, fn, NULL);
> +       obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(dev), &intel_dsm_guid, 0, fn, NULL,
> +                                     ACPI_TYPE_BUFFER);
>         if (!obj)
>                 return -EOPNOTSUPP;
>
> -       if (obj->type != ACPI_TYPE_BUFFER || obj->buffer.length < 1) {
> +       if (obj->buffer.length < 1) {
>                 err = -EINVAL;
>                 goto out;
>         }
> --
> 2.40.0.1.gaa8946217a0b
>
