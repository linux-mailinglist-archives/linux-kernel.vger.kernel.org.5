Return-Path: <linux-kernel+bounces-3091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B337816744
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1801C222FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E8B79FC;
	Mon, 18 Dec 2023 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHiUM5Wg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B7879D9;
	Mon, 18 Dec 2023 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-203d93b660aso33347fac.2;
        Sun, 17 Dec 2023 23:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702883952; x=1703488752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3psRlmXcavUjlawnzU62rR1l9UyH9mO8Qc/nCsa+TC4=;
        b=JHiUM5WglmgYZ/VMBmZDWfd1RKeqHtWM+C2X36sPXDbXywINZyHGl9H7yUyisZgis3
         Y1L88aG7wLzjoeA3Sf0IAlnfKb+WxslSOiFBmpoL5MJDkQvLmc/ADNosFRTnmS8mhU9g
         p8jPDs6WMYuobILDIcIuMnqPwSjGJ0Yx+ZDjox9OvyR8VewC4cpO4YF08CQzNzAueqhL
         yTgZ82msm2WgPqSWgOmGp2Xv5HPNR9NBHx1SLI1cAogXRTB2Cs87iw/0s+g7Y4BDOtqy
         qvxxE+n8LPt99xcR7V9LzTxCvO3+NRZog1QnGa3lRcKsJOy5KxK94FV88Dv7LdlXlHu3
         UvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702883952; x=1703488752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3psRlmXcavUjlawnzU62rR1l9UyH9mO8Qc/nCsa+TC4=;
        b=ihVPDolYhaQDBPyh5uLsX5Lk4dyuu+h4KEz5PIALM6I4lopUloUiA5pEN9lXHTzVsJ
         3M8IKRry1f4x8HnZW6dsjTm667zqlmUal9cV6e+eKc9di3Qqj7hZOivjdzUv8/HxGneO
         PutWvGgX/OYCCgXWSXYEqibaa/NfcIsuqNyM9es5PJtzI5Vqux37z3msrTweQ5Pcp0Ie
         cB+1xw8K2x5lokxzIrweBrBCzwu+hWAbs0UH1o1R20FE4CdYmBLAQLELz2AM4eN3oJvz
         6uvwuaOxXexHzLgZPxeVlErkUslGggpPqT7Q7nGljdHnYRPBULq6XkDaltuDH6L2DMLC
         FH9w==
X-Gm-Message-State: AOJu0Yxz1e54xIKzvcbi2aG5SGj8ZfFL755ziZ5N7RKF02urdeKOLSrb
	uIRtugKRM3KKtmXguKrG1cEAiA0cv4AC8+/fD4qAknitheM=
X-Google-Smtp-Source: AGHT+IHti2eGyJH4puKkOt7wvA/AKXJF3FpMvcLaivZ9rYJ7DdoRzEecd7zK8SGMMIjEj2JJuOHgbrlidVWxswhLuRs=
X-Received: by 2002:a05:6871:5a05:b0:1fb:75a:77bb with SMTP id
 on5-20020a0568715a0500b001fb075a77bbmr15703452oac.108.1702883952076; Sun, 17
 Dec 2023 23:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215085630.984892-1-chunyan.zhang@unisoc.com>
 <20231215085630.984892-5-chunyan.zhang@unisoc.com> <fd927698-6aa3-4a6b-988c-fc82663235ca@linaro.org>
 <CAAfSe-tTvxLCAdSCCgEw8HMFaVVfOytoowY_Fb2F0H-vo+cCmA@mail.gmail.com> <4faf78f5-5e57-44a1-8fdd-7b6a33b0bd19@linaro.org>
In-Reply-To: <4faf78f5-5e57-44a1-8fdd-7b6a33b0bd19@linaro.org>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 18 Dec 2023 15:18:35 +0800
Message-ID: <CAAfSe-teE0RnC9fNtEP4dW3d94ud7pxF4wAB71FLik65HjatNQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: sprd: Add support for Unisoc's UMS9620
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Orson Zhai <orsonzhai@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Dec 2023 at 15:00, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 18/12/2023 03:31, Chunyan Zhang wrote:
> > On Fri, 15 Dec 2023 at 18:36, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 15/12/2023 09:56, Chunyan Zhang wrote:
> >>> Add basic support for Unisoc's UMS9620, with this patch,
> >>> the board ums9620-2h10 can run into console.
> >>>
> >>
> >> ...
> >>
> >>> +
> >>> +     soc: soc {
> >>
> >> Are you sure you do not have here W=1 warnings?
> >
> > Do you mean warnings generated by running "make W=1"? I tried just now
> > and didn't see warnings on this dts.
>
> No, I meant `dtbs_check W=1` or W=1 coming from dtc (dtbs).

Yes, I just run "make W=1 dtbs",  also have tried `dtbs_check W=1`,
didn't see warnings on ums9620-2h10.dtb

