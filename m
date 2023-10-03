Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E6A7B7184
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjJCTHI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 15:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjJCTHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:07:05 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E350AD;
        Tue,  3 Oct 2023 12:07:01 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-57b68555467so119390eaf.0;
        Tue, 03 Oct 2023 12:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696360020; x=1696964820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJms9X5CgYzjQTYi0S46+K7l4i7nfUDiIw2fC9Ea75w=;
        b=g/5+l3+Gbwu+ybHrJ32uaNUsjNDKF3AscUz18AvSubMCr3PPcjFfcrBeCBsfgIc10i
         Ku4X4FDX4iP8XegIvtH0HL6k4JfnkD4/uZBhaPzhVGsynXcGH9Ulur2MpNo5NSuodULV
         e2CNvQkD4pO4smyG8M2M8UNTJL0Oj5glocshnSCEnJasUUAFCyXgjeWZL4S3XyAmAg9a
         gfxBI4gZMunPG057/CdAGIPG330hwGHkgBmIkGIzeIKlWgmFN1/zqwYnKa8VwDN8MB0h
         Adeqn8q14IOwmk9lk5YzXSRHHhlduoXPTWGKWGp/lw6LtsHsUBlL7T/OjEPVXOcbfGN6
         TGdQ==
X-Gm-Message-State: AOJu0YwvSdRY4OczRvaxeMy4VxgvK5YkW8GTkabiwykgRIgQAdpfjaQ/
        qQYrXYlZUXrCD6RpFKDr9tfspykl5elb/EwgO+g=
X-Google-Smtp-Source: AGHT+IGlUyo+Eh9vciX3F+asaZNDopwJMHEwvuHTmzKRLyVshyAQjshz7W8olqTxAZX9bk180zjwfh6f6xuePTN+LDQ=
X-Received: by 2002:a4a:b807:0:b0:57b:3b64:7ea5 with SMTP id
 g7-20020a4ab807000000b0057b3b647ea5mr237436oop.1.1696360020170; Tue, 03 Oct
 2023 12:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230928214807.43409-1-bergh.jonathan@gmail.com>
In-Reply-To: <20230928214807.43409-1-bergh.jonathan@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Oct 2023 21:06:49 +0200
Message-ID: <CAJZ5v0jjwez87RBTYx8eKs1AYNWbv4U41=YbKC6scHkY3-920A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: acpi: Fix label indentation and leading
 comma formatting issues
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     lenb@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Sep 28, 2023 at 11:48 PM Jonathan Bergh
<bergh.jonathan@gmail.com> wrote:
>
> Fixed the following formatting issues flagged by checkpatch
> in utils.c:
>  * Remove incorrect indentation before goto label
>  * Remove whitespace ahead of comma in parameter list
>
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/acpi/utils.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 2ea14648a661..300646bf8ba7 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -399,7 +399,7 @@ acpi_evaluate_reference(acpi_handle handle,
>                 acpi_handle_debug(list->handles[i], "Found in reference list\n");
>         }
>
> -      end:
> +end:
>         if (ACPI_FAILURE(status)) {
>                 list->count = 0;
>                 //kfree(list->handles);
> @@ -523,7 +523,7 @@ acpi_handle_printk(const char *level, acpi_handle handle, const char *fmt, ...)
>         vaf.va = &args;
>
>         path = acpi_handle_path(handle);
> -       printk("%sACPI: %s: %pV", level, path ? path : "<n/a>" , &vaf);
> +       printk("%sACPI: %s: %pV", level, path ? path : "<n/a>", &vaf);
>
>         va_end(args);
>         kfree(path);
> --

Applied as 6.7 material along with the [2/2] with edis in subjects and
changelogs.

Thanks!
