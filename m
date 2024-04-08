Return-Path: <linux-kernel+bounces-134870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7345989B812
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B798EB226F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3DF224D1;
	Mon,  8 Apr 2024 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="0uDQ1s6b"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D51CD38
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712559728; cv=none; b=M8DTHPfzzOFe3I5S6G6a29b5Mw7rSJrWGxLbAZvEZAtoB+L/q1ED+Il/H8e6FTiQn/ESuhhaHh2fHXtVr1hVPFBT+qJ+mPs9ULBi/c/en+wgc6cpN/zq7swSKvIfTmBN3ZD8+EEgze4Letynba3w4XEqBc+nwNBXxL90iBU2CgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712559728; c=relaxed/simple;
	bh=+J3hXyNpUJmooVXir9znvQFZPVRcR4aW/rauvt6w34U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KsKOHGZEUzZym7dvhri7ssrSjHMjsuZT/dUzDbgogSuD+smu1hzv3m8WKP1iZKlg/Yvb7DwqQAneKoRDvSPdd9sGZMN+CerZ6yRe8SSyDCe+zFVGz+JplmvLPFOK/iPjE4AupbVB+gAbeUuFkp/CGjf+YA3sXAcBxSilimOsHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=0uDQ1s6b; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51a20a6041so308824966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1712559723; x=1713164523; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=offh16ke5+BtPn8lxdjzqkvHVyx4akkldH1viry0sBk=;
        b=0uDQ1s6bAlCt3EwH+WhXaX2W8xvEGRwUA0M/gspvsa4fCoN7s4v3cu8sOVYULAntZw
         x3V2vImDwgzlO2tpc2AtYmqUsmKcKIi63Gy4jG0ep25c8Diyuq1ASikkO4ipFcXJh3G2
         msHR4Ohi4ZPGsw7n8MSp46OxrEik94QytSUzZ2mySO+v1muOxWiyoGqm6LZ/32SQPHZv
         RRWff9CNC+s8bNkH3Yep4AWGOstyx/fVQUvKVA7iOqCY6CbFDzrWXeIJk1CvjHZTTHUn
         h8uajPR0gxjVsG58BCCl2r6h4zPskgI6VVGLtmd5xkPTluhodX1a11bSsxILmbzz27D+
         5XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712559723; x=1713164523;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=offh16ke5+BtPn8lxdjzqkvHVyx4akkldH1viry0sBk=;
        b=t1VD03Pja8X5V3HYIKw4ios8qq7LuG7MMt4x7mTGSMqigdMnatukwzdG/hMgViFA4o
         58AmiFUF0/dWR7gb4spDKj+E34FPjKHXDXTP2/g2wFNRwOQQAGs7/1Xl03lS9GMhZDFV
         r45Zp/MW6WJCzPgTTTZxV57htrkFRny4XWfQIFqs7P4XzhAi7L79aP2oGH6xPaKGgi9y
         6S1kPD7FGaRf/myDyTvQj0FU0eln8Jts2MH9LrxzlEjEoa0fP57pK56l6jgWIReFdnTl
         uALmsBZvzxTSY1Tpm3TjlteLx5lippQuUa/x/nhHzEqvfTbuRhsNs17695SgT1BydsbS
         Q+pg==
X-Forwarded-Encrypted: i=1; AJvYcCVgL8ECkcOs3pY8VP5O9sj9t9PUKiEYkp7Mqe+rZsxdDEiXdlyqxxLRrRHFTbqkKamL5+y/tpv8JCRM1CNlEnt/touTmjmsqnioVWoK
X-Gm-Message-State: AOJu0YyE7dEwVb+3taBSD3CxFD2cLjE/GAlFhPMYI15OLRj/qE5ekvbq
	pw05Qby+WeZY2cA5YtaBLL9l+1+anH1Btd4Vj5XNYoS48b40xUeuqt5il8i9CVg=
X-Google-Smtp-Source: AGHT+IGx9XWjPlhTGwhQaw4YbPMUv+UviHwS/hf5jfRvCaR11azYOCmvOEGSZXxsXF/fHOKZQMqw2A==
X-Received: by 2002:a17:907:6d0e:b0:a51:cdef:f7a7 with SMTP id sa14-20020a1709076d0e00b00a51cdeff7a7mr2608583ejc.54.1712559722617;
        Mon, 08 Apr 2024 00:02:02 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id og9-20020a1709071dc900b00a4ea067f6f8sm4055003ejc.161.2024.04.08.00.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 00:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Apr 2024 09:02:01 +0200
Message-Id: <D0EJR77G6HF0.2LUJ3XY1YFG65@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] arm64: dts: qcom: add USB-C orientation GPIOs
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konrad.dybcio@linaro.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240408-hdk-orientation-gpios-v1-0-8064ba43e52a@linaro.org>
In-Reply-To: <20240408-hdk-orientation-gpios-v1-0-8064ba43e52a@linaro.org>

On Mon Apr 8, 2024 at 4:33 AM CEST, Dmitry Baryshkov wrote:
> Populate orientation GPIOs for some of the PMIC-GLINK-based devices.
> This leaves only FairPhone5, RB3Gen2, SC8180X Primus and SC8280XP CRD
> without the orientation GPIOs declared.

Hi Dmitry,

How would I find this GPIO on the schematics, or downstream devicetree?
I scanned over some relevant areas but nothing jumped out at me except
for the USB_PHY_PS signal coming from PM7250B CC_OUT and going into
GPIO_140 of the QCM6490 - but I'm guessing this is something else?

Regards
Luca

>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Dmitry Baryshkov (4):
>       arm64: dts: qcom: sm8350-hdk: add USB-C orientation GPIO
>       arm64: dts: qcom: sm8450-hdk: add USB-C orientation GPIO
>       arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add USB-C orientat=
ion GPIOs
>       arm64: dts: qcom: sc8180x-lenovo-flex-5g: add USB-C orientation GPI=
Os
>
>  arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts        | 2 ++
>  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 ++
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts                    | 1 +
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts                    | 1 +
>  4 files changed, 6 insertions(+)
> ---
> base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
> change-id: 20240408-hdk-orientation-gpios-141bc7fd247d
>
> Best regards,


