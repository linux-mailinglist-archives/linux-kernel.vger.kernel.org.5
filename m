Return-Path: <linux-kernel+bounces-39884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D47983D6FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B481F23AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130D0605D6;
	Fri, 26 Jan 2024 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpu6YZFm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A810A28;
	Fri, 26 Jan 2024 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259970; cv=none; b=ZCRU+t+yk5/pa/2TyQx4DPY5HVGw8CjsXkiSReAimiuEf6oqXSZ77zSnR5UOi+NG69kjoMHR472ll8/CqRNHq7mquaHpVqtsI/rrFi4luKL5GCNJsPCisB6DVbwXXcNTsm9E1WsQ+cIqhzb3+ivHkcc3sNLQJLl+9ZjxuQOsEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259970; c=relaxed/simple;
	bh=JMGTsyBAlUGTZ2JRMVHxhfJbZK/iVzioQcU+MUzCCZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXMd8AFhhjlDW1oJog7k9kUjCLRay6zAeB0rSCqiBB1Mv5PuENpgHTPvu9OVtaEeukSQSu0osgKVzTh6JqVvLBVL/TQefSnaBFBdeOditonexV8IupuaXkwqXAkodspGKBrY0+TKgkOaswP2zMmiSeE50I+S0+XrJrOTA8EKoVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpu6YZFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725C7C433F1;
	Fri, 26 Jan 2024 09:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706259969;
	bh=JMGTsyBAlUGTZ2JRMVHxhfJbZK/iVzioQcU+MUzCCZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rpu6YZFmZe59WukwEoxOOd1HDKLHl+/ISjtUwftIdHSb7EgQuBRTHV6kqfmMIkB+9
	 kqCPTYxvg8Sq5F0inVyHgQxfGpfQM3QsSmOXqMA4bBhtV+/2xF/Gz+gqSf8x+JzERx
	 TFmzoO1uFHWGhFM3do2vyPF1WT/pPZmuMsn00gtOfXXxUFyuntbgWe9c+xU4x3HO/d
	 HR70NXwDyrwtCXOFjiD46FzSiqewTTWosFjWC8GfvCr3B7s7pXAtR4lrDbhyQuS+wU
	 1kifBhd1D0wVRjW2J7m5AlNJ5dejx/ckOo6XVTYgEV1ntvao8Hltl6X2rwzj1SXuNI
	 E66qXzXG5zydQ==
Date: Fri, 26 Jan 2024 09:06:05 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 2/6] mfd: cs42l43: Tidy up header includes
Message-ID: <20240126090605.GO74950@google.com>
References: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com>
 <20240125102555.2621736-2-ckeepax@opensource.cirrus.com>
 <20240125135509.GL74950@google.com>
 <CAHp75Vc4jiz3Wjg_1DKs=X=Q8oxMmEASx2VB-BZsawSDa2cwRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vc4jiz3Wjg_1DKs=X=Q8oxMmEASx2VB-BZsawSDa2cwRQ@mail.gmail.com>

On Thu, 25 Jan 2024, Andy Shevchenko wrote:

> On Thu, Jan 25, 2024 at 3:55 PM Lee Jones <lee@kernel.org> wrote:
> > On Thu, 25 Jan 2024, Charles Keepax wrote:
> >
> > > Use more forward declarations, move header guards to cover other
> > > includes, and rely less on including headers through other headers.
> > >
> > > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> > Patches look okay to me, but seeing as Andy suggested the changes, it
> > would be good to get a R-by from him.
> 
> I'm worried now only about missing a commit message in one patch and
> (with less severity) the v2 of this one which appears not to be
> necessary (i.e. v1 is fully okay). If you consider the commit message
> absence is okay, feel free to apply v2, otherwise with that addressed
> v3 can go in my opinion.

Please fix-up and submit a v4 with Andy's R-bs.

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
Lee Jones [李琼斯]

