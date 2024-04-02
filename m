Return-Path: <linux-kernel+bounces-127618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B917894E71
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001041F23D6D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9643D5732B;
	Tue,  2 Apr 2024 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/Q5z29g"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08956766
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049391; cv=none; b=dw8eTBUhxoSuaw9UPe29qKM/gaL25NRWV7KUpoTI2svDlBUp1SqMqfuyfjRMrwuaF5cl42ImoN+P2pEpNI7beGZcZa7/JGYr2NB8/3245OxR1rxdhT+5JJdBxLw6M0TifpwGvyLEcZ2qRlVdkY9bOfT6NO0KBkKz8lYIJ8ovZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049391; c=relaxed/simple;
	bh=DDyRnVQamRLCS1cqxXCcAOjLkMQNdJEtWVNZoAZwsLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVvP4GxD2mBa4AIJ30aGzYiuUKyVd0hHbiqtqdwG6WM08HyFfjC/NHizrNnyb9BrBPDf0A4dtu43wdFTa5ZuhIruIXs0hXNl+u2K86TdIgc9jt3Xf6uJg00vX1NZ+n1olCy5RY3fuBxef+d5m1ED7lUjL9NDVarWv4dv0+UBSQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n/Q5z29g; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbed179f0faso3827406276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712049389; x=1712654189; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RW/J19q+6ozr61crHNrzeNGIrOeeWwrel26k4kB36RQ=;
        b=n/Q5z29grrHiTX/+/Vy2sZATEoeuW/iP+nYNuP2lb1OfejyW9tAIlc1FRLGJPJBgg5
         ldAV6KKQoF9db4W9Aqq4+xyVrCNDGP0+5wzSvVnCIabsJUTOsfByj7/uyOAKyyUA18YZ
         CaoOQ1aTRt2OaY4tvXYrB4ldtLARp7bwu6XAudiAAaBDnB9Qt6eFUbEsVTcv+uP8Uvx1
         /6frUPezwO5btJLmLJy3yjwsRQGoQBFq4kLi/zPqXOiPUfjO7s5gaS79UBOuywFOurOF
         WoRjVh4nW7GOaePwKGKAvDUegTTg7I1QW4mocM4HTD05F+W+nlkaPBUslWcDTLPpFECg
         UOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712049389; x=1712654189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RW/J19q+6ozr61crHNrzeNGIrOeeWwrel26k4kB36RQ=;
        b=qC0YOlZyHtH3QAMSvm588hhbNavUq/9hmG2KomkhJjCxMi2rA4rFzQVbE5Daz8qee8
         BL95aUMzJe3TTnxy9JGUAsZ8+Y14lsbWilSz1ZQgCF2FiRZGt6OidTxAUBFmhC/Rc59l
         Fq6/lTajejJGReg6mxqF028dgihGKcSjq80P1a2bhVnRRTQijCK6Wk0HfYrs5ycVwCfU
         jzsJEB0BgcWy890r8N+RAOR/F+6P6WMG5/hh+RToBQZ+dAPz588tRwkiT4lNjcLtifEM
         d/oev75HyQZhb6+btaXSVIWuZi3k85Fc5Wc954GFqHNT59N5Jqyi6xHrqktCg6v7z0Jq
         la2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrBXC47k0NtSbtb/yhx2g1mM/TALlbwpdUVrXdGBfjGRZJyL8KwrF9Hbw2efZOPwsffKIZB35hcGUHMRFkEsn+dM01NlYSPad2T7Ad
X-Gm-Message-State: AOJu0YycYIcNJ+Ly2MvcRtOD8TfHJSCFTYnlboiuo73Tbw66ITd02QSl
	jFmJFzhCO/M05aCfIizhq1eDRkW7M9Q+afmeovKm1Ctppc9fnrtz/qOFQyrO5ZshdH+txVkXWZZ
	YX6ttooqiHs42p/VUQmDmuN+Za5gXMKxChyp4wQ==
X-Google-Smtp-Source: AGHT+IHitKHl0fp/VoZIqlnhJ/6GKmAuCC/3Z9L5xNfnbpdu2K3wh+2/nvTH+t0RG3v6M8mSP+y913kZutQQyrQm8aw=
X-Received: by 2002:a25:bf82:0:b0:dc6:d1a9:d858 with SMTP id
 l2-20020a25bf82000000b00dc6d1a9d858mr7727682ybk.8.1712049389443; Tue, 02 Apr
 2024 02:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402090349.30172-1-quic_kbajaj@quicinc.com> <20240402090349.30172-2-quic_kbajaj@quicinc.com>
In-Reply-To: <20240402090349.30172-2-quic_kbajaj@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 12:16:18 +0300
Message-ID: <CAA8EJprnuh6Ep5-CmcfrbSQH3SzS8Jb-CtDiJg-J1HHuxrLYZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: qcm6490-idp: Enable various remoteprocs
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_tsoni@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 12:04, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Enable the ADSP, CDSP, MPSS and WPSS that are found on the SoC.
>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

