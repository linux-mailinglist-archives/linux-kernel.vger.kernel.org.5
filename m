Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68597D72C2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjJYR7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjJYR7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:59:51 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149C5184
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:59:49 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b2b1ae4c21so4126851b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698256788; x=1698861588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+X2BcGs+yr5ozuWWWHgMfFUYNfIzqQVUuDmFrK+H+k8=;
        b=N2ZfGEhkHwAxCnUSg5U6gOYoKiM9IYBJZgUvpug8JRt+N8fGqcWVKLgMRLHW1yZGkm
         yLrgmTZMH6CGru7H/nRWIdutHNUGrepmLtX8EF4dTL5kEsN6eJcFZ+uBwSYtCe15onYA
         cMq4GkT48ihaJof3WB9Mk+Wo4b37mmHzBWNMA2u+kk9msGo+BJq9UiEvicm7S+hY3D1r
         D1aav9omocOVPbNopaui2wyxPP1bkFCLYlBND80uGGuvQXpWsy6Fottc7aQbMJAdr2TS
         oReZrVl5+JKkXFdwotYeFI7nrbQNq9/UmCAxIwUMBV+g9wnKgLsZkV2qUev51+NRlWHd
         yFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698256788; x=1698861588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+X2BcGs+yr5ozuWWWHgMfFUYNfIzqQVUuDmFrK+H+k8=;
        b=sXUqQ549tXwe8BqKU+p7ckSJ7D4rAqTqNbYtut1xvZkdeXMaoNpRBdhNIhPOUXV9Km
         lIwhoB9rR0ID/C+DO6URASji+sRVItDlKilJ/si0L0LlNgjkOvDbGJ+KL2w1oTGUx7rr
         Fo/R/uFxzxwg5PySCC+hNTijXDHIRUgDf21QG9B40LZ79o5aTLKJWvgD7SOLyhQcriy1
         suFaZtqtnw/LJnSjLo6h+lxf7EfIaRal5Z3B+nruUiHBlSb/hDwiuJkcSiKMPES2ORej
         Abki/+KaBm1Xqram66eDw7aurUPUC33hVjlFD0P4ev5aAFs5zpPj4fnR+yqW2bIzmLjS
         kEGQ==
X-Gm-Message-State: AOJu0YxxbVaUo+Nbb88wqXRXRIn5POY7zKoZrw6NkOdAHtK1qduky6Cy
        QAddJQ3v57//UzjjE1XWbS1BZpBCwx5/1uIodvxMFg==
X-Google-Smtp-Source: AGHT+IHt0K3a3YxmMMAXLMGE/SLHxoNsrcnDOTH2dLfGGsktR/apcQTUfBYmn31LK8udeC2DVR6+WlimdKhWd044Rt0=
X-Received: by 2002:a54:4090:0:b0:3a3:ed41:5ab with SMTP id
 i16-20020a544090000000b003a3ed4105abmr16867919oii.9.1698256788382; Wed, 25
 Oct 2023 10:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <1698253601-11957-1-git-send-email-quic_mojha@quicinc.com> <1698253601-11957-3-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1698253601-11957-3-git-send-email-quic_mojha@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 25 Oct 2023 20:59:37 +0300
Message-ID: <CAA8EJpoYTXwdrwEUnRLtpeFY=xC_wYdE_pW1W4kM=JkRmR=mNQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sm8350: Add TCSR halt register space
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 at 20:07, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
> Enable download mode for sm8350 which can help collect
> ramdump for this SoC.
>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v2:
>  - Improved commit text.
>
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
