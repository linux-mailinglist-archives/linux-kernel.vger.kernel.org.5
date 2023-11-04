Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE667E0FBC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 14:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjKDNX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 09:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjKDNXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 09:23:55 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C4B194
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 06:23:51 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so2735765276.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699104230; x=1699709030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ihpTO3F03JzgacnLk5uBUsxe1t+WyOgXLtjj9fTyAZY=;
        b=c/cnOsccQ/fIrrcu/GNkooemVtQ1f2i7DGtv8dQQV+NN9/XTL0G5H7Z/byj7AtAGTg
         Nh5tNYpfeGxJl85qM9Ys5nybvZr7KA12IazlA2UDDOCvIVw/HMSskEQMDZXoQgy5JIUk
         A/R+AMFDzknrYWqSJF10Pk5FomwgdopsorBLidqxKi/puBx5zAD7wmGqJniXHBgq3Tvg
         XdoXng5jXbgwjWjd/0Uv7gHyXaRbTdhABSt6p/eyC2trhkHROlKBR4DydXN+YBdbBl+g
         tvei06BmxZslptmqnhc3kBqvNuQ9qnJsOdbBo+009iefbA2KhfmYXOhAI38niKyqnOnP
         MXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699104230; x=1699709030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihpTO3F03JzgacnLk5uBUsxe1t+WyOgXLtjj9fTyAZY=;
        b=Ib+QExubZsBT0+9R35w4PIMqbq4VXirO8ULSIqlqRqwNU9phiM1G44pGrAoajBYveB
         QM0QZvVHthkF+tm234K+S3/YL/xqyHDTilCAH+dp5R3X8+FJgDiaguI73sDZtZNOZjyY
         ca/2OsuW2HLBp2CAwDBmsqBiBQHOJERWdVM0vH+blZLOBaFQirmjBayPEk/z05I54/5x
         WkXCbaEhlpI9iGKTh5MnPg9hXz91h5ors/kKIlyEWfWgkeJUsiIIcob3phD7o5sGV/If
         pyqqjoTRJGWHe3IFL44CBALXvCDMcpC8QlofgoIceI5qZ2+d3PhOR2eobAuxYOEMpDVP
         UMqA==
X-Gm-Message-State: AOJu0Yy8/87L9WKyRjXzfuTGM/KvQtcp6pE3szExuuCq6JnzyRbcHWFU
        A8tGJfJv0Z++SVqjs7BrsiuoyHud2q7Xe/RXK+KATw==
X-Google-Smtp-Source: AGHT+IGVlWdeV8B/RVB/c5DH0WUIogCLxoudcchmyfPsPK9fAim8y9X901ML2K7hubgLTE5ct4OanZhXxd+HhodgcZg=
X-Received: by 2002:a25:dfc7:0:b0:d0f:846c:ef7b with SMTP id
 w190-20020a25dfc7000000b00d0f846cef7bmr21101785ybg.17.1699104230336; Sat, 04
 Nov 2023 06:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
 <20231027-sc7280-remoteprocs-v1-9-05ce95d9315a@fairphone.com>
 <12ea48bd-5022-4820-815a-89ef23ec9385@linaro.org> <CWMK0AQRL87L.1F9MIDVQ4J439@fairphone.com>
In-Reply-To: <CWMK0AQRL87L.1F9MIDVQ4J439@fairphone.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 4 Nov 2023 15:23:38 +0200
Message-ID: <CAA8EJpqCeW8NVcrpwo6JVn0kE2W-QMELB1YH7i7pgOH6qiPbCQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable WiFi
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

[Added Kalle to the CC list]

On Tue, 31 Oct 2023 at 12:31, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> On Mon Oct 30, 2023 at 8:26 PM CET, Konrad Dybcio wrote:
> > On 27.10.2023 16:20, Luca Weiss wrote:
> > > Now that the WPSS remoteproc is enabled, enable wifi so we can use it.
> > >
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > > index d65eef30091b..e7e20f73cbe6 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > > @@ -713,3 +713,7 @@ &venus {
> > >     firmware-name = "qcom/qcm6490/fairphone5/venus.mbn";
> > >     status = "okay";
> > >  };
> > > +
> > > +&wifi {
> > > +   status = "okay";
> > qcom,ath11k-calibration-variant?
>
> What value would I put there for my device? Based on existing usages
> (mostly for ath10k) I'd say "Fairphone_5"?

I think this is fine.

> And you mean I should add this property in dts before even looking into
> the firmware/calibration side of it?

From my experience some (most?) of the device manufacturers do the
wrong thing here. They do not program a sensible board_id, leaving it
as 0xff or some other semi-random value. The calibration variant is
the only way for the kernel to distinguish between such poor devices.

The kernel will do a smart thing though. If the device-specific
calibration data is not present, it will try to fall back to the
generic data.

-- 
With best wishes
Dmitry
