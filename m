Return-Path: <linux-kernel+bounces-1853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0F78154D4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A51C287128
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A4E15AF;
	Sat, 16 Dec 2023 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEiLw/Nn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB1199BF;
	Sat, 16 Dec 2023 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77f56750defso73757885a.1;
        Fri, 15 Dec 2023 16:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702685067; x=1703289867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0mzJ4H5MhZF/h5tZH9TyuGgDJrxXw5MvJ57wx7MoZ8=;
        b=fEiLw/Nn76IQ1MtJm95AKZt5fG9x+Hatsivc3gmkbp/d3CLNzSRHs+xEUNIoYj5zbn
         gIiqWtncITJpBJXfn+dRmvx0wCBdsPIExhj7WNWdeSQqZG4gsDUs4yaFssGaJcQKdD/K
         NyV3P3WgWznUcJe/WKaGcJU3ym8wMEtYmTBx6RtRuFIALm0Zrb6/ajZ10NNMCHqabSI9
         godEoySOX8E/qMIV2Tlmb2sEWAGuJDGEvcaJ4ju5gVBXbEUBnD41zuAWPpoR1TvpBzlE
         z7EQj6cwgjGDmpnVoGUMatwroBJoYlSmu0KGEAG7sshEX94HWuprlRqvqCpEz3aFX/A9
         3cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702685067; x=1703289867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0mzJ4H5MhZF/h5tZH9TyuGgDJrxXw5MvJ57wx7MoZ8=;
        b=K2sd7HbMgwFZ08GBMyF6ySeIMv+nF+vplA3S2eQsHZv/u2hDWS0FY7hDMR696AJY09
         0U/CasMJx9Fse2ncIWJtP/vQQnOaI8oYObHmurUzIqY2m2Sq5JD2qj3Q3/7WeT1S1+BD
         vdr8zoO7TfaVh8nOpvzQRYTqPglHlrcozh/8e5dJt6WR0ytcZj5c8o31xFSqfLd9iSwc
         BK5z1zHlKpj6h7nGIN9e/RcjudP5sJNRcwJUVqPGbeoLBEpXd23Y9cLrfKp9MsUiy72D
         yGB7oipEqn3nY/XVvC4+KfIq4+c42CaK5H+KEevdlh2qoaKoooiFWPMtUsaWdmH4+iO3
         OZLQ==
X-Gm-Message-State: AOJu0YzqXx7FLeqRTmfXzfxQYsgkwlISnfW5+WYlcqqjYn9fhB6wPVAk
	3UKCeaYvAGUH//FoIERnPb3l1fz7557D+g==
X-Google-Smtp-Source: AGHT+IHzigIoCiCTUdFDlC5KE8nXSbLVA4SsyD6SeigrpOAc1SVrwBrKrTXS9/FXlycKIpWCRyJGpg==
X-Received: by 2002:a05:620a:5311:b0:77f:25f5:36f2 with SMTP id oo17-20020a05620a531100b0077f25f536f2mr13495872qkn.143.1702685067562;
        Fri, 15 Dec 2023 16:04:27 -0800 (PST)
Received: from localhost ([2607:fea8:529e:7800::a768])
        by smtp.gmail.com with ESMTPSA id g9-20020a05620a40c900b00767b0c35c15sm4571579qko.91.2023.12.15.16.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:04:26 -0800 (PST)
Date: Fri, 15 Dec 2023 19:04:23 -0500
From: Richard Acayan <mailingradian@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm670: fix USB DP/DM HS PHY
 interrupts
Message-ID: <ZXzph8s_WF09VdtZ@radian>
References: <20231214074319.11023-1-johan+linaro@kernel.org>
 <20231214074319.11023-2-johan+linaro@kernel.org>
 <ZXuv8zgm4kl3fwZV@radian>
 <ZXwBj-EAZ1rE8erk@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXwBj-EAZ1rE8erk@hovoldconsulting.com>

On Fri, Dec 15, 2023 at 08:34:39AM +0100, Johan Hovold wrote:
> On Thu, Dec 14, 2023 at 08:46:27PM -0500, Richard Acayan wrote:
> > On Thu, Dec 14, 2023 at 08:43:17AM +0100, Johan Hovold wrote:
> > > The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
> > > controller in order to be able to wake the system up from low-power
> > > states and to be able to detect disconnect events, which requires
> > > triggering on falling edges.
> > >
> > > A recent commit updated the trigger type but failed to change the
> > > interrupt provider as required. This leads to the current Linux driver
> > > failing to probe instead of printing an error during suspend and USB
> > > wakeup not working as intended.
> > >
> > > Fixes: de3b3de30999 ("arm64: dts: qcom: sdm670: fix USB wakeup interrupt types")
> > > Fixes: 07c8ded6e373 ("arm64: dts: qcom: add sdm670 and pixel 3a device trees")
> > > Cc: stable@vger.kernel.org      # 6.2
> > > Cc: Richard Acayan <mailingradian@gmail.com>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > 
> > Tested-by: Richard Acayan <mailingradian@gmail.com>
> > 
> > On a Pixel 3a, plugging in a USB cable doesn't wake up the device
> > (presumably because there is no wakeup-source property) but this gets
> > USB working again on linux-next.
>
> Thanks for testing. And yes, the wakeup interrupts will indeed not be
> enabled at system suspend unless the wakeup-source property is there.
> Did you try adding it?

Just tested today. Adding it does not cause the system to wake up when
plugging in a laptop on the Pixel 3a, but that might just be because
USB wakeups are disabled when the adapter is configured for peripheral
mode.

drivers/usb/dwc3/dwc3-qcom.c (dwc3_qcom_suspend):
	/*
	 * The role is stable during suspend as role switching is done from a
	 * freezable workqueue.
	 */
	if (dwc3_qcom_is_host(qcom) && wakeup) {
		qcom->usb2_speed = dwc3_qcom_read_usb2_speed(qcom);
		dwc3_qcom_enable_interrupts(qcom);
	}

