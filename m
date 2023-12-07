Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF1F8087AE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379247AbjLGMYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjLGMYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:24:08 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06416B5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:24:15 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d3efc071e2so6326147b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 04:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701951854; x=1702556654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MiKLmLIgvazj+jtVgQtH7JvD+NHtPSGxW4NwV0BlIco=;
        b=K+YfXuQu9rw+8mUINwZ5NcYr8Doke2Y878dV69PlB1GgCqmmoos4naykIm4nBr9D63
         ViaqVp+P9D9jcG8EV7k+KrUInnoTctZhQNBb+fjsIXffcBbjczfN3qoBwufh0/ak6OQi
         scNwNTgYbrF63SGmP0ayga3nqyudxj6+LW5O0JUdWs2EK42l9jl3zVHywGHZmaEevjiz
         tb41a26yCX4tg55y/xinKmijdGoL342T0QUFR+yQQEyn+9UHiBrhZFQMzYNF/FsLF3E9
         OZbOCBcj/B1B0/CFEPZh4bMsbwBTLqxuSs84t7Vu19HNnE78+8fTgx98h5HVIly5O0Kr
         +UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701951854; x=1702556654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiKLmLIgvazj+jtVgQtH7JvD+NHtPSGxW4NwV0BlIco=;
        b=qIn35q9sMmJptBJGNmqzortNRTjTnrYd5sbDBUrPg1AZNJLRmOtMGlePEzwCxyD+Mw
         znCAwI6OlChKZGba373/7RvCF4fgJf0uQcEEQiGc0wMolHtqIoJO65rvJJWjKp6oSxFw
         QAEodO5LrEO18oQTTJy3zOPQQkVb8K80TX+tAS0sCyvq/2fQST5ProSiWJnXw7w7ILwU
         uwr74YVdWB8Xj4rYichA9asZAUdFg4Fbxajg/s5vs/tjbIiu0elv/a2/5QTRPgHQibk5
         dp5m2rQxUumOF2EEh0CTJWk3pmCIMoXHwXyQOJ38GUllZjtlSsD8pnTFlTlrlcvjXs+E
         qdog==
X-Gm-Message-State: AOJu0YwN4309vGWc1GIgk7zG00GC/E3Lr9xmQGQCiXZpcORf30ShLS2P
        yOYFTSLQaUFZ4+I+K2lE9xAkAKkD03OSZ9Fg8PcxSw==
X-Google-Smtp-Source: AGHT+IHqCc46uHXGyBjJCpF2wowIEkat5HWL4fNDZS1yBZyQ6JsjmMrOr0YV4JZnMRdfN+polaHzy3D/khi0W5LPnYs=
X-Received: by 2002:a81:ae16:0:b0:5d7:1941:2c1d with SMTP id
 m22-20020a81ae16000000b005d719412c1dmr2049988ywh.74.1701951854242; Thu, 07
 Dec 2023 04:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-0-dfd1c375ef61@linaro.org>
 <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-3-dfd1c375ef61@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-3-dfd1c375ef61@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Dec 2023 14:24:03 +0200
Message-ID: <CAA8EJppHjA2VNBwD=EjcBSjqGtLcc=co8M8QjzjWi93VDSTOAA@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] phy: qcom-qmp: pcs: Add v7 register offsets
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 at 14:19, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The X1E80100 platform bumps the HW version of QMP phy to v7 for USB,
> and PCIe. Add the new PCS offsets in a dedicated header file.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h | 32 ++++++++++++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h        |  2 ++
>  2 files changed, 34 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
