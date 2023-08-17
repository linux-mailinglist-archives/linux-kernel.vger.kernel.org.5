Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E052277FD4C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354116AbjHQRx3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Aug 2023 13:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354144AbjHQRxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:53:24 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CAB26BC;
        Thu, 17 Aug 2023 10:53:23 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56d26137095so14768eaf.1;
        Thu, 17 Aug 2023 10:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692294802; x=1692899602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlvBL9hLbtt33M9fY9Puk2USBot1CchuwIVoJwFLp4M=;
        b=fLha4IsJDYIVV2C0uNF8n1zfoljQOraEBjkWUleDxZAjZr2NRqJkxa6Zhy+2c3fYKY
         x7uJeSt3s0ZiCLVOU74euTwRjHFgAeLOqHjgu3WZDhjJL2jk8D/YHFeUNmBPbOXLcy5i
         4WLVW8BcepTSXfmYf74PvltQgl15JuZAY/O3CHAJXhSbDKbVuKSvFgQytJX6SIUVEcif
         fD9OWpggqLISxp5eO1WOeEV/f8X+3vi3aEkUfOR+FMnSiKw4YGCD5aCS1BDmUiqjbWdt
         nliBc3XrsV5ae8/D2Dvdf4jEKsSwMEtQckrbnKh0/qdOtbvrlGQMQ+/WX8LW+M+eebuK
         +jIA==
X-Gm-Message-State: AOJu0YwxQpabr3wXNtCLQ767suPGZw0xv4MSr5WhnFzmNGVoNfscALGm
        zGnNjzTuUZBIzYows6lgUzM/0uxFZjWKvFSr/kH2W1pX
X-Google-Smtp-Source: AGHT+IGpJnfL4dL61F5vbkydy8Y/n0LzYI8rG4OnuLVHJl+NzAE3rns4FtoWsDIrSl7ASVw6NQEEGjyH4bxudSM646Q=
X-Received: by 2002:a4a:d581:0:b0:56e:487f:8caa with SMTP id
 z1-20020a4ad581000000b0056e487f8caamr465349oos.1.1692294802755; Thu, 17 Aug
 2023 10:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230814135623.23084-1-yuehaibing@huawei.com>
In-Reply-To: <20230814135623.23084-1-yuehaibing@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 19:53:11 +0200
Message-ID: <CAJZ5v0j6_YFXyf7m7EVp7qNoy4RRhefsM0-VENBfJtDg09j7Sg@mail.gmail.com>
Subject: Re: [PATCH -next] ACPI: Remove unused declarations
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        hdegoede@redhat.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
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

On Mon, Aug 14, 2023 at 3:56 PM Yue Haibing <yuehaibing@huawei.com> wrote:
>
> acpi_create_dir()/acpi_remove_dir() are never implemented since
> the beginning of git history.
> Commit f8d31489629c ("ACPICA: Debugger: Convert some mechanisms to OSPM specific")
> declared but never implemented acpi_run_debugger().
> Commit 781d737c7466 ("ACPI: Drop power resources driver")
> removed acpi_power_init() but not its declaration.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/acpi/internal.h | 1 -
>  include/acpi/acpi_bus.h | 2 --
>  include/acpi/acpixf.h   | 2 --
>  3 files changed, 5 deletions(-)
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 5f5c3a159872..866c7c4ed233 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -123,7 +123,6 @@ int __acpi_device_uevent_modalias(const struct acpi_device *adev,
>  /* --------------------------------------------------------------------------
>                                    Power Resource
>     -------------------------------------------------------------------------- */
> -int acpi_power_init(void);
>  void acpi_power_resources_list_free(struct list_head *list);
>  int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
>                                  struct list_head *list);
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 23fbe4a16972..18203ee9096d 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -569,8 +569,6 @@ int acpi_match_device_ids(struct acpi_device *device,
>                           const struct acpi_device_id *ids);
>  void acpi_set_modalias(struct acpi_device *adev, const char *default_id,
>                        char *modalias, size_t len);
> -int acpi_create_dir(struct acpi_device *);
> -void acpi_remove_dir(struct acpi_device *);
>
>  static inline bool acpi_device_enumerated(struct acpi_device *adev)
>  {
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index 0c1b69ad95d0..3d90716f9522 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -970,8 +970,6 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>                                                void **data,
>                                                void (*callback)(void *)))
>
> -void acpi_run_debugger(char *batch_buffer);
> -
>  void acpi_set_debugger_thread_id(acpi_thread_id thread_id);
>
>  #endif                         /* __ACXFACE_H__ */
> --

Applied (under edited subject) as 6.6 material, thanks!
