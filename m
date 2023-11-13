Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136577E9C67
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjKMMub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjKMMu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:50:28 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004CAD79
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:50:23 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso6578698a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1699879822; x=1700484622; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N13JBdU904zFnf0HqevyoXQNJ3lJ+1zQrKvMl13vlHo=;
        b=JZ5lvL5wec3FzGpEvDNeRdBApoD8UYWPUxrMcU62T8whvibXTgLOTio3C/uGDXHXVX
         d+5E9FE1Ay8Kvxunu7jZtkCRHnnurlRSts8xJJZo5yskLtkQkAgiEEmyVWwqJYJwyG/M
         ZZ70AOAqSbqK26qlenjy0QaXGHdetMFL5fMFj/NR9FynL1aW+aKNEGZUUlmqHpG7cGkP
         rqtyX9A+QdH480LdQj0/aDbBlwZXAh3MWnqGOuVrStmr5pMFOHCjD3lQtyqP+I96Wy8E
         iLgnuGsl7AP4ksGKR2Gx7J9c9WPhPDv1UYJrWeD0EC4iYEGOThWCN2TgwLDcqCsM/hF/
         jvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699879822; x=1700484622;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N13JBdU904zFnf0HqevyoXQNJ3lJ+1zQrKvMl13vlHo=;
        b=kptsVZHSaFbYRpSymkmY5bbbZRRARWxZPyPD+85XTUHhp0WqKduVJcZ/S7WX9t5/UY
         FLdqxzwUMmzUT/2BOkYTNd2LuQpw2yoQvJGs6x9QNktQsabFFsxXiSw9neH6stkUrBei
         w1E2bucHEb6+fvPaAqj6PikR1mpxirt4fdN1p0qwjXpRHltg92rxcy3rfMGZIQ10RVs0
         eTQ66tCCeYuyij1CaeA6PiYISSoD2IG/Df7/kuPLdvvMug4NRFAOrCTxFiPl46X/2nA0
         g8RbH2c9n8qGMLyMtDvFQOjRJf5z8fuwyT3Zc2vWILQfNm9/uaUq6azq6AEUTS2GAbTc
         kUqA==
X-Gm-Message-State: AOJu0Yykq+ROe43k12uniy5wDn2Jz45dGKlgPCiHRQW0L6b6LBNCdDqu
        zmpn5VZHNCrkhcOEN6dU+FKIMg==
X-Google-Smtp-Source: AGHT+IFAHarCQT9X05gSVzLNnvdGW4iSoxHQZnNRwA8Psb/ROnfXippLqiuXAEGP4HAefaqXNIn0Qw==
X-Received: by 2002:a05:6402:1a45:b0:53e:1815:ed0f with SMTP id bf5-20020a0564021a4500b0053e1815ed0fmr4884047edb.31.1699879822427;
        Mon, 13 Nov 2023 04:50:22 -0800 (PST)
Received: from localhost (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id b30-20020a509f21000000b0053d9f427a6bsm3805358edf.71.2023.11.13.04.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 04:50:22 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 13 Nov 2023 13:50:21 +0100
Message-Id: <CWXP3TCW3A1G.2ME0JJT3S540G@fairphone.com>
Cc:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Rob Herring" <robh@kernel.org>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>
Subject: Re: [PATCH 9/9] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable
 WiFi
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Kalle Valo" <kvalo@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
X-Mailer: aerc 0.15.2
References: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
 <20231027-sc7280-remoteprocs-v1-9-05ce95d9315a@fairphone.com>
 <12ea48bd-5022-4820-815a-89ef23ec9385@linaro.org>
 <CWMK0AQRL87L.1F9MIDVQ4J439@fairphone.com>
 <CAA8EJpqCeW8NVcrpwo6JVn0kE2W-QMELB1YH7i7pgOH6qiPbCQ@mail.gmail.com>
 <87zfzhu9kx.fsf@kernel.org>
In-Reply-To: <87zfzhu9kx.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 13, 2023 at 1:22 PM CET, Kalle Valo wrote:
> (adding ath11k list)
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>
> > [Added Kalle to the CC list]
> >
> > On Tue, 31 Oct 2023 at 12:31, Luca Weiss <luca.weiss@fairphone.com> wro=
te:
> >>
> >> On Mon Oct 30, 2023 at 8:26 PM CET, Konrad Dybcio wrote:
> >> > On 27.10.2023 16:20, Luca Weiss wrote:
> >> > > Now that the WPSS remoteproc is enabled, enable wifi so we can use=
 it.
> >> > >
> >> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >> > > ---
> >> > >  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 4 ++++
> >> > >  1 file changed, 4 insertions(+)
> >> > >
> >> > > diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/=
arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> >> > > index d65eef30091b..e7e20f73cbe6 100644
> >> > > --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> >> > > +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> >> > > @@ -713,3 +713,7 @@ &venus {
> >> > >     firmware-name =3D "qcom/qcm6490/fairphone5/venus.mbn";
> >> > >     status =3D "okay";
> >> > >  };
> >> > > +
> >> > > +&wifi {
> >> > > +   status =3D "okay";
> >> > qcom,ath11k-calibration-variant?
> >>
> >> What value would I put there for my device? Based on existing usages
> >> (mostly for ath10k) I'd say "Fairphone_5"?
> >
> > I think this is fine.
>
> From style point of view I would prefer lower case and dashes, for
> example "fairphone-5" but I'm just nitpicking, uppercase and underscores
> work fine as well.

I really don't mind, but I used "Fairphone_5" in v2 now, but I can
change it for v3 if that happens if you wish.

>
> If you have different SKUs or similar which need different ath11k board
> files being more specific like "fairphone-5-eu" and "fairphone-5-us" is
> one option. But I'm sure Luca knows best what is needed for Fairphone,
> just throwing out ideas here.

As far as I am aware, there's only one hardware variant, so nothing
extra should be needed there. (We also only really sell in Europe, apart
from a small rollout in Taiwan and a trial in the US, but same HW there)

Regards
Luca

>
> >> And you mean I should add this property in dts before even looking int=
o
> >> the firmware/calibration side of it?
> >
> > From my experience some (most?) of the device manufacturers do the
> > wrong thing here. They do not program a sensible board_id, leaving it
> > as 0xff or some other semi-random value. The calibration variant is
> > the only way for the kernel to distinguish between such poor devices.
> >
> > The kernel will do a smart thing though. If the device-specific
> > calibration data is not present, it will try to fall back to the
> > generic data.
>
> You are correct, just to be specific it's ath11k which will choose which
> board file to use. I recommend always setting
> qcom,ath11k-calibration-variant in DTS if you can.
>
> Back in the day I have tried to push for the firmware team to improve
> the board file selection but no success. So the only practical solution
> we have is qcom,ath11k-calibration-variant in DTS.

