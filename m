Return-Path: <linux-kernel+bounces-38688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B959883C41E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445BE2974E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7BF5B213;
	Thu, 25 Jan 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzyt2/gs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1886A5B204;
	Thu, 25 Jan 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190675; cv=none; b=KSIsmad6SXCiT1i0pMoJehadZ76vkipm6pgwHXW+6S1XmeNXlrphsr920iSVuiQK0DB3vVmCfWqKeM/TLeDRPbFlj6qPLzE/FOstdrVGOdmLzJ3ORCLohyJL6I07B9qO1FSh+a6oakernCIEWHF+VJLPSFr5ztBtv2DDIV8UoeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190675; c=relaxed/simple;
	bh=wH81iS855opiUGjOXv2S6FTtpKNofrQv2CSZAxYC3/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XuS9yd/it7VNNy7wFnUy15ZpQKrLQCXg9jD0o4okLSdW10qskDXyH+aqApGQT8EWKIZe8++/DVPjtjY4n6qnxuvDmAoeubRoZGbLrVq2sEd0lf0rlpZ7SVvnqHiaE0zoq6nD8XT6gSTttzezd6Bp8yXqNuUJu5gRKecrqIFZZEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzyt2/gs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC8DC433F1;
	Thu, 25 Jan 2024 13:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706190674;
	bh=wH81iS855opiUGjOXv2S6FTtpKNofrQv2CSZAxYC3/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fzyt2/gsNccB/ZCejD01UTKlKnbJ/DDRyMh4JuscNZPSrX0Bgt8TItGfPX6z4Qmis
	 MeE60VNLb/zQcqOlYLpSxGqC+4YSfUMpEp1zbVHpfYIba/LwaNoFR0Y49Y2d1ba/4f
	 aa+o1kQjtomqLMHgdPAOdiyAmmnrGMwGVwm6PpHplc8V05zSNJvIvg9C+0V2Es6ty3
	 EWy/62av6nWIFq5f6caMPyYFUtNmChzhuxwq49D3zJYKwcWTB/WB2YlmKUFjUzul5V
	 I4OiuXKvHow9jE3ajDGgGCibe28VgIgA3t4h4mk7VrD7QLRg0mx5qkPgYV8uvhTsZm
	 M5sdhjzkxIyFQ==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 Jean-Jacques Hiblot <jjhiblot@traphandler.com>, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240109090715.982332-1-arnd@kernel.org>
References: <20240109090715.982332-1-arnd@kernel.org>
Subject: Re: [PATCH 1/2] leds: remove led_init_default_state_get() and
 devm_led_classdev_register_ext() stubs
Message-Id: <170619067236.1476369.7542248214179652574.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 13:51:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Tue, 09 Jan 2024 10:06:39 +0100, Arnd Bergmann wrote:
> These two functions have stub implementations that are called when
> NEW_LEDS and/or LEDS_CLASS are disabled, theorerically allowing drivers
> to optionally use the LED subsystem.
> 
> However, this has never really worked because a built-in driver is
> unable to link against these functions if the LED class is in a loadable
> module. Heiner ran into this problem with a driver that newly gained
> a LEDS_CLASS dependency and suggested using an IS_REACHABLE() check.
> 
> [...]

Applied, thanks!

[1/2] leds: remove led_init_default_state_get() and devm_led_classdev_register_ext() stubs
      commit: c0b64609dada48907b04b48873ba052efa8f121d
[2/2] leds: make flash and multicolor dependencies unconditional
      commit: 54602f38551e89b520611ffb9df05232d1bf73f8

--
Lee Jones [李琼斯]


