Return-Path: <linux-kernel+bounces-68634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49930857D90
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964721F22477
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1952D129A80;
	Fri, 16 Feb 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="D5B7Hw53"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340554745
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089676; cv=none; b=YRC/xUytLhYPvz8GEVqa47pWb2hBkBs0yKx+T4V/ai4wowrhUvuT3PwFj6xeaWPvsWUjcvMxd+eHPFXdWVEBe7phmG4kVTcM2tdAbVbI5ip2Otw36xKvicPo/hDel65g4w/7GErFQOdJtSQ5GfT57XgbUU9JBLRgJ2X0yGKGdk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089676; c=relaxed/simple;
	bh=udSul/eRgtJRJ6ARIbkr4NL1MgBVE7MGsgqQqJxfgPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOBHjFEbgdHXsI5gZePBz2ecOM6lALcMUDnDo1xpPmOqb+RA76f9ggNumAbcJb5psox8ECY890g6rr8rWR9x77WMOmbox5TEDmXx1pEUWAxPJPOL0eTKkzb5Vap7S0zLKmeWNz24lSs2MLaI1Li0puYvGTljVXaPdvn2NmpReD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=D5B7Hw53; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4c020f519f7so247216e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708089673; x=1708694473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udSul/eRgtJRJ6ARIbkr4NL1MgBVE7MGsgqQqJxfgPQ=;
        b=D5B7Hw532AoRkHriohZsnR4IMiOIUAhHjtXgwZuz/OGSpug3sPxDMwt0zCJQ73De9/
         3ZzyAjTphlZh01tivRvDu490p9jK5s1z3gV/3esaABUqeEqebcFvRAr6dJBgCkgDDSI2
         VlnG+a70e1m/E1fxhA1NVoL13AJtaIncnWuxRvter5Nv7BvFL68MTmS5dfQ+R5oysXdB
         AOKHSthxdmpLZfFfjAGI2PXkpoPnVS4fD+GLNcWzME5JC50LfvlF1PlXRQuPTTFxiYPF
         PzT0rlfg9UO0T+4f5UyZDoXMDJgf/Z9EpIvpelf2xzm47aS1Hu3fO2NtqCXus/fDBAik
         tnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708089673; x=1708694473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udSul/eRgtJRJ6ARIbkr4NL1MgBVE7MGsgqQqJxfgPQ=;
        b=rcXUiNOlqtv9oOy7uufgf5MCmfSoLt0bJKkpUjfp8wUhoXo8A/w+NpzoAIw0aadBx6
         JLt9brj9RgD2+nmLytXxhcUpV3vW1TYDy8uERDCsUkJRXroY60zMgElsHRHFenxdV+u9
         5tVq/SmYwbi8HC/CPXSXoOrd3+rdJQx1huwdDTLeDg4KbznXT1LzHo2Clnx0E8bR99va
         9ZSTX3YEEi+Zdp9dvIyCuLeID4odlEhnmM2IvYqm9+AgzYxaOmTT3NmemcOy7XCK7iRD
         ayIpX9mMnTNiQ2QkphHSMY8n57G6jPCpqrdxDVx5bikOdeLwlGsllUArgWLGPPu3sIhD
         IEDg==
X-Forwarded-Encrypted: i=1; AJvYcCUxccUvxtRRTBo/KLaV6+g5gFQGDTrXUE3BSHxaVUfcOQe7I11Omf+QNCnmgWCqf7H4fPu4e0ta9JyDjCkFoWvzBfvpZcj7AyLrMbDv
X-Gm-Message-State: AOJu0YwqrNkl8k1NkYRLHJYf8+hxqqeniGYKZIKopsg3NIK7JckSxlGd
	2cRelkwDjdWoPWd7eWGUA3lv07x2x1b0CbGexFqOC/otchcbXkWGKFeKdCRj3QrMdxy03Eqm2Nx
	8bAJwhNYiIBUg17nW8SmFk1oMsSjYrzAdN1z9SA==
X-Google-Smtp-Source: AGHT+IE6Rs+3kC/mGaITISiSLYMyE7rbdrnqU0kK14bpT+3x+Kt63SJ4/IF4wI+sIkYlYdvl/LaSiYLL/7AvNsnJzIQ=
X-Received: by 2002:a1f:e043:0:b0:4c0:5e95:b9f3 with SMTP id
 x64-20020a1fe043000000b004c05e95b9f3mr4382436vkg.5.1708089673107; Fri, 16 Feb
 2024 05:21:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240216105945eucas1p15af2e143fe2090cd33fabb91ff012571@eucas1p1.samsung.com>
 <20240216105930.16265-1-brgl@bgdev.pl> <1542ef65-508b-45be-ad5c-63ad124cb1a2@samsung.com>
In-Reply-To: <1542ef65-508b-45be-ad5c-63ad124cb1a2@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 16 Feb 2024 14:21:02 +0100
Message-ID: <CAMRc=MdCYp=EPe2Koh4NKvKTUWYZn7TRNKXVG39RLYxRxEsiAw@mail.gmail.com>
Subject: Re: [PATCH] gpio: cdev: fix a NULL-pointer dereference with DEBUG enabled
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Kent Gibson <warthog618@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 1:35=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 16.02.2024 11:59, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We are actually passing the gc pointer to chip_dbg() so we have to
> > srcu_dereference() it.
> >
> > Fixes: 8574b5b47610 ("gpio: cdev: use correct pointer accessors with SR=
CU")
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Closes: https://lore.kernel.org/lkml/179caa10-5f86-4707-8bb0-fe1b316326=
d6@samsung.com/
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks, patch applied.

Bart

[snip]

