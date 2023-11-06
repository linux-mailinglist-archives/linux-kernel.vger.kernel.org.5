Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617DC7E2F6B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjKFWGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjKFWGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:06:31 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E24D47
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:06:28 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507c78d258fso6537885e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 14:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699308386; x=1699913186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikwQ0BwJZ8jOJp5MM/eEVIEKe9pDDvdQBjT/UpPI1+k=;
        b=h30A2x7cXn7ERrJGIavCF4xkDbZFfil1zcILyQ+EAut62T0GAPmWnzl54Dkp5VJnVO
         rqv5YeWpZd08CnGJJX0tqIEAG6F66t0oy/xLipeR6ZE4V+pXjHdluwSpRZwd67JE2POh
         70nJbyhudL08Gg+k7Zq68HjlWqills0kFQhFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308386; x=1699913186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikwQ0BwJZ8jOJp5MM/eEVIEKe9pDDvdQBjT/UpPI1+k=;
        b=VSsu0YCyh4wOnC8zns9mOprtrFKLYU64Y9D3KLK4EZ49aXXNLioZUeWL8WpAQ8NFYG
         Rw18JDmS9UFw9hoMcsCVd+x1e7i5cEYGP3g3APgITnyGQHNziGs4CZVSgLvb7W4mt0an
         Y25R9PzU63xiM+b+PQUhhL51GsZ3v8u2ItyyoHhgOAuXYQa/F5Li8+rVNDS0oy7ffVa6
         imNZ7SuVr4cW/MlMTIDAQsYkWUwZ66Z0m7L5GMarXKGY8Ygw1+bz+4YrY2p7aubxKIu8
         3GJUE0jP1xnpwxg2zTJV06MgVfYfWErEOW+Btwff74MyLTcIISlxH1bnT8sAEl1ZKkSz
         IZ5A==
X-Gm-Message-State: AOJu0Yx9QPUq7i1nm4Yq4x/BeBwPne1bZo5YLYnEfV1OFD74ODmGQWbu
        EXpcAqeKCFHbg4LyfV+OBsqrDiw0Z7wa98s8yMRbzWT/
X-Google-Smtp-Source: AGHT+IFjHvOinovxuCDhrm95iJBuGgqi1Smsh5yoGr8cO8mNYCfQ7nYbJUz4mOfHhFn8GqfjrPw98Q==
X-Received: by 2002:ac2:4c3c:0:b0:504:3a3d:5015 with SMTP id u28-20020ac24c3c000000b005043a3d5015mr22629150lfq.27.1699308386112;
        Mon, 06 Nov 2023 14:06:26 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id u10-20020ac248aa000000b004fe1f1c0ee4sm106917lfg.82.2023.11.06.14.06.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 14:06:26 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso393e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 14:06:25 -0800 (PST)
X-Received: by 2002:a50:aac7:0:b0:544:466b:3b20 with SMTP id
 r7-20020a50aac7000000b00544466b3b20mr10200edc.5.1699307921610; Mon, 06 Nov
 2023 13:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20231103105440.23904-1-quic_anshar@quicinc.com>
 <feca8e74-6653-4cec-943d-47302431e1fc@linaro.org> <CAD=FV=VTCXSQo3Bo3G7oJ48qA-fUet5rHAzT8WLM1Hx70KyYMA@mail.gmail.com>
 <a3f3c391-370a-4ed2-92ed-afcfbea829e8@linaro.org>
In-Reply-To: <a3f3c391-370a-4ed2-92ed-afcfbea829e8@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Nov 2023 13:58:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VojU57uDUi3uByNKKBQnUhTXP6f=kK1C9E_Mgih2aMCA@mail.gmail.com>
Message-ID: <CAD=FV=VojU57uDUi3uByNKKBQnUhTXP6f=kK1C9E_Mgih2aMCA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Add capacity and DPC properties
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Ankit Sharma <quic_anshar@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ashayj@quicinc.com,
        quic_atulpant@quicinc.com, quic_rgottimu@quicinc.com,
        quic_shashim@quicinc.com, quic_pkondeti@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 6, 2023 at 1:52=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro.=
