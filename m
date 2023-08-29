Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474A778CFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbjH2W4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239904AbjH2Wzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:55:38 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D144CC4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:55:36 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d7820f9449bso4972486276.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693349735; x=1693954535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V5z5Ea0/s611VoAt5Pa4bFhJ/Bo9nHhqcd1Tv501Afg=;
        b=TIUELmKnHqL+LpemZHoZdaPLOW8T6G7lFHHiHdyJ8QjDh+fRDchb4/S8zkwMLxcuQo
         Oi7IEhmdk0xfHd36n1Tm3p/6/D+5un4muWcIMs76Ug37F6jYN2AHCSNmyguLEduJGnod
         aTGFLbU7cPcOtGALRxRBUO9jqZzHqDZXPMkJjtVg1dyDkn42dgF4OZ5SFlsJT6MwBBdg
         nSs4nwLBTyWWpbZeyUiaXpzfH22zqNydAugNQo1Suy9mwo2U3TXpIs/bC4d3Y6HuyMK+
         UUEsjzZYpqEI7ttsc1KgU0VcqDuUOLiXZKoIqMN+rPnPCnN5Mm4Pzr6qH5wsULXTDZrn
         6+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693349735; x=1693954535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5z5Ea0/s611VoAt5Pa4bFhJ/Bo9nHhqcd1Tv501Afg=;
        b=TinEwewKWaHQoUgh2pLb/zJClu4qQ4+RszelM+NhnJIWTsW9V+xSSDD9RlMxHEs7PC
         EroSyHFzQ4v+G8+Q6PLmMTzzWUE3fAR4dUbkhI7Zk9vHMd1Yg5s6lCMVSUlPpodJexN5
         /hVlKVhydTBsLk5MohlPSYd1lClBpadqdV1UXIMdIT3JCAVk2/CzTLcI5Dheb2WAkTfb
         0bE/KEtoaZQbT/CbcmLh6Xb3ZfqvIYDVdHnn8x2GqvpqepMlzOTFYYACVEjgrLdfiJIb
         AKITq9ECqQPQ2UGyQcvukSiZO99mA4B2Gp+YmLZrkofrv0y6n101W9md3w1kaFGsO/vT
         oUpQ==
X-Gm-Message-State: AOJu0Yz/56Zg6lDUsYhMaOJr1O300y+SisYlnyyJG0+27gQC3CElcGEO
        wZg0cMTdvQTrrPwN0tt6eRyfgWQLFT0A4XWVyqGatA==
X-Google-Smtp-Source: AGHT+IFt7/BCxH0GtWiSupqqehbMdutKrtDpqoa4v3TstBRoXA/a5IYrYad6OentD54Vy4/ADeok71pR5tfNhySZekg=
X-Received: by 2002:a25:258f:0:b0:d12:1094:2036 with SMTP id
 l137-20020a25258f000000b00d1210942036mr526110ybl.43.1693349735279; Tue, 29
 Aug 2023 15:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230829-topic-8550_usbphy-v1-0-599ddbfa094a@linaro.org> <20230829-topic-8550_usbphy-v1-1-599ddbfa094a@linaro.org>
In-Reply-To: <20230829-topic-8550_usbphy-v1-1-599ddbfa094a@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Aug 2023 01:55:24 +0300
Message-ID: <CAA8EJppHjejyKn6d2H34ofX6MYG+pFNnCCTaKrDO9=P8A-WrAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] phy: qcom-qmp-combo: Square out 8550 POWER_STATE_CONFIG1
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
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

On Tue, 29 Aug 2023 at 23:59, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> There are two instances of the POWER_STATE_CONFIG1 register: one in
> the PCS space and another one in PCS_USB.
>
> The downstream init sequence pokes the latter one while we've been poking
> the former one (and misnamed it as the latter one, impostor!). Fix that
> up to avoid UB.
>
> Fixes: 49742e9edab3 ("phy: qcom-qmp-combo: Add support for SM8550")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c      | 2 +-
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
