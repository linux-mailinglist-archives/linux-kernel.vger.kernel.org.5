Return-Path: <linux-kernel+bounces-146808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3359A8A6B46
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90051F21D13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8312BF1D;
	Tue, 16 Apr 2024 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OEEv3x+l"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF112BE8C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271158; cv=none; b=FKIoTV4Rk6dOZp8zUoZrphqvyLV/iMJohnNIAFzsUKNzTklYOraOygZA35ATT7dCBS9UQiYQaF9t1l+sRIpVEAkqcnKc9BhutX7Oz5vlu+Upf0OrOHsKriBppu5z9rUAl+OMhl3oLZz0+RX83UfG1uJP/oavO9K/94XxY4pr8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271158; c=relaxed/simple;
	bh=INkgGkw3lfof6ttOSzX5lzwufaDoB7uPeJ1nhpgVeBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kO/5hg6LLvmK5Vvo1MJqwhQGhs32gefMxAgGikaU+Go8VLq+eTp+CjGwB1w2D4FQv0DkmZntAtlenL9iiAERawVp64q+OaCKm85ihI+SJ6RogdQc0KhwzOvxafNG5kDPl7Y35Gd6KJyQIKy7RRmhHy5QprhjmNmfjS5tP1HyEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OEEv3x+l; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc71031680so4306594276.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713271156; x=1713875956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L5+AVlKX0UKLNpDnTXG4nLDmpjGwbimLrrB82xXakLA=;
        b=OEEv3x+lS4XGYlyWSp1K2umbJiSxK1HR5BAJqWRb7JWbFXnppyecl/uUENSFWXMFbq
         qLXMKHxWIhle0EEqFiC+cQCOR/X9NRJq8ly1QR11M34bmL2MyXLLDpkIHlQv+qdPQVAn
         F+tt/AVs/OsgJTdbkBGI865zapaZjRQkignR+Xql8iIhYqY5+d+yrpV2HKQIYE39r1ra
         kvTgR+QdZOZAAf+D2Ez8dvPKGXSV3NrqiPPOT8PXchYEWEF+deYJJNl6iov52XIVjTee
         GEghGjHAztoO8k1qhjzk5BJhxH1knZry+GUDSAqPGRS7f1bY3vVt7Wsyj1hFgp7O61CS
         xAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713271156; x=1713875956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5+AVlKX0UKLNpDnTXG4nLDmpjGwbimLrrB82xXakLA=;
        b=eEWauxSgtmU6/nA8gpr9KVv5B79AgM1Sms5QBY8z+Kp5XztfeIPBd9m7pbyXCWqe25
         pdgCCyKfgC/3skUoPEaPFgLuRkMhzB3djzhKyJyW0e7mtZX2iEWL/87oR80WvIe7LcqJ
         CqYXYgvuUf67I2sVtyM8YcYnk3zZl1I33GsP6lZshmVAbb5L1zUE2zJm2ixdf1TwYlOU
         tXPtMfnheYfbdh3P31SJZatvUX6Gdy4QWFYB9K3jjxYJdFaVw3+P16bpjE5wTGrywMnu
         XsRqgbrKk2IOHrIvmfxihikAd5FU5GWhReBEfg7o21t82P/pKuEjQKd3BkxItwKW/goG
         wMGg==
X-Forwarded-Encrypted: i=1; AJvYcCXcr/AbuLCzb5g7upIBMESdfzdIHQq6nJfeWrglajNL6XeMbNzwtMH8AMbCD/p6LiHkoW+x+oK3y0KAlWtKS+n3rxmssM4UvdCYPvni
X-Gm-Message-State: AOJu0YyqXt/N0cQS1L0la6tHIJi9/eaOJv5x+zb1ZaUS6aJgtbbI2OiN
	uq7wJmi0/IM1offpyeSy31HF0m+ST01X7/2YcWC8cA0DUJB3PW1dh6i46AmEpU1hvDE6n3yP96P
	kWAkVri4P8tCyEy+C6rQc5nGsmfYuGXx7v+DhfwH0tAUdlLEgi8s=
X-Google-Smtp-Source: AGHT+IEwQ0Ngh3qKjVVX87FYrtRCF4iosRKAkJdiG4FLgPF1wzvvHbh6c2T/y9yAEHN+DSCC8BOhOKXji/M+uyanmTc=
X-Received: by 2002:a25:dc92:0:b0:dc2:2041:fc49 with SMTP id
 y140-20020a25dc92000000b00dc22041fc49mr12430917ybe.5.1713271156421; Tue, 16
 Apr 2024 05:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416-pm8xxx-vibrator-new-design-v11-0-7b1c951e1515@quicinc.com>
 <20240416-pm8xxx-vibrator-new-design-v11-3-7b1c951e1515@quicinc.com>
In-Reply-To: <20240416-pm8xxx-vibrator-new-design-v11-3-7b1c951e1515@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Apr 2024 15:39:05 +0300
Message-ID: <CAA8EJpp9Td4ttqQN-hU72bEcRxMk0Wug92cTjvOKxfCaJb0Smw@mail.gmail.com>
Subject: Re: [PATCH v11 3/3] input: pm8xxx-vibrator: add new SPMI vibrator support
To: quic_fenglinw@quicinc.com
Cc: kernel@quicinc.com, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 05:44, Fenglin Wu via B4 Relay
<devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
>
> From: Fenglin Wu <quic_fenglinw@quicinc.com>
>
> Add support for a new SPMI vibrator module which is very similar
> to the vibrator module inside PM8916 but has a finer drive voltage
> step and different output voltage range, its drive level control
> is expanded across 2 registers. The vibrator module can be found
> in following Qualcomm PMICs: PMI632, PM7250B, PM7325B, PM7550BA.
>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  drivers/input/misc/pm8xxx-vibrator.c | 52 +++++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 9 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

