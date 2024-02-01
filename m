Return-Path: <linux-kernel+bounces-48970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F678463EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AEF1F2853D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7D645C14;
	Thu,  1 Feb 2024 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aejgf9iV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAA146546;
	Thu,  1 Feb 2024 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706828320; cv=none; b=sffrKqhCx26uR77H8zB5JMRgGhf+GY/ZoMTnJsBbvOqiULaatTMX497gSQ/OIb58jRzFpf0GIhHXt5i5duomoIrqEXoBVZtiEfYYRvZI4zqN9yJtZgYKPYfh0YPFAdxnbH6EPK2P4M3gxLrAk6uD9rNQFgKrICLHrpwfg5I4wJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706828320; c=relaxed/simple;
	bh=J6+XAazfq8OI3ywEXe3H0Aa1Rt570MhNrUUKWp85JHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHajVbUEOl37+D174j5B7WuMK/9DA0fJGiwQsmHhPb2O++82iPY8YqEBW0GRRbj6YXKWhBehGD8+r1M99zuZ2qDtTM4z0PlhtVLi+r3cwYNVNTs1eJVVRDMu2hGyUGGkU5mTI4h99K63MnakOnomp46LqPljNLRbJb4yHnrXFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aejgf9iV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAACC433F1;
	Thu,  1 Feb 2024 22:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706828319;
	bh=J6+XAazfq8OI3ywEXe3H0Aa1Rt570MhNrUUKWp85JHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aejgf9iVT8l88D/qVvwS4KS5hF/AXyC5GpnMO7K2KmMw2d/www5MgUpHyjpYfkakN
	 QFVnBJgy3N9j4zGIlp8Cdk0ykzGmPOjq7TzqjtCVwj+FzKqM4mx1mFDb19Okj15b+O
	 fInXLvNmEoPHYEbmXvvxI7sYOQ9SwEIkrhm2VVrRXDFMrH4yqrI0VqGbMAFkrM014z
	 T9zxu38dFBwVdzusB7pJzhcvNnP6xshY0HY/oVn9nEPG0NcXH5KHQCOrGkfQCs3N6y
	 Zjx+pcjzzrvtHJ/zFps7ej6C9ke46aGOD19xi58QPEZZslwFHx0o1Dh0z1BGJMLjwp
	 olYJeAuesGZdg==
Date: Thu, 1 Feb 2024 16:58:37 -0600
From: Rob Herring <robh@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Cc: tzimmermann@suse.de, markyao0591@gmail.com, andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, mripard@kernel.org,
	devicetree@vger.kernel.org, airlied@gmail.com, heiko@sntech.de,
	maarten.lankhorst@linux.intel.com, daniel@ffwll.ch,
	hjc@rock-chips.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: display: rockchip: rockchip,dw-hdmi:
 remove port property
Message-ID: <170682831660.1899746.18090191904658752173.robh@kernel.org>
References: <a493c65e-7cf9-455f-95d5-8c98cad35710@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a493c65e-7cf9-455f-95d5-8c98cad35710@gmail.com>


On Wed, 31 Jan 2024 22:14:29 +0100, Johan Jonker wrote:
> The hdmi-connector nodes are now functional and the new way to model
> hdmi ports nodes with both in and output port subnodes. Unfortunately
> with the conversion to YAML the old method with only an input port node
> was used. Later the new method was also added to the binding.
> A binding must be unambiguously, so remove the old port property
> entirely and make port@0 and port@1 a requirement as all
> upstream dts files are updated as well and because checking
> deprecated stuff is a bit pointless.
> Update the example to avoid use of the removed property.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V2:
>   rename title from deprecate to remove
>   reword
> ---
>  .../display/rockchip/rockchip,dw-hdmi.yaml    | 24 +++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


