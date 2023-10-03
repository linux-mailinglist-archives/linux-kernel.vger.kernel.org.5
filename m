Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913CA7B70D0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbjJCSaA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 14:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjJCS37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:29:59 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACA9AF;
        Tue,  3 Oct 2023 11:29:57 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57ddba5ba84so104083eaf.0;
        Tue, 03 Oct 2023 11:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696357796; x=1696962596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKuLyXDaUOfq1uIfw6OusMnl9KqNTsb0JtRvHzmk/hI=;
        b=qQe3AcuO6rLideDcZTfQ2gt6avF+1WZhWg0sDR2ItXn0hz1IY80PmSSZaSQh/IF/g3
         VguzuGSEDwTzDCEmtBzZBhonRqSKLvfvQhwCs30zV2yvEmsaq553PmDNb9Jse4edtEfD
         dWuXxSdTUFBl8RyB0OP1HXi9d8f4q+tmDiR+UDO22bhH+hza/ZRwuniNK77wHFpMJ59Q
         XpTNrcHKdhCmvQmworzI3XsBjQA7MVaZK33NQbPlApTMe34MTgM0P1nqF59gX24174HN
         DoYqwQjCxer5EgwFMGxuePjkcLjh/25qHDf9vbv87FWhPU7L54BZ07hRygO930rdB+g4
         PjCA==
X-Gm-Message-State: AOJu0Yx9COnjXyfCPLi6ByeeYZthNYYtegFXD5EAV8jM03A+/iip6DQ4
        4v6wXJB4jrY1U7j9nrahYgSsNC3y8wgnhSklBdw=
X-Google-Smtp-Source: AGHT+IGfYbL8E3JNC+wKvzaKai74tZwW1E6GU4g6CClDy5JW4gC42y+OnApY8XJwxgpeKFJARKmcdzK14ndUdbcCDDA=
X-Received: by 2002:a4a:b588:0:b0:578:c2af:45b5 with SMTP id
 t8-20020a4ab588000000b00578c2af45b5mr209370ooo.0.1696357796460; Tue, 03 Oct
 2023 11:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230930090248.34759-1-bergh.jonathan@gmail.com>
In-Reply-To: <20230930090248.34759-1-bergh.jonathan@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Oct 2023 20:29:45 +0200
Message-ID: <CAJZ5v0gDBNzUP8_9ayHniObOz0LriV0=sg4Kqw5GizMH8Aox0w@mail.gmail.com>
Subject: Re: [PATCH 1/3] drivers: acpi: Fix pointer declarations in parameter
 lists which included whitespace spuriously
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
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

On Sat, Sep 30, 2023 at 11:03 AM Jonathan Bergh
<bergh.jonathan@gmail.com> wrote:
>
> Fixed issues where pointer declarations in parameter lists included
> whitespace before the parameter names and should not.
>
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/acpi/osl.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index f725813d0cce..29e0005c30aa 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -493,7 +493,7 @@ EXPORT_SYMBOL(acpi_os_unmap_generic_address);
>
>  #ifdef ACPI_FUTURE_USAGE
>  acpi_status
> -acpi_os_get_physical_address(void *virt, acpi_physical_address * phys)
> +acpi_os_get_physical_address(void *virt, acpi_physical_address *phys)
>  {
>         if (!phys || !virt)
>                 return AE_BAD_PARAMETER;
> @@ -784,7 +784,7 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u64 value, u32 width)
>
>  #ifdef CONFIG_PCI
>  acpi_status
> -acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
> +acpi_os_read_pci_configuration(struct acpi_pci_id *pci_id, u32 reg,
>                                u64 *value, u32 width)
>  {
>         int result, size;
> @@ -816,7 +816,7 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
>  }
>
>  acpi_status
> -acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
> +acpi_os_write_pci_configuration(struct acpi_pci_id *pci_id, u32 reg,
>                                 u64 value, u32 width)
>  {
>         int result, size;
> @@ -1197,7 +1197,7 @@ bool acpi_queue_hotplug_work(struct work_struct *work)
>  }
>
>  acpi_status
> -acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle * handle)
> +acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle *handle)
>  {
>         struct semaphore *sem = NULL;
>
> @@ -1554,7 +1554,7 @@ void acpi_os_release_lock(acpi_spinlock lockp, acpi_cpu_flags flags)
>   ******************************************************************************/
>
>  acpi_status
> -acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t ** cache)
> +acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t **cache)
>  {
>         *cache = kmem_cache_create(name, size, 0, 0, NULL);
>         if (*cache == NULL)
> @@ -1575,7 +1575,7 @@ acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t ** cache)
>   *
>   ******************************************************************************/
>
> -acpi_status acpi_os_purge_cache(acpi_cache_t * cache)
> +acpi_status acpi_os_purge_cache(acpi_cache_t *cache)
>  {
>         kmem_cache_shrink(cache);
>         return (AE_OK);
> @@ -1594,7 +1594,7 @@ acpi_status acpi_os_purge_cache(acpi_cache_t * cache)
>   *
>   ******************************************************************************/
>
> -acpi_status acpi_os_delete_cache(acpi_cache_t * cache)
> +acpi_status acpi_os_delete_cache(acpi_cache_t *cache)
>  {
>         kmem_cache_destroy(cache);
>         return (AE_OK);
> @@ -1614,7 +1614,7 @@ acpi_status acpi_os_delete_cache(acpi_cache_t * cache)
>   *
>   ******************************************************************************/
>
> -acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
> +acpi_status acpi_os_release_object(acpi_cache_t *cache, void *object)
>  {
>         kmem_cache_free(cache, object);
>         return (AE_OK);
> --

Applied along with the [2-3/3] as 6.7 material with edits in the
subjects and changelogs.

Thanks!
