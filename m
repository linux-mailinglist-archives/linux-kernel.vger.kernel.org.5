Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7F2790886
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 17:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjIBPfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 11:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjIBPff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 11:35:35 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FCBCFE
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 08:35:30 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59254e181a2so255647b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693668930; x=1694273730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1+geAIG1XuG5AiKbVe19BQVk3qAdLZu0i5hOnOCVh/o=;
        b=vMg5aACrKZf5AUINOM17Y2t87X2BW1p9IP1O49PfKH5/Y07QHeJ9XideUTQQEYL01i
         nCRvet06oQ1ooeT3Xf9ndMuJnn4YQ0qhFKqHG25nHNW0NTrNiIxdtp2udWerc33BZFeG
         8eno0Ux9fbA3Tb7GrDcMV7XQpWOotPwl18cPeZnv1QozwEercfvGxYnDc6ZSs3JQ/MhS
         OtV6MCcTF5VpY4xsFiuyR6+PN7awYxrkxZHrZbLBiyQXEvJF9i1E3dh8lXztvzxvf24z
         x3ahNuPpSy5qxGioBgLGFSEeVRJZ1Qb/C3kTK+02kWIKoUtPJjSp1J5v96FeGsoiB0PF
         CEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693668930; x=1694273730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+geAIG1XuG5AiKbVe19BQVk3qAdLZu0i5hOnOCVh/o=;
        b=iqbuuHi4QOceh54bm96iguCJWnWeNfoumOmILG0wC9Awgo+WDzv4fVaELRse255l62
         /kFTMopmbwlNZPkTuVumgncrQAC+GGZ4sqybs4XhVWZmKSWHm3dP3BPgwxIf6ypdInxe
         neq/NEcxhfM80JXrd8hWLLGdUEIlR1OAKdaJkHKMig1m8aqljugbXSaj9w/Ej3RcfurA
         YyvGBIYIHZHm0AqISbWP8OUbm5MJ55me5LfGNuliWPQt0m4+Co2EnTloTOIXGZbecpDz
         FpsVIkj+Pxxgyj2Ij48di/Z1Z3SFkoQPu7RR8Z6s+g9E/e30OnbM9t0UBFRo2tlSDOiC
         FQtA==
X-Gm-Message-State: AOJu0YxItl4ovNgrytI6o7H1xdbAOGQYBjhKjMbGNR3Qc+ztIXAh83wo
        E+Q51t+p8CAxxokapGWNKp8im94XflhVfPRc/zBJSQ==
X-Google-Smtp-Source: AGHT+IFCHM4PXEBeb/JbCbMQ5PVbb8QowbaUMo5+2kpDljwFPCxh1UHz+cYvLpqoOxF5W9gJUHq8T417tHZxevfXc/I=
X-Received: by 2002:a25:cec9:0:b0:d7b:89c6:b316 with SMTP id
 x192-20020a25cec9000000b00d7b89c6b316mr5741326ybe.21.1693668929778; Sat, 02
 Sep 2023 08:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230901181041.1538999-1-robimarko@gmail.com> <28b7934f-f041-ad7b-d44a-3bed70aaf100@quicinc.com>
In-Reply-To: <28b7934f-f041-ad7b-d44a-3bed70aaf100@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 2 Sep 2023 18:35:18 +0300
Message-ID: <CAA8EJproMKoW=ue3dDCW88gkLyYqWQFvbmKdkoqXb3dVOL45dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ8174 family
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Sept 2023 at 17:43, Kathiravan T <quic_kathirav@quicinc.com> wrote:
>
>
> On 9/1/2023 11:40 PM, Robert Marko wrote:
> > IPQ8174 (Oak) family is part of the IPQ8074 family, but the ID-s for it
> > are missing so lets add them.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >   include/dt-bindings/arm/qcom,ids.h | 3 +++
> >   1 file changed, 3 insertions(+)
>
>
> Reviewed-by: Kathiravan T <quic_kathirav@quicinc.com>

Is there a chance of you using the full family name in your git tags?

> > diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
> > index be12e1dd1f38..d2b84a308fde 100644
> > --- a/include/dt-bindings/arm/qcom,ids.h
> > +++ b/include/dt-bindings/arm/qcom,ids.h
> > @@ -203,6 +203,9 @@
> >   #define QCOM_ID_SM6125                      394
> >   #define QCOM_ID_IPQ8070A            395
> >   #define QCOM_ID_IPQ8071A            396
> > +#define QCOM_ID_IPQ8172                      397
> > +#define QCOM_ID_IPQ8173                      398
> > +#define QCOM_ID_IPQ8174                      399
> >   #define QCOM_ID_IPQ6018                     402
> >   #define QCOM_ID_IPQ6028                     403
> >   #define QCOM_ID_SDM429W                     416



-- 
With best wishes
Dmitry
