Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36970752728
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjGMPcu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 11:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjGMPcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:32:35 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2765930F5;
        Thu, 13 Jul 2023 08:32:15 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b6e2eb71c2so3053281fa.0;
        Thu, 13 Jul 2023 08:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689262287; x=1691854287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEgyv0cci576WGyNwcqpYH0DIUtSj32VEpSp0sob1x0=;
        b=SdduFklWkFLg9fzqbUSR9ERoebu0nLYW26A17cPHbWeHFKPNgvRY4CLKya8fcjWhjj
         wix6QGyuIDBPS3aRqbVZufJbi2oqvSJQeHCvvuhPW2LERLgyndCanVJGqQ0skHtVXse3
         cOxALwVrgIVZS1e1owsOvzccxNqlKlZiNLkq785OvLAuwBRyIuE+pOh3HKhg4fw/P+1E
         mMWHVbp4mkvPzy7gigmt7vj/OEnAj3+GTwyTFAuohkX2NFYrtN7GvaV9Gtp6IQVcDcUA
         gQwl4xvoB7UYU7mYTlqEitCoInfHe8qHwKdH1O2dfNu/2afsUMsps/u5RHSgvkkZvWfL
         eGsg==
X-Gm-Message-State: ABy/qLZqjEkS4uxXcfC4RT+C95MDu8bmO/2J7a6eqHHC7MlU0o7vPZ0c
        rsM8lfcc/vfcEk+x2xttlNOCisnSgNWTYVLejRg=
X-Google-Smtp-Source: APBJJlEGN3mNfwXC0sE4w/L4+BmaoxzzZtLJMqiLhNNMHvhfRQ4zywUSnqrxaZLo/LCt7DSNgjrLuJowHeXKPazohes=
X-Received: by 2002:a2e:be10:0:b0:2b7:2ca0:989a with SMTP id
 z16-20020a2ebe10000000b002b72ca0989amr1823257ljq.5.1689262287093; Thu, 13 Jul
 2023 08:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230712172459.20275-1-mario.limonciello@amd.com>
In-Reply-To: <20230712172459.20275-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Jul 2023 17:31:16 +0200
Message-ID: <CAJZ5v0jDpMNsWztgPDfLG3eGw3YOxK_ygWRLgHmbZUoMh97tbw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: thermal: Drop nocrt parameter
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 7:25 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The `nocrt` module parameter has no code associated with it and does
> nothing.  As `crt=-1` has same functionality as what nocrt should be
> doing drop `nocrt` and associated documentation.
>
> This should fix a quirk for Gigabyte GA-7ZX that used `nocrt` and
> thus didn't function properly.
>
> Fixes: 8c99fdce3078 ("ACPI: thermal: set "thermal.nocrt" via DMI on Gigabyte GA-7ZX")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Stable material I suppose?

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ----
>  drivers/acpi/thermal.c                          | 6 +-----
>  2 files changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a1457995fd41c..2de235d52faca 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6243,10 +6243,6 @@
>                         -1: disable all critical trip points in all thermal zones
>                         <degrees C>: override all critical trip points
>
> -       thermal.nocrt=  [HW,ACPI]
> -                       Set to disable actions on ACPI thermal zone
> -                       critical and hot trip points.
> -
>         thermal.off=    [HW,ACPI]
>                         1: disable ACPI thermal control
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index f9f6ebb08fdb7..3163a40f02e30 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -82,10 +82,6 @@ static int tzp;
>  module_param(tzp, int, 0444);
>  MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.");
>
> -static int nocrt;
> -module_param(nocrt, int, 0);
> -MODULE_PARM_DESC(nocrt, "Set to take no action upon ACPI thermal zone critical trips points.");
> -
>  static int off;
>  module_param(off, int, 0);
>  MODULE_PARM_DESC(off, "Set to disable ACPI thermal support.");
> @@ -1094,7 +1090,7 @@ static int thermal_act(const struct dmi_system_id *d) {
>  static int thermal_nocrt(const struct dmi_system_id *d) {
>         pr_notice("%s detected: disabling all critical thermal trip point actions.\n",
>                   d->ident);
> -       nocrt = 1;
> +       crt = -1;
>         return 0;
>  }
>  static int thermal_tzp(const struct dmi_system_id *d) {
> --
