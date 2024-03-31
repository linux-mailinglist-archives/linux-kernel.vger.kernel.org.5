Return-Path: <linux-kernel+bounces-125917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA73892E31
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 03:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CEE2825D0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 01:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A277B10E6;
	Sun, 31 Mar 2024 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a36wuHNF"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3ACA5F
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711848520; cv=none; b=bbVowo1rjWuPDEvH9wyPBhXQYgIeN5XrnyYKMITJXWVwvSAP4jlxb4BTeWhAz6qMEFCxP6CrEXiDYbN8GlcM/CBXdOb6mVEDeyNXZ7C/V3L2o+Q2f/yc2wO0UFbJ4ZKETt16X+kwtiQPps+Fi6SilCLtT3vgkpvmYEioya3R0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711848520; c=relaxed/simple;
	bh=fwCsj9KzvvZz8Fr0/8Sp6V8OFjpmhOC76hu56ZddtJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2FVvMaRqk/DvYF0X8CkCasjhonuRXq6smfYOQfA79HTagpKGas2PQPbmfrr3b3phohPIVX5tA+nPvbQf10+73jzabPuk9LJd4AEUN+YX+bBYH2gYTrgT5GAta7PMeTfzWjZOzweRr8Qz6fLnuzUUK1UbBx7+Y/+8Sl9v3im6r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a36wuHNF; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc74435c428so2930763276.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 18:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711848517; x=1712453317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BL2R1QAuvfVx+U9ruvI1fjJwx/fUUYB4YJfJTk35Ycg=;
        b=a36wuHNFC0DbmMRm9QNUNO76ibDrG+CFhwqGJNF/T+ZsGvxiiPPtHWtQB72uyywcgK
         mbG+KxWt05iQ305lA/75h/3MmLy6WwzZP8djSg2sXaomibAj4iOEy7+wdzlGvqwVgG5w
         KoVW2gzxJPD1dcSN2Qt9djf405pA3ToxA8/2VJ/4C0bT4kYHN7M3bv9ooJIxH/tRCnEp
         VHiF+Jre1VL6ShwiQdEGIoBaDCXUV46vfytw/Rp5O9fQfbxuEKfte+SRDessTADb5qof
         BQoO22I1wFbwWvETV2Bj7BoWXemSEfAl4Mix0N8GGxwPOCNnT+Mrn1WSa48XnoQKbL0g
         mChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711848517; x=1712453317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BL2R1QAuvfVx+U9ruvI1fjJwx/fUUYB4YJfJTk35Ycg=;
        b=FxpHbZ/h7Or3uMCD1HSK5QixprCB5XqWxxxZWPVnDstCkCMjkvq3JpRLe9UvnM4YJa
         T3U+LKk4oNlxn+GI/krEs6E9l1Sxn0w4eAHeRDo6nkMdnwhj6W2eil9bdTOI5qtcnFoA
         iG3Z3ou3F+RFE1aK6Czjstku8/2svf2lIEGrhD0CIYi1qxE1nz9tLXRFCHdzCd5NguNM
         TE/u+/rqLOrbSLylZ6hkLoXbLZPgR5Y4v1hMJPzFdQmBYKCO49VJZnYb1NnUT+N2LePq
         cj8MwZjtGxDctyze64fc4saebfRZwQgBlYLpyPmBH5V/so63VPf1MMOz/wP3nnbyf8ii
         dmLw==
X-Forwarded-Encrypted: i=1; AJvYcCWlHw7W72xET0SAWC4NljlVA1YyLhOQiWzRF5Mu1v+CBGzXIv4nbETh5zqjXBybEkwL8QIbMfouwb435om1k/J045i+SZGPrIl40SsP
X-Gm-Message-State: AOJu0Yzb7y1IqDmmmzxOflqD3h2Q2eXibx2q6q21+R59NcoMKiPc8Hxu
	qaQ3L0F0MfukYTlh690wk71FGbaRdIcVfsv0OjsqeEzzeCSf4Ib4Y9lyikWYUz+t/PivRaLqazI
	lLdP226sWcgcPqFnFoouDv9hNEakxsMue+kqdTw==
X-Google-Smtp-Source: AGHT+IH8rc6ukKZ431Xu+JFdWXSvpJY/UG2Kt+Pg0Sya5av9XYBdN41omRMHENn7AkaVIvIVLpbPE6RbB/yVwhyEjNc=
X-Received: by 2002:a25:890b:0:b0:dc6:9c51:760f with SMTP id
 e11-20020a25890b000000b00dc69c51760fmr4459130ybl.56.1711848517203; Sat, 30
 Mar 2024 18:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330182817.3272224-1-quic_ajipan@quicinc.com> <20240330182817.3272224-4-quic_ajipan@quicinc.com>
In-Reply-To: <20240330182817.3272224-4-quic_ajipan@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 31 Mar 2024 04:28:26 +0300
Message-ID: <CAA8EJpqZjysw+YE=vKguearf_abSzocvYtMvW9eHAZD-tMKs0g@mail.gmail.com>
Subject: Re: [PATCH 3/7] clk: qcom: Add DISPCC driver support for SM4450
To: Ajit Pandey <quic_ajipan@quicinc.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Mar 2024 at 20:29, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>
> Add Display Clock Controller (DISPCC) support for SM4450 platform.
>
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig         |  10 +
>  drivers/clk/qcom/Makefile        |   1 +
>  drivers/clk/qcom/dispcc-sm4450.c | 781 +++++++++++++++++++++++++++++++
>  3 files changed, 792 insertions(+)
>  create mode 100644 drivers/clk/qcom/dispcc-sm4450.c
>

[skipped]

> +static int disp_cc_sm4450_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;

Is there a MMCX power domain on the platform? See how other dispcc
drivers handle pm_runtime status.

> +
> +       regmap = qcom_cc_map(pdev, &disp_cc_sm4450_desc);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       clk_lucid_evo_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
> +       clk_lucid_evo_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
> +
> +       /* Keep some clocks always enabled */
> +       qcom_branch_set_clk_en(regmap, 0xe070); /* DISP_CC_SLEEP_CLK */
> +       qcom_branch_set_clk_en(regmap, 0xe054); /* DISP_CC_XO_CLK */
> +
> +       return qcom_cc_really_probe(pdev, &disp_cc_sm4450_desc, regmap);
> +}
> +
> +static struct platform_driver disp_cc_sm4450_driver = {
> +       .probe = disp_cc_sm4450_probe,
> +       .driver = {
> +               .name = "dispcc-sm4450",
> +               .of_match_table = disp_cc_sm4450_match_table,
> +       },
> +};
> +
> +module_platform_driver(disp_cc_sm4450_driver);
> +
> +MODULE_DESCRIPTION("QTI DISPCC SM4450 Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

