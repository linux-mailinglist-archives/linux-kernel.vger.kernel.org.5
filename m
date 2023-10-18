Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB1C7CDA2F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjJRLXT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Oct 2023 07:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRLXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:23:17 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7488FE;
        Wed, 18 Oct 2023 04:23:15 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57f137dffa5so959209eaf.1;
        Wed, 18 Oct 2023 04:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697628195; x=1698232995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL8d1Wy2RYg7Z3Gg7sRF+6FjUhQukhbwr28QCxGfYwQ=;
        b=rI/ZQCdYay37wlm1u4sGslUIdm/JtoOwobWoV74LtPxBogTx2hmmkUmD0asDS5iPWZ
         ST0R/e5h5mM6kE8EbA7UfcO/TX5h0nfAfK1gZ2hFbo4xz4fOOI0By6a1YAL4p5uGWDaa
         Mx8CJ6aD8rYpgy7IlUUVCDWzNZf4kkTNVxfAX87dFNdLOR9Wscx7AGLl5jf84RAQN6x5
         ovzuNOBLzvBw8ijt83hAQL8m53Edq8ElhMLyznyocE3LNCGpBJoSs9fpMIg2gySC2r4x
         Tnx/HMQv83MOhr7Dyj/1GdnJZ3WXmgkELtk4NwGQl60iRO/T+6XoM8tFWw5IQ5F5nbTO
         h02Q==
X-Gm-Message-State: AOJu0YzY4ySYh8GE+2g8nioo1UZli6Kaf3ZaCyP1Vzdva+vd5ADotJF4
        zxSE9CJEnTkOWTjq1vckO7TfHTVq0tSK6aDN6KsWbsS0
X-Google-Smtp-Source: AGHT+IHwAj/x3rnK0iruCbW5d4oq4fAlIoJHsIB1GFHgvd4bGUjDgCn1lE771+MBeeCJ74DtLny7PLmN3Dz2rGI/BUs=
X-Received: by 2002:a4a:e1cd:0:b0:581:feb5:ac87 with SMTP id
 n13-20020a4ae1cd000000b00581feb5ac87mr970404oot.1.1697628195091; Wed, 18 Oct
 2023 04:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <547f8b.93e.18b26e5e031.Coremail.chenguohua@jari.cn>
In-Reply-To: <547f8b.93e.18b26e5e031.Coremail.chenguohua@jari.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Oct 2023 13:23:04 +0200
Message-ID: <CAJZ5v0jJDr0w2R2Up_e_ZSeuw9Z-29FdHheGHwCjh05++GKe=g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Clean up errors in acpi.h
To:     chenguohua@jari.cn
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
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

First, the subject is misleading, because the patch doesn't address
any errors, but cleans up the usage of white space.

On Fri, Oct 13, 2023 at 6:32 AM <chenguohua@jari.cn> wrote:
>
> Fix the following errors reported by checkpatch:

Why does it make sense to run checkpatch on the existing code?

> ERROR: "foo * bar" should be "foo *bar"
> ERROR: space required after that ';' (ctx:VxV)
>
> Signed-off-by: GuoHua Cheng <chenguohua@jari.cn>

Please fix the changelog to simply state that it cleans up the usage
of white space so it is consistent with the kernel coding style.

> ---
>  include/linux/acpi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 9bcf5641a7cf..b55a8ac627e9 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1421,7 +1421,7 @@ acpi_graph_get_remote_endpoint(const struct fwnode_handle *fwnode,
>  }
>
>  #define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable, valid, data, fn) \
> -       static const void * __acpi_table_##name[]                       \
> +       static const void *__acpi_table_##name[]                        \
>                 __attribute__((unused))                                 \
>                  = { (void *) table_id,                                 \
>                      (void *) subtable,                                 \
> @@ -1429,7 +1429,7 @@ acpi_graph_get_remote_endpoint(const struct fwnode_handle *fwnode,
>                      (void *) fn,                                       \
>                      (void *) data }
>
> -#define acpi_probe_device_table(t)     ({ int __r = 0; __r;})
> +#define acpi_probe_device_table(t)     ({ int __r = 0; __r; })
>  #endif
>
>  #ifdef CONFIG_ACPI_TABLE_UPGRADE
> --
