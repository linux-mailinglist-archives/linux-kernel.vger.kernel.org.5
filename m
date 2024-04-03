Return-Path: <linux-kernel+bounces-130140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D9489748B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C501C27965
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4A514A620;
	Wed,  3 Apr 2024 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wh0JsEq+"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F45149DF5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159588; cv=none; b=IRXf0nofBYU/OTXDL0RH3RtpICmmGG9IaR01iJ0E2K4FrkPGeRF6ldYq2uzXGp4ZlL3cn5Nnv6EFEFFGfoPfzXBym+7ZaQupv6AWkht1vbwxIfqCOl3tO9rXzu8dgyifVVwBb8YBouZLUArfXuz6aKzuQiOApf5I377vfzQhg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159588; c=relaxed/simple;
	bh=ZDg0KQ0iWZU2ZGWemXowPBB9KN1D2XkPEqdi22YbXzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Il8WBDQdeLwozOHc47H/+Jbgq/F82kpKZCl1GjFtKKfTCe8atDWeC3HhspVktTLIxoSSGoAeDqwfMA5px4B4lA3VON4jXAPYL3WdmLlXOYLXUr+oVhx5Hrqu3Cb53eJKWmCSXTBKZ1as4b6f86K0WysLxVuX6kQFuzLUReMuuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wh0JsEq+; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so25140276.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712159586; x=1712764386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/yiMC5R+kTJY6W41EC/ZaB+VdKDo+c8x7WrU9W465mY=;
        b=Wh0JsEq+OFVG3C54nTcPrinCXF0Sl//GcG52gfP+W6HgPvQT9I69hgWDBhUHvGxPbC
         GZNxtqNVzN0ri3mao7TwkRleubRkao+3LFJcDplllvKSuIE9eItKcrwJeopNqEcilIX5
         K/6krrlLs0otfK5mhpig+Axg6N6wUlbUF9IK0OeWoeKSMmMD+ShpiDq5OvBBF1E6ZFzF
         CyfKR16CGqo/SHq78DgIAkI7r0uWHdPflviGHWGaeVFObT2mJNtePkgqX7VMIdSQa8Cx
         9x9avxB6ZEkrr84lhuZiDTJZBfH72QpGc3Lx3suHQ/AasaDiSeLu4STeIkRUyxFiJZFz
         TNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159586; x=1712764386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yiMC5R+kTJY6W41EC/ZaB+VdKDo+c8x7WrU9W465mY=;
        b=PfqOfi7hhP6VYXjjYgI4CJ3xW7fMvX8Yt35Y66NKVO0dB4d1RabkVizr6EGeog0qYg
         AWarD5U13bSWGAUKPWNUWhq8sZ7au/K0bQschZZbvkrGww0JzvRCZSq6lJCYRCMy2zmE
         97xB79p1a4f6NB5RRUCEit9VBPDJUtGqId6Vdrbb5i7QfJAGWj+tWVkGLkT5OGQJDgb9
         lctWwhXntM9BF+JVmAbK6m26iGgs7gI+MjpCN/+QYm5FkqDSKD13Io2qlC02jvL6XZpQ
         B0nFHw2DZDLoj7HrpiEX+pkWEB1CmeLZ7OZpQAHvtnhTBBTfUSKeUjFtDh6GfuFrghJy
         6/pw==
X-Forwarded-Encrypted: i=1; AJvYcCVY5n8QAHeZbczWf2RijPhcPYTHwwKE1iVSR3SJw/ZxnGS2AqnYKlxsBwRu+4bRFRohDJpmn5B4d9sJC6+iUMhIPNnphHtMXQ3vbAqa
X-Gm-Message-State: AOJu0Yx1l8AE5JP31tFGSUlF+0shGCNdl5OE/ZEsMY/La4GxcLsvLZXr
	oLmQgx3xaHnbjBQZSvHdTF76dMwCd/pXLqW2omPe1JNaPX8OwAEOolpY4RhEM6SNJUBQdJu/7IK
	KL96iD7Up1E2iiX1edIoaQsREEF6ihO26TNkvDg==
X-Google-Smtp-Source: AGHT+IFYYTj23BFPwhBEl3t/Qa3q2nRotj6Lz3gJyO4nsNuTMND7tLhJ6hpSru3fI59jMNl2QnjPzHz6m9ynV88kfR4=
X-Received: by 2002:a5b:6cd:0:b0:dcf:c7ef:e4e0 with SMTP id
 r13-20020a5b06cd000000b00dcfc7efe4e0mr2821320ybq.1.1712159585683; Wed, 03 Apr
 2024 08:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319091020.15137-1-quic_kbajaj@quicinc.com>
 <20240319091020.15137-3-quic_kbajaj@quicinc.com> <CAA8EJprXPvji8TgZu1idH7y4GtHtD4VmQABFBcRt-9BQaCberg@mail.gmail.com>
 <Zgs7Yau1/jYvys4i@hu-bjorande-lv.qualcomm.com> <5354493b-63de-43bb-9871-73918f123661@quicinc.com>
