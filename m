Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0032E76C9EC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjHBJ4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjHBJzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:55:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2119B196
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:55:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so10901931e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 02:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690970150; x=1691574950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3f9a0bqaXmmtqQwbJx6feRw+OxMSPGWZtZpS80ibCA=;
        b=TsJKcJ4yS+4vQ3C3KyyOdARzfk2j7dx8adqXZ7Vodft741sJJC8JXHqCFds86wXwej
         qESohiG6KA+3asWplAABmzuMmvTuko03NiF3hzUyb5GB2+eosnAl7+FAu9ZxBElkF/ux
         Oud3ZV8nuudqi6Bd9CtI7cgEi8AZfsc9/QaOD2Kz7RFeoQKNoU1bsFSdPCfBf/miIasS
         2UnUx+DLvRociKdqbZISdIElvZDz1+EBwOhXAudcLqsyz2x9w95peJGgNsfrBjZfNMA+
         twpZJhWribksSbomuAZgWLi67yCoMsn+vhHKSrm3wuMb1ESfqpWy+KkximQRMQXFGyf0
         qc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690970150; x=1691574950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3f9a0bqaXmmtqQwbJx6feRw+OxMSPGWZtZpS80ibCA=;
        b=D0Pe5wo5Ej1cm10ZbclyhEuyKvkrTgEMKspGamaKZCAFAC0z+YrQ2MESp/N4l1REqG
         2pPTC7FFGLM+AdQmd29P5L0ld0nNt+GivjfPE20S6G1ju7wLDnxpkNSKtuHrIoLxwl9I
         BNkRCSHSCeKuTDwY8+ovKWfV52lKlptC25k0ZgLsxafs/2ee+oNamX3tiJqMkErskUbS
         nkIl7aVya7kZVs6wG0lp0taitDDJrHG0weofM1HdLe5d1tbo8oD6j4u5TFMNfw9qR762
         TG4dEDJZKixWQBTaVsKTJWMU2/Jb61WfQF429GFmcfb1kDlRhDuojkfpsuRVV0pUFcG4
         hjrg==
X-Gm-Message-State: ABy/qLZzYEKckv1a6r5HwQLw3R+Ogj2cg/6vgJ240aTWMNd++KaFg22B
        JQzCAnM/Kc2iN+JtD6v1uB28MA==
X-Google-Smtp-Source: APBJJlH8PxyhUTN1mgA7mgCOhBeQJg4KAK+rtWR5LQCJoz3DfP5YUZqpJdz9DuxfNw42F/LERt4eUA==
X-Received: by 2002:ac2:5319:0:b0:4fb:7c40:9f97 with SMTP id c25-20020ac25319000000b004fb7c409f97mr3788949lfh.27.1690970150547;
        Wed, 02 Aug 2023 02:55:50 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x17-20020ac24891000000b004fe1960dd7csm2779762lfc.132.2023.08.02.02.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 02:55:50 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ruan Jinjie <ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] drm/msm: Remove redundant DRM_DEV_ERROR()
Date:   Wed,  2 Aug 2023 12:55:46 +0300
Message-Id: <169096995980.4183272.6381311756168703819.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727112407.2916029-1-ruanjinjie@huawei.com>
References: <20230727112407.2916029-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Jul 2023 11:24:07 +0000, Ruan Jinjie wrote:
> There is no need to call the DRM_DEV_ERROR() function directly to print
> a custom message when handling an error from platform_get_irq() function
> as it is going to display an appropriate error message
> in case of a failure.
> 
> 

Applied, thanks!

[1/1] drm/msm: Remove redundant DRM_DEV_ERROR()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/f09f5459bd85

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
