Return-Path: <linux-kernel+bounces-78791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7581D8618DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A081F22D93
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A9B12AAF5;
	Fri, 23 Feb 2024 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8uS0kF1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375412A151;
	Fri, 23 Feb 2024 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708127; cv=none; b=Z6tFC5ehgZ8iYsmpBmnW6SavKEt2U/nMqdDksPncpwP4U0tIKF3uO7lnABDOlDoVonZb+FcGh8aABVb7S1ZlJkxN8CvxAbGjdp+4HPenT8EByer1vgcoYzD9dA7AuYKNo7+3+u29BDhz6QvoKDSoreueWUcjzsevRYKx8c9cqAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708127; c=relaxed/simple;
	bh=5hJ/D9Kao9lIBFDWHQLPu2B5DiRAXR70lYrCEK2lp2U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cYbNJMsURI5IqUvkKC+y7WOUQ015JCezWysz/TgJ15Imm+cwnjINO0VhxqGPe/TwBIcPM/SArZcPmQXte9UIw1WU8j0BaCmMDDDNDZtzrNKxq5QnJTAGjNlHN+AI0jkU3hIczETmUSzLHrORWI2eaROTI3TviXSjP46zTReIQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8uS0kF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C72C433C7;
	Fri, 23 Feb 2024 17:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708127;
	bh=5hJ/D9Kao9lIBFDWHQLPu2B5DiRAXR70lYrCEK2lp2U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Z8uS0kF1TdAKTnt+18CdAp0Df7SiTf0VsC0FUD3bUDVE8DEQvcBL71/4HFa4Chw4L
	 IqFg6KflQ5pLX7aN+yvimhzM0K6kB9btFcsakc9lC7djK61AEOyJd6y3BXE9ZtaBMN
	 HeAHzJAB7NuSgcQ2DMr5nFjmxKFtSGGcvwJxWFfqbVoBpNh5t5+SuIRFb0SudK48be
	 j5FolcOa/Ucg7QM53UB2UsMnAMkkcMcBk61KQC8C0SwSts5Ft9QVPktHqpDWF05V3x
	 cbdyqX78TxJFrdBQRjgIJgAjVYKzAfJy1pXj8Qp3dOPsGAtZPg6ZtTsZYWy8mkUW67
	 GcPxQWRMAXjuA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Stephen Boyd <swboyd@chromium.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
 devicetree@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Douglas Anderson <dianders@chromium.org>, 
 Pin-yen Lin <treapking@chromium.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Benson Leung <bleung@chromium.org>, Conor Dooley <conor+dt@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240219202325.4095816-1-swboyd@chromium.org>
References: <20240219202325.4095816-1-swboyd@chromium.org>
Subject: Re: [PATCH 0/2] mfd: cros_ec_dev: Add gpio device and DT binding
Message-Id: <170870812420.1760347.5174943339912731699.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 17:08:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 19 Feb 2024 12:23:22 -0800, Stephen Boyd wrote:
> This is the mfd part of a larger series[1] that describes the USB
> topology on ARM based chromebooks. These two patches add the gpio device
> and DT bindings when the GPIO feature is present. The gpio driver will
> be sent separately.
> 
> Stephen Boyd (2):
>   dt-bindings: cros-ec: Add properties for GPIO controller
>   mfd: cros_ec_dev: Add gpio device if feature present on EC
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: cros-ec: Add properties for GPIO controller
      commit: 365ea466d6aa5c8618e096141d72c48fb5707ee4
[2/2] mfd: cros_ec_dev: Add gpio device if feature present on EC
      commit: 1fe6dcba7bcf0dbd53be0c7ea009524c4c44447b

--
Lee Jones [李琼斯]


