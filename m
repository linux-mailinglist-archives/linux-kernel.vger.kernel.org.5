Return-Path: <linux-kernel+bounces-157655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660B88B1419
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDEB1F24ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8E31442F5;
	Wed, 24 Apr 2024 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQXOtZW3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D34143C7A;
	Wed, 24 Apr 2024 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989202; cv=none; b=Dyt32PlChQPbkfzJQrk7yyjX1ACbnEKkT0PJJVOh9edcwtkCkQC3DE+k4YDRcUv89rSevnistuDZuYm26Roo3vDI59gqs1kT1MpP0UW8KCRqQtOz3B6rW/MU+q3Z1vsaYGhO18j77PvY5GGBiqkAhIAHyCHnxE2aXVafz3AG8Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989202; c=relaxed/simple;
	bh=3QQAIZ0s4nvmQ6DvzguWJ0rhp8Fhy0GLTpNHl1lPOLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsCEGR5g+4iYEq1/fkJWnjFB8y9jBddcgTnVXBVZdq2REeFLp5RN+t/TVmaz2Tv3vNXFKfZNj0HaVqCRFZKsHPy0XHVdVzIjtgigvvvqQxsLP6QSfw+3JN0tD/ZS5GPwtxM3VQxggaT/86BKecc35WtOxJad+BoQGOT+QAPzqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQXOtZW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C641C113CD;
	Wed, 24 Apr 2024 20:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713989201;
	bh=3QQAIZ0s4nvmQ6DvzguWJ0rhp8Fhy0GLTpNHl1lPOLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQXOtZW38nEGkTLID/XVwTTx6OIgTzHTdTnMfP9XE79DnO1xhe9xW/IKwLFKAi71K
	 m55CT2LM9MPjQw8QGtPOa+tj7rTQwchVkLtYqt1uWEr7AqYFAmx/obA8atSrOJTyw6
	 zrKsXAYYzQmV2kI7v0fnZyGMLb9v6JQRv94k90b6tM8vNBVZ/JHfTMTtD1N7jcqLib
	 nxUGE93x/r+52RJd8OipeQhLr4cy5SrRjVl3X5Z2saAaOp+PLqga+r/lbE0eBwr97h
	 /3ZxiN05xZcvCHTiu9j9HlVIgT9OjiEubk4N66DmW4L/rqNMEodCW6XyZWi7VWipGq
	 1+1CCPrn4z+qA==
Date: Wed, 24 Apr 2024 15:06:39 -0500
From: Rob Herring <robh@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Chuan Liu <chuan.liu@amlogic.com>, linux-amlogic@lists.infradead.org,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/5] dt-bindings: clock: add Amlogic C3 SCMI clock
 controller support
Message-ID: <171398916736.412339.6884561050040801002.robh@kernel.org>
References: <20240424050928.1997820-1-xianwei.zhao@amlogic.com>
 <20240424050928.1997820-3-xianwei.zhao@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424050928.1997820-3-xianwei.zhao@amlogic.com>


On Wed, 24 Apr 2024 13:09:25 +0800, Xianwei Zhao wrote:
> Add the SCMI clock controller dt-bindings for Amlogic C3 SoC family
> 
> Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../dt-bindings/clock/amlogic,c3-scmi-clkc.h  | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 include/dt-bindings/clock/amlogic,c3-scmi-clkc.h
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


