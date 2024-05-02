Return-Path: <linux-kernel+bounces-166746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC078B9EDA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F17CCB232C0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A9416D4D4;
	Thu,  2 May 2024 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir5mxJnj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8776F15E80E;
	Thu,  2 May 2024 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668497; cv=none; b=Vooec+A7YwcW7qhinYTbKASHfMCc0X2dqp5sJmWNUWRRPVwCqr6BSa71bqkJQJmuGiF7JtfA2D1Uq95scWlc9AGsWuto23MgIO8oYQ/CYD8CwcGYdnGjrkX8bohPPqU+Xyex+q9CaRJhonAkDbSEGm2zaRJwfOGPhCNS/ok7prs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668497; c=relaxed/simple;
	bh=wNDnU38OrwB2elGxkleTWMYW3InPgN3uSRSVCxbvH6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j/QLrZVqXddZxMnVO0mrZWYG8qX3KZXwblkxtwi1z3E91osIUOuF60hitAOhSwPb5WqmlBNWrDYc/cpMfYzgbbZYByOdTPQuKJq5Z1chQ8ZkUvRpexETvV0+abKEbWAn9FXnRrfHmXlAzj4HpA/ISwsG2rUmhEL2O9Io6nUK21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir5mxJnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B002C113CC;
	Thu,  2 May 2024 16:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714668497;
	bh=wNDnU38OrwB2elGxkleTWMYW3InPgN3uSRSVCxbvH6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ir5mxJnjLXguyI7fGVg3eUd2HSK4jptyW4KlKHhXd+fWejI6L9F/kOodlKSwi5JOD
	 gV5ELtHOv4EHZlWgv3CBS5OC54KSVu9WsKMGbUYxLAXcA4Adf1Z3Q5R96f/td4j7BO
	 B2xG6/aobzeSrkZIBE3DwTTgUcNU5uQETJDH3qGA+hOvygOGHovvrFo1nz/AWhZU1T
	 hl3Bx9cNW2eGX/50cN6Aq/gdkUuXaa2FNRmkwaWsKApdt7AH9CIChImRfVgPKOLPw6
	 vsWRbws3/+EOaOBfCKXXmauH6xT1JVC0O4VuXP5RBFaRIYdHyNITvi2gyt3TgWiWN0
	 v9uaTOfsPNhTw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Flavio Suligoi <f.suligoi@asem.it>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240417153105.1794134-2-f.suligoi@asem.it>
References: <20240417153105.1794134-1-f.suligoi@asem.it>
 <20240417153105.1794134-2-f.suligoi@asem.it>
Subject: Re: (subset) [PATCH v1 1/1] backlight: mp3309c: fix leds
 flickering in pwm mode
Message-Id: <171466849494.1206441.17324969195592920195.b4-ty@kernel.org>
Date: Thu, 02 May 2024 17:48:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Wed, 17 Apr 2024 17:31:05 +0200, Flavio Suligoi wrote:
> The mp3309 has two configuration registers, named according to their
> address (0x00 and 0x01).
> In the second register (0x01), the bit DIMS (Dimming Mode Select) must
> be always 0 (zero), in both analog (via i2c commands) and pwm dimming
> mode.
> 
> In the initial driver version, the DIMS bit was set in pwm mode and
> reset in analog mode.
> But if the DIMS bit is set in pwm dimming mode and other devices are
> connected on the same i2c bus, every i2c commands on the bus generates a
> flickering on the LEDs powered by the mp3309c.
> 
> [...]

Applied, thanks!

[1/1] backlight: mp3309c: fix leds flickering in pwm mode
      commit: ce60cddc2abf61902dfca71d630624db95315124

--
Lee Jones [李琼斯]


