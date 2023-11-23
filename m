Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC847F6412
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345038AbjKWQjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjKWQjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:39:09 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06B91B3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:39:15 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db4422fff15so541566276.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700757555; x=1701362355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0eTdj9miWeM4U+bp189+wCGxZuG/z71lDB6h3m9Wk18=;
        b=tp3RPnxgavkp+8Ls+BdGNu+yTGMAMwPL1bsD7oxXawfeMMySkuamNgStNXIqUv3KLE
         l5dsXwuDKPLCMC2aSG2D1L4wWm+kKbJ/uJlnxX/uqTq6RYG+qhGITTyQ8WCiveud1waf
         fcJTtWoEDfhehzOW/zhaO3dXye9wvfIOmQ3vUrhInnImmCPKY/6mpL4xHSDqAtkQpCjt
         lckXAc8HQL+KFIfHuMrPSCItsihpI6Xad9gWmW3BLHLl6Rhe7v/Ut4YNa3O2mLwdTTCq
         jCZCxJhay8p8mrb4t/ZivakfTqG3yg2Lc+i4z8+LAFWwZ3Dn59FJ3D3YKnwFP4WTDigP
         3rIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757555; x=1701362355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eTdj9miWeM4U+bp189+wCGxZuG/z71lDB6h3m9Wk18=;
        b=UpjGxa9bh+qfOQQadFPWBsXdxVzZPVin9efeNd/HcCD44IvEBrVkmjgCREmDdv/Mrz
         Xar0NEBKNB38vFACGKHRUcrwc+B1W66iP4pH1vpFBy83cnGxPuTSSvomUwc24gVzSVR/
         8PK/w5iQMeyMlqRxxoQYHbQ63Mgi9tt0Gd/lyIWjhD76USpL+BiEZVNVQJ3YqJcK/EYw
         77cicARJC98TpFW5MyKpteyuZ2ICWhRrXF/hilwLtILS6P80oF8l3WADEtxe8uCQYv6x
         MmX16pU6PDlWkVvIw33inbCJoeC8P2DBHVMzlYYRuwP2ADe04qO7wx8I4EgE+WXpfFlC
         34HQ==
X-Gm-Message-State: AOJu0YwnNa/uKUqmYJ+9SArqrAJuu0c21kOWAUWnHcD5IH1t1x9e2XNh
        1B+BmvYuSpKgy8fgj8H9iA+IA1M+ZJ7BmPHaFBDN5w==
X-Google-Smtp-Source: AGHT+IEvXn81cNYK+IH1RhWt+nLuhiDh2Z0MjG/kWfFXbI01hwighqvsvEk41nf/V7A86F7avZeTYr0TTKlSd1xH90o=
X-Received: by 2002:a25:d08b:0:b0:da0:470c:868f with SMTP id
 h133-20020a25d08b000000b00da0470c868fmr5952168ybg.51.1700757554924; Thu, 23
 Nov 2023 08:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20231123100021.10918-1-quic_sibis@quicinc.com>
In-Reply-To: <20231123100021.10918-1-quic_sibis@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Nov 2023 17:38:39 +0100
Message-ID: <CAPDyKFo5Jb=YWCZ9QvVScUDpbLAFehuXs4BBAHuCERsGFrdS_g@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] pmdomain: qcom: Update part number to X1E80100
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        conor+dt@kernel.org, quic_rjendra@quicinc.com,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_tsoni@quicinc.com,
        neil.armstrong@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 at 11:00, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> Our v1 post of the patchsets adding support for Snapdragon X Elite SoC had
> the part number sc8380xp which is now updated to the new part number x1e80100
> based on the new branding scheme and refers to the exact same SoC.
>
> V2:
> * Add more details to the commit message on both the patches. [Krzysztof/Konrad]
>
> Sibi Sankar (2):
>   dt-bindings: power: rpmpd: Update part number to X1E80100
>   pmdomain: qcom: rpmhpd: Update part number to X1E80100
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml        |  2 +-
>  drivers/pmdomain/qcom/rpmhpd.c                       | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
>

Applied for next, thanks!

Note the DT patch is shared via the immutable "dt" branch.

Kind regards
Uffe
