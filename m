Return-Path: <linux-kernel+bounces-78471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA478613DA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FEBEB22B95
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D294823BC;
	Fri, 23 Feb 2024 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eacw6DRV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8048B82883;
	Fri, 23 Feb 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697991; cv=none; b=Dcn3agqE69Zrjd31kABNnqun9ULx3MqXNoLlD7FJK0IzBdkZaj4QVTyXEmUu8yjMGoDIqKMq0I/1cOfndV0+AtkO/2k9hAEkxVFA8/XtGHGuka41YCLHriLE58+doll1z6C2fF/xgEaFr/frUmoxG33miAXSut+uv69+wC/Gf3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697991; c=relaxed/simple;
	bh=ETKYcbVy9F3oKzFZtWeCfPtjpmK5klMob+7HF4Z81lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1Z086qGW7EuqJN8jTrC3dJvuRoYVj7G6R/Icw69byuhryipiU7yT1KMQ2QhfPEUohI0H4Y8hdYNT4IXaiuiVLah1ILwVaIJnDYXnHnL8aCK5iPo+ceA5DuPxblOl6xFzoLuKDkG4ZTJ1DLTQWHGEZib9pM9NlK4NaGxUpKUJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eacw6DRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39E4C433C7;
	Fri, 23 Feb 2024 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708697991;
	bh=ETKYcbVy9F3oKzFZtWeCfPtjpmK5klMob+7HF4Z81lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eacw6DRV+EHA5iO8RBu8bFKeMyPlp8sbd8pkC2N4jM3EIR6XjC7et+quyXaCCwdgt
	 Em0tIE/Xm8LXtSYZ9Oc+pr/R48EkxRke7rHiQgBLJCcokMyKu9M5wqzV7xgSXGa1Ej
	 IBYEAN/HFqOEoklKNm1DIQY3f1LkKLcjDYxGSMt6Fv223meRzd4AXzZxg4rhVyyxs2
	 0n99jNUBQ/I5UpGLszwm8Yx8/QNwbX5cH5gzXctInzIK8CKcqom0rzHNfxeaCgxOSG
	 g2HRRJ4Or+Ws3aTaDLLdXVvGlmuqr0Aa48s4F8CqKf4B/Q6mW3318awmLA+NUjGnNE
	 Bk0jTbFFLj0Xw==
Date: Fri, 23 Feb 2024 07:19:48 -0700
From: Rob Herring <robh@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	JunYi Zhao <junyi.zhao@amlogic.com>,
	Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 2/5] dt-bindings: pwm: amlogic: Add a new binding for
 meson8 pwm types
Message-ID: <170869798755.1908267.1779690942757984843.robh@kernel.org>
References: <20240221151154.26452-1-jbrunet@baylibre.com>
 <20240221151154.26452-3-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221151154.26452-3-jbrunet@baylibre.com>


On Wed, 21 Feb 2024 16:11:48 +0100, Jerome Brunet wrote:
> The binding that is used up to now describe which input the PWM
> channel multiplexer should pick among its possible parents,
> which are hardcoded in the driver. This isn't a good binding in
> the sense that it should describe hardware but not usage.
> 
> Add a new binding deprecating the old one that uses clocks in a
> better way and how clocks are usually used today: The list of
> clocks describe the inputs of the PWM block as they are realised
> in hardware.
> 
> So deprecate the old bindings and introduce a compatible per SoC
> family to replace these.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 50 +++++++++++++++++--
>  1 file changed, 47 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


