Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772D176A87F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 07:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjHAFtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 01:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjHAFtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 01:49:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3151A1FC8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:48:49 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3175f17a7baso4706476f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690868927; x=1691473727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Et0y0K2d+vVjwJdOfEnIsO7SeHd2XahanE6nhjTZtyw=;
        b=ZGI+j/vdjy03FGaaR+xJmI0DMD0W/H7WW0lm3ZBYDDRezadMv0/SINLUbiIcwOtcVB
         6rWtQ2cJvXxRZSulEQomaoyiqBzEnpaplbDFim591uXPwyf87YmFLWNt8bAd8yRX21DL
         GPjKd1X6TmlAbHcj+cjT6rSO288MI/s1Ly9eRctTJkVrb4crvbJvy2HCXg0B9TwHFNog
         exm46xW+eeXJaPHIok5LOyVhVurfSDya4DvT5rzGQTRfvdYmYkmfRftvjki7vmeyBJze
         IB5E8F2VxjFjcTuEPg8Qfyk/2klnS8EVtHCoM+VIx9+1reKs06NNxqmEiizsalvFHGLR
         NLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690868927; x=1691473727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et0y0K2d+vVjwJdOfEnIsO7SeHd2XahanE6nhjTZtyw=;
        b=RywFGaEW1mtmp9360KzAL/SIvxjbpnMjdCHUhn4qQNGEWkBUZHk+mTPNwlJdZ73NT0
         cE+pIEigiKFjg2xkKdmbJRS2FhCN2FXY0Nk/bEuBdTGjlp+hK+j4Y6U0CFT6iCZhG1Bm
         eCVH8ULY5bcJgJA2+wMN1gnsLpWuaB+wVLiO+UOZ4+RQSgZWL2buoZ22Z2ymuTwS2SGI
         eXd60VpGJ09lAC6CG3GiFqUqMuDIysi6nzNjyqqLft9sg5EUbpt7rQHBdst8Cqn781QR
         +BfcMAZK7vtPJ/kCEguOMR5ZBkIatpWbaGs+ciTo4IlqnM0PJx0p/4EiuLK0b8+werxF
         QNzQ==
X-Gm-Message-State: ABy/qLaXdW6xLkQpLPU2GFEIN++ZGMRY0jZ6+WHTUgQxJww0/UkI8dGM
        hzsGulOUBIG0wnMVkKjL5lmzP6L1EsI3NOYK724=
X-Google-Smtp-Source: APBJJlHhGeuATSL7uKZn4NPYaNxFYSoHPGkAI7laRJP7KUIdZtITolb3PfjPpmxMeGEj/ExyQbcwog==
X-Received: by 2002:a05:6000:1808:b0:313:f395:f5a3 with SMTP id m8-20020a056000180800b00313f395f5a3mr1408315wrh.38.1690868926808;
        Mon, 31 Jul 2023 22:48:46 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d6184000000b003142c85fbcdsm14984240wru.11.2023.07.31.22.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 22:48:46 -0700 (PDT)
Date:   Tue, 1 Aug 2023 08:48:43 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
Subject: Re: [PATCH next] mmc: sunplus: Fix error handling in
 spmmc_drv_probe()
Message-ID: <042ff6f5-58d4-4e93-aa26-79411bf81c54@kadam.mountain>
References: <20230801052321.1328225-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801052321.1328225-1-harshit.m.mogalapalli@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:23:20PM -0700, Harshit Mogalapalli wrote:
> There are few issues in spmmc_drv_probe():
> 
> 1. When mmc allocation fails, goto is a no-op.
> 2. When mmc allocation succeeds, the error paths should use goto instead
>    of direct return.
> 3. platform_get_irq() doesn't return zero, so '<' is sufficient.
> 
> Fix the above issues by adding goto instead of direct return, also
> remove NULL check in 'probe_free_host' as we changed the goto to return
> when mmc_alloc_host() fails.
> 
> Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/a3829ed3-d827-4b9d-827e-9cc24a3ec3bc@moroto.mountain/
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---

LGTM.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

