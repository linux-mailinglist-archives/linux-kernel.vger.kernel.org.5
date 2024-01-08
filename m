Return-Path: <linux-kernel+bounces-19201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 910788269B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE8B281B90
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C437C139;
	Mon,  8 Jan 2024 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjMjyi/h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5522511707;
	Mon,  8 Jan 2024 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55719cdc0e1so1653692a12.1;
        Mon, 08 Jan 2024 00:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704703449; x=1705308249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+9Jg5BQ8JEMURJ/pr1DweiURe6hKi7epJYXXDt7ils=;
        b=OjMjyi/hAOgXQa3ydKANgynspXjqte/Wt+jTWHSuq3OuaIrICzQaA4nPy4f45eNXI4
         aghXa7vLs/YCJZEAHO8q4iHWefbSysC9imCS6ReKVrtLaq7Z5ZbR5gQYee/dxh+Gslqw
         OYG3uUDYsjyg3HtRA8cswdtvrj1tGI88fk/AsleL/fDlYKKUMFQK07rcJrStK+lfZdmZ
         a14W/UF8fklEXRgcMiR/lPu2SkbGojRvUKHq7vZ6G0kgB1p7mkJMMbwRywoTGkpnzKHR
         K1qJVptrnJKqcZtjle9Tkgs9g81iQP80UBbWlKHJ30l1j+kgshl7MSPAAun4aLfmdSTI
         ASvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704703449; x=1705308249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+9Jg5BQ8JEMURJ/pr1DweiURe6hKi7epJYXXDt7ils=;
        b=XDx4OMnDHhuNZBTI3747cmS07XDFOXIKCq6Idi3YuOFmdZt4SMeQN3iG2FzvSKLz8I
         vLwfVKOLslMQnYGWHjOvnFDRz9J524EvNVT5XRYhHM9ihWkIJ4RhezSKSUGrxeCIJsSl
         R3F6Jy3fXXXPEDRp1qSolXJzpdDezB5+TZ7Bwx3usU0q9qWcv36AnPKVHDYhvbbTrvHr
         aUcH41nIGHeD9QayK3hWNRWGY0gM5y+CYP/5ppX2IQTmuK7kr1wWv88ZBeY0/hTY+8Va
         oOD2ueiJhhLMYmvvmiZ+yjB7l05EVp+GrdCT+h/9EDw9fpkK7wcZcX7wgTfYllWwgdzj
         aRvg==
X-Gm-Message-State: AOJu0YxEVDmFEpogKf3zkZszQlY4DIbboCdD2XRSp1n57nAdPP8WrHZH
	S92ILxv41mN8n26rnWMr56VTsroDRgiwhfjhfUBDdJxW9kvLhA==
X-Google-Smtp-Source: AGHT+IEE+qvQ/6JJsWRaEgpjGbyMFDbpPtmWY5aS32yvLL+ChLsU5FOTB0/ndsmpPxRh6DeBFuXUm//X2iyjx8c7LMI=
X-Received: by 2002:a17:906:97c7:b0:a2a:767f:29cd with SMTP id
 ef7-20020a17090697c700b00a2a767f29cdmr624303ejb.75.1704703448926; Mon, 08 Jan
 2024 00:44:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105160103.183092-1-ulf.hansson@linaro.org>
In-Reply-To: <20240105160103.183092-1-ulf.hansson@linaro.org>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 8 Jan 2024 10:43:57 +0200
Message-ID: <CAEnQRZB16QDJAqkQaLZ6he8eTQLcWzAFXivYt9Gj3CJns-G-NA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] PM: domains: Add helpers for multi PM domains to
 avoid open-coding
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@arm.com>, Kevin Hilman <khilman@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Stephan Gerhold <stephan@gerhold.net>, Ben Horgan <Ben.Horgan@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-media@vger.kernel.org, Iuliana Prodan <iuliana.prodan@nxp.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 6:02=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> Updates in v2:
>         - Ccing Daniel Baluta and Iuliana Prodan the NXP remoteproc patch=
es to
>         requests help with testing.
>         - Fixed NULL pointer bug in patch1, pointed out by Nikunj.
>         - Added some tested/reviewed-by tags.

Thanks for doing this Ulf. I remember that I've tried introducing the
helpers some time ago
but got side tracked by other tasks.

https://lore.kernel.org/linux-pm/20200624103247.7115-1-daniel.baluta@oss.nx=
p.com/t/

Will review the series and test the remoteproc part this week.

Daniel.

