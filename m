Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27367DBC58
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjJ3PEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjJ3PE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:04:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5A9C9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:04:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so7753243a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698678262; x=1699283062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JvOfGIGza1mBeWZawbJIooxVS12He6qAo7rs6m+IoM=;
        b=P1VwQQ9teZJ4If4eD4+ngSHL6cfghvmFy85TV1tGlIFsrpdnwQdLwW5Lsub5pdCqnu
         gTBC09Oq0UFJgXDIFjovAulPnaKdFWe3s2wab82OpW7UtZ23JRX1bnNvvD4JYHP13yzD
         ZLsHlYHYMXv2iZC/jML+JYQAm+AiYDIx1gHsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698678262; x=1699283062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JvOfGIGza1mBeWZawbJIooxVS12He6qAo7rs6m+IoM=;
        b=H42CE6ElNrpo+OqMIWLGR7TLtEhhWS2LMFtJqzPQs29gio+outZIDe6CPuho9dgeWE
         9bVW7speLyDQ/KsKbuirLH+4XV4AO959nSE/XxvrP/RejkIsaqr7vaWWR8h7y5WXVb6O
         18d0VK6pqa0nN9o1CvyCNP0gNDqRcYCKhLmaZIu79jMm9bbGf23tb5AX/q1kYns8Sx5M
         tCZrQAo9OE+7NYMC+JtWvcXBtKc/8xIoSSsO9WG4Sab3Z78QIBl50/nSw+aChuUtTRtC
         U9ir17idlEN21G0T8ECYpEU7mkq1hyjjqc/CInZ6I0HdeKjZdtpHWyxgK3ezZUr9JPqx
         0r7w==
X-Gm-Message-State: AOJu0YwtkG0OveXzczqVUkq2m48l5XTxCCnSjYiHcvpxWWaohBX4rgJP
        jFriQvAflu2tjozpAuDhFA73dQZMBC+gs/Yiuql7uRHS
X-Google-Smtp-Source: AGHT+IHCrIA0f1haaZbn0XndEw+DUr5SPfskSQL9FtqIwIWI1vWvW53UYVY3fa96Dk9PYy5hrzTYaw==
X-Received: by 2002:aa7:c158:0:b0:53f:2128:ff4f with SMTP id r24-20020aa7c158000000b0053f2128ff4fmr8334333edp.17.1698678262192;
        Mon, 30 Oct 2023 08:04:22 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id m28-20020a50999c000000b0053ed70ebd7csm6379156edb.31.2023.10.30.08.04.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 08:04:21 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so102495e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:04:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc5:b0:408:3e63:f457 with SMTP id
 o5-20020a05600c4fc500b004083e63f457mr144533wmq.2.1698678254490; Mon, 30 Oct
 2023 08:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
 <20231027-sc7280-remoteprocs-v1-7-05ce95d9315a@fairphone.com>
 <7934a36a-9438-719a-2ed0-4a78757b044b@quicinc.com> <CWLNP6QNUXN1.SNVACF2IEGI8@fairphone.com>
 <CAD=FV=U6mi0h0MBFMC+ba4oq-te6_+WR6fj1XjAq7tmUu64bUA@mail.gmail.com> <CWLUQWPZNAS5.3F4Y5W13OD08M@fairphone.com>
