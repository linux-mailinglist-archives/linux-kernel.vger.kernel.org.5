Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2548036DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345114AbjLDOe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbjLDOek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:34:40 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625A711A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:34:44 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59b5484fbe6so51258227b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701700483; x=1702305283; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UBJs9HC3lM8sYwTRCXh1LpvZlOzGYSuuBBbJkIOs//U=;
        b=YaB/gZUfhLPXoqYnr1QPK96+E7oKc6HgYxa0Hoe+qWsBI0OsLUZqhiE+ee2/6cddv5
         ctTn9H9sDwBnpQzSu8BF8XEJdCGa5xXSJvP4Zl1SGlZbS6nNZI2UY/BkLtX/7ZZYevrv
         QkheP15F2U0dRWjJS7dr1C/myPZ8gIu+/2aOHUzlvn1F5qWxN70Lgmuv2z8T/obv1CiY
         bmSo7omQmPwIY/2dJO0igkk9MfllyzQ/56IAjytLwUVGgVE7fOmnbkXPaJ2jJFnaZ9IY
         roUN6luf3OYzgLdOCmKTB39WkRtMRcCuYi1GjVHANlpNYm62sJqadxUzZ0SwxBZqeEir
         PyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701700483; x=1702305283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBJs9HC3lM8sYwTRCXh1LpvZlOzGYSuuBBbJkIOs//U=;
        b=YWAxgjJFE0WBpgmnhH94GJPCno8AnZaf3d9nspdjSMZ1VXJW38vK9Ik6L36+xj+/Ll
         UQ4tfX0rdYOMXuJ/5hzG42InvUCrvsW5uLLLuO5bqwGh3qB9kJugkj1sNRWhSSUEYxAS
         0ektjx9Ev3ZYOI/khq8BfwOU00ne1Ao3hjf68nF+uB0LdBxcq68b+swirMMBeuwcOViI
         Ir8qOmotPW/w0efmXyDqVSqsqufW0+6GzhXPFvMBaUSDO7oIAkcZddSHDPYV/wUGM4iC
         Rv7WrvZec+aT3nJrRL17Mh2mJr3UFEpo3c4PkIZE+/ZTonjyfpW0Pt5EojAsuIjMk1ed
         HAhg==
X-Gm-Message-State: AOJu0YxZmC5mV/Em8w7pH+y2hMz2Pu2b9p0Rix5puGcqBY88+giybYQc
        UViqbAUCA0SDHm16u9aAAho/g7U2Kh1btbKfArfA6w==
X-Google-Smtp-Source: AGHT+IEQBiggNpMjfj9oThMBY/8bdATSwaG+XOy2BXMbwSykTrdtIUthOTH1NAuFhyC+vQtpeQxbkyOnMjBb+nYhN8M=
X-Received: by 2002:a05:690c:82c:b0:5d6:aea0:2236 with SMTP id
 by12-20020a05690c082c00b005d6aea02236mr3471440ywb.26.1701700483592; Mon, 04
 Dec 2023 06:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v2-0-21956ae0c5c3@linaro.org>
 <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v2-7-21956ae0c5c3@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v2-7-21956ae0c5c3@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 4 Dec 2023 16:34:32 +0200
Message-ID: <CAA8EJpryFUtWU1PPHzW2+gkz9UOzWPTvao3NTS0ABhLO4HMFgw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] phy: qcom-qmp: qserdes-txrx: Add v7 register offsets
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

On Mon, 4 Dec 2023 at 15:08, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The X1E80100 platform bumps the HW version of QMP phy to v7 for USB and PCIE.
> Add the new qserdes TX RX offsets in a dedicated header file.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h    | 78 ++++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h                |  1 +
>  2 files changed, 79 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry
