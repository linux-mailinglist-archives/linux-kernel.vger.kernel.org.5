Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933267C8C5A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJMRdX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Oct 2023 13:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJMRdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:33:22 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8903DBB;
        Fri, 13 Oct 2023 10:33:20 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-57f137dffa5so353099eaf.1;
        Fri, 13 Oct 2023 10:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697218400; x=1697823200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDfH1O6ogKZ8M8NviATD62mLbrLkHU8SBP3Zaxp2SRo=;
        b=whvK6aL1R+Ct6rT8rZ9R6owBUNZXhgJ2QO14+RR7n/XrmZAza1eCwlvZ13zDqyQf0H
         r5vS1EOKbJXQMfi4jNWidgUR9mGLAW324UWw2uWl8A3IUmNuuW22RUlTz2aS95xBj6Xq
         oBOY2AoVKMngw2f//mzlZv/FwjSRug6DZx7x+UiAR7EHhqBdWlVXbH2A/AaXAo4ND0Ph
         dyjPYAQ9u7LegJfOX0Sr2xsSlb9mI1+eNnqwQGkIHDreoTZEmdFV9Xu8n2o51Us//SwU
         IqgxexFBD/9sDSuHfT4eMtHoTXzlrhHr1X8M2MoZjCNAdZMBWxm2CnRW+fOSC6Tb5FMT
         2JJw==
X-Gm-Message-State: AOJu0YwGo8M7R7NbwYL7ONk2gVq8+Fvk0mNCBKM0gZS0S1O3t2rayIw7
        wTqLHZYbXeixPK5uf4Ok7Z8xz9zZGlIr+Jp8STHPyq22
X-Google-Smtp-Source: AGHT+IGpqTtsrxMYUFtH5deAkA/tEHSXWzMLbD5VN81q1HO9y18wLTNYO9yqm/6IUKNcHYlc8iapeVquTEbU8laEsmo=
X-Received: by 2002:a4a:de08:0:b0:56e:94ed:c098 with SMTP id
 y8-20020a4ade08000000b0056e94edc098mr26637440oot.0.1697218399800; Fri, 13 Oct
 2023 10:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231011083334.3987477-1-michal.wilczynski@intel.com> <20231011083334.3987477-2-michal.wilczynski@intel.com>
In-Reply-To: <20231011083334.3987477-2-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Oct 2023 19:33:08 +0200
Message-ID: <CAJZ5v0gGi5joPQ2dCUs_oPZgPqT_=Y-z7epXE2mfYdmp7DOwQQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] ACPI: AC: Remove unnecessary checks
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        lenb@kernel.org, dave.jiang@intel.com, ira.weiny@intel.com,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
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

On Wed, Oct 11, 2023 at 10:34 AM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> Remove unnecessary checks for NULL for variables that can't be NULL at
> the point they're checked for it. Defensive programming is discouraged
> in the kernel.
>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/ac.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index aac3e561790c..83d45c681121 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -131,9 +131,6 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
>         struct acpi_device *device = data;
>         struct acpi_ac *ac = acpi_driver_data(device);
>
> -       if (!ac)
> -               return;
> -
>         switch (event) {
>         default:
>                 acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
> @@ -216,12 +213,8 @@ static const struct dmi_system_id ac_dmi_table[]  __initconst = {
>  static int acpi_ac_add(struct acpi_device *device)
>  {
>         struct power_supply_config psy_cfg = {};
> -       int result = 0;
> -       struct acpi_ac *ac = NULL;
> -
> -
> -       if (!device)
> -               return -EINVAL;
> +       struct acpi_ac *ac;
> +       int result;
>
>         ac = kzalloc(sizeof(struct acpi_ac), GFP_KERNEL);
>         if (!ac)
> @@ -275,16 +268,9 @@ static int acpi_ac_add(struct acpi_device *device)
>  #ifdef CONFIG_PM_SLEEP
>  static int acpi_ac_resume(struct device *dev)
>  {
> -       struct acpi_ac *ac;
> +       struct acpi_ac *ac = acpi_driver_data(to_acpi_device(dev));
>         unsigned int old_state;
>
> -       if (!dev)
> -               return -EINVAL;
> -
> -       ac = acpi_driver_data(to_acpi_device(dev));
> -       if (!ac)
> -               return -EINVAL;
> -
>         old_state = ac->state;
>         if (acpi_ac_get_state(ac))
>                 return 0;
> @@ -299,12 +285,7 @@ static int acpi_ac_resume(struct device *dev)
>
>  static void acpi_ac_remove(struct acpi_device *device)
>  {
> -       struct acpi_ac *ac = NULL;
> -
> -       if (!device || !acpi_driver_data(device))
> -               return;
> -
> -       ac = acpi_driver_data(device);
> +       struct acpi_ac *ac = acpi_driver_data(device);
>
>         acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
>                                        acpi_ac_notify);
> --

Applied as 6.7 material with edits in the subject and changelog, thanks!
