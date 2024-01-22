Return-Path: <linux-kernel+bounces-32937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A838D83622E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC111C24D97
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544D83C495;
	Mon, 22 Jan 2024 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9zFhEFR"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FF13B190
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923337; cv=none; b=LlrRzY7LKIPwLTjf9FNTKskrE8pP07OGUCbkUCFwdFLnDjlcMpvGBFQtAcZ7HDAtg+HuXLMiwta0C6NRZVj4gekNUV59z2DznrebeabqMh3NBtIxah8kaTk8z257+rfwI27JsIVKYzg8apY2cjnQ7oaQy32oEso3XHKWiaTP9sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923337; c=relaxed/simple;
	bh=MKhp81vARlwnJymH/8tghIShD/bDEWbnCKTlx0FV08M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kn2Vy6biWRgEaUaNCs5hozJvxGt0ug7QW9TmkSaDUnyVqmsHUs6Q0+48hpiT4UC+bGO4KzzsLfeSHnuZ0fGhQGznEX4nFaY7vLPQDx4cV+PGHbqUQXbOAJicO/pdIBMyBcs2tERgYOEgiJuSRoxFXUh2EXaZvIWbPI3fiTJ7sjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x9zFhEFR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4298e866cd6so26924431cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705923334; x=1706528134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp69NjIciMowFkuRsLGhE3n0Q0pkwwaucBTFCSL5onM=;
        b=x9zFhEFROzvkm4Ru5Gq13L0nJXA3FyGCSifSUNwwzeKxL1CE0aPaJIIpICDzIuB/hO
         whqIU4Mn2Wt6/ug5QsG/TYXHaA34+SWf/gJ9oHzUf5+V2Z+SkSTEBBfcH84ToxFudQ3I
         E7fNVnwm+6Aa5qNjIixW/eWiPklIHOEEbPYWIoY21nrtbBX53fdkoTST3PTQoh3k2X/r
         eSj994rm94QIYd86EYFw3Bps40KfGrodioWbegUtzH2uP4sMQWoRgSmkvggRhmZk9jiW
         EaUjxWPHeyQhDwKg/VOOd7oqCOgAaKXM5OvWn8Yb9zN8Yaxp3kIBBFXN3O5VRoHi96Hv
         qp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705923334; x=1706528134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zp69NjIciMowFkuRsLGhE3n0Q0pkwwaucBTFCSL5onM=;
        b=eSnyAfDRc20W4w2ap9jbrIJfrgmyL4PMMJISMQc2tfmehnI9mfZFW7or+/yrOe+UiD
         zZrd3nNtt+hXSgIAi5G/N/4vUDeRjmRWZosINKR6RV2K+4whxwiZYwcDhni6jJ5jjn/c
         gAk2UjUo3fF4Q/HyxJOs0Nrb5sExvVnsEb/+ap2EELi9UNJxTv7igkhQBt4t9ZVE9cUj
         zi1WttrUsKV7gitrogI/am1WFtmmh2mMZV1tDn8z2kY3SRU2qqIisTTqe1CyGC73Y2Ls
         HsiW0TlFLyC7/tjdt2ccIidrAQFSg2VV/qJQa+D1rWG6Zeo37tYIVGDJdFFEMYx2pquk
         bk0Q==
X-Gm-Message-State: AOJu0YwD2xVyNs82mpF3VZvw+9dNKEhjTO3ucrVtY6llGpD2wqlsTHRZ
	43ZjysklvZ8RMaYmcTif+baknTKdEMFjAParod9tLzfOBWCOI11meoF/KvT69P/INfcIimdW+ct
	M88IrvtCa3dN9VrWGYi1zRI8CUru/KtMqcXLoew==
X-Google-Smtp-Source: AGHT+IFfbt1twZUvmT8z7VGChIkCgPKQHHxqBGrS63BoCbyR/vAH+owtPtC2Qv6lTuo0zS3m2FS7umRwUXkd5pMbv8Q=
X-Received: by 2002:ad4:5baa:0:b0:686:94cf:d742 with SMTP id
 10-20020ad45baa000000b0068694cfd742mr792478qvq.122.1705923333904; Mon, 22 Jan
 2024 03:35:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222165355.1462740-1-peter.griffin@linaro.org>
 <20231222165355.1462740-2-peter.griffin@linaro.org> <4cc6df4c-504c-499f-be83-3b40d1ee6240@linaro.org>
 <CADrjBPo6YqxDAKUe629Z3e0MtmEgyTqEzVLLc1bZ8xJe_dw5SQ@mail.gmail.com> <f4901720-9df8-4433-976a-47d60da49f69@linaro.org>
In-Reply-To: <f4901720-9df8-4433-976a-47d60da49f69@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 22 Jan 2024 11:35:20 +0000
Message-ID: <CADrjBPrPjkiPCxLj2D4YVXxGuSinWtzQO0CkDM5-5scd_Nx5ng@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: timer: exynos4210-mct: Add
 google,gs101-mct compatible
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	daniel.lezcano@linaro.org, tglx@linutronix.de, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
	semen.protsenko@linaro.org, saravanak@google.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Mon, 22 Jan 2024 at 11:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/01/2024 12:19, Peter Griffin wrote:
> > Hi Krzysztof,
> >
> > On Mon, 22 Jan 2024 at 11:00, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 22/12/2023 17:53, Peter Griffin wrote:
> >>> Add dedicated google,gs101-mct compatible to the dt-schema for
> >>> representing mct timer of the Google Tensor gs101 SoC.
> >>>
> >>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> >>> ---
> >>>  .../devicetree/bindings/timer/samsung,exynos4210-mct.yaml       | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>
> >> I applied remaining two patches. Let me know if I should grab this.
> >
> > If you have applied
> >   clk: samsung: gs101: register cmu_misc clocks early
> >   arm64: dts: exynos: gs101: define Multi Core Timer (MCT) node
> >
> > then if you can also take this one that would be great.
>
> I know that you want it, but what I meant:
> If Daniel acks it or if Daniel does not take it in some reasonable time,
> ping me. Reasonable time starts from rc1 :)

Right I see, thanks :)

Peter.

