Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F067F43A1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343719AbjKVKWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjKVKWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:22:03 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D9493
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:21:59 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5c08c47c055so70295877b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700648518; x=1701253318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/gZ0hKqy1f9kc8RcgP1XxUJkPdo24HWoCQORei+jumU=;
        b=gVNuTINJO3YZMS0daKp9tXQpCdfuT+DlFUNQwHLT6KPOZ1T/stDiOEl+nB01TKi0nm
         DQvngE+QQHlYGJM8zDqCkNbQeDV6aXptQ08AXxvdMK9hpu9gF15dnCaO330BEazvpH/u
         mUYu/PdXqzWCamADqrS1lxjgMqjEvP1Ikymg/2dkUMa62lntjABBk60FmUg9O7n+gwFM
         /crX9hsb552WN5zxiuDJ4W3P+FPcIs/zJLabczzVI/Lhd2bLsg0YKEjusrkBDw4/tD78
         Y76bE0fKO6VCyy7RA4YqeecEhNkMxmHwJcf0g5y6CfgMg6wjw+0fj3jJPTPj8Vyie6yv
         rs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700648518; x=1701253318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/gZ0hKqy1f9kc8RcgP1XxUJkPdo24HWoCQORei+jumU=;
        b=XFHeMJI7ix2juK/nQEFidZivG/3YQpcUyYbt1ZWZ6gRaXGeb0LMZjj8JSDUax6c9Q+
         xMVuf2uDZyF4jSCwqrfE3sU/8KwCOUdAdD0rI7f1qypgB9eBcKTdj6s+vt+qs7KhNCYw
         CHdaPGArMcKRrYx77fHOrn59WpSqT7GD3ZudGad7Va6dk/mESINIuH/uuWK48xkGmf0v
         5A5TKEt0eHnqhl9uh3RKaQ87EmzOzeBtkWpYk+WP5Cm914U8FLl5pdz3DlobDWBecSuT
         ZGGC5nLnrLBrlN1LJ6ygtHGnU5hWZYth10sg3yJxNkbXLTf+hWU3NLY8UWnsidyMBLWX
         GsEA==
X-Gm-Message-State: AOJu0Yz4awzOvvrVP89uKpxrSr6Gm2fwSBERNW3Z6PQVkmOX1gXAUj7A
        vrFEOv/e+glDKBAYahiYYS0jXnHwdNMxIk3MVCLuFWS85STSRTmbEd8=
X-Google-Smtp-Source: AGHT+IEeRQ4qsIvFGcEJIwsctyI3Q+u4v4Ik5e2P38+EqeUPIaxGM5oXZGPeHDuCv4isrbvSHwDGDrO6Y+saFepsexE=
X-Received: by 2002:a05:690c:408a:b0:5cc:8f6f:39c0 with SMTP id
 gb10-20020a05690c408a00b005cc8f6f39c0mr713906ywb.28.1700648518161; Wed, 22
 Nov 2023 02:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org>
 <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-6-d9340d362664@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-6-d9340d362664@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 22 Nov 2023 12:21:47 +0200
Message-ID: <CAA8EJppSmWDxCqgKOhbr3JwhKjSvSB89HxtN859EeEPu82nxJA@mail.gmail.com>
Subject: Re: [PATCH 6/7] phy: qcom-qmp: qserdes-txrx: Add V6 N4 register offsets
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
> There is a variant of V6 offsets that are different, the QMP PHY N4,
> and it is found on the X1E80100 platform.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h | 51 ++++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h                |  1 +
>  2 files changed, 52 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
