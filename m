Return-Path: <linux-kernel+bounces-80293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9A1862D00
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF561C203D7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E691B94F;
	Sun, 25 Feb 2024 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tksXgWRG"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07481B81B
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708894846; cv=none; b=GQYdcL0zJDEfLWg5GAbdovYxNnrVwdUE70xE6rUTqjiyQRegNXIUvcLW+2pXa8SbrBKMMy/VF04AKpyRPy4HGZolnhsmAzzXWVMITUTE9yUj6CsUAqu14ZK0GLOxgorItkUq+OxkrMkO8I0RD5Mgm3be4frC3ttUwRUjQ8E4KFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708894846; c=relaxed/simple;
	bh=unlIYXL3BwizleLlMEBQGYNfHGKdQOyg0kKHZe9dPEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9cEC0oGe2s8ueeCGiBFEuOOQOt/j7pGF+ajYhEYdRlTFh0HrX0Y7ospodC6amlo0YunmeHiRBWJOJOPKK/i0QEwUS1qjK/5wt/Hy33M7TyHcTpiFNN+M0XT7jXT5PetK9s/+ZI2CQ0R0gKiP5E6TbnTXxnrQF0gdlpkp0rmvx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tksXgWRG; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so1783707276.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 13:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708894844; x=1709499644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KqbMk46NxtU+fpvdDcQrXCuDM/dEl6vfrxJr2Yihlwg=;
        b=tksXgWRGOsSgTIqcFZmmzJOxF6Cxkq8yU2hps6BDvX9wo48Kpt/PBHN0BdletCN8jG
         sloPCuUyKtPprdw4qZ6i7fUSRFg4p46dRxULw0UaQgDGEIBU+0YKG05Fqzhz5b9hh3Hm
         RZcrFL9iwC8OxCyQm/AXlywB8d+c0Vs9U4cWXaMCDbnz7OmiG9NlPkCWb5Z3R8igCfAs
         Zcy7Wbvm9l5KdlV9Uh7ABVFREOtyddOZlYHgITrssUaFMqsG3NtzaCYtoxHRgqvIcM+a
         WEY754Vi8kwv0gdT891lOQUn63yN7smvXA0hzUO1XBYQ868pBg4PSuI1jvmeUpG59dpa
         XFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708894844; x=1709499644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqbMk46NxtU+fpvdDcQrXCuDM/dEl6vfrxJr2Yihlwg=;
        b=QBoFdaWT8T9U2eg2qzuGnaDk8IOJ3Ty0Z5GaaqzoB8Sfh0LcTa6J25akMvZ03cDObg
         oFTNih7OKFDYVftosbYhFG8tDB7cmDxfQhBYFfw72UhSUEdnl7lJanxEZSnGgduQtJsz
         JvV+yNkikioh7lX/bHve+XE7cfFWjQN/dJurjv+RcXoy1cYbQIURySQy8qUc0rTg0cOH
         Ac6PJaHfsgttHK9jfj55bx6iorvQkrCaNR9upyQlDPD/s128qSBTaGmzzuLr1I94l8J/
         Ng7xRR8xbZbCkcQ3cG0YtXnTkZD4uC66TM3zGXsq/Y9kCMY5i1Fc3FI7lP2hJwMsHz+T
         Iq9g==
X-Forwarded-Encrypted: i=1; AJvYcCUVcR40fluBzEp3w0ceiKUPkZKmKvHpQvKQRVy3z006dULdRk99KKrOPkuVsh3QGDiuGULVMjULJpEo+gvo4Xj7MQgV9goAKKmeej4T
X-Gm-Message-State: AOJu0YxO3rhtNe7/L0YM1eVS4ENVCxbf0dFnV5beriOmAa36/ly+O+Mk
	py/I4MexxHD5WXdmzmPn9EIygz7YGsCGEC2q2A21Q/+nsOPXDCQtn6oS5eWXs7uBOgdVIxj1LeA
	HaU1O+tKxbbNqcLnN9L4/U1BBtQuooTgE1oZk1g==
X-Google-Smtp-Source: AGHT+IEqqz8HfqIigknKKk7AO/yotuhTPLw8B2KFACuiv8hx5tb8SwwFs8WBzSRjLRJOs2BSRjve+1IeMNGqw34uTP4=
X-Received: by 2002:a25:7e07:0:b0:dcd:a331:40ee with SMTP id
 z7-20020a257e07000000b00dcda33140eemr2928290ybc.14.1708894844066; Sun, 25 Feb
 2024 13:00:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225-gcc-ipq5018-register-fixes-v1-0-3c191404d9f0@gmail.com> <20240225-gcc-ipq5018-register-fixes-v1-3-3c191404d9f0@gmail.com>
In-Reply-To: <20240225-gcc-ipq5018-register-fixes-v1-3-3c191404d9f0@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 25 Feb 2024 23:00:33 +0200
Message-ID: <CAA8EJpr19P6P7COjP8YpFgK4x41Q8M8A3+n_avtzfpKBAuxBpA@mail.gmail.com>
Subject: Re: [PATCH 3/3] clk: qcom: gcc-ipq5018: fix register offset for
 GCC_UBI0_AXI_ARES reset
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, Varadarajan Narayanan <quic_varada@quicinc.com>, 
	Sricharan Ramabadhran <quic_srichara@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 19:34, Gabor Juhos <j4g8y7@gmail.com> wrote:
>
> The current register offset used for the GCC_UBI0_AXI_ARES reset
> seems wrong. Or at least, the downstream driver uses [1] the same
> offset which is used for other the GCC_UBI0_*_ARES resets.
>
> Change the code to use the same offset used in the downstream
> driver and also specify the reset bit explicitly to use the
> same format as the followup entries.
>
> 1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r4/drivers/clk/qcom/gcc-ipq5018.c?ref_type=heads#L3773
>
> Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/clk/qcom/gcc-ipq5018.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

