Return-Path: <linux-kernel+bounces-157853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4238B1753
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A6828257C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9BD16F269;
	Wed, 24 Apr 2024 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gAc/Ji1T"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA0616F0DD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002133; cv=none; b=NV218eoZ3d3+d0mQbwTwMM+XQohqaAFWZkvJglTM0CJmCxmCm7RpekBziGPTosnh/HgxqqHVFtIUklTZ9/PwyC9GvBRW97xyEbsKcoHbDWsYgZtSM8QZ6AOMNuNE/rbMeIo2nKwt0mr+G4UvJ9ShXOJYZcQxfa/hD+/NHZSh9Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002133; c=relaxed/simple;
	bh=PI+JeQg21yVOePuaS0Iw7b/7W79QBq8ROcxLJNdsIlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I38fEbBJW2hFa6ejCYENmelHzOMqLe9iBK1Bj19m27BJKQEjuvJy7jyhfrWEvokDovOzCMIXWHZ28neRCJNXWT0nqtnrH7x47/J/mJBewPp4swYzyj5qVjvpjFqSE9uwXtcC6s7/m6p972VyrU6CPny1i86rwh/HqALl2IWN/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gAc/Ji1T; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso515307276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714002130; x=1714606930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3di6KRuk2RHSbdtvrUmozSSvs5i2WcfXE6+Fo0L3m8=;
        b=gAc/Ji1TR7JadObuMUESXqzZx/R9pYFyDyHNTd3em+uf9PVzR/EhWXaR+C6yX3+ev5
         gSuJZIItZu0pVHWHtY+5Jylrye3ORAuWPBv7Djlv/ph3ATrmlbDrxeL5drmtg7o+WsKT
         4zkcd/oeWIQqmLx+bDlrwdpQF2f7of78zwPnB/VwMa5eiGs0YJEIJ8rrhc+/9SS0dbFc
         rMHL2hhzI+9JjqmHid4TLreic+X9VG8Dfv6hMUxcPXeg7rCRHIf51f3mS8WRJxrdzgqF
         e+RO64ncTpeK8SjJ8O8zKcvChhV/PvYOHZJsfiD6x9Gd48sd/Nw7OfoUqU7TGUYPTUXb
         M5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714002130; x=1714606930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3di6KRuk2RHSbdtvrUmozSSvs5i2WcfXE6+Fo0L3m8=;
        b=ooC7mhjsT1T/bEDywA7855pw1lFjbMJJG0dCsn9KZZWWxOVjH5QsGZit+9+OwVCIv5
         m6MpxzGCK87LAdbnUofyY01Md/fi80nprqfdRQcd9FLoVmhONki3w4k385wzsTor58vZ
         67egPVpL2hn+tS1RexKVQROI5qMur02dx/mBURuMVSGoRkCscCa5Wp8LSkrbsXWfuHDx
         mLuJNqOsIS0wBN28k27pHdSGSC2uEJuPeW5OScDj5n7j2235Sva0Z4Fmz6CDvdBzMV9T
         MaAqKjrkrlJdfqOQuQQBmQqdNtlRPn7vtkQLmUCdLNguQfwXy9AdWERJmTHHaiLuyCTx
         UvrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Tuz4qn1QGgT+40z39BkG+u4ArCvilGjLBRdxr5zu+Vg3ESJwFpJ2l1mXss1GeWvdwT6lE6BNM/lt1GneWcfvfCA6cqbcnUAWvfUP
X-Gm-Message-State: AOJu0YxvbA5NYTqAkZKkH434uBuPsrARgBt3q8aLTdOdd0j85MoEwcAE
	lFomt46BqUiR1NUUNNBA4cjE0+h3HGe5KnKWgoXviy9G+oNc1PJCx7dldpoGusXeS5KqG8HpBsO
	IKomw4jupLtpSAdaYjCl2rz06yrktHjtlLCZBVg==
X-Google-Smtp-Source: AGHT+IFNoEoWuTCW+J4r60ygLSWMpFSH9Zo3V9Aq2hPRxkt1QB/fN+kZPsxejKNUHrSBHusjPdMi8tBWqcJwR5uPFYI=
X-Received: by 2002:a05:6902:526:b0:dc6:ff12:13d7 with SMTP id
 y6-20020a056902052600b00dc6ff1213d7mr3280481ybs.60.1714002129912; Wed, 24 Apr
 2024 16:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424101503.635364-1-quic_tengfan@quicinc.com> <20240424101503.635364-3-quic_tengfan@quicinc.com>
In-Reply-To: <20240424101503.635364-3-quic_tengfan@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Apr 2024 02:41:59 +0300
Message-ID: <CAA8EJpqGub3LuFPbwcA-MTYN2kY=94YXe=T3-mewYzxgcF-ZMQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm4450: Add cpufreq support
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 13:16, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>
> Add a description of a SM4450 cpufreq-epss controller and references to
> it from CPU nodes.
>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm4450.dtsi | 29 ++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

With the next patch being squashed in:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