In-Reply-To: <CWLUQWPZNAS5.3F4Y5W13OD08M@fairphone.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 30 Oct 2023 08:03:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XbwbjFgMjq-y_L-9EO+xfxwGo6RYV8Wh6P5oBR=oDf_g@mail.gmail.com>
Message-ID: <CAD=FV=XbwbjFgMjq-y_L-9EO+xfxwGo6RYV8Wh6P5oBR=oDf_g@mail.gmail.com>
Subject: Re: [PATCH 7/9] arm64: dts: qcom: sc7280: Add CDSP node
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 30, 2023 at 7:43=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.co=
m> wrote:
>
> On Mon Oct 30, 2023 at 3:11 PM CET, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Oct 30, 2023 at 2:12=E2=80=AFAM Luca Weiss <luca.weiss@fairphon=
e.com> wrote:
> > >
> > > On Mon Oct 30, 2023 at 10:04 AM CET, Mukesh Ojha wrote:
> > > >
> > > >
> > > > On 10/27/2023 7:50 PM, Luca Weiss wrote:
> > > > > Add the node for the ADSP found on the SC7280 SoC, using standard
> > > > > Qualcomm firmware.
> > > > >
> > > > > The memory region for sc7280-chrome-common.dtsi is taken from msm=
-5.4
> > > > > yupik.dtsi since the other areas also seem to match that file the=
re,
> > > > > though I cannot be sure there.
> > > > >
> > > > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > > > ---
> > > > >   arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |   5 +
> > > > >   arch/arm64/boot/dts/qcom/sc7280.dtsi               | 138 ++++++=
+++++++++++++++
> > > > >   2 files changed, 143 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b=
/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > > > > index eb55616e0892..6e5a9d4c1fda 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > > > > +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > > > > @@ -29,6 +29,11 @@ adsp_mem: memory@86700000 {
> > > > >                     no-map;
> > > > >             };
> > > > >
> > > > > +           cdsp_mem: memory@88f00000 {
> > > > > +                   reg =3D <0x0 0x88f00000 0x0 0x1e00000>;
> > > > > +                   no-map;
> > > > > +           };
> > > > > +
> > > >
> > > > Just a question, why to do it here, if chrome does not use this ?
> > >
> > > Other memory regions in sc7280.dtsi also get referenced but not actua=
lly
> > > defined in that file, like mpss_mem and wpss_mem. Alternatively we ca=
n
> > > also try and solve this differently, but then we should probably also
> > > adjust mpss and wpss to be consistent.
> > >
> > > Apart from either declaring cdsp_mem in sc7280.dtsi or
> > > "/delete-property/ memory-region;" for CDSP I don't really have bette=
r
> > > ideas though.
> > >
> > > I also imagine these ChromeOS devices will want to enable cdsp at som=
e
> > > point but I don't know any plans there.
> >
> > Given that "remoteproc_cdsp" has status "disabled" in the dtsi, it
> > feels like the dtsi shouldn't be reserving memory. I guess maybe
> > memory regions can't be status "disabled"?
>
> Hi Doug,
>
> That's how it works in really any qcom dtsi though. I think in most/all
> cases normally the reserved-memory is already declared in the SoC dtsi
> file and also used with the memory-region property.
>
> I wouldn't be against adjusting sc7280.dtsi to match the way it's done
> in the other dtsi files though, so to have all the required labels
> already defined in the dtsi so it doesn't rely on these labels being
> defined in the device dts.
>
> In other words, currently if you include sc7280.dtsi and try to build,
> you first have to define the labels mpss_mem and wpss_mem (after this
> patch series also cdsp_mem and adsp_mem) for it to build.
>
> I'm quite neutral either way, let me know :)

I haven't done a ton of thinking about this, so if I'm spouting
gibberish then feel free to ignore me. :-P It just feels weird that
when all the "dtsi" files are combined and you look at what you end up
on a sc7280 Chrome board that you'll be reserving 32MB of memory for a
device that's set (in the same device tree) to be "disabled", right?
...the 32MB is completely wasted, I think. If we wanted to enable the
CDSP we'd have to modify the device tree anyway, so it seems like that
same modification would set the CDSP to "okay" and also reserve the
memory...

In that vein, it seems like maybe you could move the "cdsp_mem" to the
SoC .dsti file with a status of "disabled". . I guess we don't do that
elsewhere, but maybe we should be? As far as I can tell without
testing it (just looking at fdt_scan_reserved_mem()) this should
work...

-Doug
