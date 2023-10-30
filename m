Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C3B7DBC00
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjJ3Ono (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjJ3Onm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:43:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414F2DB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:43:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so7746767a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1698677019; x=1699281819; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nwo0UYDV4o06Mzw9WU2DYO+XxHpuorjy7eMshi09Lk=;
        b=2OESjA41F9aeEf4pRwy2E815bTZti3+39VGllMtCc00lpc549g4Kom0Y10M4gYNSHE
         ZNNQO+cBqrmBAAY5Muk0aP3CieqiTm15yOXfQWi2heAHGoBiLLhaPDvzJJpF8/8J1pq9
         IfwnXst+MYR7Yw4pKDevoffkybX6f88HiXfMSuxsd3Rvf5HjC8bpCJndcpPBGRpkJeVQ
         yZKXZ2q9x43/LRasiJs110sx0Qrjh0aDNioGGiImAIaCZDH9P5Z48uGmCUZ4X+ZggN/w
         wgGvEdKoZqiFKrh2doJi92eCWe+84dJHd0h4AUXuxgF6AXYG6n6714VYUiyszgdVIhF5
         LU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698677019; x=1699281819;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4nwo0UYDV4o06Mzw9WU2DYO+XxHpuorjy7eMshi09Lk=;
        b=uFa68hL3WpmMceXgPaDVrSeC/X5EkLxo7zA2rW4iXzhJ8JkrUvhBvkt/8CmvWkvZY2
         wifio1rXuOUD6kelI5YgKEud69dlz0/HcqqmZMk+K+CfFnLKnEkALaQKdDZpRhiOaxUV
         h26jpH2NE0BeyU7VKLFDIHSGmYURzubg6CV6fn+YpugKjXQXqFw5YgaiRZvouYtX246X
         22FZo4le+Uu3pzhEFu/BeCob24MeJIt4sKphJ/5ArZeTYr7fIU/+PEVAYYPqo81zV5fb
         up7qIWplKFd/2YlD+3Ij6tzQuGwj1kbwCH3Drde8EzgxnGx0W2cSE/F8CPEyU6SqdCxY
         qziA==
X-Gm-Message-State: AOJu0YxHkl6qhg4fDcncYt/uaNB6hzrch3FESsyZM9NyluVKPp8/rtJc
        lZ8tZCCBjcZKZED25UkYrxBhMg==
X-Google-Smtp-Source: AGHT+IFyhSMzoVuE7IRbjjhWsmhUnwHwbqzbPgJdBWIPhNuv82ntn1Jnq5yfajDSWdfDcVkYhUZKCA==
X-Received: by 2002:a17:906:38e:b0:9d3:8d1e:cee with SMTP id b14-20020a170906038e00b009d38d1e0ceemr2667017eja.70.1698677018573;
        Mon, 30 Oct 2023 07:43:38 -0700 (PDT)
Received: from localhost (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id n11-20020a170906b30b00b00989828a42e8sm6035976ejz.154.2023.10.30.07.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:43:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 30 Oct 2023 15:43:37 +0100
Message-Id: <CWLUQWPZNAS5.3F4Y5W13OD08M@fairphone.com>
Cc:     "Mukesh Ojha" <quic_mojha@quicinc.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
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
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/9] arm64: dts: qcom: sc7280: Add CDSP node
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Doug Anderson" <dianders@chromium.org>
X-Mailer: aerc 0.15.2
References: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
 <20231027-sc7280-remoteprocs-v1-7-05ce95d9315a@fairphone.com>
 <7934a36a-9438-719a-2ed0-4a78757b044b@quicinc.com>
 <CWLNP6QNUXN1.SNVACF2IEGI8@fairphone.com>
 <CAD=FV=U6mi0h0MBFMC+ba4oq-te6_+WR6fj1XjAq7tmUu64bUA@mail.gmail.com>
In-Reply-To: <CAD=FV=U6mi0h0MBFMC+ba4oq-te6_+WR6fj1XjAq7tmUu64bUA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 30, 2023 at 3:11 PM CET, Doug Anderson wrote:
> Hi,
>
> On Mon, Oct 30, 2023 at 2:12=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.=
com> wrote:
> >
> > On Mon Oct 30, 2023 at 10:04 AM CET, Mukesh Ojha wrote:
> > >
> > >
> > > On 10/27/2023 7:50 PM, Luca Weiss wrote:
> > > > Add the node for the ADSP found on the SC7280 SoC, using standard
> > > > Qualcomm firmware.
> > > >
> > > > The memory region for sc7280-chrome-common.dtsi is taken from msm-5=
.4
> > > > yupik.dtsi since the other areas also seem to match that file there=
,
> > > > though I cannot be sure there.
> > > >
> > > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > > ---
> > > >   arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |   5 +
> > > >   arch/arm64/boot/dts/qcom/sc7280.dtsi               | 138 ++++++++=
+++++++++++++
> > > >   2 files changed, 143 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/a=
rch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > > > index eb55616e0892..6e5a9d4c1fda 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > > > @@ -29,6 +29,11 @@ adsp_mem: memory@86700000 {
> > > >                     no-map;
> > > >             };
> > > >
> > > > +           cdsp_mem: memory@88f00000 {
> > > > +                   reg =3D <0x0 0x88f00000 0x0 0x1e00000>;
> > > > +                   no-map;
> > > > +           };
> > > > +
> > >
> > > Just a question, why to do it here, if chrome does not use this ?
> >
> > Other memory regions in sc7280.dtsi also get referenced but not actuall=
y
> > defined in that file, like mpss_mem and wpss_mem. Alternatively we can
> > also try and solve this differently, but then we should probably also
> > adjust mpss and wpss to be consistent.
> >
> > Apart from either declaring cdsp_mem in sc7280.dtsi or
> > "/delete-property/ memory-region;" for CDSP I don't really have better
> > ideas though.
> >
> > I also imagine these ChromeOS devices will want to enable cdsp at some
> > point but I don't know any plans there.
>
> Given that "remoteproc_cdsp" has status "disabled" in the dtsi, it
> feels like the dtsi shouldn't be reserving memory. I guess maybe
> memory regions can't be status "disabled"?

Hi Doug,

That's how it works in really any qcom dtsi though. I think in most/all
cases normally the reserved-memory is already declared in the SoC dtsi
file and also used with the memory-region property.

I wouldn't be against adjusting sc7280.dtsi to match the way it's done
in the other dtsi files though, so to have all the required labels
already defined in the dtsi so it doesn't rely on these labels being
defined in the device dts.

In other words, currently if you include sc7280.dtsi and try to build,
you first have to define the labels mpss_mem and wpss_mem (after this
patch series also cdsp_mem and adsp_mem) for it to build.

I'm quite neutral either way, let me know :)

Regards
Luca

>
> -Doug

