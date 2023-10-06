Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB407BC07D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjJFUjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjJFUjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:39:54 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AF1CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:39:52 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a2379a8b69so31007217b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696624792; x=1697229592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCCsvCjoztAYuiGh0Xey9xgcOmDlkIVfrEdnFUpQWQo=;
        b=qmMMSAtMV0KLM9RtwJ1oPScNfXITRyUkLad/AhjuEweUNldoN0AJeWyNTstvXzmeQ8
         gPagpsAknageqJ2nJkzj1ta1fJ0XCstDYqFU45yFywpi4tbZ9PIxxmiXc/JGDlzuoCCY
         PGYi3ppvhtoA1qOCMTA9FCqIf/deMf3VYK0t9K61OJIACuquQmKYrxD3lnzwrG2ohtk/
         Pw95MIx+DEwBJYHWkm+2yVyA9K84i4zSAu8wFowL3uJFmi5G+cgf7UengCnZeg06OmHC
         J/v33EpEEpX/CfrOF5KDjxdJs3ik4LGPL6KER0wrk3d2Zaa8I88NSs9sOf0LQy0HuEJC
         ViFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624792; x=1697229592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCCsvCjoztAYuiGh0Xey9xgcOmDlkIVfrEdnFUpQWQo=;
        b=RbCQ63K6yNZq/8ZvDY3SGGB7YunJ1seyCJGBmLo1qyx6Na5eOnlnam8hKqfpz35nsY
         sc1FSH8UEkCCLGU3bhIU7orkvwtN9AZnx2s/fLlMjr99Uvlxjt9oWVWRxC9483mNOnQQ
         7rhDikBXldHozt/frnNM2AMAVYJF8+TeOJ1I70EgpgfYNAQnunJ+oHYBGE8atq2QJJbr
         QTrc9c+neuQwJkMRH+rI5OotwEzqPThmNg0O9MY3uWTg1IxbANmYcwBZDLjdzOQqrGhI
         hcadtTMN52IC7Utn3xuwLjxwYj3eQExjxyjLZ6C+i+yRgNObum6QjuDFeJ86+pTolzBA
         5CBA==
X-Gm-Message-State: AOJu0YynNgvJSBWpsytiwkVkYi+qRlr/bS2hc91eaBNEfGCTbuRKJmZP
        RsRRZ+pIeSDVVnc1NhTAtRCrS7j1PwQFUur5lTXgON10b4XsrYcR
X-Google-Smtp-Source: AGHT+IFR8NVGwTdVcapVfJC8kRBUPD6L6tfpVRlQ1CZCYYO//rqZ3c7OWFya24qTOj/hY79e7ym8EazegWVwlW4BrEw=
X-Received: by 2002:a81:7cc5:0:b0:599:b59f:5280 with SMTP id
 x188-20020a817cc5000000b00599b59f5280mr9869580ywc.28.1696624792113; Fri, 06
 Oct 2023 13:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_DD2D371DB5925B4B602B1E1D0A5FA88F1208@qq.com>
In-Reply-To: <tencent_DD2D371DB5925B4B602B1E1D0A5FA88F1208@qq.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 6 Oct 2023 22:39:40 +0200
Message-ID: <CACRpkdZtOdBYfHtAE-2QzqhUhELFm38TV93ek7bO1qLJMGiXLA@mail.gmail.com>
Subject: Re: [PATCH] maengine: ste_dma40: Fix PM disable depth imbalance in d40_probe
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     vkoul@kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 4:28=E2=80=AFPM Zhang Shurong <zhang_shurong@foxmail=
.com> wrote:

> The pm_runtime_enable will increase power disable depth. Thus
> a pairing decrement is needed on the error handling path to
> keep it balanced according to context.
> We fix it by calling pm_runtime_disable when error returns.
>
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>

Looks correct,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
