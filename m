Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2667631E9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjGZJ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjGZJZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:25:56 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B739E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:24:02 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bb31245130so2217285a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690363442; x=1690968242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=evpSZ3RXNicfZVh7nuw0DF2HHt7Ic+bUTRklUjl3NsU=;
        b=DUINzwJ9R7vTlXWpUggI687d3y2CHb6418khydW1hw8ktgnGCEE8qGwopvMfvb35ZF
         9belBMHBoH3Ce3wwRPvIQAWeZWQIPZvb8hAunDgsrprh9moIjsyq+bo8NS739q3F0EiD
         E/BEkIVRP+mALMZH9mg3Dxt+M8ws6KJ/pHiTBW8XOz2qhoWNZdLSkdwUuShumC0n3VLm
         FQXz1f6sJr+NTLfyz41+BKMXENQyMcCjYH1bOipAExkoZB8h6GcKyWUlefwc6oFkj0y4
         taBAN7o664EmD37KHCoMWP012D7oHsFz8z20h75wUSX9VP+YI2+sPG+y5WrWkWLUrcVv
         O13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690363442; x=1690968242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evpSZ3RXNicfZVh7nuw0DF2HHt7Ic+bUTRklUjl3NsU=;
        b=PxZozUfZhfWXEcCNxyUw0xLU8OFx8ME0QAZ4mhi3ZQbT8T4fnBcjFWmYny49sNy11G
         K5FVfybqsJJa7UTE1QTJ+SHe0zvfgSiK/b63S5n3sEx2fFbc6aPVD1waFDUcj5MHwdpD
         G62TWBc6+70Qh2JI3pEr/r+0flDm02ifakVb7V1JKr64cOkiqRfobeltLMgfpaBTGgRl
         CRYCKZl4J4FOw1J5T5CeYWSuDWyXqJkLe3D6VttT572XlSlPlSpeueC1ePoyiMSkaRFq
         HsCZAmHJXOULgbiqKGWP0g5FhdKG4tWjTdi2pDGe2g1EojGvUxcyvtHAf8MVo862v23W
         Wmcw==
X-Gm-Message-State: ABy/qLbFtea/XHwYevMUIVpeCLVOXTK2DCOpFGcgJTa5jbkXlb5hKp2k
        wMiiL7zMSHz4CSSLqaknug5xGj0zdgKvMHyjrPTOQw==
X-Google-Smtp-Source: APBJJlHgwH1hMJ17p1VokeuM0YeDVBjTRG76ExpI/O2a1enOG31yWAqvHw/F+GQf9mR5Yhg9yNR/TO7CIGUwxlEX1uY=
X-Received: by 2002:a05:6830:138a:b0:6b9:465c:d22c with SMTP id
 d10-20020a056830138a00b006b9465cd22cmr1676020otq.8.1690363442186; Wed, 26 Jul
 2023 02:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230725140604.1350406-1-james.clark@arm.com>
In-Reply-To: <20230725140604.1350406-1-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 26 Jul 2023 10:23:51 +0100
Message-ID: <CAJ9a7VgfFXsnD5mz23aeHBuPj81XErgu1ghNAykWgoYF+aFtMg@mail.gmail.com>
Subject: Re: [PATCH] coresight: Fix all W=1 build warnings
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 at 15:06, James Clark <james.clark@arm.com> wrote:
>
> The kernel test robot looks for new warnings in a W=1 build, so fix all
> the existing warnings to make it easier to spot new ones when building
> locally.
>
> The fixes are for undocumented function arguments and an incorrect doc
> style.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-cti-core.c  | 2 +-
>  drivers/hwtracing/coresight/coresight-etm4x-cfg.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index 7023ff70cc28..3999d0a2cb60 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -22,7 +22,7 @@
>  #include "coresight-priv.h"
>  #include "coresight-cti.h"
>
> -/**
> +/*
>   * CTI devices can be associated with a PE, or be connected to CoreSight
>   * hardware. We have a list of all CTIs irrespective of CPU bound or
>   * otherwise.
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> index d2ea903231b2..c302072b293a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> @@ -40,7 +40,7 @@
>   * Invalid offsets will result in fail code return and feature load failure.
>   *
>   * @drvdata:   driver data to map into.
> - * @reg:       register to map.
> + * @reg_csdev: register to map.
>   * @offset:    device offset for the register
>   */
>  static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
> @@ -132,7 +132,7 @@ static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
>   * etm4_cfg_load_feature - load a feature into a device instance.
>   *
>   * @csdev:     An ETMv4 CoreSight device.
> - * @feat:      The feature to be loaded.
> + * @feat_csdev:        The feature to be loaded.
>   *
>   * The function will load a feature instance into the device, checking that
>   * the register definitions are valid for the device.
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
