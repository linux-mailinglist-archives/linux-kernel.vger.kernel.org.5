Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF2C78B6A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjH1Rhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjH1RhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:37:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A24124;
        Mon, 28 Aug 2023 10:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4855C623E0;
        Mon, 28 Aug 2023 17:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DF1C433C8;
        Mon, 28 Aug 2023 17:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693244228;
        bh=tga8GO4N/hA8gXfJc0T7Z7dk0eMHOrpO8lNUy4BnGRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X/99MDqJgzRohaiWSvPK4XgGM5jvLQCA3cdak6SM7D+NhIoxHdkAsn/Xyqgr//UBG
         gx/pG/lFtqkacmeFLQfgWcc34Gr6C0YVpRAsQDy2fhiej/iy9ukfYdpg0wdMHv8HPW
         Ot0j8XWnJ2tur5FdB/kmVPZawH8wal9sJ3/6Uz/ydzJuglyDwnbCZRZMt0ZgSk1Pwc
         88Vl54fsCASTbHgufLDLad9/yEVLfX5w6yJ5hwovFMNljaz3Nf7CDnMaNsdQcxVs4M
         iv3c7Kw9fqVmMg6zfCbl6YwG7ucmZaaD1fj7UlxZgMVOhf2Q6du9JpkUHJ1miqbHVx
         CAbAG7yOQCmIQ==
Date:   Mon, 28 Aug 2023 18:37:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v1 1/1] iio: dac: stm32-dac: Use correct header(s)
 instead of string_helpers.h
Message-ID: <20230828183728.3e1fbc24@jic23-huawei>
In-Reply-To: <20230808164137.66663-1-andriy.shevchenko@linux.intel.com>
References: <20230808164137.66663-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Aug 2023 19:41:37 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is nothing from string_helpers.h used in the driver, correct
> the header inclusion block accordingly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied

> ---
>  drivers/iio/dac/stm32-dac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index 15eb44075107..3cab28c7ee3b 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -11,12 +11,13 @@
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
>  #include <linux/kernel.h>
> +#include <linux/kstrtox.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/string_helpers.h>
> +#include <linux/string_choices.h>
>  
>  #include "stm32-dac-core.h"
>  

