Return-Path: <linux-kernel+bounces-16504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E95823F74
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6432872B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5655420DD6;
	Thu,  4 Jan 2024 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="diyYpS6f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E7E1D52C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5e7c1012a42so3486577b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 02:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704364269; x=1704969069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCNFeNKXOeCzIlUtEMdOZEsjRxjcm1Bo281rfBm6FiA=;
        b=diyYpS6fqZS18QiYj9nlfzGyT8Z1oUF7L94pj+VaWabXE0Iac0N2z37LpTWMx+BjY1
         HdcYhJBjDgYWuj6zoxTubEmBWDlgfetIGvnNM4oxqB/sqdHEUwpE2jNhETkgpfB6DIE+
         D8zFDYpnZMSk7MyKEHn/Xeh2l2RwBDLm7aXg8VDhEES56Wp4mBpYQ0TSzZNJ7FQiz7CZ
         +KdkoW5Ip0rkDNq3ThMTKr2zuEWCDCAIBn9mH6ZQ3EjWR2UmgVTkZd0jpoin/O8MXe8V
         B8lu5N85lXafhA+vNRaZOAVXC0VMLNWBBFoVYUn4y0YEDEM1Vqy1qzeL5rE6DDFW1K4d
         GOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704364269; x=1704969069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCNFeNKXOeCzIlUtEMdOZEsjRxjcm1Bo281rfBm6FiA=;
        b=xEw19s+2314yAHhGKo4lhR/6RX5SPOWKIEUBntHsBUUpXZ9+3/OHR2mDhKq74I4or0
         zm63xGe7++XBBH1t/ybUA+QFQyfAZssFUwwLkhf/TgGSAayYk1sTGBpEGg/xc86h6Pzo
         wQoOTDJLFe6Ap4X4G5wA92I9oRH1JJu39nAl8+TBoj86tuIObfkMkvaJPKnkPeqR7WX4
         YLvHXNTc9mJvvwjp7R/oMSFhazA730K2dDkRldzbxImmWgruOOwP5qxrJ4rQR3xxy8jN
         lmr1e0gh6sxfiuQOALKkLoFIvkBc/NYuRwvnLNfgOY5QZQt3dK966I+NXocbYDho4W/s
         +wCg==
X-Gm-Message-State: AOJu0Yz0HPe8BEjKpRM9VrqiB86Tp0g4yASKn1tSmOnUaoVYIZluwDRx
	c7lzGn5O+sfLDb9oeCNdQbB0YgVnuSZyqEgVpK5ZNIxqsq3xrg==
X-Google-Smtp-Source: AGHT+IHtpqenJGKeLrTGRodwG7tnpzNoDf6V4ZvXzs6wlWaf+XUFFDP5Zbx1bxkgQwJQ6ow5LfTQ/zzrQMMtEIer3SE=
X-Received: by 2002:a0d:e9c2:0:b0:5e4:acfc:4d0e with SMTP id
 s185-20020a0de9c2000000b005e4acfc4d0emr417065ywe.2.1704364269013; Thu, 04 Jan
 2024 02:31:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104-gcc-docs-update-v1-1-127e4816b798@quicinc.com>
 <CAA8EJprsGke9zZBy_x=YSxz7R1aSpx8r3ndjjXVVKhjKBxd=QQ@mail.gmail.com>
 <724f608a-cbfe-48f6-a1f7-59b961a7d724@quicinc.com> <56ee556d-ec31-4553-bce3-0c1e12c111ed@linaro.org>
 <ce5b0ae5-e61a-40a3-8a83-278b56274aba@quicinc.com>
In-Reply-To: <ce5b0ae5-e61a-40a3-8a83-278b56274aba@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 4 Jan 2024 12:30:57 +0200
Message-ID: <CAA8EJprAy4cjLw9jBPQ4Oh+g8d5aGmFx1pWaYv_kzF7xTsvGKA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: add #power-domain-cells for
 gcc node
To: Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, quic_tdas@quicinc.com, 
	quic_aiquny@quicinc.com, kernel@quicinc.com, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jan 2024 at 12:27, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
>
>
>
> On 1/4/2024 6:16 PM, Konrad Dybcio wrote:
> > On 4.01.2024 11:13, Fenglin Wu wrote:
> >>
> >>
> >> On 1/4/2024 5:53 PM, Dmitry Baryshkov wrote:
> >>> On Thu, 4 Jan 2024 at 10:06, Fenglin Wu via B4 Relay
> >>> <devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
> >>>>
> >>>> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> >>>>
> >>>> Property '#power-domain-cells' is required as per defined in qcom,gc=
c.yaml
> >>>> so add it for ipq6018 gcc device node to eliminate following warning=
 in
> >>>> dtbs_check:
> >>>>
> >>>> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: gcc@1800000:
> >>>>           '#power-domain-cells' is a required property
> >>>> from schema $id: http://devicetree.org/schemas/clock/qcom,gcc-ipq601=
8.yaml#
> >>>
> >>> But ipq6018 doesn't implement GDSC support. So for the sake of fixing
> >>> the warning you are adding a bogus property.
> >>>
> >> I agree. However, there are also some gcc drivers not implementing GDS=
C support but the bindings are adding '#power-domain-cells' in the DT examp=
le, such as: qcom,gcc-apq8064.yaml, qcom,gcc-ipq4019.yaml, qcom,gcc-ipq6018=
.yaml, qcom,gcc-ipq8064.yaml, qcom,gcc-msm8660.yaml.
> >>
> >> Actually I thought that maybe we should do a clean up by removing '#po=
wer-domain-cells' out of the qcom,gcc.yaml binding and only adding it into =
individual qcom,gcc-xxx.yaml for the driver which has implemented GDSC supp=
ort. I checked this with Taniya offline, but she prefers only fixing it in =
ipq6018.dtsi as it doesn't hurt anything by adding the property, and she ex=
pects the GDSC support should be existing in most of qcom,gcc drivers espec=
ially the newer Qcom chipsets.
> >
> > Before we start changing anything, we should assess whether these
> > platforms actually have GDSCs within this clock controller block,
> > even if they are (currently) not described in the clk driver.
> >
> I would assume '#power-domain-cells' is only required for drivers which
> register GDSC as power-domain device, for drivers that only configure
> GDSC during probe or for platforms have GDSC but not register them as
> power-domain device, making '#power-domain-cells' as a required property
> doesn't help anything but just generating more dtbs check warnings.

If there is a hardware GDSC, it should be registered in software
unless there is a good reason to do otherwise.


--=20
With best wishes
Dmitry

