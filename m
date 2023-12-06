Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C4A8078E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442808AbjLFTti convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 14:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379274AbjLFTth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:49:37 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A76FA;
        Wed,  6 Dec 2023 11:49:42 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b9b5b254e2so31526b6e.1;
        Wed, 06 Dec 2023 11:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701892182; x=1702496982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp7+4/skeq3z1JjM3KigvsLSXGvrXr1gskXOMgpelSY=;
        b=CysehOvfQJu5YxK3jdN2InAl6O8JpAI0enLtXaC7iJjaIs1J13bs/dCoGzlqf6dtZ+
         MqdFbC6K3OWPmaqptAuWlEzx7fwyHa6NkPJYdUUROQNfLNVnXo440wTDMR7KGLUkQCNF
         wayscpiXYsASJbSoOfdGGIUG9HrxQYu7osnW+0oF4zn/dUs1Mv4s7J81NbxUBxUy0FLf
         lyDgBVzdQiyKHEZLQsBxguMUaR82kf+5byieayAk6OWyGdo5DznYHEb7Biv9WAzDUaU3
         7jNLjohIk0wgxMqk52hTzGg4tMXFMkxQIRfR6AdrdqosmH5aYSCN5h//k5u2WjOp8CYA
         5VJg==
X-Gm-Message-State: AOJu0YyIv02B5IokNNAfm7iDorOhcWOz2wYPIM23QSs7aivIvBNAhlXC
        XesLK39CVrhRA9BA+eyJxtk71a+YxUVs1Ahaexg=
X-Google-Smtp-Source: AGHT+IExIFz0Wd6u8xUoM+mJ2csD63ycuSkUyWPAXV3GY072wzEGAsU15EY9wikRo0era7uyehQBhU1ZBS4x7XKxo1M=
X-Received: by 2002:a05:6870:b69a:b0:1fb:9b:3d4c with SMTP id
 cy26-20020a056870b69a00b001fb009b3d4cmr2791355oab.0.1701892181729; Wed, 06
 Dec 2023 11:49:41 -0800 (PST)
MIME-Version: 1.0
References: <20231127055858.41004-1-ytcoode@gmail.com>
In-Reply-To: <20231127055858.41004-1-ytcoode@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Dec 2023 20:49:30 +0100
Message-ID: <CAJZ5v0h-7mhSP5BAig6fj-pax6V_m=u2ygjYU4DxMypJfqv5Cg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Remove unused struct field and incorrect comments
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Mon, Nov 27, 2023 at 6:59 AM Yuntao Wang <ytcoode@gmail.com> wrote:
>
> The return_object_type field in `struct acpi_evaluate_info` is unused,
> so remove it.
>
> There are also some issues in the comments of acpi_ps_execute_method().
> First, the parameter_type field has already been removed from
> `struct acpi_evaluate_info`, so the corresponding field description in
> the comments should also be removed. Second, the return_object field
> description in the comments is duplicated. Remove these incorrect comments.
>
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  drivers/acpi/acpica/acstruct.h | 1 -
>  drivers/acpi/acpica/psxface.c  | 3 ---
>  2 files changed, 4 deletions(-)

This is ACPICA code which comes from a separate project.

The way to change it is to submit a pull request with the desired change
to the upstream ACPICA project on GitHub and add a Link tag pointing
to the upstream PR to the corresponding Linux patch.  Then, the Linux
patch can only be applied after the corresponding upstream PR has been
merged.

Thanks!

> diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
> index f8fee94ba708..fe57c3a16e59 100644
> --- a/drivers/acpi/acpica/acstruct.h
> +++ b/drivers/acpi/acpica/acstruct.h
> @@ -169,7 +169,6 @@ struct acpi_evaluate_info {
>         u16 param_count;        /* Count of the input argument list */
>         u16 node_flags;         /* Same as Node->Flags */
>         u8 pass_number;         /* Parser pass number */
> -       u8 return_object_type;  /* Object type of the returned object */
>         u8 flags;               /* General flags */
>  };
>
> diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
> index 6f4eace0ba69..df5679bbc510 100644
> --- a/drivers/acpi/acpica/psxface.c
> +++ b/drivers/acpi/acpica/psxface.c
> @@ -70,9 +70,6 @@ acpi_debug_trace(const char *name, u32 debug_level, u32 debug_layer, u32 flags)
>   *                                    NULL if no parameters are being passed.
>   *                  return_object   - Where to put method's return value (if
>   *                                    any). If NULL, no value is returned.
> - *                  parameter_type  - Type of Parameter list
> - *                  return_object   - Where to put method's return value (if
> - *                                    any). If NULL, no value is returned.
>   *                  pass_number     - Parse or execute pass
>   *
>   * RETURN:      Status
> --
> 2.43.0
>
>
