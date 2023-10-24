Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8647D5C23
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbjJXUIa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 16:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344181AbjJXUI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:08:29 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203F7A2;
        Tue, 24 Oct 2023 13:08:27 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1e99a55a9c0so752287fac.1;
        Tue, 24 Oct 2023 13:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698178106; x=1698782906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEsMZu8Eqayi45LcxRtOZkFhUqbYnUdSwErTzQoK/I8=;
        b=fN5x0BcrE2MH2lz3tEwkyidkPgVE/5LgRwJlWZVAyOvbKrYyp1K0wKlNDr1UXZBVlX
         SnI7jQUEZk4cSYg7ChD5CqvntYtioQF9p8XbYBm6c5OHd7t0DEI6P6IPM42WAGC7/ZeK
         dIPaMGv8O7vwQ2YUZHw83qtOh8UMeTt7Ss6gDinJetN54XCLHYNjE1L7cXv6kwIRkUXE
         CyT3VrJur0UeQMi96M/H9/v6tR1AoZ+kXHBHN5QAJHp+kf/r36kx6egTUalqVIpzJK6d
         t9etpiVR7zv8y4ywR9e3Bn3YdciQ4fgYXrHSluS3bEfYefozlqZ56kt5K5KUz/Cep0/x
         TxsA==
X-Gm-Message-State: AOJu0YzwQV614VR7g4Z2N7C28rTJDhQNVLDQQCY9KH4x14Jc8EZJIfOO
        p48r1MV6sK4CiW4OVgze2jZ3BQANmQnqDChopzY=
X-Google-Smtp-Source: AGHT+IF3IKMVvXAvqIHlVk8xy2u/3N4jetWHGmHiTZ6ATMxW3MKPb5NHIxeV4cKTjgwWGWALKBR9CNSZHnzzLFeiMxU=
X-Received: by 2002:a05:6870:4d17:b0:1e9:8a7e:5893 with SMTP id
 pn23-20020a0568704d1700b001e98a7e5893mr15978010oab.5.1698178106255; Tue, 24
 Oct 2023 13:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231004183455.27797-1-ville.syrjala@linux.intel.com> <20231024191719.4041-1-ville.syrjala@linux.intel.com>
In-Reply-To: <20231024191719.4041-1-ville.syrjala@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Oct 2023 22:08:15 +0200
Message-ID: <CAJZ5v0i+96sV9DuLk31iBB-K8y=6i9Tq1ef893btCUkvetHVDA@mail.gmail.com>
Subject: Re: [PATCH v2] powercap: intel_rapl: Downgrade BIOS locked limits
 pr_warn() to pr_debug()
To:     Ville Syrjala <ville.syrjala@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, Zhang Rui <rui.zhang@intel.com>,
        Wang Wendy <wendy.wang@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
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

On Tue, Oct 24, 2023 at 9:17 PM Ville Syrjala
<ville.syrjala@linux.intel.com> wrote:
>
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
>
> Before the refactoring the pr_warn() only triggered when
> someone explicitly tried to write to a BIOS locked limit.
> After the refactoring the warning is also triggering during
> system resume. The user can't do anything about this so
> printing scary warnings doesn't make sense
>
> Keep the printk but make it pr_debug() instead of pr_warn()
> to make it clear it's not a serious issue.
>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Wang Wendy <wendy.wang@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Fixes: 9050a9cd5e4c ("powercap: intel_rapl: Cleanup Power Limits support")
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 40a2cc649c79..2feed036c1cd 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -892,7 +892,7 @@ static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
>                 return -EINVAL;
>
>         if (rd->rpl[pl].locked) {
> -               pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name, rd->name, pl_names[pl]);
> +               pr_debug("%s:%s:%s locked by BIOS\n", rd->rp->name, rd->name, pl_names[pl]);
>                 return -EACCES;
>         }
>
> --

Applied, thanks!
