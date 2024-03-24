Return-Path: <linux-kernel+bounces-112640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC70C887C5D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDD91C20AD9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18699175B6;
	Sun, 24 Mar 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQdMRJgm"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B4117589
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711277755; cv=none; b=OkkpEkhxS6J3QkvhDNpPLD0LmzJAfjhfEdaSBYpboo5aOVCC9E5VzINPkeYDhESQIZSPCHeDaxgN2Zk7+WCNLjOSO/5edZzGdsIFN/gsac9cWUBhvFxBWEaIZtL3nYI4XNmub/y6YhGVwrwkFckmn/bBBM5myUB+hYM20tBkbsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711277755; c=relaxed/simple;
	bh=DOwSL7mXDyPOAjM0UkBuYKsf3EoBGfoyowiAFlRJIsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwJTr3sNBl2k4QQ/ggNKWVMXSjhg3uOPrfvkTBAMRLHUx3Nl80QjjoAe8G9rZHTyRzjGq0oc+Ys0NNvhAdAYoO5r72ECYrNy+jKdB/kjZAREudooaV5nhUwfDGPXoy+dkePBk5urUSY1T6ywiDqg84cCP5GMPXsjkEe1Kh0QbFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UQdMRJgm; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso3214504276.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 03:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711277753; x=1711882553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOwSL7mXDyPOAjM0UkBuYKsf3EoBGfoyowiAFlRJIsU=;
        b=UQdMRJgmLJHvmCiShSG2dwpgUsED1zrEULD12xEdXiXrANAbNW4siyhRdC7Zlr2T4r
         03tp9Ylc7DxyB+ah8AcTAckckAjeKIUgfRSThIPTPHW17ZgmiXOs19EazWiqlPQnTwQk
         NBUSm+/E8uPlVbQZH23YS+vxY3TNeHRY4V+9BHyzjtbM1igPgWYU5QCEtzZyH2xLWyZi
         B5qAbrDmuME0NC0wfzUdq7iFBJ27+jBgP3AeL7Hy8ASFRWJSOkL3KU+uFycsNNikgRS6
         ggQkCOszC2+LLhUh3vL7qDbOe1N6l3VGrmuqdvuQxHaXxrsZrgngpi+P/gNx95swnCiB
         jrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711277753; x=1711882553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOwSL7mXDyPOAjM0UkBuYKsf3EoBGfoyowiAFlRJIsU=;
        b=sipugXjZtgt9/szGnv7IinRDFW3hwqTSN9EAmFbGUb3SH9Yc3gCI0qeGBsTomUTUx0
         zAdmZ5wuzHHc7zGuiya9p02r+tNwUqm8Fx11O3EfpGwJh3gU71JtY2+G69JGPg/WcNHf
         xZ5zooGGdBaNtzDffuIgIx4zrPIMlCPsvR1wBYErm5MdwdTVWW5VA6LGydcBsekpzsN7
         eLxkHL/3leDujh8xYthNCo283bP76zdAf18vwqYJY28IfdZ7WAmCQvgueDFgD5neGXTA
         SGDKb5AOxKcUrBhUE7SClTin/R+pHiyK6zrg2gqO9wigFN8Rq99WnxiD0kNXiSyhSXnP
         juwg==
X-Forwarded-Encrypted: i=1; AJvYcCWUczCCCdlxGm3VO5zuEUF/nln7vOSntya8H3BOnS8K54y8zVGwrZhjL0ZH6zfn/OOrbljQy2a1b4zrFp0n1cKIyHga5Lvu+ZdtLmcl
X-Gm-Message-State: AOJu0YzW+Lvy7Olnb/GlYh6yoSDB26KrDoHK9dfa8q9ebYE5StU6I0wZ
	sEc+D1Ne7iOGzJdeZR5GJzgLP5kC7MYDv87q8GP2yXd17fMV2xVqW1lDlVJtXaCcOUz7qmMppSG
	LDs4mos/za8yO7oOdL2t/IWJC1KTjuV9UWJVbgQ==
X-Google-Smtp-Source: AGHT+IExyKjpZseSV1kpJ7RcBkKqU6Q57JVG4+6PiFJV0gPMfZO9nn0Edo5Fex/bx491hEBPiYAPOfEi0VViYT9ql54=
X-Received: by 2002:a5b:181:0:b0:dce:2e9:a637 with SMTP id r1-20020a5b0181000000b00dce02e9a637mr2807424ybl.20.1711277752811;
 Sun, 24 Mar 2024 03:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com>
 <20240321-apss-ipq-pll-cleanup-v2-3-201f3cf79fd4@gmail.com>
 <CAA8EJprr4E1CM4f+eBzdRN41nm33xY-hRPQDn3peR94vLyJsYQ@mail.gmail.com>
 <ca4d85f1-397e-4c43-8548-436b9238e85e@gmail.com> <CAA8EJpp9jyCHgMSEBMumSz7xXUkMRm3wapjUdjzeOuJSpH5g5w@mail.gmail.com>
 <a34f1ab4-e505-4281-9a8f-b72c62beed5d@gmail.com>
In-Reply-To: <a34f1ab4-e505-4281-9a8f-b72c62beed5d@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 24 Mar 2024 12:55:41 +0200
Message-ID: <CAA8EJpqDzKnwuHVwKpKURELB+fnGFEB221z+pOSYypCUy2MwuA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] clk: qcom: apss-ipq-pll: remove 'pll_type' field
 from struct 'apss_pll_data'
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 24 Mar 2024 at 09:29, Gabor Juhos <j4g8y7@gmail.com> wrote:
>
> 2024. 03. 22. 23:33 keltez=C3=A9ssel, Dmitry Baryshkov =C3=ADrta:
>
> ...
>
> >> Although my opinion that it is redundant still stand, but I'm not agai=
nst
> >> keeping the pll_type. However if we keep that, then at least we should=
 use
> >> private enums (IPQ_APSS_PLL_TYPE_* or similar) for that in order to ma=
ke it more
> >> obvious that it means a different thing than the CLK_ALPHA_PLL_TYPE_* =
values.
> >>
> >> This solution would be more acceptable?
> >
> > This looks like a slight overkill, but yes, it is more acceptable. The
> > logic should be type =3D> functions, not the other way around.
> >
> >
>
> If that is overkill, it does not worth the change. I will drop the patch =
and
> send an updated series.

Either way is fine to me.


--=20
With best wishes
Dmitry

