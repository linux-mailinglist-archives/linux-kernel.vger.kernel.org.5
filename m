Return-Path: <linux-kernel+bounces-10646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8303681D80C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 07:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C415C282836
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 06:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E571117;
	Sun, 24 Dec 2023 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJfr7Go5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DC320F8
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5d2d0661a8dso28612287b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 22:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703398620; x=1704003420; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+yJH4M7lQzSLCFAOCgx/IfyOcjTUsiv4Zv46F5h0xK0=;
        b=WJfr7Go5KmfQ4TmWEvfqliitP1Y23ZV09UWXSvJlLue3yrdMGIixMnOCGfdOsrJ7Kw
         ebbnW1OT8TEL9dKMh5QgI3wYxpLoIejauKTGtJABjEmlrtwsCcpvkpc9A9gkZIApWk+9
         a54mNeJv2PJIS/kUtwHdvXGxlRzZNyDvyq34CGJi4xOF3WFhhRWdYVRxboewuXXGwIlG
         uOPXtI+FB1CAiQ+efgyym3UxHv8uzr5uhK6AgH8p+cyHsIZDk1ydudyNrU7XdYKNFIvW
         SjTUD96EYIagMlxAfdmsT/e74KWXn3L4h7UbZbk+f5mdhjX4Jy0cCgBNew7mDY+h8BRl
         I2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703398620; x=1704003420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yJH4M7lQzSLCFAOCgx/IfyOcjTUsiv4Zv46F5h0xK0=;
        b=nFtTGrlEPUyPRoyZuNeOajhoH9IiTwgzKjbPlUkL56IGLfEngjUk3XTIHn8vG0fdwB
         eUGePzuZtmP7I1s9on1DUu/lwvs3b/RRr5pDSrmlrMO4BjWjkC0xjqsv2/0+t0PFPcpx
         fAIxyJY+68dk3xrGmC2knBxWeJxiKsVabbpzALs7EWN8A73ZoZPcaB2rfY/QdFuu0INx
         c9PPOOEanw9nCjyoOHtxE6t0hze+jUZRA317AkJO0NxadhxAUhIzLqWeGDCZVXX8YHmU
         IIed+k8giUg8QbVv15QCUzT7sYx2h1EBuf8PGQnKk9AupJvSNqwafO5h1e860jHSquyl
         OEbg==
X-Gm-Message-State: AOJu0YyiE/Deb3hCsGk8ZWd3YhgI5Q5yMGmp/BAfbbwj0D0ncQQ2OViS
	w58ERZf9zQYOauPN34qnMD/bM818ivEyn0brz4TFNUlNlQEAOw==
X-Google-Smtp-Source: AGHT+IGj3x86AOzKQKDN6TlGAjhfiLdu/m9mbvukDFEOZqq9qJwmmW9PBdR7ggUmuzrbN657Dt2zBN0GOTIL6rnUZHs=
X-Received: by 2002:a0d:d247:0:b0:5e9:f302:1a0a with SMTP id
 u68-20020a0dd247000000b005e9f3021a0amr3308849ywd.95.1703398619915; Sat, 23
 Dec 2023 22:16:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223-x1e80100-phy-pcie-v2-0-223c0556908a@linaro.org> <20231223-x1e80100-phy-pcie-v2-2-223c0556908a@linaro.org>
In-Reply-To: <20231223-x1e80100-phy-pcie-v2-2-223c0556908a@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 24 Dec 2023 08:16:48 +0200
Message-ID: <CAA8EJpo774xzmpb2+72sJ80kmcCqJK-gDfkaLERGgmPeSZV3PQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] phy: qcom: qmp-pcie: Add QMP v6 registers layout
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Dec 2023 at 13:55, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> For consistency, add the QMP v6 registers layout even though
> they are the same as v5. Also switch all QMP v6 PHYs to use this
> new layout.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

On Thu, 21 Dec 2023 at 05:51, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> The SA8295P and SA8540P uses an external regulator (max20411), and
> gfx.lvl is not provided by rpmh. Drop the power-domains property of the
> gpucc node to reflect this.
>
> Fixes: eec51ab2fd6f ("arm64: dts: qcom: sc8280xp: Add GPU related nodes")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8540p.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

