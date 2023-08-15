Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB1A77D54C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbjHOVj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbjHOVjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:39:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF76F26AF;
        Tue, 15 Aug 2023 14:38:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26b0b92e190so3682962a91.1;
        Tue, 15 Aug 2023 14:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692135471; x=1692740271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/jXW3AspyW8+b9C62Np7yUFKq+iseXeXa75HJbIw/k8=;
        b=FZ7moBdw67NvDYBO6MxohU2L3a7W36RNcji+IthrLTirHHDbdm93JNd6qzzVZgaEP5
         vz065HpkLYdE2yA/+kQFQj5Im3Mm2DdTNQk9PA90TrmS7Yfx0MCMdCVWiqw1Hie3U1nV
         cJOWaSSqotA6uWNeW1Pj2nJhj6BHuQX57T7ctQQol/thNJ6gnChODGo5Cn/fr6dFEQQW
         umIQ416wxdJ96SPU44ADHQNKP7turGkX4kFE/zmvv39Wnb9QSqtttWhEe7Wfsc8VGIg8
         7ff1xKaldQixTBbUkrt6p+1AoLKX8a+i+nbBpeWHsdl05mDWRelaZ4c8UkRAJmJUW2QX
         QKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692135471; x=1692740271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jXW3AspyW8+b9C62Np7yUFKq+iseXeXa75HJbIw/k8=;
        b=Onog9RYSRX5AyAYc+KXPYgEruCqKvMWraGp5yWg3DcgqOkucp7ZI5PMHoPHlJ+clCH
         NyDMcnNLdeb1ukkRVNBXynH5igZ7xCoWA+Hp/Cgq7V3CK8C0SMKq1402GULqhqJAW4rZ
         mwPh8x27RDrD/Dcsuoj7DoYCX0sdGeXgiX+pQfUEda5huUG0cZhX3ZJZcXg+cODVLcd+
         zYrWXMwt68B10DxGZTMbBptPr2HMzrvZPMs8MQ2aCzjxiIt1bGBArYYrqEHVUxLIUCC5
         BJ/jpAu3voIOSDlqaCxfulLL7En0GKr5t7GLJXANzZtTqQuYYd8jnE9chSqM1Qdl6cUn
         jD/w==
X-Gm-Message-State: AOJu0YyquylYK7z9cWVk6TWIOyhi2YWB9gHF7y25liil/XbkVmTIgzP+
        EHNmVi9/MymCrGr7bPv842C9plks0/82Dq+p560=
X-Google-Smtp-Source: AGHT+IHRWjimmB3BALvmQjkO5uWB6G5lBUkAmjCqMP4gW/lV0PToXoKDIxPMgei9WHvEnUhE9ypexUv/yhG/uGTtqm4=
X-Received: by 2002:a17:90a:e50f:b0:26b:6532:95a3 with SMTP id
 t15-20020a17090ae50f00b0026b653295a3mr3867009pjy.6.1692135471246; Tue, 15 Aug
 2023 14:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230815141908.1084893-1-robimarko@gmail.com> <20230815141908.1084893-2-robimarko@gmail.com>
 <3174c398-a19a-3b59-c2fc-3ec9a5e1a9df@linaro.org> <CAOX2RU6HYBzhh0TBdsFj5AJPwqdv2xQ=XsA=L-BaCwNUxTx2Vg@mail.gmail.com>
 <aa699c29-6e63-cbf6-b6ee-1fad76478036@kernel.org>
In-Reply-To: <aa699c29-6e63-cbf6-b6ee-1fad76478036@kernel.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 15 Aug 2023 23:37:40 +0200
Message-ID: <CAOX2RU67W0KuLMy7+oAgbGHwSqvg3PW7JS1e+VoqtjPvu-X0pg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5018: add WDT
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_saipraka@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 at 23:33, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 15/08/2023 17:38, Robert Marko wrote:
> > On Tue, 15 Aug 2023 at 16:40, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 15/08/2023 16:17, Robert Marko wrote:
> >>> Add the required DT node for WDT operation.
> >>>
> >>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 7 +++++++
> >>>  1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> >>> index 3285c86824cf..168322bfb11c 100644
> >>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> >>> @@ -182,6 +182,13 @@ v2m1: v2m@1000 {
> >>>                       };
> >>>               };
> >>>
> >>> +             watchdog: watchdog@b017000 {
> >>> +                     compatible = "qcom,apss-wdt-ipq5018", "qcom,kpss-wdt";
> >>> +                     interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
> >>
> >> I think all GIC_SPI interrupts are level high.
> >
> > They are most probably using GIC-500 which supports rising edge or
> > active high interrupts.
> > Both the older GIC-400 and newer GIC-600 also support the same.
> >
> > Vendor DTS indicates this level, IPQ8074 and IPQ6018 which use the
> > same core, and it
> > seems the same WDT IP use the rising edge IRQ.
> >
>
> That's ok, but now I see missing Cc to DT, so standard message goes:
>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>
> You missed at least DT list (maybe more), so this won't be tested by
> automated tooling. Performing review on untested code might be a waste
> of time, thus I will skip this patch entirely till you follow the
> process allowing the patch to be tested.
>
> Please kindly resend and include all necessary To/Cc entries.

Indeed it looks like I managed to miss the DT mailing list somehow, everybody
else was added.
Apologies for it, will resend it in the morning.

Regards,
Robert

>
> Best regards,
> Krzysztof
>
