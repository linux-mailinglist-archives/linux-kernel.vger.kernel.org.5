Return-Path: <linux-kernel+bounces-80193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB4A862B9F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AB8CB21990
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3CF1CA83;
	Sun, 25 Feb 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TtA5/lQG"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A617BBD
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708877475; cv=none; b=a6S+Lf2jlT7Bvo+5Jrzilu/ZPCuGQl19X6o1kRfl5YRm2Gq2jFas/ky6D2b6m5qanUdsJUYeTMabMUPCWpBLWf+R1Id/dumQyGS8xmd8MdYb8aT7VSpsXCG/lDAVRG4tLQy04pZ7ILUfpRWaWninyAgAfT8cql8rj4EW7Yp0Gt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708877475; c=relaxed/simple;
	bh=u8Qpi5YiOy9kRaDr0ChX2/pXA1mqNLtMkVDkNl61WfQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L45FdIZIID6cQhOks8uPKdFywtmn37rRARinm/VG13Bag002wESC+G29SxJCWdJ2d5mSlzDPUWGO8/x+KOYrZsc7WjywHM3opoq1jx8r6zN9I9TKsygm+JHRjRDaSmedYHEh8OdJVf7EEkN1N44eVytsbwFXxoF3iiVdd0VdMo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TtA5/lQG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso31898451fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 08:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708877470; x=1709482270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REeTwuyBteq5+THLDDm+N0sqW9JR2kC2T9JOUPzqTZQ=;
        b=TtA5/lQGRL/UROVJ/pSLyqTWZi8F3bCyMVnVhz0pnCGV0BUoPx/ggCNfqn8pXwM7jb
         dxUTXzK/LD3lammTvA+qWT1h4m8gKZ+rlQQVZ+4HRMMIbgkbbKZTn/k/ECxI1FMFHYdt
         gzKPLI9brf9nH0wzc/HgWlVte7iXafghvuYVikVjJ48MNleEcBGpLBEg4xy/A6VFbua6
         FZV35UhnmwMZDj757//pwHTUcynXcO6oGYhA33GMj3kX3eqk5/btyzuNixEKXO1WFSlc
         dhTk7fqPGQrDMEVaRvdmTr3MTAmo+jylzAwRRk4D4N1+0bTC3Ca8mcGrlz8nzatVRKVB
         TT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708877470; x=1709482270;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REeTwuyBteq5+THLDDm+N0sqW9JR2kC2T9JOUPzqTZQ=;
        b=MAGGTPjOgEaspHwaiD0rcr4LhUE092v8aZn6HfkOO1BOcHC2V4wF3iPbbZUxpFouoe
         l/lsIyQSVM4tVhZYj+x4SdkURsI/08ZsiVrTcYOYK+RIVGOYkSRzrOyIZuilu0Wy7wRm
         Vv/Fg896D9IK7qCktmkZ5kEk3x8PBcvbVSwY9BsxxkpH/BTQv8ZL1g+oLATo1xnCC91A
         TvBxM8tiWQ4nNZmj9f7x9M1jK6pD5BZgFeURnJQO4dhQXBUCubBdM7gJBKMhcKuTPuLh
         jDo+jv88dxJcMAZecAsfkGyLy6mCtCxMSRGL8UvqhNPfpTL90RL8+64ZqYH5r1q4JUQG
         l9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtjTyL97fsIfIiwxVc31HhmuKGqk9dHjLwM+P2w7tv4V6Jz71GuCNR9paFTw/ZJmzY/O04M+wvDgvHkJ58NAwn63hypH4Jf7aTtTIj
X-Gm-Message-State: AOJu0YwGHeUyOH9ce5TpNqoAdyvB3QLCj1EaEvRHOmKthtBs0SijR35l
	817ZQwpkYiPPRe6IzS1Ex2qOoNJ1V4+r44fZpC+P4OCde4NazTRGoIguoByxfmY=
X-Google-Smtp-Source: AGHT+IH5ysbPnEAR4gSNi9Y8xJXQNzwoFma6m8b1/S0CcoLGSmBaXXI9IRTtAoynqulT2fdbH///4g==
X-Received: by 2002:a2e:b170:0:b0:2d2:4cb2:59e4 with SMTP id a16-20020a2eb170000000b002d24cb259e4mr2790327ljm.31.1708877470466;
        Sun, 25 Feb 2024 08:11:10 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id n21-20020a2e7215000000b002d2697570fcsm579184ljc.93.2024.02.25.08.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:11:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240224202053.25313-11-semen.protsenko@linaro.org>
References: <20240224202053.25313-1-semen.protsenko@linaro.org>
 <20240224202053.25313-11-semen.protsenko@linaro.org>
Subject: Re: (subset) [PATCH v3 10/15] clk: samsung: Keep register offsets
 in chip specific structure
Message-Id: <170887746854.215710.5270227845876951742.b4-ty@linaro.org>
Date: Sun, 25 Feb 2024 17:11:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Sat, 24 Feb 2024 14:20:48 -0600, Sam Protsenko wrote:
> Abstract CPU clock registers by keeping their offsets in a dedicated
> chip specific structure to accommodate for oncoming Exynos850 support,
> which has different offsets for cluster 0 and cluster 1. This rework
> also makes it possible to use exynos_set_safe_div() for all chips, so
> exynos5433_set_safe_div() is removed here to reduce the code
> duplication. The ".regs" field has to be (void *) as different Exynos
> chips can have very different register layout, so this way it's possible
> for ".regs" to point to different structures, each representing its own
> chip's layout.
> 
> [...]

Applied, thanks!

[10/15] clk: samsung: Keep register offsets in chip specific structure
        https://git.kernel.org/krzk/linux/c/78bc2312ef9cea4af1073dfab4c71d91b2015b5d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


