Return-Path: <linux-kernel+bounces-66696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0565585604F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377F71C20886
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04743132473;
	Thu, 15 Feb 2024 10:41:25 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6C12A14C;
	Thu, 15 Feb 2024 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993684; cv=none; b=OJ6GnDtkHsCNeRgXypXG/yw1Dx+aJPTRuxb+i0JKbZbXOlMA+aKrPzdFZmRfO13BZhvAtk3Ih/SrG6Voj99VF3st8vwsCl6EfZmdtfSyFVm62e4AAFges2u7r3qf9qjXZam9iVEl57aDe2UQGW4z8CEvCXtPytz5VMamac+HMto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993684; c=relaxed/simple;
	bh=hJ+JXqdOrEJnX3WT582TNr+VYiHYPK6HQI+HEvWK9t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5tmPXU7LJFVtGSszHFiLMr/TSxoWjDUCsoMj65TCToq07jwcEWwq+fFMUrNWKd5CRtZpWg0qCns76VKp6DnsU/XP0ZqIXLCBtHspGnhPjc3P5AdQgRS9dC/7CnINOOxUXRuxHH55258jGi3TnmciM0ebwuse5kHraRYSDfZu0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-607dca92fcaso2067987b3.1;
        Thu, 15 Feb 2024 02:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707993681; x=1708598481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BYNOg5Hl4Io6X5VDtgJ8P/zozWReiHM8av/Gg63dgE=;
        b=VMLtCooVRK6mG4m2HErNLVX2jpS5NhTL4fGlSkvAcOke9QHUCGRhIAQGYIhYdcsblJ
         O+ayHNA/T25TwHTcwzsCopxDaczl2K1Gz/+dY6nud3dZNWSPXxkGO8seWJPRsk4yhnjJ
         5Fq1/TpblZvjKUFb5p4gEKd1SAJWi8ibkzaSAHSacHSh98p2RCujEo0L6Zj646CIXTab
         8rPWxrCOM9jxIkVhrDw4ZKTHISL2lMsb3/7NmPFr+ZFGGwefpLz0SXZDyYlBOLFCB/nD
         o+GqvkJ56ORSRaegz0esSqrJpZA0FyODMt4Gcr8vz+juaE/OiIA1lfTFTth/QLvcFpy4
         P9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXiXzKqnDoQRvATAeXebTgPVKSJzRiW+cORH8Z6OWPMAUIQq1C2mJWVUR053fipKBozScLO56iHX+RacXS04+LnUNhfI6KVzF5wWGa
X-Gm-Message-State: AOJu0Yyj7SFtae280Jhj1i93QxjetHwpireHPiM4HHe4V29vxDjQ3+9b
	5fbp+CUMN7O5ki0G3VfCqI1+Fh2dS7m3iGR4y20LKw+glMJxfg6xI29mn/rofqzfRw==
X-Google-Smtp-Source: AGHT+IHy211Eq9GaDDfwhv5mamwsT+hrL0Acdei4KfkR+rddVmeXsoGNVEt/hnCNlEo0PZXvNg9V2w==
X-Received: by 2002:a81:8507:0:b0:607:c7b0:302e with SMTP id v7-20020a818507000000b00607c7b0302emr1333340ywf.27.1707993681088;
        Thu, 15 Feb 2024 02:41:21 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id x13-20020a0dd50d000000b00604b1b977b9sm191958ywd.62.2024.02.15.02.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:41:20 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-607bfa4c913so6817867b3.3;
        Thu, 15 Feb 2024 02:41:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUe0LGeOk5yUaUT09KeCKnx4Wo89o0rlHElDX1U9Zey9MaqW8j8JgiABU7MJ+nTrVk3kFmvIRxr18hSlomlGIPwsKL8GBKEc2VvNTkA
X-Received: by 2002:a25:b286:0:b0:dcc:6757:1720 with SMTP id
 k6-20020a25b286000000b00dcc67571720mr1193139ybj.32.1707993680622; Thu, 15 Feb
 2024 02:41:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <20240212170423.2860895-12-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212170423.2860895-12-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 11:41:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVD4VTgwU3KqTZxW0baJ8PzNwW3aU=_nJgWtVK9uhHsvg@mail.gmail.com>
Message-ID: <CAMuHMdVD4VTgwU3KqTZxW0baJ8PzNwW3aU=_nJgWtVK9uhHsvg@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] auxdisplay: ht16k33: Move ht16k33_linedisp_ops down
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> We will need the update functions to be defined before
> ht16k33_linedisp_ops. Move the latter down in the code.
> No functional change intended.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