In-Reply-To: <5354493b-63de-43bb-9871-73918f123661@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Apr 2024 18:52:54 +0300
Message-ID: <CAA8EJppNZrLzT=vGS0NXnKJT_wL+bMB9jFhJ9K7b7FPgFQbcig@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qdu1000-idp: enable USB nodes
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Komal Bajaj <quic_kbajaj@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amrit Anand <quic_amrianan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 10:50, Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
>
>
>
> On 4/2/2024 4:25 AM, Bjorn Andersson wrote:
> > On Tue, Mar 19, 2024 at 11:52:15AM +0200, Dmitry Baryshkov wrote:
> >> On Tue, 19 Mar 2024 at 11:11, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
> >>>
> >>> Enable both USB controllers and associated hsphy and qmp phy
> >>> nodes on QDU1000 IDP. Add the usb type B port linked with the
> >>> DWC3 USB controller switched to OTG mode and tagged with
> >>> usb-role-switch.
> >>>
> >>> Co-developed-by: Amrit Anand <quic_amrianan@quicinc.com>
> >>> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
> >>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> >>> ---
> >>>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 65 ++++++++++++++++++++++++
> >>>   1 file changed, 65 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> >>> index 89b84fb0f70a..26442e707b5e 100644
> >>> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> >>> @@ -46,6 +46,33 @@ ppvar_sys: ppvar-sys-regulator {
> >>>                  regulator-boot-on;
> >>>          };
> >>>
> >>> +       usb_conn_gpio: usb-conn-gpio {
> >>> +               compatible = "gpio-usb-b-connector";
> >>
> >> If this board has only a USB-B connector, can it really handle USB 3.0?
> >>
> >
> > Here's a USB 3.0 Type-B cable, so no problem there:
> > https://en.wikipedia.org/wiki/USB_hardware#/media/File:USB_3.0_plug,_type_B_-_1709.jpg
> >
> >
> > @Komal, please confirm that this is the connector you have on the IDP?
> >
>
> Hi Bjorn,
>
>   Sorry for the confusion. The QDU1000 IDP has a Type-C connector. The
> type-c switch present between SoC and the connector is HD3SS3220 (from TI).
>
>   I think Dmitry's comment was that if it is 3.0, is it Type-C ? and if
> it is Type-C, then the compatible written in the being
> "gpio-usb-b-connector" would mean that there is a Type-B connector for
> someone who looks at the DT. (Dmitry, Please correct me if I understood
> the comment wrong).
>
>   I tried to push a series for adding a compatible to gpio conn driver
> [1] to resolve this and explained the connection specifics to Dmitry [2]
> and he suggested me to add a compatible for just the switch present on
> qdu1000 idp.
>
> Dmitry, Krzysztof,
>
> I was looking into the code again and it turns out there is a driver
> specific to HD3SS3220 switch [3] in linux already. I tried to check if
> it can be reused here but that driver relies on I2C communication
> between the SoC and the HD3SS3220 chip to get information on role
> switch. But in QDU1000 IDP board, there is no I2C communication present
> between SoC and the switch. Those lines have been cut off. The SoC only
> knows about VBUS/ID pins (other than DM/DP/SS Lanes) and no other I2C
> connections between the switch and the SoC. We still need to make use of
> vbus/id pins to decide which role we need to shift into. Can we still go
> ahead with using usb-conn-gpio driver by adding the compatible
> (qcom,qdu1000-hd3ss3220) and using it in DT ?

Is Qualcomm a manufacturer of the device? It is not.
Is qdu1000 a part of the device? It is not.

So the compatible string should be "ti,hd3ss3220". Which is fine to be
used in the platform driver. Just describe the differences in the
schema.


>
> Let me know your thoughts on this.
>
> [1]:
> https://lore.kernel.org/all/6f2df222-36d4-468e-99a7-9c48fae85aa9@quicinc.com/
>
> [2]:
> https://lore.kernel.org/all/6f2df222-36d4-468e-99a7-9c48fae85aa9@quicinc.com/
>
> [3]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/typec/hd3ss3220.c?h=v6.9-rc2
>
> Regards,
> Krishna,
>
>
>


-- 
With best wishes
Dmitry

