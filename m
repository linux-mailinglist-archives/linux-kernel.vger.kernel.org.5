Return-Path: <linux-kernel+bounces-72989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6F285BB8F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C8C1C21D48
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E7F67E66;
	Tue, 20 Feb 2024 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWVhMlhN"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154B67C6A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431175; cv=none; b=qV/8firIm0VRidM+7mlN3VvAeKV2kpTkvlBG9G4FB91zzxdtxcXi/5r6rsxy3xr/4Lf4xZ2wFptPaB1n2DW0GqfYx8tkDWyVyVURTTpJXxC9qnyKi0shZZWsevyiEVlX2EXXbHtrKXE1v5zhjmTJdMCa/RbTsOkaSMLb8pQLbF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431175; c=relaxed/simple;
	bh=xk3aJYvUH7ummcRIbLiEZHE82TlzfaBE6gHzhdpzgcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mv7WBrnEylhL3K8IAc6kWj8UP/4Vm0JCBpmfIRrqVeUEltiRPPc1t9EylacEh3PGYoTkw0DnGF+EiwwmuF8YENZZQ773gl18zXwkIxVZthEWTNRuegtRsK+aqQKXM42J6tKQSyKgIrfqJ/u7dR+HfR+MRl767wmAt+WsK/FihOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FWVhMlhN; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-608245e549fso23361657b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708431173; x=1709035973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e6wTR0VmqItODr2yd8HndCQHY6rqvWA1sKIhl9SSx/4=;
        b=FWVhMlhN4rE9aV5P9cCsDPHzXOpyPbpXYkysI+LoL6y4i1pFdT2CoNLaPnILraRGay
         rQf/m/G4FfWdfcL1PUgrj36CGtLb1CN19ENiYMY+VXCbTPwSQuXy+O5m6z1C/ykoPYxQ
         mr++JRE8NuvfaVCqTzXMLzs8sQeZEBgyfBGE3vDmKHkD/h0XD0sMnavj44trCFQ49M80
         6ckPPg9KKWWIvqANU7dnA1iSWvT+1+oRrV7qnod9GqQcGj1zxj/KVauB8tTAoI9GQEp6
         n5YZ5nQ3nVuUvxZ7w9ONnfn7urGoTyBQWuGvjeTgJfdY9wi8NRpkqPZeKCb8nvRgwsF7
         QycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708431173; x=1709035973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6wTR0VmqItODr2yd8HndCQHY6rqvWA1sKIhl9SSx/4=;
        b=Z5QGEHTVo7ZM1J8SKaWbqF6hAyoCkpaFxsxiJ75H/JorEqRxROzsWUEII1tlOAiSbp
         s1aLGNU4iVv4KyRn+Eraxmf1U16DSTeB3z3nfwF4Sh2UAwrSK1Hi7O8RYDn6ibdIvIC5
         R4og+hyuUp6b1Nr6Zwa6B8MT5ACiLkVsJBlri6ylIBvlrIo0k/inbux99vlR5V5EPz4a
         LQRG2h+RpOvq7glwADXHVRYnY7pHxx6d9Lm2doGmjeiEreZtRO6tcPVgj5dd5N0wo0kM
         DUERNJIaVZVTf2frelj8TsgkHRseiofn0tZXEBXaf9Dbfod/h7AEs50Iu22OTtSRNH+g
         2+5A==
X-Forwarded-Encrypted: i=1; AJvYcCUzQEsC5yL+sn/tk4/kEkeMWS8rF9PVazEmQor5jX8eDhL9JOjGY01uQZL7E3x8ZV7nx33kxHrjMwPs0ZRp+Ijt+g1LJR40tAzVcQef
X-Gm-Message-State: AOJu0Yz9wBSrKBiWOzNW5FN3ypAnFmW0yDx6J3p1pnliJXJQK33feQSU
	cUeYIZ8pDWGYNc2QXlvnFVeay7/GeeJc6LoPQFLAqduGQHjRqByGjAEb+vdTYAcAyMKYEsM+gc8
	ErseJgfouyG711mS1IpR3Q7rvj0YIiHIjiZ2sIQ==
X-Google-Smtp-Source: AGHT+IE89QVyewZFZs3o8KYR14F/wdiOB0kpE6qbJHNRXT44hQTbwweqexbkQuL1HRYlWatO5NlcBcrvZUHtw5GjUgs=
X-Received: by 2002:a05:690c:f90:b0:604:9551:f595 with SMTP id
 df16-20020a05690c0f9000b006049551f595mr16185146ywb.50.1708431173276; Tue, 20
 Feb 2024 04:12:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220-x1e80100-phy-edp-compatible-refactor-v5-0-e8658adf5461@linaro.org>
 <20240220-x1e80100-phy-edp-compatible-refactor-v5-2-e8658adf5461@linaro.org>
In-Reply-To: <20240220-x1e80100-phy-edp-compatible-refactor-v5-2-e8658adf5461@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 20 Feb 2024 14:12:42 +0200
Message-ID: <CAA8EJpooQh0v3cvoum94J2AkmUgD=KEiYw6R=2=h9un9bGvc2Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] phy: qcom: edp: Add set_mode op for configuring
 eDP/DP submode
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hovold <johan@kernel.org>, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 13:58, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Future platforms should not use different compatibles to differentiate
> between eDP and DP mode. Instead, they should use a single compatible as
> the IP block is the same. It will be the job of the controller to set the
> submode of the PHY accordingly.
>
> The existing platforms will remain with separate compatibles for each
> mode.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 76 +++++++++++++++++++++++++++----------
>  1 file changed, 56 insertions(+), 20 deletions(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

