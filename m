Return-Path: <linux-kernel+bounces-45884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1C884378B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95861F24BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FC750A63;
	Wed, 31 Jan 2024 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skGgilxU"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403805577C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685430; cv=none; b=of1jKl1C1tignvj6sSBNIPQbdSzjyZla1D7xFEKrqo2QWeIQkha69VqNRcFGbaz7wXHMvI38d51YnyM0wPDJM3oMusaeaO75EFhqA7Vllq1i1nV1zXijzAaDaXpVgBqUXrdCGqf/aY8uozkboPAaE8DTBr+v9Kh67ToKyT+xL1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685430; c=relaxed/simple;
	bh=SBwf/LLGCzAHLu6vwrpQFfw+tJTtM2sMiItF7LdOdsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/jsk06gogrlS/oWcDrfHdC2iRgp32d+egPZUbkiK9spQOSEyjqZSVJRdiD03wTshXY+lGdUmkkI5qAyLP57Xp6iJPasl+/Q3vRWuxJXW5V6p/v6x4WkBtaxUq3y0TpDPL6chJa6jAcmVGja5XqsrsrUiad9E/IOCDQC78WGnBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=skGgilxU; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so5151904276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706685427; x=1707290227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i++Ghkf0yxbfp+SFq64kOAC5DCFdLn2FGQfA07BzBKg=;
        b=skGgilxUjyHfYPott6hjnYEwUcGIIw0iLZ79jmZDeoTwQ39TGuwMbYfSOSeR1xlylj
         KmPNLTPoxFsJwxfzStCQBl9x0+j+gA5Yvjo3wYuxEPKriaQgq2ByUszH4EPwE35vBKzY
         GaXKNuo/7a+G7t0FcS4oRg5A3f2GO1a/A9LAKud+MnfzVLc/FwUkfunju5D9hFFhavbq
         ZGICYfM7Yv7s2aPLbMBG9JNBR0wTf34KCtRDGW9T+8pXqVz9FcClOQNMF6FdVbKI3KpA
         qFQIIxUU3o45sNSE1RBBvB536zGlzscmCRlaNiu3jGFNQtxkpJSI73D0DaNVU2ivhgB3
         Np5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706685427; x=1707290227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i++Ghkf0yxbfp+SFq64kOAC5DCFdLn2FGQfA07BzBKg=;
        b=tMftEb/5dVhOvKpqg7tkTi9rZodbQjqJzOUCleWVQhHHZj2M2bxTVvFp6Dq7iqX1Zq
         EtwipLPQvBh4i8UyI9mUVBIofJOU+KMIee3fSot5fMKPBd0aRp2qluKrVrKv6d1SlthC
         y+Uw7AfV0uPWisIIWAANAIRHbMlde2fGlJoNw+XbEpEkcQeMB8ghs2zttl4dlsh7EzgX
         jWMYpLNT7Vj2d6so4K7pGtobTwSHaPIZr8mDZ4g2R3NCsXxiznDhiiBQjzIbre6zCJWx
         tsdJRZsl/Tc/hfZNNUqUmAiWhwyCztCYM4DbP/HZt+LJvqnHk170NdRpBx9Ywbi1Yp3t
         b2nA==
X-Gm-Message-State: AOJu0YyMx9o4GpC/QuYh/EBJ/xVlcsgzj5kqc7urlAuRluIHddhwbvmI
	LoVQDjyTBCBzihwpwN0r7oZDbn3NtUOBCS09GtQxr0QeNTYWTOWOk2dGV/IcP2nkeAe8N7VQREV
	FVBW67a/upw9Tk4+kY/Dny9THMjScDg7ENVEZuw==
X-Google-Smtp-Source: AGHT+IFTNzxcPE7P1aDSv5JKuBB1enENzJJokT41i2jNc0I+1qhMXhMXCe1ePN6biXsX0bf+Ecr83unT7phgH6+21hA=
X-Received: by 2002:a25:6b44:0:b0:dc2:2e50:dc4b with SMTP id
 o4-20020a256b44000000b00dc22e50dc4bmr894449ybm.52.1706685427161; Tue, 30 Jan
 2024 23:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131-ufs-phy-clock-v3-0-58a49d2f4605@linaro.org> <20240131-ufs-phy-clock-v3-2-58a49d2f4605@linaro.org>
In-Reply-To: <20240131-ufs-phy-clock-v3-2-58a49d2f4605@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 31 Jan 2024 09:16:56 +0200
Message-ID: <CAA8EJpqGhUiF6is9K0OeB+DW5BmTTEEvk1sEDkxV+cN5BWpNnw@mail.gmail.com>
Subject: Re: [PATCH v3 02/17] phy: qcom-qmp-ufs: Switch to devm_clk_bulk_get_all()
 API
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, quic_cang@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jan 2024 at 09:08, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Device drivers should just rely on the clocks provided by the devicetree
> and enable/disable them based on the requirement. There is no need to
> validate the clocks provided by devicetree in the driver. That's the job
> of DT schema.
>
> So let's switch to devm_clk_bulk_get_all() API that just gets the clocks
> provided by devicetree and remove hardcoded clocks info.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 63 ++++-----------------------------
>  1 file changed, 7 insertions(+), 56 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