org> wrote:
>
>
>
> On 11/6/23 17:56, Doug Anderson wrote:
> > Hi,
> >
> > On Sat, Nov 4, 2023 at 4:52=E2=80=AFAM Konrad Dybcio <konrad.dybcio@lin=
aro.org> wrote:
> >>
> >>
> >>
> >> On 11/3/23 11:54, Ankit Sharma wrote:
> >>> The "capacity-dmips-mhz" and "dynamic-power-coefficient" are
> >>> used to build Energy Model which in turn is used by EAS to take
> >>> placement decisions. So add it to SC7280 soc.
> >>>
> >>> Signed-off-by: Ankit Sharma <quic_anshar@quicinc.com>
> >>> ---Hi, thanks for this patch
> >>
> >> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>
> >> I performed a quick grep in arch/arm64/boot/dts/qcom and noticed
> >> that at least one of these values is missing for:
> >>
> >> rg -l --files-without-match dynamic-power-coeff $(rg cpu@ -l) | sort
> >> ipq5018.dtsi (homogeneous cluster)
> >> ipq5332.dtsi (homogeneous cluster)
> >> ipq6018.dtsi (homogeneous cluster)
> >> ipq8074.dtsi (homogeneous cluster)
> >> ipq9574.dtsi (homogeneous cluster)
> >> msm8916.dtsi (homogeneous cluster)
> >> msm8939.dtsi
> >> msm8953.dtsi
> >> msm8976.dtsi
> >> msm8994.dtsi
> >> msm8996.dtsi
> >> msm8998.dtsi
> >> qcs404.dtsi (homogeneous cluster)
> >> qdu1000.dtsi (homogeneous cluster)
> >> sa8775p.dtsi
> >> sc7280.dtsi
> >> sc8180x.dtsi
> >> sc8280xp.dtsi
> >> sdm630.dtsi
> >> sm4450.dtsi
> >> sm6125.dtsi
> >> sm6375.dtsi
> >> sm8350.dtsi
> >> sm8450.dtsi
> >>
> >> rg -l --files-without-match capacity-dmips $(rg cpu@ -l) | sort
> >> ipq5018.dtsi (homogeneous cluster)
> >> ipq5332.dtsi (homogeneous cluster)
> >> ipq6018.dtsi (homogeneous cluster)
> >> ipq8074.dtsi (homogeneous cluster)
> >> ipq9574.dtsi (homogeneous cluster)
> >> msm8916.dtsi (homogeneous cluster)
> >> msm8939.dtsi
> >> msm8994.dtsi
> >> qcs404.dtsi (homogeneous cluster)
> >> qdu1000.dtsi (homogeneous cluster)
> >> sa8775p.dtsi
> >> sc7280.dtsi
> >> sm4450.dtsi
> >> sm6375.dtsi
> >> sm8350.dtsi
> >> sm8450.dtsi
> >>
> >> Where platforms with a single, homogeneous cluster likely don't
> >> benefit from EAS..
> >>
> >> Is there any chance you could dig up the correct values, for at least
> >> some of these platforms? Or would you know whom to ask?
> >>
> >> FWIW the one we're missing the most is sc8280xp..
> >
> > FWIW, I wrote up a longwinded commit message when I added these values
> > for sc7180. See commit 82ea7d411d43 ("arm64: dts: qcom: sc7180: Base
> > dynamic CPU power coefficients in reality").
> >
> > The short of it is that if you have hardware and a basic "smart
> > battery" to measure power consumption it's pretty easy for anyone to
> > add some reasonable numbers.
> That's a big ask, especially with stupid laptop battmgr firmware that
> only refreshes data every 5 to 25 seconds :)

Meh, the script I wrote (which you can find by following the text of
the commit message or just looking here [1] should handle that OK.
While the script is ugly, I wrote it to handle pretty non-granular
measurements. Right now it's set to test each frequency for 2 minutes
(min_time_per_freq) but it wouldn't be hard to make that 10 minutes
per frequency.

[1] https://lore.kernel.org/all/CAD=3DFV=3DU1FP0e3_AVHpauUUZtD-5X3XCwh5aT9f=
H_8S_FFML2Uw@mail.gmail.com/


> Qcom probably has some reasonable numbers somewhere, given they are
> likely to test their SoCs' characteristics before taping them out
> en masse :P

Sure, if Qualcomm can give numbers that'd be wonderful. In the past
they haven't been willing to and I tried to convince them that was
silly because anyone with access to the hardware could measure this
themselves. If Qualcomm has become more reasonable about this then
that makes me happy.

-Doug
