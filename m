Return-Path: <linux-kernel+bounces-61669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C692B851529
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE811F20407
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5E03D3BC;
	Mon, 12 Feb 2024 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZXPEUyv"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F51C3D0BF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743829; cv=none; b=oCLMgMzt/C075dW4iYJzfKBxUE43FetGt4gmEQivsYfGPTNpi78yWYYHlPntjRZPXpnzebivMVw/RvWWK9EHv/Sg2YqUIL+641BhWHZAsAx6ww38d/6A36Yx3Gf+3ASMNouHnTNnlclYlT+oFcImiAn70q78oAj4acj2KDGk3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743829; c=relaxed/simple;
	bh=EFPEqd46s5I3E5DiBGISav+OKrKybFE1x7xvB+oOzus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8hDxJ2TipnCkmtSavOT5Q+8zwP1C/y9pFItowpTlxuv8N5ITIGhDAtpPyymDXE58f/6rpSIkwgdzZgyPAvTQ7FgeTNa42Ed8GWlgRkzf1EusTT0XBKzcN4TQXjSLDdqTvfqqkVzlkCzU3ezMHOEYFtcWeQkGFoZQ5Z1yH2bkmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qZXPEUyv; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso2827619276.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707743826; x=1708348626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/+XEKHxpbfeHopZyLoPZwvUQi1sJb8QAohlEN697rP8=;
        b=qZXPEUyvRsWhEPAPJqiBITzGzJk+QE0USleiyN+YaJFpv9g6CViWKPGzp0Ok8N1rJK
         46wz1C+bfHvjjwPYt8mlgwy96IghTfD/QyyjgyZXiLepzfIJhM9Q+EOKvKbWM7Ed/gw8
         6zhT4C/OjPqcUVi90evrgyEbMAFsfA1AF+VrmJjTbcFxm93zUA1oEaPz3hPXlOsjxgC1
         0TkTvEeU0q1Mh0ihUwp5kn96YPHX2EvDA3cC0XpcYxawYUuX/In5+HL9ShHPlLUfduAe
         G3GcRq2ztozgQchrqPmateUUvOObn3QKz8+Sy4uhyG4KkT9f8iYh3pHVUQUgGjIdNKiO
         LZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743826; x=1708348626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+XEKHxpbfeHopZyLoPZwvUQi1sJb8QAohlEN697rP8=;
        b=DfhKnBwucShSAeB3FLThBWAwI3VN7zx0uxSdoBi7Xmo1/3qiNxqkx/t0kwCVSq5nkn
         lhZ/qjkmyBRWoAuegwC+sFq4zY7cQrZzWARZw0a9iZu4WGg0Pfa7cu5gNzPleWY/jCzZ
         JvXD9woo2+nGIPb2aMr+HtLp2Q1OWIU30D3t845VmxKb6zkYZiCuDN0307jnqROXNFuI
         vuZu46QNknzZTl+s8KwMATZkKluS261pdAd4lDMW05WXWcTQ8rdkDOLIIPgq8hC/QaRJ
         5q7WqfeAn8JPPU813H+hYLTFq9kuv6Rber4CKTJ/WQmHqRGk2fuSQHxpxxFkTM8ptCLP
         wlSw==
X-Gm-Message-State: AOJu0YypXo5sKtX6xEkEnSQ9z4N2rLepG294/zoKUfA767u6Xo5TDZCQ
	i7wOD/TQqV/9Bkzvd2FVWJNEI5fY+F9rku9QUlFxMbgjD9yVnNZEKYxG3KPlBPGIiVstcBMF+HC
	gwvqPq/kiSu39T30SDTSKiXkjlyTLA6/UDqMZcA==
X-Google-Smtp-Source: AGHT+IGYHJiazxsOUSDJtVowkMIrtZPyFcKSzyUn9nL+Lb6N5qCPSjjhXoJXWVqdlecBvt0jLzmlRqrGB00PokESqw0=
X-Received: by 2002:a25:ae9c:0:b0:dc7:43aa:5c0b with SMTP id
 b28-20020a25ae9c000000b00dc743aa5c0bmr6076081ybj.21.1707743826518; Mon, 12
 Feb 2024 05:17:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206113145.31096-1-quic_jkona@quicinc.com>
 <20240206113145.31096-5-quic_jkona@quicinc.com> <edc9fa59-5f39-4f47-8647-242a9b0a8cb4@linaro.org>
 <e5c484cc-7624-40fd-a527-8cfcbf7784fe@quicinc.com>
In-Reply-To: <e5c484cc-7624-40fd-a527-8cfcbf7784fe@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 12 Feb 2024 15:16:55 +0200
Message-ID: <CAA8EJpqjU-RDwPH6xGLa7xzcyxmU+86mX0X+DL09SJ0uVB5_CQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] clk: qcom: camcc-sm8650: Add camera clock controller
 driver for SM8650
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Taniya Das <quic_tdas@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Imran Shaik <quic_imrashai@quicinc.com>, Ajit Pandey <quic_ajipan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 15:09, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>
>
>
> On 2/7/2024 6:41 PM, Bryan O'Donoghue wrote:
> > On 06/02/2024 11:31, Jagadeesh Kona wrote:
> >> Add support for the camera clock controller for camera clients to be
> >> able to request for camcc clocks on SM8650 platform.
> >>
> >> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> >
> >> +static struct clk_rcg2 cam_cc_mclk1_clk_src = {
> >> +    .cmd_rcgr = 0x1501c,
> >> +    .mnd_width = 8,
> >> +    .hid_width = 5,
> >> +    .parent_map = cam_cc_parent_map_1,
> >> +    .freq_tbl = ftbl_cam_cc_mclk0_clk_src,
> >> +    .clkr.hw.init = &(const struct clk_init_data) {
> >> +        .name = "cam_cc_mclk1_clk_src",
> >> +        .parent_data = cam_cc_parent_data_1,
> >> +        .num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
> >> +        .flags = CLK_SET_RATE_PARENT,
> >> +        .ops = &clk_rcg2_shared_ops,
> >
> > Nice.
> >
> > I compared this to WIP for x1e80100 which looks nearly register
> > compatible. Use of the shared_ops indicates to me you've thought about
> > which clocks should not be switched all the way off.
> >
>
> Thanks Bryan for your review, We want all RCG's to be parked at safe
> config(XO) when they are disabled, hence using shared ops for all the
> RCG's.

What is the reason for parking it instead of fully disabling the clock?

>
>
> >> +static struct platform_driver cam_cc_sm8650_driver = {
> >> +    .probe = cam_cc_sm8650_probe,
> >> +    .driver = {
> >> +        .name = "cam_cc-sm8650",
> >
> > That said .. please fix the name here "cam_cc-sm8650". The title of your
> > series is "camcc-sm8650" which IMO is a much more appropriate name.
> >
> > The admixture of hyphen "-" and underscore "_" is some kind of
> > tokenisation sin.
> >
>
> Sure, will fix this in next series.
>
> Thanks,
> Jagadeesh
>
> > Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>


-- 
With best wishes
Dmitry

