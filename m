Return-Path: <linux-kernel+bounces-166732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A827D8B9E9C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190CB1F21C60
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF793A260;
	Thu,  2 May 2024 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geI7Rhvo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0BD17BBA;
	Thu,  2 May 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667541; cv=none; b=kxfc6SelI2NlX1VIhHwhOM6uEs47J2Ntr9WJLTpQWw0E+BtHBkbPluGgBaLs14JHbd+xYTdS5Adn6sjLR0A3zJqGWIr5I/y7PbQ/CJ1WKScWKQHjicIvqx1HAY5trKFRL9qqoaiYz8NC93pUxE51veiTde/PII5kuyfuJlCwW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667541; c=relaxed/simple;
	bh=Kd9IfN+bMPr5jWBG+Mqie5UM4c89qfMB98700/u5GHo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fmAX5c28Voz1HX8FQN0gf8uF8p75ci9nizRv4iCwDq+NzTbgGq1ou89Vy5i93DPj7mqjp8n7S8Er5U+LP6nGepH4hNpzDk/JWkw2YUX8VedAcSmbRwvC4/SUi8KroN9RtCUQkAJlQ86a/NaEFcKqNtqAP4E3pkObcJ2TczjPIks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geI7Rhvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1852C113CC;
	Thu,  2 May 2024 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714667541;
	bh=Kd9IfN+bMPr5jWBG+Mqie5UM4c89qfMB98700/u5GHo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=geI7Rhvooj7V+/XBiTDSe8wTtod0Pmxew7IZ/xyLGZhMe4k4NphVK+JQh7L7pTKYv
	 hq84XHQPJAtx9kXk6MXbAJL/wfmnySCrEmjBpyUSdyvgeopGMOwd/od40e8sXmiqkk
	 0+sF/D1iZfRRJ8aF4bFMcC1PGjHwBgk262jL1eZdI1LwihRGO1N/d9rtgq4OvRS+Mp
	 1RoXzpsapWnDrmQ3/kBiw5B8rTd9JfaTOZr8c825MF/ucHco6aztvPgQAUhmCB3DrW
	 I++m/g2hWBneJ29TT8HaziKCqSZVEry6iMJyQgvkTlIdcDE4f43RQKAb8nCjiExC/8
	 J4PG9ghTvNkQA==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>
Cc: linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 kernel@salutedevices.com
In-Reply-To: <20240416201847.357099-1-mmkurbanov@salutedevices.com>
References: <20240416201847.357099-1-mmkurbanov@salutedevices.com>
Subject: Re: (subset) [PATCH v2 RESEND] leds: trigger: pattern: add support
 for hrtimer
Message-Id: <171466753939.1199434.16328391643586401261.b4-ty@kernel.org>
Date: Thu, 02 May 2024 17:32:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 16 Apr 2024 23:18:05 +0300, Martin Kurbanov wrote:
> Currently, led pattern trigger uses timer_list to schedule brightness
> changing. As we know from timer_list API [1], it's not accurate to
> milliseconds and depends on HZ granularity.
> 
> Example:
> "0 10 0 0 50 10 50 0 100 10 100 0 150 10 150 0 200 10 200 0 250 10 250 0",
> we expect it to be 60ms long, but it can actually be up to ~120ms
> (add ~10ms for each pattern when HZ == 100).
> 
> [...]

Applied, thanks!

[1/1] leds: trigger: pattern: add support for hrtimer
      commit: aa172ba73948e2152e258ead7e9ddbd806e809b0

--
Lee Jones [李琼斯]


