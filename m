Return-Path: <linux-kernel+bounces-73777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C56085CB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108B0284404
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0773C154431;
	Tue, 20 Feb 2024 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tB7ZgtGI"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E855787
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469140; cv=none; b=ecLuKsmvPEDzHowGRcPcaY1YY+R73hlAv3jl8NoBz7JEBQKnjdO9MeAhSsCFqkwAlS2QbIawK3/rSMkrwnfNsn0OD3sU04PS6HfbW5oQBpgJFi4UJOYFF4wvXVKIFarN7BSzl5DQaZ6m0KqmLHrMtsHwCJuzykjAKlyyopFNI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469140; c=relaxed/simple;
	bh=q9RdCg06m93tYC/ZEX+DeihLwlkQ7buG8kY7YIdjplc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewxghwn7PBCpqZ8zGiy/6Lu5AC/rivR1Aj1ah3dEwJV/ldfpdSSGWts14CvG+vZHLKjXT7aIKgIBRK1Bveo986it7DcbXP4Nazdua8r58jCzSLlsYHY7AIEqhfBEcAUfZ3/amAEU6FQPTJYh2b+7pRdBocZyClMiiCiyo1vhgag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tB7ZgtGI; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60879e3e3ccso3740987b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708469137; x=1709073937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wyzl5JN8+bRH8SoabXDVr5mKJJXqZjqJuY8CXRYywik=;
        b=tB7ZgtGIB5LC5+2joPFQSl5nZEYZ6UmpqFNgBWyX0nJ3p5yzwGJk5L8+SLBkKZAnGL
         yU8t9rR9mmrfB6+oR8QUx6S0s89h0pDuz/3QSnx2+KuajULXCmNXRwxFNheldIAfgvhA
         UTf0xR+nq2IFamm/f+ynvSW026SvpkBszhjWh7oPsQ/Cy3pByMKEgHrrJZnlu1/1nuLL
         JNi/+HYWVBwur1iaLRdcYIL6PP3S46/QwG8KEc+3pi/2vkd9KYiYh3WPDpDnu/lqBcB0
         GuSkhFSeRhkT6/JM6ICi2R2lF7s4rdG7QqyR7SlvkwjRz9fEd3kwtwanS0+9oBx+edAJ
         OKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469137; x=1709073937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyzl5JN8+bRH8SoabXDVr5mKJJXqZjqJuY8CXRYywik=;
        b=oWuLtPuYYvzfAb9ih46IRyIRNweh4BiL6Ql30BkJX/LLEJA7OoByu95Nul6tkcXZJv
         1htkpcNyNzhgDN+w4xmZHhsaaLz9Sa6Z/k3pdsORip0nDLb0m+2thvgAVR599b/HwWeB
         fxCYyFRjCJNVc4XjrldG4x6kIvRVTPGDYbHz1HtHWE0R6P5QbbMtBAbRKObJv0khVksr
         lG9TmgyApMUDtuNVoEqSGFqfTfY2UOvoAKJBYif/sgI1nwWJq7XjavzftQ4rnFU+x5LX
         /N222HC+5YMtE8wCwDfwrwRzVgCZhdnvcUWt6m9oo2ICoIAODwHIyRTwzBBftL5OCQoW
         W7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1e0D7gTakfgprQ8fXBeK9AMvrIN7VxU8pvf0ILrMxCh0RkMBKNv8ETY1WdX+OFnq/0W5643QmdUA11tHRUz7KIgFXp5OPf8vNMPHp
X-Gm-Message-State: AOJu0YylCJ6MVFLee2NOAHqmLPofbcumX4D/UKFYp/xuWWir/wh10q+c
	PFhpNbIA0Z9XmNaLH1hXrMRWNNV5N+NSyTBQgQMiIx/Hkol823S+1hYTLVTV5H2KUUvN1fLiuoI
	hcJOGPNf9kmMAPEaWv9128+OVTp6ed43A+USnQA==
X-Google-Smtp-Source: AGHT+IF+xIZ9uDKsFh6JgHxIqt3FqCkkcvbZBLqMVJBuLYitjFyRfjIa/li7CVOUGl10KAdra82TAbKJ4WHDuqP98HY=
X-Received: by 2002:a81:83ce:0:b0:603:fdc7:2f93 with SMTP id
 t197-20020a8183ce000000b00603fdc72f93mr17295904ywf.33.1708469136945; Tue, 20
 Feb 2024 14:45:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-phy-qualcomm-edp-x1e80100-v4-0-4e5018877bee@linaro.org> <20240221-phy-qualcomm-edp-x1e80100-v4-3-4e5018877bee@linaro.org>
In-Reply-To: <20240221-phy-qualcomm-edp-x1e80100-v4-3-4e5018877bee@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 21 Feb 2024 00:45:25 +0200
Message-ID: <CAA8EJpp7LKRG2yr70+1jWAM9YHm+anfmeWmAD4cjxLq9G2qPXA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] phy: qcom: edp: Add v6 specific ops and X1E80100
 platform support
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Johan Hovold <johan@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 00:05, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Add v6 HW support by implementing the version ops. Add the X1E80100
> compatible and match config as it is v6.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 180 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 180 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

