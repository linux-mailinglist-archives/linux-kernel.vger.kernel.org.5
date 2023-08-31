Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D371978F2FB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347099AbjHaS7L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Aug 2023 14:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbjHaS7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:59:10 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EABE65;
        Thu, 31 Aug 2023 11:59:08 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5711d5dac14so244255eaf.0;
        Thu, 31 Aug 2023 11:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693508347; x=1694113147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owyEPNij5vc6Nz2n0ejjQMnqcMpa572QB0sGcFXBGz8=;
        b=LjajlZ7S7cbdk43eoZo8ptAi+oFmslR2pVqPBl2JQrddoOKNsrznHGgHVDm0D6gf2b
         OthL4dRfrx+6u1cW2XwSwfig8ghVZsz8oIZqL3GOBy5r2xs/+tWqdF9Dc5vHF2rOBzY/
         247JlfQzfZFUkw5BL/2YgwvjsiBobP4OiMtsbbX9/cKNaaM/qDFjPY0GCflucqjvXAzg
         gu0IXP0bcqYN/d5dTPKDGqnVmdl6jRrf0C4BnUg6rOiWSso19Qd9RVkhdie6iLwC4Piy
         RZE76ILa9Os3EVDQv9aO9T7omx8iInElqAn7lncIZTYFkXoMUkWzU1pTX7YXNuyWrQ4J
         ovVA==
X-Gm-Message-State: AOJu0YysaCvN86xUobgAjy2CpYenL1qD2/RdHeko9M+nZGiFA8iceuF7
        xV/OUyBRM6ZHN1sCB8qux81HpoZziyM6IV2m6Io=
X-Google-Smtp-Source: AGHT+IGpKGlHdPEGp22AQkareb+5rq++ydP6FTuJfuT1OAMYhCYVcGMDVWj2hXHVNh1eU8X0Pwl78FPHzenlT/yslnY=
X-Received: by 2002:a4a:de43:0:b0:573:2a32:6567 with SMTP id
 z3-20020a4ade43000000b005732a326567mr400925oot.0.1693508347419; Thu, 31 Aug
 2023 11:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230829171212.156688-1-mario.limonciello@amd.com> <20230829171212.156688-2-mario.limonciello@amd.com>
In-Reply-To: <20230829171212.156688-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Aug 2023 20:58:56 +0200
Message-ID: <CAJZ5v0ggnjtnyZtNYfozTPpHN7qondg8bAYZ7jE=+Q4LTLHE0w@mail.gmail.com>
Subject: Re: [PATCH v16 1/3] ACPI: x86: s2idle: Export symbol for fetching
 constraints for module use
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     hdegoede@redhat.com, bhelgaas@google.com, rafael@kernel.org,
        Shyam-sundar.S-k@amd.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 9:28 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The amd-pmc driver will be fetching constraints to make decisions at
> suspend time. This driver can be compiled as a module, so export the
> symbol for when it is a module.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and please route this along with the rest of the series.

> ---
> v15->v16:
>  * new patch
> ---
>  drivers/acpi/x86/s2idle.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 08f7c6708206..de9c313c21fa 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -322,6 +322,7 @@ int acpi_get_lps0_constraint(struct acpi_device *adev)
>
>         return ACPI_STATE_UNKNOWN;
>  }
> +EXPORT_SYMBOL_GPL(acpi_get_lps0_constraint);
>
>  static void lpi_check_constraints(void)
>  {
> --
> 2.34.1
>
