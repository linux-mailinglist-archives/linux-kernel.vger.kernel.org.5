Return-Path: <linux-kernel+bounces-129672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C92896E4E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E763028B097
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CC6143899;
	Wed,  3 Apr 2024 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O760GfrL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D559B142E82;
	Wed,  3 Apr 2024 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144181; cv=none; b=GA7cV1AepbiHAxJcNbbNqBAdCyhbbTBvLizLDJa0RMNj55ZqLyK6MqSFQm9oLyQR0XY1o2i9Z7hIrCEY+NHrv6hw2AnRG/UDz5Us1/aJOzLJsrJO7ZlqnnSL7hINyy0IgvDwiyEDFGG9pfT/8jwWooPIzWjqB3mZK+ODdKpYj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144181; c=relaxed/simple;
	bh=4tqxqDkSL01CbMJoeEiZbI5mx3er2mrAV85iI3zf/dA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J27h3L0cf3QJQwMo2oIFQtBCT9xsI+Z+AnTCb+HHqJXzJPJNGdF7X8QsRCXnR+4kQaBKluLmp6n13tUpoQ395ExsUNTDrazs+1VZaw0yItSYt1UTim07V1hNGUK9W8z+NGSEjVzfdkgXFObEyGG+Rk/NRZp+DpZhHZyHmID53Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O760GfrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E5CC433F1;
	Wed,  3 Apr 2024 11:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712144181;
	bh=4tqxqDkSL01CbMJoeEiZbI5mx3er2mrAV85iI3zf/dA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=O760GfrLnT36YjFMwcl1+DBI9NoZYd0FWsRjpyVUnbbCQZRJYa58RVpdzLqU9kAjO
	 V5FjjW99OZaas6RvYLDGLWqrL7jBGGxPfkq4tYWHX4VQMtXf0i8G3hyU96qWAe8W/C
	 kURV+iIhUAgYFPhI+snvJHIEJ51lFw52qNQYlRjA9oiUqTY3oHIAt32/EvLhq0k+hT
	 ME/jqzBlY3OKykp6G751Iu21zd1dD7ghNYJEJsch/gfG31o03sam8Orrjq5iZ/pH3A
	 kcPZFIaR1mwEa5T1+W4t5GYBmKAliFMQjahehAfbKbKWeFuqljSFsrgZnjMZS4oCfE
	 wKxPQaaASyERg==
Date: Wed, 3 Apr 2024 13:36:19 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Ivan Gorinov <linux-kernel@altimeter.info>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Input: WinWing Orion2 throttle support
In-Reply-To: <20240216215447.426ca3e7@lxl-9drxzh3.na.joby.aero>
Message-ID: <nycvar.YFH.7.76.2404031336070.20263@cbobk.fhfr.pm>
References: <20240216215447.426ca3e7@lxl-9drxzh3.na.joby.aero>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 16 Feb 2024, Ivan Gorinov wrote:

> WinWing Orion2 throttle works with Linux out of box,
> but the kernel sees only 16 of 47 buttons on the throttle base.
> 
> This module enables all buttons, and also adds LED controls.
> 
> Button numbers 0 .. 63 on Orion2 are reserved for throttle grip;
> the throttle base buttons have numbers 64 .. 110.
> 
> Linux kernel HID subsystem only supports up to 80 buttons.
> 
> Remap throttle base buttons to numbers 32 .. 78,
> reserving only numbers 0 .. 31 for buttons on the grip handle.
> 
> Changes since v2:
>    - Fixed automatic line wraps added by mail client
> 
> Changes since v1:
>    - Fixed formatting of descriptor byte array;
>    - Using product codes of Winwing grips in config.
> 
> Signed-off-by: Ivan Gorinov <ivan.gorinov@jobyaviation.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


