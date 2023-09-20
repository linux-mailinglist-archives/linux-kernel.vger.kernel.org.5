Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F78C7A8CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjITTVr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Sep 2023 15:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjITTVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:21:44 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C648F;
        Wed, 20 Sep 2023 12:21:39 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3a707bc2397so17413b6e.0;
        Wed, 20 Sep 2023 12:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237698; x=1695842498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QnwindRPyDSzR2SN+sH5xPh30Omc5eoxXIdaiaP7AU=;
        b=Z4r6sgNngFyhrdrYwoZHvNvxjoS2cX+h1eTG4XBnb6jJKxR+agL//z7qqVoYfKq+Y9
         lYYEvQuYV34Cj5A9LnLtihwSzHfIGx+QkYc/AQRBXTWY2UV26Lsmy5BnXdaCqoxOdWud
         SVKHgCUXYLbbAkxqJBgfy38ZrE78F/UIrI5eTzfFN0g/jCxVVooRWmRBPiFOIMyqQKWL
         brDVIWQW07Dc8f7qZy2xNKibaOtcef1zMLV0MZyTdwiI3UUSXyh8njSpgbHpW2VpcYXc
         KRmc+zK3KK+rWwVDBuNlYRgJGCURQecyn/bJbAtUcMWwK5K/dSgx43jdhL1X5SvbKEZZ
         iL8Q==
X-Gm-Message-State: AOJu0Yxkz/W9ReSW2BkMBGSlGPlKNXNJoINA2Lil0AYx5BKB7ReStsHe
        ZbYSW6o5GyHTk7tBIl0tjE3AlXOS5DnNiE/YJss=
X-Google-Smtp-Source: AGHT+IEWokomSBcfOokE6pDpUVh17f+4H1Vtb1rCulI7Jq5BJaC8N/5TPJriFvBOsW7qFxEyc6pTm909t5Nku8Bvt5s=
X-Received: by 2002:a05:6808:1496:b0:3ab:8ae5:e7c6 with SMTP id
 e22-20020a056808149600b003ab8ae5e7c6mr3781056oiw.1.1695237698046; Wed, 20 Sep
 2023 12:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230920185153.613706-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230920185153.613706-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Sep 2023 21:21:27 +0200
Message-ID: <CAJZ5v0jLms5iUM8CXDWNCPcXSQgLv9_XJzqx9RwReqGGUKFL_Q@mail.gmail.com>
Subject: Re: [PATCH linux-next] thermal: int340x: processor_thermal: Ack all
 PCI interrupts
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 8:52 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> All interrupts from the processor thermal PCI device requires ACK. This
> is done by writing 0x01 at offset 0xDC in the config space. This is
> already done for the thereshold interrupt. Extend this for the workload
> hint interrupt.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Is this a fix for one of the commits in linux-next?  If so, which one?

> ---
>  .../intel/int340x_thermal/processor_thermal_device_pci.c       | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> index 44b179ce9bc9..3c5ced79ead0 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> @@ -154,10 +154,11 @@ static irqreturn_t proc_thermal_irq_handler(int irq, void *devid)
>         if (status) {
>                 /* Disable enable interrupt flag */
>                 proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
> -               pci_write_config_byte(pci_info->pdev, 0xdc, 0x01);
>                 pkg_thermal_schedule_work(&pci_info->work);
>         }
>
> +       pci_write_config_byte(pci_info->pdev, 0xdc, 0x01);
> +
>         return ret;
>  }
>
> --
> 2.40.1
>
