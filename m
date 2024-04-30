Return-Path: <linux-kernel+bounces-163819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104D08B7255
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3340F1C22B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654E712D1E8;
	Tue, 30 Apr 2024 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5oqDNOQ"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFD612C805
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475224; cv=none; b=WyH0OFfcYReUyQXd1v/yYi5Vs1bmnEtRajPo1AF92UTaSQ2cXwvzxN1IefIsiwPtsYbu9jxQU65qTNygF4kRVxY67QEHnzQ3GNCbPx0aaFKIYlU6eLu7UAJUShA/iy/RdToV+D1ccd4/HF7rcgkHO+AZC+hpsSzJo4uctOU3I7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475224; c=relaxed/simple;
	bh=+6cV7rhQy0tyqmlQOhmCF7WmeVnptWzEPHeS6lT3oBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mY6YYXVOQPsCEu5yiLxQXJxjEMqu2b8p99pP6q7B6OVkwceKo4JJIUDidqsNnwPRaczqbmTk8iIpO9/Rp0MROIOglJby1cAbxRjt1R7q6sL/z5mYAe1F0FAuUfcLy0esYvHAQnr6Kahzcpf5ZvZI0iXGs+kRhA8X0DP70RLmtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j5oqDNOQ; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5aa17c29ba0so3714774eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714475222; x=1715080022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JlFLonT6AbxZce1grlaceJ+UmWNTD7jKyAmm8+eZz5A=;
        b=j5oqDNOQqQauMBOj/sZxhKQI62RwyUm8Zb9wcuXvP+wlTiuuDEq3rzLJezH3nL9KML
         WTKx4SJfCmnwDbF8x+ncK2/RIocgcPiV5/7ZQBoyPlylR+YL7Cnpz9hkJkKe82URr405
         iaErhH7KEpAV1kYDg2m8Lw+WcSwDcb5e18K1aOJpHT0zBUk5JoPhhNqoMFn58VwbZWTr
         lbmwfRTU6lis+Mgwia5l0iokmf8GfaT5bNftZoa7OrSimoKrjNDfAhsRHlploRnxSE8s
         zvA2y3L8zQ+5GzwxrbRnj6oiL/dDoFXRPKHzbT8VRdM/cSpjzY86hSqfNZxvCcgAkHT2
         44Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714475222; x=1715080022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlFLonT6AbxZce1grlaceJ+UmWNTD7jKyAmm8+eZz5A=;
        b=OWAdC+Bna1E86pi60h57p7HiV2QRY7r7tOMgqdtY0H+NvD60eX8DgnUEEvBiLoscON
         FjHq6HKEDyERVeN/axC6fnYi9sbIeT7rX5NWsEs+hGAtdPOj+daMWEK6iQy9MdzXyI/h
         T+KG7sgOkgL1dMY8L6IEQrLiA/6Tt06MisN7FBWollUQ1iOO/6VaZWClAnOBpXJT0oUq
         B/36AYXrkyJYxO8EjL5HNqb1f+DN6Wv2Q/dZ+k0DN51uWvHI7bfXYJhsjUPs3yAa3tSp
         92UpVmGch5J7Ap+PsxTyCpdnQbvww7xF7pPF3C00NmC/UR6Q6zw2D3LvSiVdnJIe9ZHw
         UgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyPlE4zSbQ07mFidsYC3kQP0kiJLcWKFHL7OJ5QD3QPaLMJpqVmm1N1Ke4eUQSQAC3cRCy3CSZdKBNTnTV4M+YbPWu/ICtuydBY/3S
X-Gm-Message-State: AOJu0YxACHX9clhZIoFRHUZ5FUuAe6E5eCk7VvaHnITaldF0uzeNoy51
	w0suwgQUr9u9VqaPzOaGvojr0HN8/AkBOXSn1mltcxJIVqx+/AANB0alwFbzZnB5y38VmCm5V54
	GntWsrucWvGOw7VzW+ry0PNh8MJdKpODcvZe1jQ==
X-Google-Smtp-Source: AGHT+IFhPeJXeV1s//xKAbfSLFyLypE5EQb5yNM836B9rqVy61LRxN3Mxm8oY0UDLV94lhjAp+2c4sfuf0XgokC2zZQ=
X-Received: by 2002:a4a:d46:0:b0:5ac:c39b:3a7a with SMTP id
 67-20020a4a0d46000000b005acc39b3a7amr16090427oob.1.1714475222500; Tue, 30 Apr
 2024 04:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429111537.2369227-1-peter.griffin@linaro.org>
 <20240429111537.2369227-4-peter.griffin@linaro.org> <8b3c9d34-15d5-4aac-b725-4cc25e469a58@kernel.org>
In-Reply-To: <8b3c9d34-15d5-4aac-b725-4cc25e469a58@kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 30 Apr 2024 12:06:51 +0100
Message-ID: <CADrjBPrSLpjsgHBncYG5cfh6nnnFMv-vsk3Uq9PXsBa2JHRf7w@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] arm64: dts: exynos: gs101: Add ufs and ufs-phy dt nodes
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tudor.ambarus@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Mon, 29 Apr 2024 at 18:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 29/04/2024 13:15, Peter Griffin wrote:
> > +             ufs_0: ufs@14700000 {
> > +                     compatible = "google,gs101-ufs";
> > +                     reg = <0x14700000 0x200>,
> > +                           <0x14701100 0x200>,
> > +                           <0x14780000 0xa000>,
> > +                           <0x14600000 0x100>;
> > +                     reg-names = "hci", "vs_hci", "unipro", "ufsp";
> > +                     interrupts = <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH 0>;
> > +                     clocks = <&cmu_hsi2 CLK_GOUT_HSI2_UFS_EMBD_I_ACLK>,
> > +                              <&cmu_hsi2 CLK_GOUT_HSI2_UFS_EMBD_I_CLK_UNIPRO>,
> > +                              <&cmu_hsi2 CLK_GOUT_HSI2_UFS_EMBD_I_FMP_CLK>,
> > +                              <&cmu_hsi2 CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_ACLK>,
> > +                              <&cmu_hsi2 CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_PCLK>,
> > +                              <&cmu_hsi2 CLK_GOUT_HSI2_SYSREG_HSI2_PCLK>;
> > +                     clock-names = "core_clk", "sclk_unipro_main", "fmp",
> > +                                   "aclk", "pclk", "sysreg";
> > +                     freq-table-hz = <0 0>, <0 0>, <0 0>, <0 0>, <0 0>, <0 0>;
> > +                     pinctrl-0 = <&ufs_rst_n &ufs_refclk_out>;
> > +                     pinctrl-names = "default";
> > +                     phys = <&ufs_0_phy>;
> > +                     phy-names = "ufs-phy";
> > +                     samsung,sysreg = <&sysreg_hsi2 0x710>;
> > +                     status = "disabled";
> > +             };
> > +
> > +             ufs_0_phy: phy@0x14704000 {
>
> Drop 0x from unit address.

Thanks for the review,  will fix.

Peter

