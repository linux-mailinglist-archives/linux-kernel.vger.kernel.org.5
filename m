Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91957A4833
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239849AbjIRLSp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 07:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239979AbjIRLS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:18:28 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED9D94;
        Mon, 18 Sep 2023 04:18:23 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5711d5dac14so1122642eaf.0;
        Mon, 18 Sep 2023 04:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695035902; x=1695640702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7R+q9QTbDGEN3i7eAllm79g5AlXcMaeqG2tb9H1j3lo=;
        b=oBI+uJAOZGLWGI5g8kJgLHPTeN2fdhTmEhhQTeohckJFxnKj8gE4HIFrfFIZoggWTw
         fE7M494Op3oS/cx00jEOpNTtvnkphadwsBUgp0UdsMNtYtMJS6UxPLduWjCgQ3pkaTkb
         k5OnKtLYz6o2gY0n6ZHiyj3NmmUJ8XE4jYNqvaXOJ+cyOSR5elEI14HPMMzRRaMh61mw
         2biqfLdQN+Mq/BJpIVydUuHRfg6YBPQPAqRkFV3DMQKaTlhtmm+Z2LXWkdiOjEqI8P3m
         WDTaAMnMmihq7+ZJIgYAgTlN+dgdftGixFjiq9C5LXrqFKSWi7BCn74972we7VLv5Q4o
         6zTA==
X-Gm-Message-State: AOJu0YyEbjDEEXgALcHltPbRfVgzc4fYRdt13oDEJMLuGL7/CM+JFGs2
        tfA4IxBNBXNCcTWzR15RVwqWjPs1F0XbRAxT68k=
X-Google-Smtp-Source: AGHT+IF74HBff7jMfxR3E+y0OWzgyEbaCy8QIeP6AGUieIHiEqOxz3vk1M5j+FOiojg9a5/pQaPqZi3iQJ9X/JiR298=
X-Received: by 2002:a4a:d88d:0:b0:573:2a32:6567 with SMTP id
 b13-20020a4ad88d000000b005732a326567mr7997421oov.0.1695035902417; Mon, 18 Sep
 2023 04:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230913173510.3963561-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230913173510.3963561-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Sep 2023 13:18:11 +0200
Message-ID: <CAJZ5v0g3J3J-nHYTMiWARiKO_xaW0r9yxxGxyo3te-EQ0d1+fQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: int340x: Add ArrowLake-S PCI ID
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Sep 13, 2023 at 7:35 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add ArrowLake-S PCI ID for processor thermal device.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../thermal/intel/int340x_thermal/processor_thermal_device.h    | 1 +
>  .../intel/int340x_thermal/processor_thermal_device_pci.c        | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> index b974583c5c11..dd025c8c2bac 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> @@ -10,6 +10,7 @@
>  #include <linux/intel_rapl.h>
>
>  #define PCI_DEVICE_ID_INTEL_ADL_THERMAL        0x461d
> +#define PCI_DEVICE_ID_INTEL_ARL_S_THERMAL 0xAD03
>  #define PCI_DEVICE_ID_INTEL_BDW_THERMAL        0x1603
>  #define PCI_DEVICE_ID_INTEL_BSW_THERMAL        0x22DC
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> index 7253277e476a..44b179ce9bc9 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> @@ -390,6 +390,8 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
>         { PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
>           PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR |
>           PROC_THERMAL_FEATURE_WT_HINT) },
> +       { PCI_DEVICE_DATA(INTEL, ARL_S_THERMAL, PROC_THERMAL_FEATURE_RAPL |
> +         PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_WT_HINT) },
>         { PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
>           PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
>         { },
> --

Applied as 6.7 material, thanks!
