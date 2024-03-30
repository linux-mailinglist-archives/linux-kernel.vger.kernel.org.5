Return-Path: <linux-kernel+bounces-125894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E44892D7F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 22:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357E51C2193C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E51C482D8;
	Sat, 30 Mar 2024 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b="rIE/a59n"
Received: from mail.wantyapps.xyz (mail.wantyapps.xyz [66.135.5.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA41DFC6
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.135.5.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711834478; cv=none; b=N6+ATeH8Eu3xShFzS652ryrVbTYfQ4DzKPs4UY8SNsK2iM18ldam3LwN0cIm3IRd0ngNdJq7HkDtsNhOr7hyO1dYqHWdOX+WWdshJhqi23LgdG82WUpjVKdbnTwmOwQw5WhxFYqc/Rn5HtwU9ZnMTpaz9uKZBt/4j2fuCjWkvQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711834478; c=relaxed/simple;
	bh=aZ7bDXZO6xGX3RPD7CY+H2g5U8yGjRKJaTPqoMlcrRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilOegItz6H0IjW9uIA84+RUrSJ9g0dIEycA8Jzr8jC7DEPk28QF6Tsmigg/9CnIpNgqKRBETODYIIs11zOsb2TBYEuAZceMeUHxNM0bjRlThSXUt4wijzlGXI2zbTvHQNMIAXlY3EoeufqKpvEggS2w4XT2hTXQB2Ri+6CTNETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz; spf=pass smtp.mailfrom=wantyapps.xyz; dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b=rIE/a59n; arc=none smtp.client-ip=66.135.5.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantyapps.xyz
Received: from multivac (unknown [147.235.194.23])
	by mail.wantyapps.xyz (Postfix) with ESMTPSA id 7323F8B63E;
	Sat, 30 Mar 2024 21:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
	s=mail; t=1711834111;
	bh=aZ7bDXZO6xGX3RPD7CY+H2g5U8yGjRKJaTPqoMlcrRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rIE/a59nPaPLfO5i5huP/7WU8RXox1JJFxGYtV3hW7nC79BMMa3tsrRJv0lW4k5JJ
	 3bDhy9AfS+znfVGvuZa5DFgx2OjxIcNKcYE9C2I+jAVkH2FuZwhH2h4Nq6CzECxEE2
	 W/5GMIHq0nLO4JaD1oHkSr38adWUZZPbR/Wd0EiK75k4nkZW9U+caU+WJsmTkxWVBM
	 uOkRYWODCgV1JA3J2W0tUYDxHSmz0Ww5VJoH4XwUk50K6JXRGVgbTBTyqsCHjLKG/J
	 S6sqPf8jR87zWzU8jOPgAVmhcIEg+mG3+c3duRdGqSeZ5UZMqStFy8+6IIGYDmkyQe
	 cwzlmtkSsDNvQ==
Date: Sun, 31 Mar 2024 00:28:26 +0300
From: Uri Arev <me@wantyapps.xyz>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl, 
	christophe.jaillet@wanadoo.fr, prathubaronia2011@gmail.com, luca.ceresoli@bootlin.com, 
	robh@kernel.org, u.kleine-koenig@pengutronix.de, frank.li@vivo.com, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] staging: axis-fifo: align arguments to open parenthesis
 in axis-fifo.c
Message-ID: <z2ewk44rjutv24i6lqau3adrmlprj524ulqtqbncvfaj44dwcg@2dnnbm75abbp>
References: <20240329203222.12889-3-shresthprasad7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329203222.12889-3-shresthprasad7@gmail.com>

> Align some function arguments to the opening parenthesis of the
> function as reported by checkpatch:
Hey, I sent a similar patch around a month ago and got no reply.
Good luck with that :)

                 Uri Arev

