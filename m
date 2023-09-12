Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869BC79D86B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbjILSKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbjILSKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:10:02 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554EE10DF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:09:58 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bf5bf33bcdso94594751fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694542196; x=1695146996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dg8t1qNOygPjgVWOVmAOAVxTu9CV1SLXUDuzKulmlZ8=;
        b=g04Zn725kKnx6ijHQ2pqJrNdhj24mcxkfkUSLwHufKyMk5LrYcaCvt4Njm8cmxjIqm
         RMmOQ8k5cKld9QnE8ebU5yfEpcWbXuO/jK5cBdv+Q5U/D3KSt5wnGH/wJTrpUCNfre4T
         S0nEk8WE1LV3obXJX9RQX1pT+F3t8q/cYBYPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694542196; x=1695146996;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dg8t1qNOygPjgVWOVmAOAVxTu9CV1SLXUDuzKulmlZ8=;
        b=veNqe9HucdU7vST019VYTIVfK/N2xk+wqjQjE6cp32v6AfUFONFstQ2nkOIR3py/26
         tKoDmBz9h+UUDkq2u2efsEWbqyEfuRyv0/sE7zzGVhEx705tp02zZd8vncyDutDcwd63
         cTJqcaW8gFd1PIh7P1uDaImw34UFnz9HA89LmnSUB876d4JEsg2Nyi1TDHlgCYHChIFw
         A5K4w7js4jmgBuQI/OAwlWQgR8OJ9vtmXQfHfrE1zEVq3p6xspKGd98tZ1vH61QiChvc
         TvjzdRYZunGQfFQGLnzFFm7WFvT/09Q6J8y+55/Qd5lW60FYv36yA3bEpVocGSut4B/S
         JUPw==
X-Gm-Message-State: AOJu0YzVadZWG1vgp+qlVIPD0OC/XHTNWnxBOq8S0XlX5P+4PcxxbLlT
        IRssIsnUpr9BJSt0Fen0cHTNmBvr2oqAQ/qkLOTmmw==
X-Google-Smtp-Source: AGHT+IF5s1Sk52Jj/p24BYqlhxt1dINxnjzQCcRFvRwclkBdJ2aJiEMXWL43KS2+2sGN6IVZfPDwHXcngx3Y+ApIX7o=
X-Received: by 2002:a2e:9e8d:0:b0:2bc:d33e:ccc5 with SMTP id
 f13-20020a2e9e8d000000b002bcd33eccc5mr381772ljk.41.1694542196552; Tue, 12 Sep
 2023 11:09:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Sep 2023 11:09:56 -0700
MIME-Version: 1.0
In-Reply-To: <20230912071205.11502-2-david@ixit.cz>
References: <20230912071205.11502-1-david@ixit.cz> <20230912071205.11502-2-david@ixit.cz>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 12 Sep 2023 11:09:56 -0700
Message-ID: <CAE-0n52myAYysd0iOH__pvU9Cfxy2bfzjmfybJyMyfEiWWR4ag@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sdm845: cheza doesn't support
 LMh node
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Heidelberg (2023-09-12 00:12:04)
> Cheza firmware doesn't allow controlling LMh from the operating system.
>
> Fixes: 36c6581214c4 ("arm64: dts: qcom: sdm845: Add support for LMh node")
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
