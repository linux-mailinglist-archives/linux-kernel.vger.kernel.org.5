Return-Path: <linux-kernel+bounces-40420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B4E83DFD7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54932829F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B744320322;
	Fri, 26 Jan 2024 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wAEnCmob"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9ED1DDF4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289521; cv=none; b=Fjd9+TD9EKIgrOlUkqkQTG8Nh/mVBOVzBzLaipj88OkCijMBa8zOKBzVA56wKITxawsZ8WjLMPvt0yRm6UF916KJ8WkcDaDDjQmwQJSSzudpTjm5DL0Vaxl2p16nKr97qpap5gYwqQKph8GM/Rfpkup1Q3kEL8xsFu0DSK1kVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289521; c=relaxed/simple;
	bh=uksqWwHp40lBMgTvtcAqAgVU0xz7/hA8zQTrE9LBb6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvTEaDMbSNm080xgIXp+26Po/byplqFEb62ZZkkFsu7Vfka+yYI+iE1eEuBTEKOkhbdae9vE2COvhwXDzeSWvUBCYFkSP4Ucsh6atUO1l8UDzl2MXJRAlRQ/C+ehIIwVCCxon4Do7BtDgY0OpxnmhDc0V8guXqh6XP9Y8CrvY8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wAEnCmob; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc226bad48cso528053276.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289517; x=1706894317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oMXftuUEwR8k3wsTwAoi8oEqR+zracFM6FSyl83rIXo=;
        b=wAEnCmobgLm4WoVxDmAgrpHh9VonWIANbdjH8ZEtE1B7EQ54qvTjzlAhRhPMj6/LMP
         jsOnBfGOHmUERFB8IUri4k6sUjKjn0b6lhb+zP/gzT0m+laDxWtGYUvdO/oU/6T26AaV
         UR5/DP9BCDrkDibO2QgiQKGp8ggxI/K2ckvv987vgpar8CJK1FKRfNnoRNl27I+/gwqj
         xIxnpE7hPFYrvS2O+G+se81lUWbJM6tY+fkOqEpID9+wJh48QBdy6+PpqwQ75FQl8FjJ
         N6Ar80pEre8TOc1K6W1OP1fZ9oHzTLadQP5MQb+VN7rMEipxVf0fDUesZRYcg5kQ+a/+
         SR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289517; x=1706894317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMXftuUEwR8k3wsTwAoi8oEqR+zracFM6FSyl83rIXo=;
        b=kgbpSKU42hwzH7wsO9FFBaP/UEdjkrcufdFsqt6FIUX9X1G5Mg/LhNAMVP0EegdHDF
         kvbGD/qTQ7cdpJQs/Yj3GjIHNwCb9q4xdSed4SVRD+Y5radCLeng0HAk4NcwBy/sRBZ3
         U64E9dwM89krRb9Vm997xrh7/b5vQPwYopWfA7X4lFIDvg4Uea9lL5RlmTtGyMsE5o3j
         LJY803mZUptZO4b+gTWmpAfTUXtQDAuOYl5GWbrkyRU1HP8Uyw8rsbpYZ4OB4Jk0AYU0
         DXfZcDgfflVrXhOyctIu3VZG5pbPr25TE2YBuWupeiJCWzfVl2meSGrIpmiPEJDT2S+J
         4+pA==
X-Gm-Message-State: AOJu0YwG+BFsNHQGlNu2/9p77DDmMaelif4iU4Dk2DMq0/Usgg72jXXk
	5B6uXYz3+FkmGsfs/2if+DPY4UPAfFMyflgxfF0AgFc6N8fYkpik7BEWPGxMdp7evdU2XC869Q+
	F9oal3T1zuZJ+ZVS+jj29CXyIwSxHCS+TziQUdw==
