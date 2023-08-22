Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DC4784B27
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjHVUJf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 16:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHVUJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:09:34 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36BD10CA;
        Tue, 22 Aug 2023 13:09:14 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bdb3ecd20dso8855065ad.0;
        Tue, 22 Aug 2023 13:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692734927; x=1693339727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6YwQR5cxz4EihrKcIMUeaFlqPXySrQcy+IZQv5pQoU=;
        b=H17jVMf+GbSsSTArxsd/bw1gxi33jfuJiIuuBXAUXxYP1u5DDnAP0fanALaq7xHeLP
         eMct5kQJiRm3Msoomo7SsLPz98hiM5FGwXxwlgTD7rrEqcsr9vY76ODvPALWYidM711X
         p/W4N9Ye/1q/ve3zoMnkYEzSiG4ryr86MaCYgAdMZ2ceWL6JYyrxvZhGna4L0Jf1Ljdo
         nJVA/0HfcJv4BOIaY/kxk1ehZVWvDVPHLnRkhOZsX2bs8OLgPhJ4EopXS5nXS5c2hNQX
         Fvr6b5NGA9uCaoolXIsHG612g6HRGSlgiHIOdTxS8tsWtMxS04Qmgncqq9V+jmQty2Ml
         tllQ==
X-Gm-Message-State: AOJu0YzApeSXpeyjMuQWmWfBJWJjKFJmtpFBUNKFC/uH9n1KfRGbX7Gl
        7evUALbVBj5716cnDJs8CX0HNBKzW/8Fv6k7vvzuaT+C
X-Google-Smtp-Source: AGHT+IGuIs4VdgEB0UAz+cjFTXvcTdPa0uRUFsSTITaqRGzShMO2JghGVD1/90Pd4eVDpNXbpPkUQQiGm8E0xbQC0Ag=
X-Received: by 2002:a17:90a:9e2:b0:26d:1eff:619f with SMTP id
 89-20020a17090a09e200b0026d1eff619fmr9483306pjo.2.1692734927088; Tue, 22 Aug
 2023 13:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230813025220.1752489-1-rui.zhang@intel.com>
In-Reply-To: <20230813025220.1752489-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 22:08:35 +0200
Message-ID: <CAJZ5v0gLnqxTPux9x=aGhLQoNAwkANPy4UoT0gYEchayE20=DQ@mail.gmail.com>
Subject: Re: [PATCH V2] thermal: intel: intel_soc_dts_iosf: Remove redundant check
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     rafael.j.wysocki@intel.com, daniel.lezcano@linaro.or,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
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

On Sun, Aug 13, 2023 at 4:52 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Remove the redundant check in remove_dts_thermal_zone() because all of
> its existing callers pass a valid pointer as the argument.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/intel/intel_soc_dts_iosf.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
> index db97499f4f0a..22fc2970c67d 100644
> --- a/drivers/thermal/intel/intel_soc_dts_iosf.c
> +++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
> @@ -245,11 +245,9 @@ static int soc_dts_enable(int id)
>
>  static void remove_dts_thermal_zone(struct intel_soc_dts_sensor_entry *dts)
>  {
> -       if (dts) {
> -               iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> -                              SOC_DTS_OFFSET_ENABLE, dts->store_status);
> -               thermal_zone_device_unregister(dts->tzone);
> -       }
> +       iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> +                      SOC_DTS_OFFSET_ENABLE, dts->store_status);
> +       thermal_zone_device_unregister(dts->tzone);
>  }
>
>  static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
> --

Applied as 6.6 material, thanks!
