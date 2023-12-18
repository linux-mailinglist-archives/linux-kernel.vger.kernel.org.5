Return-Path: <linux-kernel+bounces-3104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E946816781
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD6D2816F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3C4D27C;
	Mon, 18 Dec 2023 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl0cXgaq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33A846E;
	Mon, 18 Dec 2023 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2035a859803so1520989fac.3;
        Sun, 17 Dec 2023 23:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702885098; x=1703489898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aXLGxOatVHCtqRMm8lcqO/1yuZWSRr6aLnE/LcBt2pY=;
        b=Jl0cXgaqbi0CrFc+FUm/czcfc7rqu5gtfEvU5YiKA2yMf4+99gdt6CNVcjhPbJhyVI
         +m3iZHxSsRCJCQ2mObJjdv31tlSQ9/CM4hIel7/+7yjOwf58YRL0JczSHjwhTdc/8tuO
         LZ8r4r+qDcpPjFtNZ5SPYiR6LoBxfTYSq91uN9D6iHQ3Lf4lkKC8ao1Nk8/7gp2rpz/Q
         bjvDNbqnAIVxrgxqJcK/Z5qVJgl6Sz4TMNi68VmAPh/l/DZbNxmsOMlKkssQB5l4b1XO
         x2/VHOY64tPsXakt4UyPo2tzJuhsIFtwP1V3KOCL4qPsPVVDdxSH4A+Jgejb0NlOLWdK
         zk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702885098; x=1703489898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXLGxOatVHCtqRMm8lcqO/1yuZWSRr6aLnE/LcBt2pY=;
        b=RFGk5CHH/B4IB4O69o1AKO7y5Y3SADK0tybLp9S7ntiaz8jed2mNHRsED6jNJdEV5N
         YQyv+fxbaZiNnD3FDeMknjoAOs7n1NVECaU+pBSJNfeqjoAfENPuoWI3qwwKM83N28En
         h5LPudHtTXNeabIYWvlkI79BjjfJbLMzVaj8p9+hWuKS5vHITpkBlYr6l1qQWDnVpIK6
         kLbIv+Y3noV5SG5UK4hQKA3/qtr4iQmCsDlxOuS5JIJcH35K2iEUMpGK6xm566iOcSHq
         VmHj9KVMs0hoCnXSjxmXdEFpN3cFRXt09Z5ldHD7Y6chXZzp8ybypYoF6dkYL09+a34T
         47Pg==
X-Gm-Message-State: AOJu0YxlXnBAd4d5RTOm8jtr4miLPMhBQ261AYZu81K7KfwMOx6YWr3x
	sgw/wLMfgZmeWywjhPureijha6BEh5GiX9s9ev4=
X-Google-Smtp-Source: AGHT+IEtCzylacwE+6dDhg45zIb7YKNnZO/L6m6ignluS9ypdbXWJm2hmwHaOOYBqj46JvGlzmn9HeOu56671/5FYSI=
X-Received: by 2002:a05:6870:6714:b0:203:7923:bf6 with SMTP id
 gb20-20020a056870671400b0020379230bf6mr5169547oab.14.1702885098038; Sun, 17
 Dec 2023 23:38:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215085630.984892-1-chunyan.zhang@unisoc.com>
 <20231215085630.984892-5-chunyan.zhang@unisoc.com> <fd927698-6aa3-4a6b-988c-fc82663235ca@linaro.org>
 <CAAfSe-tTvxLCAdSCCgEw8HMFaVVfOytoowY_Fb2F0H-vo+cCmA@mail.gmail.com>
 <4faf78f5-5e57-44a1-8fdd-7b6a33b0bd19@linaro.org> <CAAfSe-teE0RnC9fNtEP4dW3d94ud7pxF4wAB71FLik65HjatNQ@mail.gmail.com>
 <7ea2e47a-59fe-43ff-89ae-4a870c754e2f@linaro.org>
In-Reply-To: <7ea2e47a-59fe-43ff-89ae-4a870c754e2f@linaro.org>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 18 Dec 2023 15:37:41 +0800
Message-ID: <CAAfSe-uAczP0AmQFF3=LmfhtZZ45h-BS1BJrPkNu0MgZkSGLBw@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: sprd: Add support for Unisoc's UMS9620
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Orson Zhai <orsonzhai@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Dec 2023 at 15:31, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 18/12/2023 08:18, Chunyan Zhang wrote:
> > On Mon, 18 Dec 2023 at 15:00, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 18/12/2023 03:31, Chunyan Zhang wrote:
> >>> On Fri, 15 Dec 2023 at 18:36, Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 15/12/2023 09:56, Chunyan Zhang wrote:
> >>>>> Add basic support for Unisoc's UMS9620, with this patch,
> >>>>> the board ums9620-2h10 can run into console.
> >>>>>
> >>>>
> >>>> ...
> >>>>
> >>>>> +
> >>>>> +     soc: soc {
> >>>>
> >>>> Are you sure you do not have here W=1 warnings?
> >>>
> >>> Do you mean warnings generated by running "make W=1"? I tried just now
> >>> and didn't see warnings on this dts.
> >>
> >> No, I meant `dtbs_check W=1` or W=1 coming from dtc (dtbs).
> >
> > Yes, I just run "make W=1 dtbs",  also have tried `dtbs_check W=1`,
> > didn't see warnings on ums9620-2h10.dtb
>
> Ah, because it does not even compile!

The patch was generated from a middle commit (that was my mistake of course).

But I've fixed the issue. I ran the command just now according to your
comments, and didn't see the warnings on this dtb.

If I'm missing something, please correct me.

Thanks,
Chunyan

