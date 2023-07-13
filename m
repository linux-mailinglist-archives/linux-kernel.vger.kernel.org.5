Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C561D752937
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbjGMQ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjGMQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:56:26 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0932701
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:56:25 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-57764a6bf8cso8690157b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689267384; x=1689872184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lwu1I3VpHiRFp8zypeMBICpm5L6K6gQ6kqfkIVHdvMc=;
        b=zFWNwpn2GNJcLzXXrGrWS9AKcJ0DImSUU6+KRjzpFMbDaeYobKGiU7x9m8EJalI2tp
         zsjvwBdbBi20McV5zc4GtM4zHzLEEH4x3AQaoj1rXZYA0lNRIT/0vu0EJIrgUZQe6DEM
         umfVTs0yWF3sKmpfy0F949JSI3lHq9olo2SaHYWxzOV6hTLIrlKT9w31wlVqJ93dH4aL
         5dQCsQFdDfcyzUh4oTIir9yZcG9y1wmgeD95vkLqz5WMOgsuF95L7rpnITMIiyTwDbyR
         ibh/4EY5usxLdaH6e5qFF0qnBNl8epNwGqFcI+9hqSrs26OZ4tXumjJnlBql/F3Fb588
         4jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267384; x=1689872184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lwu1I3VpHiRFp8zypeMBICpm5L6K6gQ6kqfkIVHdvMc=;
        b=fo+o2+H0K/GntpKZW2deTUNUuSHwff1X1EWvTEIQ6H0oRAbTQ6qFq67Xy/vTAXhO6z
         wp0jan+A4t39rbduwiE3kxP9WsxbtANi4YyAyxjDcObHDZb2IYPOmKMr4SkGpRxe5vQQ
         Sbm6J5bbl5+7WJgrdfHHJr5eaYGkq5gNcoqerF5ehwDoc8DYRVPkWbbuJpW/B1pgjjGI
         mNkBLDantmZ0Onvfp3ClKYzOv7NPWlIXuczR0g9JZcpD30lnu10Su3XdbJC+uJAXZtHx
         G6RFJpFmOjzX5/3/l46w5Fjx5qMAwmdHd2D5HjnK/FhrCAgwz4tqL88M5KHH+6rI/K/X
         t/yQ==
X-Gm-Message-State: ABy/qLbyTlbnbc9h0+MJi72Q9yorZ7sZUdsjX0jrRUMnDyRzoCcHht/n
        kd5qjynAoTbRtYXp69KSEtRpF9upUSY0QZTsq0iTdw==
X-Google-Smtp-Source: APBJJlHFuWHcG2GjrDr+7bUaz9zLs92AKucVrz6y9P6Pk+I/TSja5Xolg1JP919CvK1l2ynUnRyEqopef1QS+eiVU1I=
X-Received: by 2002:a25:32d8:0:b0:ba7:7664:916b with SMTP id
 y207-20020a2532d8000000b00ba77664916bmr1776961yby.20.1689267384460; Thu, 13
 Jul 2023 09:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230713160415.149381-1-minhuadotchen@gmail.com>
In-Reply-To: <20230713160415.149381-1-minhuadotchen@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 13 Jul 2023 19:56:13 +0300
Message-ID: <CAA8EJporcTpZVvX-Ox2cHCnsZ3JEH_9SF_U2o85z-88jZ+rG-Q@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/tsens: make tsens_xxxx_nvmem static
To:     Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 at 19:04, Min-Hua Chen <minhuadotchen@gmail.com> wrote:
>
> This patch fixes the following sparse warnings:
>
> drivers/thermal/qcom/tsens-v1.c:24:40: sparse: warning: symbol 'tsens_qcs404_nvmem' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-v0_1.c:26:40: sparse: warning: symbol 'tsens_8916_nvmem' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-v0_1.c:42:40: sparse: warning: symbol 'tsens_8974_nvmem' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-v0_1.c:64:40: sparse: warning: symbol 'tsens_8974_backup_nvmem' was not declared. Should it be static?
>
> No functional change intended.
>
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/thermal/qcom/tsens-v0_1.c | 6 +++---
>  drivers/thermal/qcom/tsens-v1.c   | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)



-- 
With best wishes
Dmitry
