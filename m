Return-Path: <linux-kernel+bounces-77897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6315C860BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E3C2841D6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C39171AE;
	Fri, 23 Feb 2024 08:09:06 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53BD171A6;
	Fri, 23 Feb 2024 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675746; cv=none; b=BKtvQWlGNfKTq5z345teYl3HpIyogp5y7QNmEaAsqBDNmbNZzzM6KWWPWN21wZtUdEZXcyn0vhG0l3C6usTtg46peY1E3ALeC3tAwegxd0nK7nuK10Hjw9MThVMUN4msmntuC36cIe19+Gq+4zK/RRm0ZF1ZgQprDCApsGDZyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675746; c=relaxed/simple;
	bh=x4Z8iJUTvCHAJSPx3bQjcgITOz8vru7wF17GpLxAXXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXKQTzvZ6Fwfke3g6meGHyDzQLC61Wp9TjdArj3Nt37ScksvLkDr3TDVAAx2HMf8CEvaSBPO7u/fBCmLIT1xunuaiUHqYNidIjRzvx6nhY01RmJrWb4y2abT3/innf5uTeL4IPvPlYe4++hmtpYIIA4AYZfZXd+rxYz2bmn6xUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-607e54b6cf5so4439107b3.0;
        Fri, 23 Feb 2024 00:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708675743; x=1709280543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kludw4BgZdLrgKj6VEs8WxDOdofv5GxlNAtTzZazTjU=;
        b=LqUEC4bxJvZxXPWPZMF2KciW6Q5T8cNUCJufaP/RUBXjZhOnFAVuO2iIN3sgLjfEV5
         bC/vttEw4jWC4ExXbnJPXOyjFvh97hVJNBYmOVCxFma2Gpb91S9gqQYIKzVm024bj0WP
         gsetMGW+H59Gmt5QeJX8etCl+SUOCh+kuhs4tNx85kTRfU8KLbc6jwwD43+8USJtNZip
         0nNKqwNuFze62S/wD/fB87mQ8J43K+ahVchrx2ZjbUmHuR/7yyBIJ/CUcJUDRucKD2Tk
         6ny/hK3smRZMu+bv7b6UhLu4Kni6406CNljs5/4IIbEuLAXZZ/PGKElZWsvEdEHwn5Cn
         vhuA==
X-Forwarded-Encrypted: i=1; AJvYcCUWKYBGufwvQSKsS+oUCcrg+iLlOrNb+ebH3/TjuG+l88u5QUEIRu5UYO5gPWznUMZMHHvUPsmtf+PmqVfMm/U+howpXkyYpiF2Ne4gOVYqjt+k8rxS2dsd+1lM+k12KR7qbMENOUs6Zw==
X-Gm-Message-State: AOJu0Ywj51wU1RUYmEPphABKh6DX7dg0wmQIARdKkvNyi1hTgQ/3yct0
	qlsLpPbfVEsdKJ4MXDBUY/S0slXjQMJ9tI7dJgK7t0bIm7FPI1pYWuO/hf4dJA4=
X-Google-Smtp-Source: AGHT+IEHPJXOSzPyjjvCJQ9kt9+ynzDgLUfT/lkri70sNuDoow6vcfABvi416VPmbK7RAVqYLBBNEg==
X-Received: by 2002:a81:830f:0:b0:608:b181:49c5 with SMTP id t15-20020a81830f000000b00608b18149c5mr1317787ywf.3.1708675743092;
        Fri, 23 Feb 2024 00:09:03 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id c67-20020a0dda46000000b006042345d3e2sm3457285ywe.141.2024.02.23.00.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 00:09:02 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6087396e405so620247b3.0;
        Fri, 23 Feb 2024 00:09:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWti0w9Qk3nufbH0QjUJaHcLunWlQAm3j7NFbN14vXhSHXDYreS3RUjjD4Mux0nkZHlZ7VJfGlXWIxxHje7wo0rSuuiOpJ35LGLLrbsgb0L9HnvP+uEF4GvOguswHWnmg8+wiODzbPsbw==
X-Received: by 2002:a25:c483:0:b0:dc6:e545:68be with SMTP id
 u125-20020a25c483000000b00dc6e54568bemr2549744ybf.29.1708675742489; Fri, 23
 Feb 2024 00:09:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-b4-bus-v1-0-2803c3ac4673@outlook.com> <20240223-b4-bus-v1-1-2803c3ac4673@outlook.com>
In-Reply-To: <20240223-b4-bus-v1-1-2803c3ac4673@outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Feb 2024 09:08:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX9Xp+GGpXT19jBC2chDuaRD-4c-vE=J6tL-zm6Sps8iw@mail.gmail.com>
Message-ID: <CAMuHMdX9Xp+GGpXT19jBC2chDuaRD-4c-vE=J6tL-zm6Sps8iw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: simple-pm-bus: Add optional resets
To: forbidden405@outlook.com
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 4:49=E2=80=AFAM Yang Xiwen via B4 Relay
<devnull+forbidden405.outlook.com@kernel.org> wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
>
> For some on-soc buses, it is also needed to deassert the resets before
> access. Document it in the binding.
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

