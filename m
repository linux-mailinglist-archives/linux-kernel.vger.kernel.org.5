Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B5077544F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjHIHkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjHIHkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:40:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146C1981
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:40:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe1d9a8ec6so3134865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 00:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691566834; x=1692171634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYypbR2BOr8zET8GaPdSoOCjpxsQd82de6in9KdA03c=;
        b=UXJHIiWTBam0bGvsriQfntFFLIdoxWBcq4eh8xBIkyzRfhil6eZW+iIpaqq8jaggbC
         FxEnJRmj9H7pwLfwaUTp0QLVbvP0nUu36hid5c7v3xhDZzddCC3qkyYxenFSv1FLKLSY
         xj1uGW4TBrABTTPaxdA98pUBdOuz58/IN/95oMc5bndPIfy9fTkAeQhe4bloxGjOHvR8
         pzVKIitpBaILvRi9Mgo36GwJvqu096bAJ947klQ3uKnxwWzlO2+pyLYwFmLxPVAMvq9k
         rjChBWJnaiqSc+BtEbJ3Q02z/CYpZynYkwnFn4ta/lOIgOGFsQ4geJbEameWORSITokA
         ztjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691566834; x=1692171634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYypbR2BOr8zET8GaPdSoOCjpxsQd82de6in9KdA03c=;
        b=XMi2iZJqGUkEA1Nl/7C6WBrqT25hGhytr04aLo5UEv7Rkm/vrxAzqkRfcFgWjUN2eC
         XYOV+3WkFS2MlWh6haUtz4S6W/6UEoKKMix2Un+2UwfZ0DjSZsEXoWjJVfGKmiX4Bh+1
         6o/0SLBWnNDXN1C1Bblgd6Yv/Hef37W2xkSYa41NaTbhA32f0WNV9vwHOxFce3xF45rB
         9HWYz7UCx2fUKP80nnhr4ANhtxX9nnThV4wKjhVqc/kGFW4LvwtGBqYr5xCeDmXDTU9d
         zGnpRH/PLqQVO2VHvxhT49J8nVg920w3I7jWvxtlh3+ZcOKgZLUHSV1GWjestJVTnkd4
         yR3w==
X-Gm-Message-State: AOJu0YxXrQdFOxmLDKBnl/pTumS0/gHQLLyzpLAtvO51XuFINqtkWYBf
        DL/yyxrh2jWBDFGaJ2U1D6WWoQ==
X-Google-Smtp-Source: AGHT+IGYAehkRoFOJds1BXJD9VgTewrLVWujc0R3IWoUImvJckfERYsfBHnUNMLnme6MWTwTT9pcAw==
X-Received: by 2002:a05:600c:1da2:b0:3fe:4c29:e626 with SMTP id p34-20020a05600c1da200b003fe4c29e626mr9532320wms.13.1691566834728;
        Wed, 09 Aug 2023 00:40:34 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x26-20020a1c7c1a000000b003fe24da493dsm1087148wmc.41.2023.08.09.00.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 00:40:34 -0700 (PDT)
Date:   Wed, 9 Aug 2023 10:40:30 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     tonyhuang.sunplus@gmail.com, lhjeff911@gmail.com,
        ulf.hansson@linaro.org, arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, error27@gmail.com,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next v2 1/2] mmc: sunplus: Fix error handling in
 spmmc_drv_probe()
Message-ID: <d4eb3558-c270-4aea-94a8-b24b8d3a1987@kadam.mountain>
References: <20230809071812.547229-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809071812.547229-1-harshit.m.mogalapalli@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 12:18:11AM -0700, Harshit Mogalapalli wrote:
> When mmc allocation succeeds, the error paths are not freeing mmc.
> 
> Fix the above issue by changing mmc_alloc_host() to devm_mmc_alloc_host()
> to simplify the error handling. Remove label 'probe_free_host' as devm_*
> api takes care of freeing, also remove mmc_free_host() from remove
> function as devm_* takes care of freeing.
> 
> Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/a3829ed3-d827-4b9d-827e-9cc24a3ec3bc@moroto.mountain/
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis with smatch, only compile tested.
> 
> v1->v2: Simplify code by using devm_mmc_alloc_host() instead of
> mmc_alloc_host() (Ulf Hansson's suggestion)

Nice.

Both patches look good to me.
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

