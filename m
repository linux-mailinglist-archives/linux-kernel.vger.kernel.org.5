Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737C47F4349
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjKVKLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjKVKLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:11:34 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D9210C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:11:30 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5cb4ee00da1so5821287b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700647889; x=1701252689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vP/wEMyyWeZXjpRHPyFJj2NtJhEcodvweIGAx/PKOf4=;
        b=n0cyBkXWblqsEl+hvxa/1Lpw6ZlkChqdzy53FGq9Lgg5N7STbru3hNxSinPUzCjgxB
         fGd9xouR0Mg/UPGl8E2bQPdjtt8mZ8nUYoEAc4m2F/JXA1+mqY59iYwhR6PmcX+d0HjN
         Emgl++Lf3VA+RxKcOr5GI+Gly7Fa8Q+Hx8gdpxBqPUbuqG4PgXiVFqRTCxU2wRvd2UdU
         NecvqnynQG8HHBoHHA5/llSpW4qy11NkGWdkbyWaITVna8jIKbpdsVsLNhLzNUgnjPDy
         Q++UbMoUhoECdKkzcUC2mer0qwRktl07Z/j5Lx3viZjHUFj4l0GMcSesUAH2rZhuydWs
         zpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700647889; x=1701252689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vP/wEMyyWeZXjpRHPyFJj2NtJhEcodvweIGAx/PKOf4=;
        b=qjQplqfyB8Bdp67sitFbYT9qkeZaqNpLbcizmy31w/A255bjYb1n4Knzf2MUOP4SAH
         VXUShxaY4+WrAmpEcyzJtXkHb4taCz5qrQxbB2o5uCbXNTxa3/TU8CPuJyILC1XD7JGf
         zF9wFh/+C4nMmv3EJZpcOCYMUYo635dqAzEL585L06ublrfykXnN8f31qSXxlXfl/QIr
         MXt6eEiEVYLKSi9lbw/Jup4S1bi1mrroawdCBFW7trd/S7N9L88gOED8GCgZeGYqdgEP
         QFDaml5scgr96Wr1Bcp8Ginu74jl8EVf2A8JhvYRwBpocJcBgwnTqMm57F4oDPr4l9UO
         wHvQ==
X-Gm-Message-State: AOJu0Yx2EUPzd2vLmKHVFMp32BV4evS93yLdBNu7loXMmjBbIsJp7KHz
        cEhv5SzVFbG/t9L+GcBmU76hmEYrCGjkWzU7crdN7Q==
X-Google-Smtp-Source: AGHT+IGx29kdRTQQn8CGZoh3j5mVVsJVk0nuXV4JhCJ+BjSjpht2kOA/BnJgoIEbmsQqceZ6ItO/dEMl6AfW/UGfH3I=
X-Received: by 2002:a0d:cccb:0:b0:5cb:79:ef12 with SMTP id o194-20020a0dcccb000000b005cb0079ef12mr4360781ywd.0.1700647889451;
 Wed, 22 Nov 2023 02:11:29 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org>
 <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-2-d9340d362664@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-2-d9340d362664@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 22 Nov 2023 12:11:18 +0200
Message-ID: <CAA8EJpq=3rPjJXRCBdf_pW5SVR1SgeHZd+4fXsyvw+qg6fd5cg@mail.gmail.com>
Subject: Re: [PATCH 2/7] phy: qcom-qmp: qserdes-txrx: Add some more v6.20
 register offsets
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 at 12:04, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Add some missing v6.20 registers offsets that are needed by the new
> Snapdragon X Elite (X1E80100) platform.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
