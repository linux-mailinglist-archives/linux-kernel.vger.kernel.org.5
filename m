Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC207B7161
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbjJCS5X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 14:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjJCS5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:57:21 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1706A7;
        Tue,  3 Oct 2023 11:57:18 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57bf04841ccso247500eaf.0;
        Tue, 03 Oct 2023 11:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696359438; x=1696964238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ox0Selfc/25SDV9Q5jkJTLaDuAWtxvahlx8boOX57z8=;
        b=YcnTAg8kuFhLnBSF/ajXTqCijE7q1lPIPyXXhorWXBCKq6hBBPWl1AlmQCIoYycB/o
         S2ysuRlP8u3epd7msNJ5onE8LNLU/3DBUdN4iZOVgaFL+hwHFncqFDYxDWmpbjTe+Xz8
         R3JJpHxiAb02T7KT13kjoLrQkLW6O3zc6RQkV9zGIHlaQocwa9+TBsYwy8RYm3aZ9Dsd
         2DkRYAQ0QulEWKxrIjX3CQARwGnNWiflhtsXwLOZ5SQggNYrdOzPMD5pRxjH9rWgRyuU
         UWHh31XHMlqIcXDZP1NPCdOhb9cRfFVF1F8pweDF7Pfwfn8LiVlFYNs9iJPmv7n2of1t
         42kA==
X-Gm-Message-State: AOJu0YxvhHicb8Mnqtyd8wetB0b1uh3N2kN1grCNB7hIkEfv8jK5n+n4
        H147wtUe7a4fsjxag4oYX4FjIzYRX5kgyeWJ+WU=
X-Google-Smtp-Source: AGHT+IFc770QxCiRdEXoSuA4LwACsS/D4asXOGsel4is2Y9vaiEzom8WVcKBQ+RnwVSORl2YT/uuqD89QXrny6x10vA=
X-Received: by 2002:a4a:ee90:0:b0:57b:94b7:c6ba with SMTP id
 dk16-20020a4aee90000000b0057b94b7c6bamr278994oob.0.1696359438232; Tue, 03 Oct
 2023 11:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230928221344.44289-1-bergh.jonathan@gmail.com>
In-Reply-To: <20230928221344.44289-1-bergh.jonathan@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Oct 2023 20:57:06 +0200
Message-ID: <CAJZ5v0i2h875LC6pxUcusJqPULKyQtTK3e_Fjz7RAM=mBN+bBw@mail.gmail.com>
Subject: Re: [PATCH] drivers: acpi: Fix formatting issues where braces should
 be on newlines
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:31 AM Jonathan Bergh
<bergh.jonathan@gmail.com> wrote:
>
> Fix the following formatting issues in thermal.c:
>  * braces following function declarations should be on a new line
>  * add single line between function declarations
>
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/acpi/thermal.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 312730f8272e..dea5f8a51f87 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -1046,7 +1046,8 @@ static struct acpi_driver acpi_thermal_driver = {
>         .drv.pm = &acpi_thermal_pm,
>  };
>
> -static int thermal_act(const struct dmi_system_id *d) {
> +static int thermal_act(const struct dmi_system_id *d)
> +{
>         if (act == 0) {
>                 pr_notice("%s detected: disabling all active thermal trip points\n",
>                           d->ident);
> @@ -1054,13 +1055,17 @@ static int thermal_act(const struct dmi_system_id *d) {
>         }
>         return 0;
>  }
> -static int thermal_nocrt(const struct dmi_system_id *d) {
> +
> +static int thermal_nocrt(const struct dmi_system_id *d)
> +{
>         pr_notice("%s detected: disabling all critical thermal trip point actions.\n",
>                   d->ident);
>         crt = -1;
>         return 0;
>  }
> -static int thermal_tzp(const struct dmi_system_id *d) {
> +
> +static int thermal_tzp(const struct dmi_system_id *d)
> +{
>         if (tzp == 0) {
>                 pr_notice("%s detected: enabling thermal zone polling\n",
>                           d->ident);
> @@ -1068,7 +1073,9 @@ static int thermal_tzp(const struct dmi_system_id *d) {
>         }
>         return 0;
>  }
> -static int thermal_psv(const struct dmi_system_id *d) {
> +
> +static int thermal_psv(const struct dmi_system_id *d)
> +{
>         if (psv == 0) {
>                 pr_notice("%s detected: disabling all passive thermal trip points\n",
>                           d->ident);
> --

Applied as 6.7 material (with edited subject and changelog), thanks!