X-Google-Smtp-Source: AGHT+IEAnlZn0o2ZmMFbEsv/yJHo5VHfIkXUWs60su9mjl4yma7GKw5ryBFdJHFs3IPbaBsWmFAx/KaCXzvEWbjrj3w=
X-Received: by 2002:a05:6902:514:b0:dbf:487b:1fe7 with SMTP id
 x20-20020a056902051400b00dbf487b1fe7mr174699ybs.17.1706289517052; Fri, 26 Jan
 2024 09:18:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120191904.15408-1-quic_kriskura@quicinc.com>
 <20240120191904.15408-2-quic_kriskura@quicinc.com> <wqdqkzvni4roqulgsiqxzubxcblzxnoydcwvv2av2pobjjx5o6@b7kwl6lq7hij>
 <a4606673-64e9-4e16-8d9e-307fb37d8763@quicinc.com>
In-Reply-To: <a4606673-64e9-4e16-8d9e-307fb37d8763@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 26 Jan 2024 19:18:25 +0200
Message-ID: <CAA8EJpoL=cWPJLaFZL-Sg2zW+as1ESPuQhQdzfJTGonXse9sPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: Fix hs_phy_irq for QUSB2 targets
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 16:14, Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
>
>
>
> On 1/25/2024 3:16 AM, Bjorn Andersson wrote:
> > On Sun, Jan 21, 2024 at 12:49:01AM +0530, Krishna Kurapati wrote:
> >> On several QUSB2 Targets, the hs_phy_irq mentioned is actually
> >> qusb2_phy interrupt specific to QUSB2 PHY's. Rename hs_phy_irq
> >> to qusb2_phy for such targets.
> >>
> >> In actuality, the hs_phy_irq is also present in these targets, but
> >> kept in for debug purposes in hw test environments. This is not
> >> triggered by default and its functionality is mutually exclusive
> >> to that of qusb2_phy interrupt.
> >>
> >> Add missing hs_phy_irq's, pwr_event irq's for QUSB2 PHY targets.
> >> Add missing ss_phy_irq on some targets which allows for remote
> >> wakeup to work on a Super Speed link.
> >>
> >> Also modify order of interrupts in accordance to bindings update.
> >> Since driver looks up for interrupts by name and not by index, it
> >> is safe to modify order of these interrupts in the DT.
> >>
> >> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 13 +++++++++++++
> >>   arch/arm64/boot/dts/qcom/ipq8074.dtsi | 14 ++++++++++++++
> >>   arch/arm64/boot/dts/qcom/msm8953.dtsi |  7 +++++--
> >>   arch/arm64/boot/dts/qcom/msm8996.dtsi |  8 ++++++--
> >>   arch/arm64/boot/dts/qcom/msm8998.dtsi |  7 +++++--
> >>   arch/arm64/boot/dts/qcom/sdm630.dtsi  | 17 +++++++++++++----
> >>   arch/arm64/boot/dts/qcom/sm6115.dtsi  |  9 +++++++--
> >>   arch/arm64/boot/dts/qcom/sm6125.dtsi  |  9 +++++++--
> >>   8 files changed, 70 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> >> index 5e1277fea725..ea70b57d1871 100644
> >> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> >> @@ -418,6 +418,12 @@ usb2: usb@70f8800 {
> >>                                        <&gcc GCC_USB1_MOCK_UTMI_CLK>;
> >>                      assigned-clock-rates = <133330000>,
> >>                                             <24000000>;
> >> +
> >> +                    interrupts-extended = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> >
> > interrupts-extended takes a reference to a interrupt-controller as well,
> > so this doesn't build.
> >
> > Did you mean "interrupts" here instead? Please update these and build
> > test...
> >
>
> Hi Bjorn,
>
>   Thanks for the catch. I was using DTC version 1.4.0.
> When I moved to 1.5.0, I did see these warnings. Fixed them up and sent v3.

Why do you use any special DTC version? Just use whatever comes with
the kernel. There is no need to use anything that is out-of-tree.

-- 
With best wishes
Dmitry

