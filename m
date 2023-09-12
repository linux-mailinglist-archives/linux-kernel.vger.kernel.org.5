Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3CC79D868
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbjILSJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbjILSJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:09:46 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB50A10E6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:09:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcde83ce9fso99960331fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694542181; x=1695146981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWTM0f5/i1QnClAjTECf9BeOt/psp+zCb1GGDraYASQ=;
        b=czfZb3j/SidR1NgJ7VYFOwQeFooWtDYkf5TwjrOApqlX9hDSDvzAixN3CbccRBSGvF
         9c4658dXFrpeA/FDy5TWv2NUdpIg4W6MZjwJKn+DL6/91dQ9hSFiUOI4V5jF5z5ERGKu
         k/PyAe2URtdinroS4Xh2OlZUMkBD6YLaG5n/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694542181; x=1695146981;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWTM0f5/i1QnClAjTECf9BeOt/psp+zCb1GGDraYASQ=;
        b=mEuFk3YbnYW8WA/CnsqNBReiboqXlC5VpswYGiA/Ei3UTD+kax8qw4asP/4wMsVEh+
         G3gihrXoeOEvI55i06nXQhEJBzuMaw72orvkuQIUwLgC6YF7OPd3wxbluhYTfpLsMM0I
         04lRlS0JNSq7dP5nxSjdguPUXE7gDthYMsPBrFcAPLnGYk7ELsP1EX7CPYlSvQJO7nfu
         DBG1WeIt4FEkgZaUBixwtcRimh86UMGRiAXIfkZQOPeZJq50hGYuJvFE79XLswtU3uxC
         KP8nMONE3M5N2Euml/tKsYcH1owqOfsIjFrvKscDWG+FfE8xx+LO/kfC6nlMWykmEff9
         rGLw==
X-Gm-Message-State: AOJu0YxbpjDQ6FtYWVPeLY0ytCOrM7Mx9KSFkQE7kqVkYE1LeUFVzDto
        veg8FmldGoGjOPC3ap4Lj1sVKuHBSF19IWlkO7v6Eg==
X-Google-Smtp-Source: AGHT+IGqBTcsw26+laBvJf/I/isoneVHzrJJ9T+K2yk5azRK+zEfUSmcs/ggygm50ClDleB1KaELGwFCQfMOnw2KkGM=
X-Received: by 2002:a2e:9dd1:0:b0:2bc:e808:e735 with SMTP id
 x17-20020a2e9dd1000000b002bce808e735mr525680ljj.21.1694542180860; Tue, 12 Sep
 2023 11:09:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Sep 2023 11:09:40 -0700
MIME-Version: 1.0
In-Reply-To: <20230912071205.11502-1-david@ixit.cz>
References: <20230912071205.11502-1-david@ixit.cz>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 12 Sep 2023 11:09:40 -0700
Message-ID: <CAE-0n50rUnwqPqDmskdaUOYc8qUPYpNoJxwsfShgsc9ha6XuGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sdm845: Fix PSCI power domain names
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Heidelberg (2023-09-12 00:12:03)
> The original commit hasn't been updated according to
> refactoring done in sdm845.dtsi.
>
> Fixes: a1ade6cac5a2 ("arm64: dts: qcom: sdm845: Switch PSCI cpu idle states from PC to OSI")
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
