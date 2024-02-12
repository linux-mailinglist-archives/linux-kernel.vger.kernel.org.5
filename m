Return-Path: <linux-kernel+bounces-61852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FAA85176E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB38BB24897
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002F53BB31;
	Mon, 12 Feb 2024 14:57:36 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD723B782;
	Mon, 12 Feb 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749855; cv=none; b=SKjYt1M0E8CZEc7iBCNJao1Dr5bdhhFPJme6nDTPEGw8wim9wh69kzW+S6RNM9Os1QoUiybiLe57N1/bu8tXFFRzEJNxai8xiDZCc9uCepcdYDh3rkunhqhUyjNYd+Tgyvd79/BB0hzVqKuEUDPOXltdxqzox6PWKTeVnj3ixFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749855; c=relaxed/simple;
	bh=dB6h7vjL83xsxisp6w5d1sjXMpb1xlAf6QjbQZNLPNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJ2PxUUId5dpTHjt09jRZRW+ZYdIudIkMt3bvzcKooF2BIfeOd/PtDjhKeU9NimDu+JDtbcANnmSqgW7mkeH+Nvitb4vVF0RqYBeHVHML1uKGsCt/iwpjY2rrmwykyde6q7VJ6ypOZynxefiH85xFfNa8NmFI++RBSrQ8Owt8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e2e74e34a7so15735a34.1;
        Mon, 12 Feb 2024 06:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707749853; x=1708354653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoJgXTdG93XMCXcdtwqy8JUV2GOmXd3e2IuGvT55Kog=;
        b=TUf415e5hhybLfRZiTSy7xs1gaG9tlW5aU0nSFalMeM+Q/U8Bd+L6c5lyGK2lN7AyF
         mHBifHOBSlySRGIln5NwcHFQdA1AA8SMao90rbRz+Lw3KrHJTS89W3kFzkXlQijJ2Rm5
         bVfHskhIzr8vWvR+pds5PucebyEw8u8IrgkpjhslXyq4a1WrbOYDwGMMyHNppwYUlKLG
         sAmVkK8kf7KalS15VkMc+pnCa9WTcGgZlM/uKu1wFK9LoQ91XW7WIbLmDiFrC1NJgeJg
         1baz0M1O2KRU5HkMwmBG51mSSeur7tl71To4tS8A45Ycv97sivj8Feq09wxJGw4NTUJc
         S1Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXiQhbJ75QlPV9d0xFPGJbqqqzf/i4ffDHPYfTmkBCbl0Dj8kzT9L1RoRcLOm0SN9JDCotfTDqgBQqwoGeAcmgREY+n79nhi88CSPj5Lbg3JEefp0QmOH3fZgRRPNvIlUDUfIiGIMs=
X-Gm-Message-State: AOJu0YyfhR37YB4pZqFoquLxyzmwlxVT99yzGVACYMpFYYyuElYj4e/r
	zemlmKbEpJQSBaLH1aqbKA0nobOEe2rt/Y10YkDJMdTrMfbQRGYEKSw3ZrHzJk4HsJFReVzJ80h
	HQoIwsmZweLL2ZtzT7HWXuftcagQ=
X-Google-Smtp-Source: AGHT+IGZyCv9xBolB0ZZzsJS3NKRaugRZdOdRxfO04espInS7VgyDrePxjvrQB0cqpt140aNEefh6SV/6bmblcWD+Pc=
X-Received: by 2002:a4a:ca0d:0:b0:599:e8ff:66d9 with SMTP id
 w13-20020a4aca0d000000b00599e8ff66d9mr5112472ooq.1.1707749852925; Mon, 12 Feb
 2024 06:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4a043533-009f-4db9-b107-c8374be28d2b@samsung.com>
 <CAJZ5v0hDmwaFEtLc8yDc4cXn2wODXAqATe0+_Hpm9QPODUPMQw@mail.gmail.com>
 <ZcOyW_Q1FC35oxob@slm.duckdns.org> <2f125955-8c7c-465c-938c-8768f7ca360b@samsung.com>
 <ZcPSuUBoL_EDvcTF@slm.duckdns.org> <ZcPelerpp3Rr5YFW@slm.duckdns.org>
 <b4ceab79-3208-419b-9a79-f34540db3f70@samsung.com> <CGME20240207213600eucas1p1615e189e07dd1e96b001c7a187854fce@eucas1p1.samsung.com>
 <ZcP3uiapKGZqw0q5@slm.duckdns.org> <8c468452-1b00-438a-b634-eeccc35d9a41@samsung.com>
 <ZcVvxbKOlrWmmyhS@slm.duckdns.org>
In-Reply-To: <ZcVvxbKOlrWmmyhS@slm.duckdns.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 15:57:21 +0100
Message-ID: <CAJZ5v0iLZ_U92q_Jt-91StZhUPdeZRD05MpDLxmaGaAa2-v1KQ@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume optimization
To: Tejun Heo <tj@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 9, 2024 at 1:20=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Feb 08, 2024 at 08:47:12AM +0100, Marek Szyprowski wrote:
> > I've tried to get drgn running on the test target, but then I've notice=
d
> > that it is not possible to run it on ARM 32bit target, as it requires
> > PROC_KCORE support, which is 'Visible if: PROC_FS [=3Dy] && MMU [=3Dy] =
&&
> > !ARM [=3Dy]' for some reasons.
>
> Bummer. I instrumented code on my test setup (x86) and couldn't repro usa=
ge
> of the dfl_pwq, unfortuantely.

On x86 there are fewer device links representing dependencies between
devices, because it doesn't use fw_devlink which is used on ARM
platforms (and other DT-based), so on x86 it is less likely to
reproduce this.

> Independent of understanding what's going on with the system_unbound_wq, =
the
> correct solution seems like using a dedicated workqueue with raised
> min_active. Just posted the patchset to do that:
>
>   http://lkml.kernel.org/r/ZcVtzJvJCRV5OLM-@slm.duckdns.org

LGTM, thanks!

