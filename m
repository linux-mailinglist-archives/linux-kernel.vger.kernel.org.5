Return-Path: <linux-kernel+bounces-29834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC49983142F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A14C282C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EA035F0F;
	Thu, 18 Jan 2024 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgzEYKib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B508A35F02
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564797; cv=none; b=USstpgemmr44n8i5fKiLr9jJ3nOVJaWfgjSlRBT4Ovq8+3hIr4pboZv9dLfScnmvd3zgM/8pbj9sulMOWmZMbJ5zhyU4qH5F81l81oL4cbnBw7FidlOMLG2Gs0rtKn2ugQ7levsH/4G4BLr2UJBS66wxQU/maawGP5edWrq0dUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564797; c=relaxed/simple;
	bh=9uRsFF6qieGLP+F+ERi/iL0hFcaPSN6g/D4jKUB0VJM=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=ZC5gFbluPKNnWlboNKksOLbcYeethAc5fsLIWbnMaGcE8WYUyhQfSq7jAItnCDxEsShkkjW+/BzNuoa18TIlB9GkiUr9t5jkM70laXwCgUhrUSB9W4jTGvWiIXE4JUOaC/+UQlcz0SNYCKIazqHhZj1Eq+9zRFw+wTjlIFrOYYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgzEYKib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F20C433F1;
	Thu, 18 Jan 2024 07:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564797;
	bh=9uRsFF6qieGLP+F+ERi/iL0hFcaPSN6g/D4jKUB0VJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgzEYKib1pts4IiNQde+oajnT012zP8RPq6Z91jcPvDaGEMi+0mSwoK0iZqs1HzET
	 QgxzJZV5Dm3KS/Rk9DpyaqG3WxDDFOEVCsLgRXdyFj9ugPzvfmPGrCsfhe9Zl1w/9L
	 9qaaocvVx9kJQJQa6fDsBdi8dH6/wVY3MDvPDXHxfejp6bdSPDHs2EMcju0aGyxprK
	 BvA5Q1Dk+JO7iJAedMod2/Syx270nEsMgHHGJoN2/+AerWBTjV+AKST5r9NCD82psk
	 adz8iInF90tJOoEqKjvCKm5eJakwHB2bGKHXgplp7DC9fv93tvldWf8AsAUvjUqN5R
	 CjLmDmpNRmkog==
Date: Thu, 18 Jan 2024 07:59:53 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [GIT PULL] Backlight for v6.8
Message-ID: <20240118075953.GM1920897@google.com>
References: <20240116164248.GL1920897@google.com>
 <CAHk-=wiOzXLOB6-k364f3=SfnMMdmxcKU7ipSds_1EvxqqGfJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiOzXLOB6-k364f3=SfnMMdmxcKU7ipSds_1EvxqqGfJw@mail.gmail.com>

On Wed, 17 Jan 2024, Linus Torvalds wrote:

> On Tue, 16 Jan 2024 at 08:42, Lee Jones <lee@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.8
> 
> -ENOSUCHTAG.
> 
> Did you forget to push out?

% git push backlight-next-6.8
fatal: 'backlight-next-6.8' does not appear to be a git repository

I think it helps to provide the name of the remote!  *facepalm*

Fixed now, thanks.

-- 
Lee Jones [李琼斯]

