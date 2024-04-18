Return-Path: <linux-kernel+bounces-150041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D18A997F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69641F21C32
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0770C15F330;
	Thu, 18 Apr 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RguN3ynB"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA1015EFD8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442128; cv=none; b=RupoJ4k+kOTJqba4G5Olvmm4ccxq4BdJ7njWRlg+HnPCMQsibJSprRuRhz+GXBr9CLeSVkXblUA2YB9oraeV+LE6lYnolcVqQazvjvfc97xRggqhtOmUwWDj3LCgPNnJCAJsiBI9XsdLI3KpzLexyeNzRPn7buWygJ/Jb7VKMSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442128; c=relaxed/simple;
	bh=EivacNFq0/5fLlwKTYEmDnsBy7Akbb2iAEHMxkjmh9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=li1A0X55EI8tokyoV5cPb7csW1u8F/3liAwCTGs+qmPseS2Vz/X8Fj0pj1Bs6BGuZpysFk3Bx31kJfZiOT3jGhDnOR/X4Wj8MnBDKN8SLFMC862V8wJbzbHFoSQ/5uBt3Du5iHvlNOPk0zBoO33X6kyP0v3Vx47kHmuXrtt/A34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RguN3ynB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-347c197a464so539237f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713442125; x=1714046925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IrT+pz9h242ho6h5cpwp9QuV44kTV1V8Z+LpieCcyow=;
        b=RguN3ynBfax/qkBvrCX1uyQho9papzclDb1b2QE6hQQR8mzuqxaCzoUl0PqME7l0w1
         U3iGFzx0h60XvoxSkES0lx5grKalOlDr+ex04pm6Rr9ON798mfptw1eUx7x6DU9ll9KE
         NaBkVL4Ds3abKw7zj7oud6hiouLqGVHdqKBjVcJwaY8nNU0mIiUlxJGkIUPGPZLA5pEL
         oZg+2FCFk4Xp2IrQA7zVty36vpPsWlq5P1Ba0BIU/Tm+eEYoj2JXQvjJahPDzw2pNmls
         VBYv9F+trIFySbzvg+QEVSBHvqxWhTfyeXwMvrRPqjxgy92RoaDRWMuV+BKS8Bmsh9TF
         blWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713442125; x=1714046925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrT+pz9h242ho6h5cpwp9QuV44kTV1V8Z+LpieCcyow=;
        b=s10ymrKMWE0U/m4CxuaLuOxLuFKlBep6B9o7MoWdYO43ohaommvjfse/t7por2K7g9
         JKX10GEKWb3Bi3zrW58J8mpAz9URNY8aRWzpysgc1hrsSKqVSAc9KDyHB4u972/j3VFG
         V907c7X4ehCf2IpSoJCTBzC+ZDPzGSKOE8/jid8tdgYTwwvVCrLCLve55YOZ19DRibmZ
         luIOxpLLS6ngdfSPcJU5wJR8/ERFVN8sh1G5+2RtehHGLdPHTeCnBP0ncjXd7BxwgtWX
         gLMsHoC499h8am2qKe29F0NVcLV8FvqLALcOSEkXMq3JMy7/jk7UVo/a5AmCBmBiqtWH
         dnXA==
X-Forwarded-Encrypted: i=1; AJvYcCWhuupeBkcx7z3Vx848NjiDvnw2j5KyRSwinaHk8fK1UyOSlMIUO1Po99jowYgoFF/WphrXvdPK0W/AzZUID0eA8PjP5jFb4mkTzm4T
X-Gm-Message-State: AOJu0YwlfDEIdnAAM918d8SDuzxCtG03X4oP5g7ckOJmqmROzZbCuBZU
	osUbxJlMvF/rQccq4LZ0RqEyUgM5Vubi1GXnHX3cm+MHixQNvEXmTJd3/CIn9Rs=
X-Google-Smtp-Source: AGHT+IFv9y8xJmg8vyenO4cu3YWChH5bcQzke4eNsa1YJO6Z2ciuRugVmRYh32oJHG0tFBkXehpvbQ==
X-Received: by 2002:adf:e60d:0:b0:346:f830:8a5a with SMTP id p13-20020adfe60d000000b00346f8308a5amr1520817wrm.5.1713442124561;
        Thu, 18 Apr 2024 05:08:44 -0700 (PDT)
Received: from linaro.org ([62.231.100.236])
        by smtp.gmail.com with ESMTPSA id m10-20020a5d4a0a000000b0033e45930f35sm1702163wrq.6.2024.04.18.05.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:08:44 -0700 (PDT)
Date: Thu, 18 Apr 2024 15:08:42 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: dispcc-x1e80100: Drop the reconfiguring of
 PLL0 on probe
Message-ID: <ZiENSp4nrLNHlAoZ@linaro.org>
References: <20240418-x1e80100-dispcc-drop-pll0-reconfigure-v1-1-453e4e70e940@linaro.org>
 <e5c60b6f-3cab-4265-87fc-7eeab03795ec@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c60b6f-3cab-4265-87fc-7eeab03795ec@linaro.org>

On 24-04-18 13:33:19, Konrad Dybcio wrote:
> On 18.04.2024 12:51 PM, Abel Vesa wrote:
> > Currently, PLL0 is configured by the bootloader is the parent of the
> > mdp_clk_src. Reconfiguring it on probe leaves the PLL0 in "stand-by"
> > state (unlocked), which will trigger RCG child clocks to not update
> > their config,
> 
> Sounds like this is the problem that should be fixed instead.
> 
>  which then breaks eDP on all x1e80100 boards. So rely
> > on the bootloader for now. Drop the config values as well. Also add
> > a comment to explain why the PLL0 is not configured alongside PLL1.
> > 
> > Fixes: ee3f0739035f ("clk: qcom: Add dispcc clock driver for x1e80100")
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> 
> This works, because you have (at least) partially configured hardware, but
> we shouldn't assume this to be the case.

OK, I think we should be safe to follow trion's approach instead then.

https://lore.kernel.org/all/20211123162508.153711-1-bjorn.andersson@linaro.org/

> 
> Konrad

