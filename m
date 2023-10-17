Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114A97CC41F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbjJQNNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbjJQNNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:13:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44A4F0;
        Tue, 17 Oct 2023 06:13:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so2994724b3a.3;
        Tue, 17 Oct 2023 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697548400; x=1698153200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1VFbOW0bkf/UWw2s6rY/Q247llB2LuJO9D6J6N3oJdY=;
        b=HXooVkYB96PuQScTFy4/bqPNSf7Isf9u9wz2xBv2R6qUh4SR2z1vlvH1pj/Q4fWLaQ
         EQM4tlOUL0QAfegAZNEpM9oTgKCKqIQq0vHbmIaCFzdGbROKWll7/pM0n/uhNoFtKYuC
         cPR9Rb44SePj7p4M2vMY5LIwf9mtIM3t5qJVngdE4vwPzkA+3ppr8P7+2SgwU+gywCfj
         80fd6vsziqnLXUp1eMJwsZmbO7zBdyzuRAA5iFPLd4UrkdqOWtYt4fnCH82ynwbFiIbq
         vlpQFg2jUXYEtfU8DZubOVKUUEawJNJGmXw5VG5FVDQwUPf7SjVQp9MlecRJ8Lh+NWxE
         /myA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548400; x=1698153200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VFbOW0bkf/UWw2s6rY/Q247llB2LuJO9D6J6N3oJdY=;
        b=wRjpqXvY/ynrEf8fOqD7x4cD86X6oTeyV9CstVfbuAQvACsjpcnofCKJqHKcBOsYr6
         fmcRQXW/1yyIu2HCyoVx8/98hMcODAEHl0wWlMzHjnlly/qtlM3UtLjeb5Qzwmfxm6Zx
         9Y9njLGDDzjtCsiu37f+Gy8KeTBpQGnqQiHzER4jwEu4xUhF8t1PxKAhk1dNW0W0pKil
         PNsttyyBNKoF6l4a3ZTo10PEM+SiBwZsLKzz3myDQ2xb5wPP6nqwwbUuChemvU3Jt8Pn
         Jhy3CEj9ferbB4dQW0uIqX0jHBW13/XabKLzhuNBSI3hXArqCfdasMtD/LxhAYg3IgG2
         /hWQ==
X-Gm-Message-State: AOJu0YzgAgcJppNh4cs8JxrX1SZvTkhydRNZoCav1+3uPUvlgEz0mpDh
        dX2YjsoWd+Se6H3aH1xNWEH3MIPLHDgYupHWTn4JeTe9CpQ=
X-Google-Smtp-Source: AGHT+IG5Yc5ThWREwvOq/jGDbzbg/WSLlwzaOaIkDoESWS+BvZoBeAcW6w7wJeifQnIns5uokCygBohaUcivs7RjOUk=
X-Received: by 2002:a05:6a21:114e:b0:16b:afc2:3b69 with SMTP id
 oi14-20020a056a21114e00b0016bafc23b69mr1815225pzb.36.1697548400152; Tue, 17
 Oct 2023 06:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
 <20230922115116.2748804-5-srichara@win-platform-upstream01.qualcomm.com>
 <1c6ecc92-89d3-3b7e-c2d0-e2fded9b446d@gmail.com> <f44b6e59-c26e-1026-49b7-e02ff02d7562@quicinc.com>
In-Reply-To: <f44b6e59-c26e-1026-49b7-e02ff02d7562@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 17 Oct 2023 15:13:09 +0200
Message-ID: <CAOX2RU6j75+8tFMTu=fVKY=mBkv8OaZJzWYUfnqkwfJY01QqYw@mail.gmail.com>
Subject: Re: [PATCH V3 4/4] arm64: dts: qcom: ipq5018: Add tsens node
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     Sricharan R <srichara@win-platform-upstream01.qualcomm.com>,
        krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@linaro.org
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

On Tue, 17 Oct 2023 at 15:07, Sricharan Ramabadhran
<quic_srichara@quicinc.com> wrote:
>
>
>
> On 10/5/2023 12:38 AM, Robert Marko wrote:
> >
> > On 22. 09. 2023. 13:51, Sricharan R wrote:
> >> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >>
> >> IPQ5018 has tsens V1.0 IP with 4 sensors.
> >> There is no RPM, so tsens has to be manually enabled. Adding the tsens
> >> and nvmem node and IPQ5018 has 4 thermal sensors (zones). With the
> >> critical temperature being 120'C and action is to reboot. Adding all
> >> the 4 zones here.
> >>
> >> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >> ---
> >>   [v3] Ordered the qfprom device node properties as per
> >>        Krzysztof's comments
> >>
> >>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
> >>   1 file changed, 169 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> >> b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> >> index 9f13d2dcdfd5..9e28b54ebcbd 100644
> >> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> >> @@ -93,6 +93,117 @@ soc: soc@0 {
> >>           #size-cells = <1>;
> >>           ranges = <0 0 0 0xffffffff>;
> >> +        qfprom: qfprom@a0000 {
> >> +            compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
> > Hi,
> >
> > "qcom,ipq5018-qfprom" needs to be documented in QFPROM bindings first.
>
>   Already posted here [1]. Initially had it in the same series, but kept
>   it separately based on review comments.
>
>   [1] https://www.spinics.net/lists/devicetree/msg633408.html

Well, if it's not part of the same series then this addition would
cause a warning as its
undocumented.

I also dont see where is it documented as part of the v2 series.

Regards,
Robert
>
> Regards,
>   Sricharan
