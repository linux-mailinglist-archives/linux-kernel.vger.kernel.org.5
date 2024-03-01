Return-Path: <linux-kernel+bounces-87913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF05086DB00
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40262286654
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917E350278;
	Fri,  1 Mar 2024 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0EmdqVA"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213947F77;
	Fri,  1 Mar 2024 05:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709270503; cv=none; b=tSYPZGqQQ9p44EPHxz/P9rFoQp+Kl/MmYFUrv2UdaZaPLJpEOas4WvKRmsb6bynlAckNZ4X8L9/uOuvfW1RkbLhmViUmgMl4/ykmZ82VM+g4Vr4puUwWam2fjVcff400fdKgVEyXlQwGUuLdlFkGbYgqE/kLIxXKcFtLp6hUlzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709270503; c=relaxed/simple;
	bh=Qj2tLZtZ2MnXE8HeAJjriLlacuwyb0Ao7gC+Tg1zCBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXay/mxVqiWRAvujGW+RAnfmXY1kOQ4+AaqHNsY4OKoA/SoHblFa8oBOfBlJcxWIGV5FKd6CjvAMEln5xKbXI4zFZw8jlR5vdOmdVx9OBhFbwnBoBn/6x4RxhvAFUADCCJWs8rCc10uRkgvrPqN7eW4KEYDXOPFRTSccqOqeVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0EmdqVA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a449c5411e1so6017966b.1;
        Thu, 29 Feb 2024 21:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709270501; x=1709875301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SklaswezKpY2+1y0XS0FlAH9tuUjyIoA0V4YKjlG8BI=;
        b=R0EmdqVAmCJvccPa0sxuP0vi3JwbPcRHtXcu/AXzzN/o1hvB08+55tkibCSwYYA84t
         MbgjKRlz5qrfbZLc+siZ0ggOkcF+WoiaLM4u53VTBkMl31u69li5un4v/SLXtpKrKtpG
         C9CYMb4Sv7Zl6sp1CiWfhw/kZPE6bzZ6kBIhwA/a002qSzWtl7wfsHZfLk0FgSi/jxMO
         IK280lDMxVD5mhspTp4PhHe8yAR1q/52KpFbuIAaLvn1E7nB2mxBU6jkBka3r/AzyyM8
         3VLqkgUV5hQm2NFEQFVt1PeSrPwFQ/xGDuzcY2czLBVl88mfe5JwWkar4TCxMxtOjSMP
         IAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709270501; x=1709875301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SklaswezKpY2+1y0XS0FlAH9tuUjyIoA0V4YKjlG8BI=;
        b=JmwtRnUyOX0tuFCatdj3nelBshwZ7u1D36tBgG3JjtX6s32nMWV6ZL54WleCpqjwhr
         Fp9XVxwu/o0ILOUzc7sRD/gNg1Tmxa1kHld8yuU7S5a4+142+vwEorAoo+jr8ATtuVgD
         Ed8pZ9gsEg/3aTsREFBzUAb8W6ihPstgwmUFncJ8PI5wtBVCe/GDRUHnpb4Be3UtLZ22
         knPygI7Pnnm1o7WG9DbHTCQB/jB7RjyOFe3jCjsjOj3+V/on3xp02xcTyi/DzGj0tyXg
         xnOYZyMWkgO8Re299Ea8VbK4geAJ8V93ZD52JNuToCeNDtpHL8/mmBBAhfZ0meIEVFQS
         QL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTCTfYTl0ifG4LbQA2qaf7hGXDAaOyIQZ98LOLo/GxElLy0urrZwwCAtG75GFdAWGrCGEy0vTrTvImv9VSx3DDfgxkpFTvZTzsNqjwtg2NLPt4EejUf5pyQENHbGwVZsW+Qq/v3nC7Fg==
X-Gm-Message-State: AOJu0YyPqz1RXlaa8FBV+7W8GJCz/nygdPMFlIgW45WdADJZa3fIq8OB
	pEd1Cl/zGrbNuAOy/NnAEduhHC/9bRdsfT+rY2PRuweL2h9tjV80t0fdmtetm5iPLDANMGe54BG
	VobSk0NCS7kXN5BktBpLhd8NwjKU=
X-Google-Smtp-Source: AGHT+IGET3NOaLRRZnH2bw1a3UmEv71dQ2BUqrpAAHnkRq0XM79z2IXN07RFGJg5LqpXTEmuY26raYoc+M7W22Jy3HI=
X-Received: by 2002:a17:906:f989:b0:a44:27e8:f514 with SMTP id
 li9-20020a170906f98900b00a4427e8f514mr407888ejb.38.1709270500676; Thu, 29 Feb
 2024 21:21:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-2-6afe8473a631@gmail.com> <823379825559bb76088c31f44f998dd3@manjaro.org>
In-Reply-To: <823379825559bb76088c31f44f998dd3@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 1 Mar 2024 09:21:30 +0400
Message-ID: <CABjd4YybaQnKm+VpU_xVrCb=pxQ7oQXPHGZzn_u1w_h3yn7gwg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] arm64: dts: rockchip: enable automatic active
 cooling on Rock 5B
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 1:25=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> wr=
ote:
>
> Hello Alexey,
>
> On 2024-02-29 20:26, Alexey Charkov wrote:
> > This links the PWM fan on Radxa Rock 5B as an active cooling device
> > managed automatically by the thermal subsystem, with a target SoC
> > temperature of 65C and a minimum-spin interval from 55C to 65C to
> > ensure airflow when the system gets warm
>
> I'd suggest that you replace "automatic active cooling" with "active
> cooling" in the patch subject.  I know, it may seem like more of the
> unnecessary nitpicking, :) but I hope you'll agree that "automatic"
> is actually redundant there.  It would also make the patch subject
> a bit shorter.
>
> Another option would be to replace "automatic active cooling" with
> "automatic fan control", which may actually be a better choice.
> I'd be happy with whichever one you prefer. :)

Sounds good to me, thanks!

> Otherwise, please feel free to add:
>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Thank you Dragan, much appreciated!

Best regards,
Alexey

